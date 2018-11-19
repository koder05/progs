using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Caching;
using System.Runtime.Serialization;

namespace RF.WebApp.Models
{
    [DataContract]
    public class OAuthClient
    {
        [DataMember(Name = "svrsecret", EmitDefaultValue = false)]
        public string Secret { get; set; }
    }

    public class OAuthCode
    {
        public string Code { get; private set; }
        public string UserName { get; private set; }

        public OAuthCode(string usr)
        {
            UserName = usr;
            Code = Guid.NewGuid().ToString();
        }
    }

    public static class OAuthCodeCache
    {
        private static MemoryCache _cache = MemoryCache.Default;

        public static string Get(string code)
        {
            lock (_cache)
            {
                if (_cache.Contains(code))
                {
                    return _cache[code] as string;
                }
            }

            return string.Empty;
        }

        public static void Add(OAuthCode c)
        {
            lock (_cache)
            {
                if (!_cache.Contains(c.Code))
                {
                    CacheItemPolicy cacheItemPolicy = new CacheItemPolicy();
                    cacheItemPolicy.AbsoluteExpiration = DateTime.Now.AddMinutes(10);
                    _cache.Add(c.Code, c.UserName, cacheItemPolicy);
                }
            }
        }
    }
}