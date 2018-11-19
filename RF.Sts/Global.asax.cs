using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.Http;
using System.Web.Mvc;
using System.Web.Optimization;
using System.Web.Routing;

namespace RF.Sts
{
    // Note: For instructions on enabling IIS6 or IIS7 classic mode, 
    // visit http://go.microsoft.com/?LinkId=9394801

    public class WebApiApplication : System.Web.HttpApplication
    {
        protected void Application_Start()
        {
            AreaRegistration.RegisterAllAreas();

            WebApiConfig.Register(GlobalConfiguration.Configuration);
            FilterConfig.RegisterGlobalFilters(GlobalFilters.Filters);
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            RF.WebApp.BundleConfig.RegisterBundles(BundleTable.Bundles);
            //System.Net.ServicePointManager.DefaultConnectionLimit = 100;
        }

        //protected void Application_AuthenticateRequest(object sender, EventArgs e)
        //{
        //    string cookieName = FormsAuthentication.FormsCookieName;
        //    HttpCookie authCookie = Context.Request.Cookies[cookieName];
        //    if (authCookie == null)
        //    {
        //        string[] url = Request.RawUrl.Split('?');
        //        if (url[0] != "/")
        //        {
        //            Response.Redirect("~/login");
        //            return;
        //        }
        //    }
        //}
    }
}