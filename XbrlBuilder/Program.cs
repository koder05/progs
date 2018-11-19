using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Xml.Schema;
using XbrlBuilder.Configuration;

namespace XbrlBuilder
{
    class Program
    {
        private static IEnumerable<XbrlReportMeta> metas = new XbrlReportMeta[]
        {
            new XbrlReportMeta { Id = 257, ReportName="xbrl257.xml", RawDataSchemaName="Raw257.xsd", XsltName="Report257.xslt"
                , XbrlSchemas=new XmlSchema[] { new XmlSchema { Id= "ep_nso_npf_y_90d_reestr_0420257.xsd", TargetNamespace= "http://www.cbr.ru/xbrl/nso/npf/rep/2018-03-31/ep/ep_nso_npf_y_90d_reestr_0420257" } } },
            new XbrlReportMeta { Id = 258, ReportName="xbrl258.xml", RawDataSchemaName="Raw258.xsd", XsltName="Report258.xslt"
                , XbrlSchemas=new XmlSchema[] { new XmlSchema { Id= "ep_nso_npf_q_30d_reestr_0420258.xsd", TargetNamespace= "http://www.cbr.ru/xbrl/nso/npf/rep/2018-03-31/ep/ep_nso_npf_q_30d_reestr_0420258" } } },
        };


        [STAThread]
        static void Main(string[] args)
        {
            try
            {
                Console.WriteLine("Настройки:");
                var cfg = ProgCfg.Configuration;
                var ceo = cfg.Staff[StaffRole.CEO];
                var auth = cfg.Staff[StaffRole.Author];
                var sign = cfg.Staff[StaffRole.Signer];
                var eio = cfg.Staff[StaffRole.EIO];
                int repNum = 0;
                string repNumInput = args.Length > 0 ? args[0] : cfg.ProgSettings.Number;

                Console.WriteLine("Ответственный Xbrl:");
                Console.WriteLine(string.Format("{0} ФИО: {1}", '\t', auth.FullName));
                Console.WriteLine(string.Format("{0} Должность: {1}", '\t', auth.Position));
                Console.WriteLine(string.Format("{0} Телефон: {1}", '\t', auth.Phone));
                Console.WriteLine();
                Console.WriteLine("Ответственный Nis:");
                Console.WriteLine(string.Format("{0} ФИО: {1}", '\t', sign.FullName));
                Console.WriteLine(string.Format("{0} Должность: {1}", '\t', sign.Position));
                Console.WriteLine(string.Format("{0} Телефон: {1}", '\t', sign.Phone));
                Console.WriteLine();
                Console.WriteLine("Ответственный Forms:");
                Console.WriteLine(string.Format("{0} ФИО: {1}", '\t', eio.FullName));
                Console.WriteLine(string.Format("{0} Должность: {1}", '\t', eio.Position));
                Console.WriteLine(string.Format("{0} Телефон: {1}", '\t', eio.Phone));
                Console.WriteLine();
                Console.WriteLine("CEO:");
                Console.WriteLine(string.Format("{0} ФИО: {1}", '\t', ceo.FullName));
                Console.WriteLine(string.Format("{0} Должность: {1}", '\t', ceo.Position));
                Console.WriteLine(string.Format("{0} Телефон: {1}", '\t', ceo.Phone));
                Console.WriteLine();
                Console.WriteLine("Параметры отчета:");
                Console.WriteLine(string.Format("{0} Идентификатор: {1}", '\t', cfg.ProgSettings.Id));
                Console.WriteLine(string.Format("{0} Начало периода: {1}", '\t', cfg.ProgSettings.ReportPeriodBeginDate.Value));
                Console.WriteLine(string.Format("{0} Конец периода: {1}", '\t', cfg.ProgSettings.ReportDate));
                Console.WriteLine();
                Console.WriteLine("Фонд:");
                Console.WriteLine(string.Format("{0} ОКАТО: {1}", '\t', cfg.Npf.Okato));
                Console.WriteLine(string.Format("{0} ИНН: {1}", '\t', cfg.Npf.Inn));
                Console.WriteLine(string.Format("{0} ОГРН: {1}", '\t', cfg.Npf.Ogrn));
                Console.WriteLine(string.Format("{0} Лицензия: {1}", '\t', cfg.Npf.LicNum));
                Console.WriteLine();

                if (cfg.Totals != null && cfg.Totals.ElementInformation.IsPresent)
                {
                    Console.WriteLine("Констатнты ИТОГО:");
                    Console.WriteLine(string.Format("{0} Резерв пожизненных выплат на начало: {1}", '\t', cfg.Totals.LifetimeReserveOnBegin));
                    Console.WriteLine(string.Format("{0} Резерв пожизненных выплат на конец: {1}", '\t', cfg.Totals.LifetimeReserveOnDate));
                    Console.WriteLine(string.Format("{0} Резерв пожизненных выплат переводы за период: {1}", '\t', cfg.Totals.LifetimeReserveTransfers));
                    Console.WriteLine(string.Format("{0} Выплаты НПО: {1}", '\t', cfg.Totals.NpoPaid));
                }
                Console.WriteLine();
                Console.WriteLine("В исходном файле Excel необходимо вытереть все заголовки и сохранить его как Unicode Text.");

                if (string.IsNullOrEmpty(repNumInput))
                {
                    Console.WriteLine("Если готово, введите номер отчета...");
                    repNumInput = Console.ReadLine();
                }
                else
                {
                    Console.WriteLine("Строим отчет №" + repNumInput);
                    Console.WriteLine("Если готово, press any key...");
                    Console.ReadKey();
                }
                
                if (int.TryParse(repNumInput, out repNum) && metas.Any(m => m.Id == repNum))
                {
                    var meta = metas.First(m => m.Id == repNum);
                    Console.WriteLine();

                    var dlg = new OpenFileDialog();
                    if (dlg.ShowDialog() == DialogResult.OK)
                    {
                        Console.WriteLine(dlg.FileName);
                        var processor = new Builder();

                        Console.WriteLine("Читаем данные...");
                        var xml = processor.BuildRawXml(dlg.FileName);
                        Console.WriteLine("Читаем данные... готово");

                        Console.WriteLine("Проверяем данные...");
                        processor.Validate(meta.RawDataSchemaName, "", xml, null);
                        Console.WriteLine("Проверяем данные... готово");

                        Console.WriteLine("Формируем xbrl...");
                        var ret = processor.Transform(meta.XsltName, xml);
                        Console.WriteLine("Формируем xbrl... готово");

                        Console.WriteLine("Проверка по схемам xbrl...");
                        foreach (var sch in meta.XbrlSchemas)
                        {
                            processor.Validate(sch.Id, sch.TargetNamespace, ret, (s) => Console.WriteLine(s));
                        }
                        Console.WriteLine("Проверка по схемам xbrl... готово");

                        Console.WriteLine(string.Format("Сохраняем в файл \"{0}\"...", meta.ReportName));
                        ret.Save(meta.ReportName);
                        Console.WriteLine("Готово!");
                    }
                }
                else
                {
                    Console.WriteLine("Неизвестный номер отчета.");
                }
            }
            catch (Exception e)
            {
                Console.WriteLine(e);
            }

            Console.WriteLine("press any key to exit");
            Console.ReadKey();
        }
    }
}
