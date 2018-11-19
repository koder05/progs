﻿using System;
using System.Collections.Generic;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Input;
using System.Threading;
using System.Threading.Tasks;
using System.Reflection;
using System.Linq;

using RF.WinApp.Infrastructure.Behaviour;
using RF.WinApp.JIT;
using RF.BL.Model;


namespace RF.WinApp
{
    public class FormCC : ActionBlock
    {
        static FormCC()
        {
            DefaultStyleKeyProperty.OverrideMetadata(typeof(FormCC), new FrameworkPropertyMetadata(typeof(FormCC)));
        }

        private object initialModel = null;
        private Dictionary<string, Tuple<DependencyObject, DependencyProperty, object, object>> formHistoryCache = new Dictionary<string, Tuple<DependencyObject, DependencyProperty, object, object>>();

        public FormCC()
        {
            this.DataContextChanged += DataContextChangedHandler;
            _sourceUpdatedHandler = new EventHandler<DataTransferEventArgs>(SourceUpdatedHandler);
            this.AddHandler(Binding.SourceUpdatedEvent, _sourceUpdatedHandler);
            //this.AddHandler(Validation.ErrorEvent, new EventHandler<ValidationErrorEventArgs>(ValidationErrorHandler));
        }

        public event DependencyPropertyChangedEventHandler DataContextChangeCanceled;
        public void OnDataContextChangeCanceled(DependencyPropertyChangedEventArgs e)
        {
            if (DataContextChangeCanceled != null)
            {
                DataContextChangeCanceled(this, e);
            }
        }

        private void DataContextChangedHandler(object sender, DependencyPropertyChangedEventArgs e)
        {
            var dobj = e.OldValue as DataObj;
            if (dobj != null && dobj.IsEditing)
            {
                if (MessageBox.Show("Форма в состоянии редактирования. Изменения будут сброшены." + Environment.NewLine + "Продолжить?", "Вопрос"
                        , MessageBoxButton.YesNo, MessageBoxImage.Question) == MessageBoxResult.No)
                {
                    OnDataContextChangeCanceled(e);
                }
                else
                {
                    UndoForm();
                    DisabeTemporaryTargetUpdatedHandler();
                    return;
                }
            }

            DisabeTemporaryTargetUpdatedHandler();

            if (this.IsOpened)
            {
                StoreInitialModel();
            }
        }

        private void StoreInitialModel()
        {
            var dobj = this.DataContext as DataObj;
            if (dobj != null)
            {
                var model = dobj.Model as BaseModel;
                if (model != null)
                {
                    initialModel = model.ShallowCopy();
                }
            }
        }

        private bool TryGetInitialValue(DependencyObject depo, DependencyProperty dp, ref object value)
        {
            if (depo == null || dp == null)
                return false;

            Binding b = BindingOperations.GetBinding(depo, dp);

            if (b == null)
            {
                MultiBinding mb = BindingOperations.GetMultiBinding(depo, dp);

                if (mb == null)
                    return false;

                b = mb.Bindings[0] as Binding;
            }

            if (b == null || b.Path == null || string.IsNullOrEmpty(b.Path.Path))
                return false;

            BindingExpression be = BindingOperations.GetBindingExpression(depo, dp);

            if (be == null)
            {
                MultiBindingExpression mbe = BindingOperations.GetMultiBindingExpression(depo, dp);

                if (mbe == null)
                    return false;

                be = mbe.BindingExpressions[0] as BindingExpression;
            }

            if (be == null || be.DataItem == null)
                return false;

            var dobj = be.DataItem as DataObj;

            if (dobj != null)
            {
                string prop = b.Path.Path.Replace("Model.", "");
                if (initialModel != null)
                {
                    var pi = initialModel.GetType().GetProperty(prop);
                    if (pi != null)
                    {
                        value = pi.GetValue(initialModel, null);
                        return true;
                    }
                }
            }

            return TryGetInitialValue(be.DataItem as DependencyObject, DispatcherHelper.GetDependencyProperty(be.DataItem.GetType(), b.Path.Path + "Property"), ref value);
        }
        
        private void SourceUpdatedHandler(object sender, DataTransferEventArgs e)
        {
            var dobj = this.DataContext as DataObj;
            if (dobj != null)
            {
                dobj.IsEditing = true;
                string dpName = string.Format("{0}_{1}", e.TargetObject.GetHashCode(), e.Property.Name);
                if (this.formHistoryCache.ContainsKey(dpName) == false)
                {
                    object o = e.TargetObject.GetValue(e.Property);
                    object ctxObj = e.TargetObject.GetValue(FrameworkElement.DataContextProperty);
                    TryGetInitialValue(e.TargetObject, e.Property, ref o);
                    this.formHistoryCache.Add(dpName, Tuple.Create(e.TargetObject, e.Property, o, ctxObj));
                }
            }
        }

        private Delegate _sourceUpdatedHandler;

        private bool _disabledTargetUpdatedHandler = false;
        /// <summary>
        /// crutch: disable on 1sec TargetUpdated event while form init from new context
        /// </summary>
        private void DisabeTemporaryTargetUpdatedHandler()
        {
            if (this.IsOpened)
            {
                _disabledTargetUpdatedHandler = true;
                Task.Factory.StartNew(() => Thread.Sleep(1000)).ContinueWith((t) => _disabledTargetUpdatedHandler = false);
            }
        }

        private void TargetUpdatedHandler(object sender, DataTransferEventArgs e)
        {
            if (!_disabledTargetUpdatedHandler)
                SourceUpdatedHandler(sender, e);
        }

        private void ValidationErrorHandler(object sender, ValidationErrorEventArgs e)
        {
            var dobj = this.DataContext as DataObj;
            var be = e.Error.BindingInError as BindingExpression;

            if (dobj != null && be.HasError)
            {
                List<FieldInfo> propertiesAll = new List<FieldInfo>();
                var depo = e.OriginalSource as DependencyObject;
                Type currentLevel = depo.GetType();
                while (currentLevel != typeof(object))
                {
                    propertiesAll.AddRange(currentLevel.GetFields());
                    currentLevel = currentLevel.BaseType;
                }
                var propertiesDp = propertiesAll.Where(x => x.FieldType == typeof(DependencyProperty));
                foreach (var property in propertiesDp)
                {
                    DependencyProperty dp = property.GetValue(depo) as DependencyProperty;
                    if (BindingOperations.GetBindingExpression(depo, dp) == be)
                    {
                        string dpName = string.Format("{0}_{1}", e.OriginalSource.GetHashCode(), dp.Name);
                        if (this.formHistoryCache.ContainsKey(dpName) == false)
                        {
                            object o = depo.GetValue(dp);
                            TryGetInitialValue(depo, dp, ref o);
                            this.formHistoryCache.Add(dpName, Tuple.Create<DependencyObject, DependencyProperty, object, object>(depo, dp, o, dobj));
                        }
                        dobj.IsEditing = true;
                        break;
                    }
                }
            }
        }

        private void UndoForm()
        {
            this.RemoveHandler(Binding.SourceUpdatedEvent, _sourceUpdatedHandler);
            foreach (var kvp in this.formHistoryCache)
            {
                if(kvp.Value.Item2 != FrameworkElement.DataContextProperty)
                    kvp.Value.Item1.SetValue(FrameworkElement.DataContextProperty, kvp.Value.Item4);

                if (kvp.Value.Item2.PropertyType == typeof(string))
                {
                    Binding b = BindingOperations.GetBinding(kvp.Value.Item1, kvp.Value.Item2);
                    if (b == null || string.IsNullOrEmpty(b.StringFormat))
                    {
                        kvp.Value.Item1.SetValue(kvp.Value.Item2, string.Format("{0}", kvp.Value.Item3));
                    }
                    else
                    {
                        kvp.Value.Item1.SetValue(kvp.Value.Item2, string.Format(b.StringFormat, kvp.Value.Item3));
                    }
                }
                else
                {
                    kvp.Value.Item1.SetValue(kvp.Value.Item2, kvp.Value.Item3);
                }

                if (kvp.Value.Item2 != FrameworkElement.DataContextProperty)
                    kvp.Value.Item1.ClearValue(FrameworkElement.DataContextProperty);

                var ctx = kvp.Value.Item4 as DataObj;
                if (ctx != null)
                    ctx.IsEditing = false;
            }

            var dobj = this.DataContext as DataObj;
            if (dobj != null)
                dobj.IsEditing = false;

            this.formHistoryCache.Clear();
            this.AddHandler(Binding.SourceUpdatedEvent, _sourceUpdatedHandler);
        }

        protected override void Apply(object sender, ExecutedRoutedEventArgs e)
        {
            this.RemoveHandler(Binding.SourceUpdatedEvent, _sourceUpdatedHandler);
            this.BindingGroup.CommitEdit();
            this.AddHandler(Binding.SourceUpdatedEvent, _sourceUpdatedHandler);

            foreach (var f in DispatcherHelper.FindVisualChildren<FrameworkElement>(this))
            {
                var o = f.GetValue(Validation.HasErrorProperty);
                if (o != null && (bool)o)
                {
                    return;
                }
            }

            base.Apply(sender, e);
            this.formHistoryCache.Clear();
        }

        protected override void Clear(object sender, ExecutedRoutedEventArgs e)
        {
            UndoForm();
        }

        public override void Close(object sender, ExecutedRoutedEventArgs e)
        {
            this.RemoveHandler(Binding.TargetUpdatedEvent, new EventHandler<DataTransferEventArgs>(TargetUpdatedHandler));
            var dobj = this.DataContext as DataObj;
            if (dobj != null && dobj.IsEditing)
            {
                if (MessageBox.Show("Форма в состоянии редактирования. Изменения будут сброшены." + Environment.NewLine + "Продолжить?", "Вопрос"
                        , MessageBoxButton.YesNo, MessageBoxImage.Question) == MessageBoxResult.Yes)
                {
                    Clear(sender, e);
                }
                else return;
            }

            base.Close(sender, e);
        }

        public override void Open(object sender, ExecutedRoutedEventArgs e)
        {
            base.Open(sender, e);
            StoreInitialModel();
            this.AddHandler(Binding.TargetUpdatedEvent, new EventHandler<DataTransferEventArgs>(TargetUpdatedHandler));
        }

        public override void OnApplyTemplate()
        {
            base.OnApplyTemplate();
            if (this.BindingGroup == null)
            {
                BindingGroup bg = new BindingGroup();
                this.BindingGroup = bg;
            }

            if (this.BindingGroup.ValidationRules.Count == 0)
                this.BindingGroup.ValidationRules.Add(new XValidationRule());

            System.Diagnostics.Debug.WriteLine("Form.BindingGroup=bg");
            this.SetValue(Validation.ErrorTemplateProperty, null);
        }

        class XValidationRule : ValidationRule
        {
            internal XValidationRule()
            {
                this.ValidationStep = System.Windows.Controls.ValidationStep.CommittedValue;
            }

            public override ValidationResult Validate(object value, System.Globalization.CultureInfo cultureInfo)
            {
                foreach (BindingExpressionBase be in (value as BindingGroup).BindingExpressions)
                    be.UpdateSource();
                return ValidationResult.ValidResult;
            }
        }
    }

    internal class DataObjEnvelopeConverter : IValueConverter
    {
        public object Convert(object value, Type targetType, object parameter, System.Globalization.CultureInfo culture)
        {
            if (value != null)
            {
                if (value is DataObj)
                    return value;

                var o = new DataObj();
                o.Model = value;
                return o;
            }

            return null;
        }

        public object ConvertBack(object value, Type targetType, object parameter, System.Globalization.CultureInfo culture)
        {
            var val = value as DataObj;
            if (val != null)
            {
                if (targetType == typeof(DataObj))
                    return value;

                return val.Model;
            }

            return null;
        }
    }

    public class EmptyConverter : IValueConverter
    {
        public object Convert(object value, Type targetType, object parameter, System.Globalization.CultureInfo culture)
        {
            return value;
        }

        public object ConvertBack(object value, Type targetType, object parameter, System.Globalization.CultureInfo culture)
        {
            return value;
        }
    }
}
