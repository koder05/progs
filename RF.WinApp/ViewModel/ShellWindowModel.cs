using System;
using System.ComponentModel.Composition;
using System.Windows;
using System.Windows.Input;
using Microsoft.Practices.Prism.Commands;
using System.ComponentModel;

namespace RF.WinApp.ViewModel
{
    [Export(typeof(ShellWindowModel))]
    [PartCreationPolicy(CreationPolicy.NonShared)]
    public class ShellWindowModel : INotifyPropertyChanged
    {
        [ImportingConstructor]
        public ShellWindowModel()
        {
            ExitCommand = new DelegateCommand(OnExited);
            Status = "Shell Alone";
        }

        public ICommand ExitCommand { get; private set; }

        public event PropertyChangedEventHandler PropertyChanged;
        public void OnPropertyChanged(PropertyChangedEventArgs e)
        {
            if (PropertyChanged != null)
            {
                PropertyChanged(this, e);
            }
        }

        private void OnExited()
        {
            Application.Current.Shutdown();
        }


        private string _Status;
        public string Status
        {
            get
            {
                return _Status;
            }
            set
            {
                _Status = value;
                OnPropertyChanged(new PropertyChangedEventArgs("Status"));
            }
        }

    }
}
