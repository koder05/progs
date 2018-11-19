using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Schema;

namespace XbrlBuilder
{
    public class XbrlReportMeta
    {
        public int Id { get; set; }
        public string RawDataSchemaName { get; set; }
        public string XsltName { get; set; }
        public string ReportName { get; set; }
        public IEnumerable<XmlSchema> XbrlSchemas { get; set; }
    }
}
