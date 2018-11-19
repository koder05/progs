using System;
using System.Collections.Generic;
using System.ComponentModel.Composition.Hosting;
using System.Linq;
using System.Text;
using System.Windows;
using Microsoft.Practices.Prism.MefExtensions;
using Microsoft.Practices.Prism.Modularity;

using RF.WinApp.Infrastructure.Behaviour;
using System.ComponentModel.Composition.Primitives;
using System.IO;

namespace RF.WinApp
{
    public class Prism4MefBootstapper : MefBootstrapper
    {
        protected override void ConfigureAggregateCatalog()
        {
            this.AggregateCatalog.Catalogs.Add(new AssemblyCatalog(typeof(Prism4MefBootstapper).Assembly));
            this.AggregateCatalog.Catalogs.Add(new AssemblyCatalog(typeof(AutoPopulateExportedViewsBehavior).Assembly));

            //if (!AppDomain.CurrentDomain.IsDefaultAppDomain())
            //    this.AggregateCatalog.Catalogs.Add(new DirectoryCatalog(AppDomain.CurrentDomain.SetupInformation.ApplicationBase));
        }

        protected override DependencyObject CreateShell()
        {
            return this.Container.GetExportedValue<ShellWindow>();
        }

        protected override void InitializeShell()
        {
            base.InitializeShell();
            Application.Current.MainWindow = (ShellWindow)this.Shell;
            Application.Current.MainWindow.Show();
        }

        protected override Microsoft.Practices.Prism.Regions.IRegionBehaviorFactory ConfigureDefaultRegionBehaviors()
        {
            var factory = base.ConfigureDefaultRegionBehaviors();
            factory.AddIfMissing("AutoPopulateExportedViewsBehavior", typeof(AutoPopulateExportedViewsBehavior));
            return factory;
        }

        /// <summary>
        /// Creates the <see cref="IModuleCatalog"/> used by Prism.
        /// </summary>
        /// <remarks>
        /// The base implementation returns a new ModuleCatalog.
        /// </remarks>
        /// <returns>
        /// A ConfigurationModuleCatalog.
        /// </returns>
        protected override IModuleCatalog CreateModuleCatalog()
        {
            // When using MEF, the existing Prism ModuleCatalog is still the place to configure modules via configuration files.
            var cnfgModule = new MyConfigurationModuleCatalog();
            cnfgModule.Store = new Microsoft.Practices.Prism.Modularity.ConfigurationStoreNetShared();
            return cnfgModule;
        }

        protected override void ConfigureServiceLocator()
        {
            base.ConfigureServiceLocator();
        }
    }

    class MyConfigurationModuleCatalog : ConfigurationModuleCatalog
    {
        public override void AddModule(ModuleInfo moduleInfo)
        {
            base.AddModule(moduleInfo);

            if (!AppDomain.CurrentDomain.IsDefaultAppDomain())
            {
                var t = Type.GetType(moduleInfo.ModuleType);
                var file = Path.GetFileName(moduleInfo.Ref);
                moduleInfo.Ref = "file:///" + Path.Combine(AppDomain.CurrentDomain.SetupInformation.ApplicationBase, file);
            }
            //System.Diagnostics.Debug.WriteLine(string.Format("moduleInfo ref={0}", moduleInfo.Ref));
        }
    }
}
