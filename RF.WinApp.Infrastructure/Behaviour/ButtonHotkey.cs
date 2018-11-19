using Microsoft.Practices.Prism.Commands;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Windows;
using System.Windows.Automation.Peers;
using System.Windows.Automation.Provider;
using System.Windows.Controls;
using System.Windows.Input;

namespace RF.WinApp
{
    public class ButtonHotkey
    {
        public static KeyGesture GetHotkey(FrameworkElement obj)
        {
            return (KeyGesture)obj.GetValue(HotkeyProperty);
        }

        public static void SetHotkey(FrameworkElement obj, KeyGesture value)
        {
            obj.SetValue(HotkeyProperty, value);
        }

        public static readonly DependencyProperty HotkeyProperty =
            DependencyProperty.RegisterAttached("Hotkey", typeof(KeyGesture), typeof(Button),
            new PropertyMetadata(null, null, OnHotkeyCoerce));

        private static object OnHotkeyCoerce(DependencyObject d, object o)
        {
            var btn = (Button)d;
            var k = o as KeyGesture;

            var window = Window.GetWindow(btn);
            if (window != null)
            {

                ICommand cmd = null;
                for (int i = window.InputBindings.Count - 1; i >= 0; i--)
                {
                    var inputBinding = (InputBinding)window.InputBindings[i];
                    var keyBinding = inputBinding as KeyBinding;
                    if (keyBinding != null && keyBinding.Key == k.Key && keyBinding.Modifiers == k.Modifiers)
                    {
                        cmd = inputBinding.Command;
                        window.InputBindings.Remove(inputBinding);
                    }
                }

                var ib = new KeyBinding(new DelegateCommand(() =>
                {

                    if (cmd != null)
                        cmd.Execute(null);

                    if (btn.IsVisible)
                    {
                        ButtonAutomationPeer peer = new ButtonAutomationPeer(btn);
                        IInvokeProvider invokeProv = peer.GetPattern(PatternInterface.Invoke) as IInvokeProvider;
                        invokeProv.Invoke();
                    }

                }), k);
                window.InputBindings.Add(ib);
            }
            return o;
        }
    }
}
