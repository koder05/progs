using System;

namespace RF.Reporting
{
	/// <summary>
	/// ���������, ������������, ����� ���� �������� � �� �������� ����� ��������������
	/// </summary>
	public interface IExportConstraint
	{
		string[] GetExportProperties(Type type);
	}
}