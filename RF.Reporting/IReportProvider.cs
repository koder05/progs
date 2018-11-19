using System;
using System.Xml;

namespace RF.Reporting
{
	/// <summary>
	/// ��������� ���������� �������� ��� �������.
	/// </summary>
	public interface IReportProvider
	{
		/// <summary>
		/// ���������� XSLT-������ ������ ��� ������ <see cref="System.Xml.XmlDocument"/> �� ����� ������ ��� MIME-����.
		/// </summary>
		/// <param name="reportName">��� ������.</param>
		/// <param name="contentType">MIME-��� ������.</param>
		/// <param name="languageCode">��� ����� (2 �������)</param>
		/// <returns>XSLT-������ ������, ��� ������ <see cref="System.Xml.XmlDocument"/>.</returns>
		XmlDocument GetReportTemplate(string reportName, string contentType, string languageCode);

		XmlResolver GetResolver(string reportName, string contentType, string languageCode);
	}
}