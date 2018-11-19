using System;
using System.Globalization;
using System.Xml.Linq;

namespace XbrlBuilder
{
    internal class XDateElement : XElement
    {
        public XDateElement(XName name, DateTime Date) :
          base(name, Date.ToString("yyyy-MM-dd", CultureInfo.InvariantCulture))
        { }
    }

    internal class XDateAttribute : XAttribute
    {
        public XDateAttribute(XName name, DateTime Date) :
          base(name, Date.ToString("yyyy-MM-dd", CultureInfo.InvariantCulture))
        { }
    }
}
