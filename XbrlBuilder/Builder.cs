using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Xml;
using System.Xml.Linq;
using System.Xml.Schema;
using System.Xml.XPath;
using System.Xml.Xsl;
using XbrlBuilder.Configuration;

namespace XbrlBuilder
{
    public class Builder
    {
        public XDocument BuildRawXml(string csvPath)
        {
            var cfg = ProgCfg.Configuration;
            var ceo = cfg.Staff[StaffRole.CEO];
            var auth = cfg.Staff[StaffRole.Author];
            var sign = cfg.Staff[StaffRole.Signer];
            var eio = cfg.Staff[StaffRole.EIO];

            XElement totals = null;
            if (cfg.Totals != null && cfg.Totals.ElementInformation.IsPresent)
            {
                totals = new XElement("totals"
                            , new XAttribute("lifetimeRes", cfg.Totals.LifetimeReserveOnDate)
                            , new XAttribute("lifetimeResOnBegin", cfg.Totals.LifetimeReserveOnBegin)
                            , new XAttribute("npoPaid", cfg.Totals.NpoPaid)
                            , new XAttribute("lifetimeResTrans", cfg.Totals.LifetimeReserveTransfers)
                            );
            }

            //var data = File.ReadAllLines(csvPath, Encoding.GetEncoding(1251));
            var data = File.ReadAllLines(csvPath, Encoding.Unicode);
            var xml = new XDocument(new XDeclaration("1.0", "UTF-8", "yes")
                , new XElement("root"
                    ,  data.Select(line => {
                            int i = 0;
                            return new XElement("row", line.Split('\t')
                                .Select(s =>
                                {
                                    s = s.Trim('"').Trim();
                                    var ret = string.IsNullOrEmpty(s) ? null : new XElement("F" + i, s);
                                    i++;
                                    return ret;
                                }
                            ));
                        })
                    , new XElement("resume"
                        , new XElement("XbrlResponsible"
                            , new XAttribute("fio", auth.FullName)
                            , new XAttribute("pos", auth.Position)
                            , new XAttribute("phone", auth.Phone)
                            )
                        , new XElement("NisResponsible"
                            , new XAttribute("fio", sign.FullName)
                            , new XAttribute("pos", sign.Position)
                            , new XAttribute("phone", sign.Phone)
                            )
                        , new XElement("FormResponsible"
                            , new XAttribute("fio", eio.FullName)
                            , new XAttribute("pos", eio.Position)
                            , new XAttribute("phone", eio.Phone)
                            )
                        , new XElement("CEO"
                            , new XAttribute("fio", ceo.FullName)
                            , new XAttribute("pos", ceo.Position)
                            , new XAttribute("phone", ceo.Phone)
                            )
                        , new XElement("report"
                            , new XAttribute("id", cfg.ProgSettings.Id)
                            , new XDateAttribute("periodBegin", cfg.ProgSettings.ReportPeriodBeginDate.Value)
                            , new XDateAttribute("periodEnd", cfg.ProgSettings.ReportDate)
                            , new XDateAttribute("periodPrebegin", cfg.ProgSettings.ReportPeriodBeginDate.Value.AddDays(-1))
                            , new XAttribute("matter", cfg.ProgSettings.Matter)
                            )
                        , new XElement("fund"
                            , new XAttribute("okato", cfg.Npf.Okato)
                            , new XAttribute("inn", cfg.Npf.Inn)
                            , new XAttribute("ogrn", cfg.Npf.Ogrn)
                            , new XAttribute("lic", cfg.Npf.LicNum)
                            )
                        , totals
                        )
                    )
            );
            return xml;
        }

        public XDocument Transform(string xsltResourceName, XDocument data)
        {
            XslCompiledTransform proc = new XslCompiledTransform();
            var xsltName = string.Concat(Assembly.GetExecutingAssembly().GetName().Name, ".Templates.", xsltResourceName);
            var xsltBody = Assembly.GetExecutingAssembly().GetManifestResourceStream(xsltName);
            var xslt = new XPathDocument(XmlReader.Create(xsltBody));
            proc.Load(xslt);

            XDocument result = new XDocument();
            using (XmlWriter xw = result.CreateWriter())
            {
                proc.Transform(data.CreateNavigator(), xw);
            }

            return result;
        }

        public void Validate(string schResourceName, string targetNs, XDocument data,  Action<string> progressCallback)
        {
            if(progressCallback != null)
                progressCallback(targetNs); 
            var schName = string.Concat(Assembly.GetExecutingAssembly().GetName().Name, ".Schemas.", schResourceName);
            var schBody = Assembly.GetExecutingAssembly().GetManifestResourceStream(schName);
            XmlSchemaSet schemas = new XmlSchemaSet() { XmlResolver = new XmlResourceResolver(progressCallback) };
            schemas.Add(targetNs, XmlReader.Create(schBody));

            if (progressCallback != null)
                progressCallback("Schemas validation....");
            data.Validate(schemas, (o, e) => { throw e.Exception; }, true);
        }
    }
}
