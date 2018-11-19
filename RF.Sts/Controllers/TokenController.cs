using System;
using System.Collections.Generic;
using System.Net;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Web.Http;
using System.Text;
using Microsoft.IdentityModel.Claims;

using RF.Sts.Auth;
using RF.Sts.Auth.Configuration;
using RF.WebApp.Models;

namespace RF.Sts.Controllers
{
    public class TokenController : ApiController
    {
        public string Get()
        {
            return string.Format("{0}! Hello from win identity http service.", "user");
        }
        
        public HttpResponseMessage Post(string id, OAuthClient cl)
        {
            //Uri scope = rst.Scope;
            Uri scope = new Uri("localhost:2500");

            if (scope == null)
            {
                return Request.CreateResponse<TokenResponse>(HttpStatusCode.BadRequest, new TokenResponse() { Error = OAuthError.INVALID_REQUEST });
            }

            var c = OAuthCodeCache.Get(id);

            //return Request.CreateResponse(HttpStatusCode.OK, c);

            if (string.IsNullOrEmpty(c))
            {
                return Request.CreateResponse<TokenResponse>(HttpStatusCode.BadRequest, new TokenResponse() { Error = OAuthError.INVALID_REQUEST });
            }

            string key = OAuthConfiguration.Configuration.StsSettings.SymmetricKey;
            TimeSpan lifeTime = new TimeSpan(0, 0, OAuthConfiguration.Configuration.StsSettings.TokenLifeTimeInSec);

            var claims = new List<Claim>();
            //claims.Add(new Claim(ClaimTypes.Name, this.User.Identity.Name));
            claims.Add(new Claim(ClaimTypes.Name, c));
            claims.Add(new Claim(ClaimTypes.Role, "AssetsServiceUser"));
            claims.Add(new Claim(ClaimTypes.Role, "Developer"));
            claims.Add(new Claim(ClaimTypes.Role, "Administrator"));

            SimpleWebToken token = new SimpleWebToken(scope, OAuthConfiguration.Configuration.StsSettings.IssuerUri.ToString(), DateTime.UtcNow + lifeTime, claims, key);

            var tokenResponse = new TokenResponse() { AccessToken = token.ToString(), TokenType = "bearer", ExpiresIn = 600 };
            return Request.CreateResponse<TokenResponse>(HttpStatusCode.OK, tokenResponse);
        }
    }
}
