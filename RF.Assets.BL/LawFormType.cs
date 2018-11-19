using System;
using System.ComponentModel;

namespace RF.BL.Model.Enums
{
	/// <summary>
	/// ��������������-�������� �����
	/// </summary>
	public enum LawFormType : byte
	{
		[Description(" ")]
		None = 0,

		[Description("�����")]
		PBOUL = 1,

		[Description("��")]
		IP = 2,

		[Description("���")]
		ZAO = 3,

		[Description("����")]
		OOOI = 4,

		[Description("���")]
		OAO = 5,

		[Description("��")]
		CHP = 6,

		[Description("���")]
		GUP = 7,

		[Description("���")]
		OOO = 8,

		[Description("����")]
		SOOO = 9,

		[Description("���")]
		MUP = 10,

		[Description("��")]
		KT = 11,

		[Description("����")]
		OGUP = 12,

        [Description("��")]
	    MP = 13,

		[Description("��")]
	    PO = 14,

		[Description("���")]
	    NPO = 15,

        [Description("�����")]
        PPZSK = 16,

        [Description("���")]
        TOO = 17,

        [Description("����")]
        FGUP = 18,

        [Description("���")]
        SPK = 19,

        [Description("����")]
        SPKH = 20,

        [Description("���� ���")]
        APKFZAO = 21,

        [Description("�����")]
        ZANPO = 22,

		[Description("���")]
		FGU = 23,

		[Description("����")]
		ZAOR = 24,

		[Description("����")]
		SHPK = 25,

		[Description("��� ���")]
		ZAONPO = 26,

		[Description("���")]
		KFH = 27,

		[Description("���.����")]
		Person = 28,

		[Description("��")]
		SD = 29
	}
}