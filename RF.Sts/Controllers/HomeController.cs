using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.Mvc;
using System.Text;

using RF.WebApp.Models;

namespace RF.Sts.Controllers
{
    public class HomeController : Controller
    {
        [Authorize]
        public ActionResult Index()
        {
            var usr = this.HttpContext.User;
            var code = new OAuthCode(usr.Identity.Name);
            OAuthCodeCache.Add(code);

            var query = HttpUtility.UrlDecode(this.HttpContext.Request.QueryString.ToString());
            var queryParts = query.Split('&');

            var redirectUrl = "";
            var newQuery = string.Format("code={0}", code.Code); 

            foreach (var s in queryParts)
            {
                if (s.StartsWith("callbackUrl=", StringComparison.InvariantCultureIgnoreCase))
                {
                    redirectUrl = s.Replace("callbackUrl=", "");
                }
                else
                {
                    newQuery += string.Format("&{0}", s); 
                }
            }

            if (string.IsNullOrEmpty(redirectUrl)==false)
            {
                return Redirect(string.Format("{0}?{1}", redirectUrl, HttpUtility.UrlEncode(newQuery)));
            }
            
            ViewBag.UserFIO = usr.Identity.Name;
            return View();
        }

        public ActionResult Login()
        {
            if (this.HttpContext.User.Identity.IsAuthenticated)
            {
                return RedirectToAction("Index", "Home");
            }

            return View();
        }

        public ActionResult LoginRedirect(string returnUrl) 
        { 
            var redirectUrl = this.Url.Action("Login");
            StringBuilder query = new StringBuilder();
            foreach (var k in this.HttpContext.Request.QueryString.AllKeys)
            {
                if (k.Equals("returnUrl", StringComparison.InvariantCultureIgnoreCase)==false)
                    query.AppendFormat("&{0}={1}", k, this.HttpContext.Request.QueryString[k]);
            }
            
            return Redirect(string.Format("{0}{1}{2}", redirectUrl, query.Length > 0 ? "?" : "", HttpUtility.UrlEncode(query.ToString().TrimStart('&'))));
        }

        [HttpPost]
        public ActionResult Login(LoginModel model, string returnUrl)
        {
            if (ModelState.IsValid)
            {
                if (model.UserName == "eivanov" && model.Password == "123")
                {
                    FormsAuthentication.SetAuthCookie(model.UserName, model.RememberMe);
                    var redirectUrl = this.Url.Action("Index");
                    return Redirect(string.Format("{0}{1}", redirectUrl, this.HttpContext.Request.UrlReferrer.Query));
                }
                else
                {
                    ModelState.AddModelError("", "Unknown logon user or password");
                }
            }

            return View(model);
        }
    }
}
