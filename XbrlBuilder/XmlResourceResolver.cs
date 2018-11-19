using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;
using System.Xml;

namespace XbrlBuilder
{
    public class XmlResourceResolver : XmlUrlResolver
    {
        private Action<string> _progressCallback;

        public XmlResourceResolver(Action<string> progressCallback)
        {
            _progressCallback = progressCallback;
        }

        public XmlResourceResolver()
        {
        }

        public override object GetEntity(Uri absoluteUri, string role, Type ofObjectToReturn)
        {
            if (_progressCallback != null)
                _progressCallback(absoluteUri.AbsoluteUri);
            var urlParts = absoluteUri.LocalPath.Replace('\\', '/').Split('/');
            if(urlParts.Count() > 0 && urlParts[urlParts.Count() - 1].EndsWith("xsd"))
            { 
                var schName = string.Concat(Assembly.GetExecutingAssembly().GetName().Name, ".Schemas.", urlParts[urlParts.Count() - 1]);
                var stream = Assembly.GetExecutingAssembly().GetManifestResourceStream(schName);
                if (stream != null)
                    return stream;
            }
            return base.GetEntity(absoluteUri, role, ofObjectToReturn);
        }
    }
}
