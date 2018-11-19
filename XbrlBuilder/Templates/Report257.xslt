<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl"
    xmlns:npf-dic="http://www.cbr.ru/xbrl/nso/npf/dic" xmlns:xbrli="http://www.xbrl.org/2003/instance" xmlns:dim-int="http://www.cbr.ru/xbrl/udr/dim/dim-int"
    xmlns:xbrldi="http://xbrl.org/2006/xbrldi"
>
  <xsl:output method="xml" indent="yes"/>

  <xsl:template match="/root">

    <xsl:variable name="id" select="resume/report/@id" />
    <xsl:variable name="matter" select="resume/report/@matter" />
    <xsl:variable name="periodBegin" select="resume/report/@periodBegin" />
    <xsl:variable name="periodEnd" select="resume/report/@periodEnd" />
    <xsl:variable name="periodPrebegin" select="resume/report/@periodPrebegin" />
    <xsl:variable name="rows" select="count(//row)" />

    <xsl:variable name="Pol_Enumerator">
      <dict key="Ж" value="mem-int:Pol_ZHMember" />
      <dict key="М" value="mem-int:Pol_MMember" />
      <dict key="-" value="mem-int:Ne_PrimenimoMember" />
    </xsl:variable>
    <xsl:variable name="Status_Dog_OPSEnumerator">
      <dict key="Д" value="mem-int:Status_Dog_OPS_DMember" />
      <dict key="ДЕ" value="mem-int:Status_Dog_OPS_DEMember" />
      <dict key="ДС" value="mem-int:Status_Dog_OPS_DSMember" />
      <dict key="ДН" value="mem-int:Status_Dog_OPS_DNMember" />
      <dict key="ДСН" value="mem-int:Status_Dog_OPS_DSNMember" />
      <dict key="ДСН-1" value="mem-int:Status_Dog_OPS_DSN1Member" />
      <dict key="ДСН-2" value="mem-int:Status_Dog_OPS_DSN2Member" />
      <dict key="ДСЕ" value="mem-int:Status_Dog_OPS_DSEMember" />
      <dict key="ДСЕ-1" value="mem-int:Status_Dog_OPS_DSE1Member" />
      <dict key="ДСЕ-2" value="mem-int:Status_Dog_OPS_DSE2Member" />
      <dict key="ПС" value="mem-int:Status_Dog_OPS_PSMember" />
      <dict key="П" value="mem-int:Status_Dog_OPS_PMember" />
    </xsl:variable>
    <xsl:variable name="Status_ZastrLiczaEnumerator">
      <dict key="текущий" value="mem-int:TekushhijMember" />
      <dict key="ТЕКУЩИЙ" value="mem-int:TekushhijMember" />
      <dict key="ушедший" value="mem-int:UshedshijMember" />
      <dict key="УШЕДШИЙ" value="mem-int:UshedshijMember" />
      <dict key="пришедший" value="mem-int:PrishedshijMember" />
      <dict key="ПРИШЕДШИЙ" value="mem-int:PrishedshijMember" />
    </xsl:variable>
    <xsl:variable name="Obosn_Statusa_ZastrLiczaEnumerator">
      <dict key="НПФ" value="mem-int:NPFMember" />
      <dict key="ПФР" value="mem-int:PFRMember" />
      <dict key="СМ-НПФ" value="mem-int:SM_NPFMember" />
      <dict key="СМ-ПФР" value="mem-int:SM_PFRMember" />
      <dict key="СУД-НПФ" value="mem-int:SUD_NPFMember" />
      <dict key="СУД-ПФР" value="mem-int:SUD_PFRMember" />
      <dict key="СМ" value="mem-int:SMMember" />
    </xsl:variable>    

    <xbrl xmlns:link="http://www.xbrl.org/2003/linkbase" xmlns:npf-dic="http://www.cbr.ru/xbrl/nso/npf/dic" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:iso4217="http://www.xbrl.org/2003/iso4217" xmlns:mem-int="http://www.cbr.ru/xbrl/udr/dom/mem-int" xmlns:xbrldi="http://xbrl.org/2006/xbrldi" xmlns:dim-int="http://www.cbr.ru/xbrl/udr/dim/dim-int" xmlns="http://www.xbrl.org/2003/instance">
      <link:schemaRef xlink:type="simple" xlink:href="http://www.cbr.ru/xbrl/nso/npf/rep/2018-03-31/ep/ep_nso_npf_y_90d_reestr_0420257.xsd"/>

      <xsl:for-each select="row">
        <context>
          <xsl:attribute name="id">
          <xsl:text>Context</xsl:text>
          <xsl:value-of select="(position() - 1) * 21 + 0"/>
          </xsl:attribute>
          <entity>
            <identifier scheme="http://www.cbr.ru"><xsl:value-of select="$id"/></identifier>
          </entity>
          <period>
            <instant><xsl:value-of select="$periodEnd"/></instant>
          </period>
          <scenario>
            <xbrldi:typedMember dimension="dim-int:ID_Zastraxovannogo_LiczaTaxis">
              <dim-int:ID_FL_YULTypedName><xsl:value-of select="F0"/></dim-int:ID_FL_YULTypedName>
            </xbrldi:typedMember>
          </scenario>
        </context>
        <xsl:if test="F20">
          <context>
            <xsl:attribute name="id">
              <xsl:text>Context</xsl:text>
              <xsl:value-of select="(position() - 1) * 21 + 1"/>
            </xsl:attribute>
            <entity>
              <identifier scheme="http://www.cbr.ru"><xsl:value-of select="$id"/></identifier>
            </entity>
            <period>
              <instant><xsl:value-of select="$periodPrebegin"/></instant>
            </period>
            <scenario>
              <xbrldi:typedMember dimension="dim-int:ID_Zastraxovannogo_LiczaTaxis">
                <dim-int:ID_FL_YULTypedName><xsl:value-of select="F0"/></dim-int:ID_FL_YULTypedName>
              </xbrldi:typedMember>
            </scenario>
          </context>
        </xsl:if>           
        <xsl:if test="F21">
          <context>
            <xsl:attribute name="id">
              <xsl:text>Context</xsl:text>
              <xsl:value-of select="(position() - 1) * 21 + 2"/>
            </xsl:attribute>
            <entity>
              <identifier scheme="http://www.cbr.ru"><xsl:value-of select="$id"/></identifier>
            </entity>
            <period>
              <instant><xsl:value-of select="$periodPrebegin"/></instant>
            </period>
            <scenario>
              <xbrldi:explicitMember dimension="dim-int:Dvizh_Sredstv_PensNakoplAxis">mem-int:Sredstva_Finans_Nakopit_PensMember</xbrldi:explicitMember>
              <xbrldi:typedMember dimension="dim-int:ID_Zastraxovannogo_LiczaTaxis">
                <dim-int:ID_FL_YULTypedName><xsl:value-of select="F0"/></dim-int:ID_FL_YULTypedName>
              </xbrldi:typedMember>
            </scenario>
          </context>
        </xsl:if>          
        <xsl:if test="F22">
          <context>
            <xsl:attribute name="id">
              <xsl:text>Context</xsl:text>
              <xsl:value-of select="(position() - 1) * 21 + 3"/>
            </xsl:attribute>
          <entity>
            <identifier scheme="http://www.cbr.ru"><xsl:value-of select="$id"/></identifier>
          </entity>
          <period>
            <instant><xsl:value-of select="$periodPrebegin"/></instant>
          </period>
          <scenario>
            <xbrldi:explicitMember dimension="dim-int:Dvizh_Sredstv_PensNakoplAxis">mem-int:Sredstva_Sofinans_Form_PensNakoplMember</xbrldi:explicitMember>
            <xbrldi:typedMember dimension="dim-int:ID_Zastraxovannogo_LiczaTaxis">
              <dim-int:ID_FL_YULTypedName><xsl:value-of select="F0"/></dim-int:ID_FL_YULTypedName>
            </xbrldi:typedMember>
          </scenario>
        </context>
        </xsl:if>                  
        <xsl:if test="F23">
          <context>
            <xsl:attribute name="id">
              <xsl:text>Context</xsl:text>
              <xsl:value-of select="(position() - 1) * 21 + 4"/>
            </xsl:attribute>
          <entity>
            <identifier scheme="http://www.cbr.ru"><xsl:value-of select="$id"/></identifier>
          </entity>
          <period>
            <instant><xsl:value-of select="$periodPrebegin"/></instant>
          </period>
          <scenario>
            <xbrldi:explicitMember dimension="dim-int:Dvizh_Sredstv_PensNakoplAxis">mem-int:Sredstva_Mat_KapitalMember</xbrldi:explicitMember>
            <xbrldi:typedMember dimension="dim-int:ID_Zastraxovannogo_LiczaTaxis">
              <dim-int:ID_FL_YULTypedName><xsl:value-of select="F0"/></dim-int:ID_FL_YULTypedName>
            </xbrldi:typedMember>
          </scenario>
        </context>
        </xsl:if>  
        <xsl:if test="F24 or F28 or F32 or F36 or F37 or F41 or F47 or F48 or F57 or F58">
          <context>
            <xsl:attribute name="id">
              <xsl:text>Context</xsl:text>
              <xsl:value-of select="(position() - 1) * 21 + 5"/>
            </xsl:attribute>
          <entity>
            <identifier scheme="http://www.cbr.ru"><xsl:value-of select="$id"/></identifier>
          </entity>
          <period>
            <startDate><xsl:value-of select="$periodBegin"/></startDate>
            <endDate><xsl:value-of select="$periodEnd"/></endDate>
          </period>
          <scenario>
            <xbrldi:typedMember dimension="dim-int:ID_Zastraxovannogo_LiczaTaxis">
              <dim-int:ID_FL_YULTypedName><xsl:value-of select="F0"/></dim-int:ID_FL_YULTypedName>
            </xbrldi:typedMember>
          </scenario>
        </context>
        </xsl:if>  
        <xsl:if test="F25 or F29 or F38 or F42">
          <context>
            <xsl:attribute name="id">
              <xsl:text>Context</xsl:text>
              <xsl:value-of select="(position() - 1) * 21 + 6"/>
            </xsl:attribute>
            <entity>
              <identifier scheme="http://www.cbr.ru"><xsl:value-of select="$id"/></identifier>
            </entity>
            <period>
              <startDate><xsl:value-of select="$periodBegin"/></startDate>
              <endDate><xsl:value-of select="$periodEnd"/></endDate>
            </period>
            <scenario>
              <xbrldi:explicitMember dimension="dim-int:Dvizh_Sredstv_PensNakoplAxis">mem-int:Sredstva_Finans_Nakopit_PensMember</xbrldi:explicitMember>
              <xbrldi:typedMember dimension="dim-int:ID_Zastraxovannogo_LiczaTaxis">
                <dim-int:ID_FL_YULTypedName><xsl:value-of select="F0"/></dim-int:ID_FL_YULTypedName>
              </xbrldi:typedMember>
            </scenario>
          </context>
        </xsl:if>        
        <xsl:if test="F26 or F30 or F39 or F43">   
          <context>
            <xsl:attribute name="id">
              <xsl:text>Context</xsl:text>
              <xsl:value-of select="(position() - 1) * 21 + 7"/>
            </xsl:attribute>
          <entity>
            <identifier scheme="http://www.cbr.ru"><xsl:value-of select="$id"/></identifier>
          </entity>
          <period>
            <startDate><xsl:value-of select="$periodBegin"/></startDate>
            <endDate><xsl:value-of select="$periodEnd"/></endDate>
          </period>
          <scenario>
            <xbrldi:explicitMember dimension="dim-int:Dvizh_Sredstv_PensNakoplAxis">mem-int:Sredstva_Sofinans_Form_PensNakoplMember</xbrldi:explicitMember>
            <xbrldi:typedMember dimension="dim-int:ID_Zastraxovannogo_LiczaTaxis">
              <dim-int:ID_FL_YULTypedName><xsl:value-of select="F0"/></dim-int:ID_FL_YULTypedName>
            </xbrldi:typedMember>
          </scenario>
        </context>        
        </xsl:if>        
        <xsl:if test="F27 or F31 or F40 or F44">
          <context>
            <xsl:attribute name="id">
              <xsl:text>Context</xsl:text>
              <xsl:value-of select="(position() - 1) * 21 + 8"/>
            </xsl:attribute>
          <entity>
            <identifier scheme="http://www.cbr.ru"><xsl:value-of select="$id"/></identifier>
          </entity>
          <period>
            <startDate><xsl:value-of select="$periodBegin"/></startDate>
            <endDate><xsl:value-of select="$periodEnd"/></endDate>
          </period>
          <scenario>
            <xbrldi:explicitMember dimension="dim-int:Dvizh_Sredstv_PensNakoplAxis">mem-int:Sredstva_Mat_KapitalMember</xbrldi:explicitMember>
            <xbrldi:typedMember dimension="dim-int:ID_Zastraxovannogo_LiczaTaxis">
              <dim-int:ID_FL_YULTypedName><xsl:value-of select="F0"/></dim-int:ID_FL_YULTypedName>
            </xbrldi:typedMember>
          </scenario>
        </context>
        </xsl:if>
        <xsl:if test="F33">   
          <context>
            <xsl:attribute name="id">
              <xsl:text>Context</xsl:text>
              <xsl:value-of select="(position() - 1) * 21 + 9"/>
            </xsl:attribute>
          <entity>
            <identifier scheme="http://www.cbr.ru"><xsl:value-of select="$id"/></identifier>
          </entity>
          <period>
            <startDate><xsl:value-of select="$periodBegin"/></startDate>
            <endDate><xsl:value-of select="$periodEnd"/></endDate>
          </period>
          <scenario>
            <xbrldi:explicitMember dimension="dim-int:Sovokup_Razmer_Pens_Vypl_ZastrLiczu_SrochnAxis">mem-int:SrochnayaMember</xbrldi:explicitMember>
            <xbrldi:typedMember dimension="dim-int:ID_Zastraxovannogo_LiczaTaxis">
              <dim-int:ID_FL_YULTypedName><xsl:value-of select="F0"/></dim-int:ID_FL_YULTypedName>
            </xbrldi:typedMember>
          </scenario>
        </context>
        </xsl:if>
        <xsl:if test="F34">
          <context>
            <xsl:attribute name="id">
              <xsl:text>Context</xsl:text>
              <xsl:value-of select="(position() - 1) * 21 + 10"/>
            </xsl:attribute>
          <entity>
            <identifier scheme="http://www.cbr.ru"><xsl:value-of select="$id"/></identifier>
          </entity>
          <period>
            <startDate><xsl:value-of select="$periodBegin"/></startDate>
            <endDate><xsl:value-of select="$periodEnd"/></endDate>
          </period>
          <scenario>
            <xbrldi:explicitMember dimension="dim-int:Sovokup_Razmer_Pens_Vypl_ZastrLiczu_SrochnAxis">mem-int:PozhiznennayaMember</xbrldi:explicitMember>
            <xbrldi:typedMember dimension="dim-int:ID_Zastraxovannogo_LiczaTaxis">
              <dim-int:ID_FL_YULTypedName><xsl:value-of select="F0"/></dim-int:ID_FL_YULTypedName>
            </xbrldi:typedMember>
          </scenario>
        </context>          
        </xsl:if>        
        <xsl:if test="F35">   
          <context>
            <xsl:attribute name="id">
              <xsl:text>Context</xsl:text>
              <xsl:value-of select="(position() - 1) * 21 + 11"/>
            </xsl:attribute>
          <entity>
            <identifier scheme="http://www.cbr.ru"><xsl:value-of select="$id"/></identifier>
          </entity>
          <period>
            <startDate><xsl:value-of select="$periodBegin"/></startDate>
            <endDate><xsl:value-of select="$periodEnd"/></endDate>
          </period>
          <scenario>
            <xbrldi:explicitMember dimension="dim-int:Sovokup_Razmer_Pens_Vypl_ZastrLiczu_SrochnAxis">mem-int:EdinovremennayaMember</xbrldi:explicitMember>
            <xbrldi:typedMember dimension="dim-int:ID_Zastraxovannogo_LiczaTaxis">
              <dim-int:ID_FL_YULTypedName><xsl:value-of select="F0"/></dim-int:ID_FL_YULTypedName>
            </xbrldi:typedMember>
          </scenario>
        </context>        
        </xsl:if>        
        <xsl:if test="F50">   
          <context>
            <xsl:attribute name="id">
              <xsl:text>Context</xsl:text>
              <xsl:value-of select="(position() - 1) * 21 + 12"/>
            </xsl:attribute>
          <entity>
            <identifier scheme="http://www.cbr.ru"><xsl:value-of select="$id"/></identifier>
          </entity>
          <period>
            <instant><xsl:value-of select="$periodEnd"/></instant>
          </period>
          <scenario>
            <xbrldi:explicitMember dimension="dim-int:Dvizh_Sredstv_PensNakoplAxis">mem-int:Sredstva_Finans_Nakopit_PensMember</xbrldi:explicitMember>
            <xbrldi:typedMember dimension="dim-int:ID_Zastraxovannogo_LiczaTaxis">
              <dim-int:ID_FL_YULTypedName><xsl:value-of select="F0"/></dim-int:ID_FL_YULTypedName>
            </xbrldi:typedMember>
          </scenario>
        </context>
        </xsl:if>  
        <xsl:if test="F51">   
          <context>
            <xsl:attribute name="id">
              <xsl:text>Context</xsl:text>
              <xsl:value-of select="(position() - 1) * 21 + 13"/>
            </xsl:attribute>
          <entity>
            <identifier scheme="http://www.cbr.ru"><xsl:value-of select="$id"/></identifier>
          </entity>
          <period>
            <instant><xsl:value-of select="$periodEnd"/></instant>
          </period>
          <scenario>
            <xbrldi:explicitMember dimension="dim-int:Dvizh_Sredstv_PensNakoplAxis">mem-int:Sredstva_Sofinans_Form_PensNakoplMember</xbrldi:explicitMember>
            <xbrldi:typedMember dimension="dim-int:ID_Zastraxovannogo_LiczaTaxis">
              <dim-int:ID_FL_YULTypedName><xsl:value-of select="F0"/></dim-int:ID_FL_YULTypedName>
            </xbrldi:typedMember>
          </scenario>
        </context>
        </xsl:if>
        <xsl:if test="F52">
          <context>
            <xsl:attribute name="id">
              <xsl:text>Context</xsl:text>
              <xsl:value-of select="(position() - 1) * 21 + 14"/>
            </xsl:attribute>
          <entity>
            <identifier scheme="http://www.cbr.ru"><xsl:value-of select="$id"/></identifier>
          </entity>
          <period>
            <instant><xsl:value-of select="$periodEnd"/></instant>
          </period>
          <scenario>
            <xbrldi:explicitMember dimension="dim-int:Dvizh_Sredstv_PensNakoplAxis">mem-int:Sredstva_Mat_KapitalMember</xbrldi:explicitMember>
            <xbrldi:typedMember dimension="dim-int:ID_Zastraxovannogo_LiczaTaxis">
              <dim-int:ID_FL_YULTypedName><xsl:value-of select="F0"/></dim-int:ID_FL_YULTypedName>
            </xbrldi:typedMember>
          </scenario>
        </context>      
        </xsl:if>
        <xsl:if test="F54">   
          <context>
            <xsl:attribute name="id">
              <xsl:text>Context</xsl:text>
              <xsl:value-of select="(position() - 1) * 21 + 15"/>
            </xsl:attribute>
          <entity>
            <identifier scheme="http://www.cbr.ru"><xsl:value-of select="$id"/></identifier>
          </entity>
          <period>
            <instant><xsl:value-of select="$periodEnd"/></instant>
          </period>
          <scenario>
            <xbrldi:explicitMember dimension="dim-int:Rez_Invest_PensNakoplAxis">mem-int:Rez_Invest_Sredstva_Finans_Nakopit_PensMember</xbrldi:explicitMember>
            <xbrldi:typedMember dimension="dim-int:ID_Zastraxovannogo_LiczaTaxis">
              <dim-int:ID_FL_YULTypedName><xsl:value-of select="F0"/></dim-int:ID_FL_YULTypedName>
            </xbrldi:typedMember>
          </scenario>
        </context>        
        </xsl:if>        
        <xsl:if test="F55">
          <context>
            <xsl:attribute name="id">
              <xsl:text>Context</xsl:text>
              <xsl:value-of select="(position() - 1) * 21 + 16"/>
            </xsl:attribute>
          <entity>
            <identifier scheme="http://www.cbr.ru"><xsl:value-of select="$id"/></identifier>
          </entity>
          <period>
            <instant><xsl:value-of select="$periodEnd"/></instant>
          </period>
          <scenario>
            <xbrldi:explicitMember dimension="dim-int:Rez_Invest_PensNakoplAxis">mem-int:Rez_Invest_Sredstva_Sofinans_Form_PensNakoplMember</xbrldi:explicitMember>
            <xbrldi:typedMember dimension="dim-int:ID_Zastraxovannogo_LiczaTaxis">
              <dim-int:ID_FL_YULTypedName><xsl:value-of select="F0"/></dim-int:ID_FL_YULTypedName>
            </xbrldi:typedMember>
          </scenario>
        </context>        
        </xsl:if>          
        <xsl:if test="F56">
          <context>
            <xsl:attribute name="id">
              <xsl:text>Context</xsl:text>
              <xsl:value-of select="(position() - 1) * 21 + 17"/>
            </xsl:attribute>
          <entity>
            <identifier scheme="http://www.cbr.ru"><xsl:value-of select="$id"/></identifier>
          </entity>
          <period>
            <instant><xsl:value-of select="$periodEnd"/></instant>
          </period>
          <scenario>
            <xbrldi:explicitMember dimension="dim-int:Rez_Invest_PensNakoplAxis">mem-int:Rez_Invest_Sredstva_Mat_KapitalMember</xbrldi:explicitMember>
            <xbrldi:typedMember dimension="dim-int:ID_Zastraxovannogo_LiczaTaxis">
              <dim-int:ID_FL_YULTypedName><xsl:value-of select="F0"/></dim-int:ID_FL_YULTypedName>
            </xbrldi:typedMember>
          </scenario>
        </context>        
        </xsl:if>        
        <xsl:if test="F59">
          <context>
            <xsl:attribute name="id">
              <xsl:text>Context</xsl:text>
              <xsl:value-of select="(position() - 1) * 21 + 18"/>
            </xsl:attribute>
          <entity>
            <identifier scheme="http://www.cbr.ru"><xsl:value-of select="$id"/></identifier>
          </entity>
          <period>
            <startDate><xsl:value-of select="$periodBegin"/></startDate>
            <endDate><xsl:value-of select="$periodEnd"/></endDate>
          </period>
          <scenario>
            <xbrldi:explicitMember dimension="dim-int:Ist_Garant_Vozm_VospAxis">mem-int:Rezerv_Fonda_OPSMember</xbrldi:explicitMember>
            <xbrldi:typedMember dimension="dim-int:ID_Zastraxovannogo_LiczaTaxis">
              <dim-int:ID_FL_YULTypedName><xsl:value-of select="F0"/></dim-int:ID_FL_YULTypedName>
            </xbrldi:typedMember>
          </scenario>
        </context>        
        </xsl:if>          
        <xsl:if test="F60">
          <context>
            <xsl:attribute name="id">
              <xsl:text>Context</xsl:text>
              <xsl:value-of select="(position() - 1) * 21 + 19"/>
            </xsl:attribute>
          <entity>
            <identifier scheme="http://www.cbr.ru"><xsl:value-of select="$id"/></identifier>
          </entity>
          <period>
            <startDate><xsl:value-of select="$periodBegin"/></startDate>
            <endDate><xsl:value-of select="$periodEnd"/></endDate>
          </period>
          <scenario>
            <xbrldi:explicitMember dimension="dim-int:Ist_Garant_Vozm_VospAxis">mem-int:Za_Schet_SSMember</xbrldi:explicitMember>
            <xbrldi:typedMember dimension="dim-int:ID_Zastraxovannogo_LiczaTaxis">
              <dim-int:ID_FL_YULTypedName><xsl:value-of select="F0"/></dim-int:ID_FL_YULTypedName>
            </xbrldi:typedMember>
          </scenario>
        </context>        
        </xsl:if>                
        <xsl:if test="F61">
          <context>
            <xsl:attribute name="id">
              <xsl:text>Context</xsl:text>
              <xsl:value-of select="(position() - 1) * 21 + 20"/>
            </xsl:attribute>
          <entity>
            <identifier scheme="http://www.cbr.ru"><xsl:value-of select="$id"/></identifier>
          </entity>
          <period>
            <startDate><xsl:value-of select="$periodBegin"/></startDate>
            <endDate><xsl:value-of select="$periodEnd"/></endDate>
          </period>
          <scenario>
            <xbrldi:explicitMember dimension="dim-int:Ist_Garant_Vozm_VospAxis">mem-int:Prochie_IstMember</xbrldi:explicitMember>
            <xbrldi:typedMember dimension="dim-int:ID_Zastraxovannogo_LiczaTaxis">
              <dim-int:ID_FL_YULTypedName><xsl:value-of select="F0"/></dim-int:ID_FL_YULTypedName>
            </xbrldi:typedMember>
          </scenario>
        </context>        
        </xsl:if>      
      </xsl:for-each>
        
      <context>
        <xsl:attribute name="id">
          <xsl:text>Context</xsl:text>
          <xsl:value-of select="$rows * 21 + 1"/>
        </xsl:attribute>
        <entity>
          <identifier scheme="http://www.cbr.ru"><xsl:value-of select="$id"/></identifier>
        </entity>
        <period>
          <instant><xsl:value-of select="$periodEnd"/></instant>
        </period>
      </context>
      <context>
        <xsl:attribute name="id">
          <xsl:text>Context</xsl:text>
          <xsl:value-of select="$rows * 21 + 2"/>
        </xsl:attribute>
        <entity>
          <identifier scheme="http://www.cbr.ru"><xsl:value-of select="$id"/></identifier>
        </entity>
        <period>
          <instant><xsl:value-of select="$periodEnd"/></instant>
        </period>
        <scenario>
          <xbrldi:typedMember dimension="dim-int:PrOblastOtcetnostiTaxis">
            <dim-int:PrOblastOtchTypedName><xsl:value-of select="$matter"/></dim-int:PrOblastOtchTypedName>
          </xbrldi:typedMember>
        </scenario>
      </context>
      <unit id="rub">
        <measure>iso4217:RUB</measure>
      </unit>
    
      <xsl:for-each select="row">
        <xsl:if test="F1">
          <npf-dic:Naim_Fond>
            <xsl:attribute name="contextRef">
              <xsl:text>Context</xsl:text>
              <xsl:value-of select="(position() - 1) * 21 + 0"/>
            </xsl:attribute>
            <xsl:value-of select="F1"/>
          </npf-dic:Naim_Fond>
        </xsl:if>
        <xsl:if test="F2">
          <npf-dic:Liczenziya_Fond>
            <xsl:attribute name="contextRef">
              <xsl:text>Context</xsl:text>
              <xsl:value-of select="(position() - 1) * 21 + 0"/>
            </xsl:attribute>
            <xsl:value-of select="F2"/>
          </npf-dic:Liczenziya_Fond>
        </xsl:if>
        <xsl:if test="F3">
          <npf-dic:SNILS_ZastrLiczo>
            <xsl:attribute name="contextRef">
              <xsl:text>Context</xsl:text>
              <xsl:value-of select="(position() - 1) * 21 + 0"/>
            </xsl:attribute>
            <xsl:value-of select="F3"/>
          </npf-dic:SNILS_ZastrLiczo>
        </xsl:if>
        <xsl:if test="F4">
          <npf-dic:INN_ZastrLiczo>
            <xsl:attribute name="contextRef">
              <xsl:text>Context</xsl:text>
              <xsl:value-of select="(position() - 1) * 21 + 0"/>
            </xsl:attribute>
            <xsl:value-of select="F4"/>
          </npf-dic:INN_ZastrLiczo>
        </xsl:if>
        <xsl:if test="F5">
          <npf-dic:DataRozhd_ZastrLiczo>
            <xsl:attribute name="contextRef">
              <xsl:text>Context</xsl:text>
              <xsl:value-of select="(position() - 1) * 21 + 0"/>
            </xsl:attribute>
            <xsl:value-of select="F5"/>
          </npf-dic:DataRozhd_ZastrLiczo>
        </xsl:if>
        <xsl:if test="F6">
          <npf-dic:Pol_ZastrLiczoEnumerator>
            <xsl:variable name="Pol_Enumerator_Key">
              <xsl:value-of select="F6"/>
            </xsl:variable>
            <xsl:attribute name="contextRef">
              <xsl:text>Context</xsl:text>
              <xsl:value-of select="(position() - 1) * 21 + 0"/>
            </xsl:attribute>
            <xsl:value-of select="msxsl:node-set($Pol_Enumerator)/dict[@key=$Pol_Enumerator_Key]/@value"/>
          </npf-dic:Pol_ZastrLiczoEnumerator>        
        </xsl:if>
        <xsl:if test="F7">
          <npf-dic:MestoZHit_ZastrLiczo>
            <xsl:attribute name="contextRef">
              <xsl:text>Context</xsl:text>
              <xsl:value-of select="(position() - 1) * 21 + 0"/>
            </xsl:attribute>
            <xsl:value-of select="F7"/>
          </npf-dic:MestoZHit_ZastrLiczo>        
        </xsl:if>
        <xsl:if test="F8">
          <npf-dic:PensSchet_ZastrLiczo>
            <xsl:attribute name="contextRef">
              <xsl:text>Context</xsl:text>
              <xsl:value-of select="(position() - 1) * 21 + 0"/>
            </xsl:attribute>
            <xsl:value-of select="F8"/>
          </npf-dic:PensSchet_ZastrLiczo>        
        </xsl:if>
        <xsl:if test="F9">
          <npf-dic:Data_Zakl_Dog_OPS>
            <xsl:attribute name="contextRef">
              <xsl:text>Context</xsl:text>
              <xsl:value-of select="(position() - 1) * 21 + 0"/>
            </xsl:attribute>
            <xsl:value-of select="F9"/>
          </npf-dic:Data_Zakl_Dog_OPS>        
        </xsl:if>     
        <xsl:if test="F10">
          <npf-dic:Status_Dog_OPSEnumerator>
            <xsl:variable name="Status_Dog_OPSEnumerator_Key">
              <xsl:value-of select="F10"/>
            </xsl:variable>
            <xsl:attribute name="contextRef">
              <xsl:text>Context</xsl:text>
              <xsl:value-of select="(position() - 1) * 21 + 0"/>
            </xsl:attribute>
            <xsl:value-of select="msxsl:node-set($Status_Dog_OPSEnumerator)/dict[@key=$Status_Dog_OPSEnumerator_Key]/@value"/>
          </npf-dic:Status_Dog_OPSEnumerator>        
        </xsl:if>
        <xsl:if test="F11">
          <npf-dic:Status_ZastrLiczaEnumerator>
            <xsl:variable name="Status_ZastrLiczaEnumerator_Key">
              <xsl:value-of select="F11"/>
            </xsl:variable>
            <xsl:attribute name="contextRef">
              <xsl:text>Context</xsl:text>
              <xsl:value-of select="(position() - 1) * 21 + 0"/>
            </xsl:attribute>
            <xsl:value-of select="msxsl:node-set($Status_ZastrLiczaEnumerator)/dict[@key=$Status_ZastrLiczaEnumerator_Key]/@value"/>
          </npf-dic:Status_ZastrLiczaEnumerator>        
        </xsl:if>
        <xsl:if test="F12">
          <npf-dic:Obosn_Statusa_ZastrLiczaEnumerator>
            <xsl:variable name="Obosn_Statusa_ZastrLiczaEnumerator_Key">
              <xsl:value-of select="F12"/>
            </xsl:variable>
            <xsl:attribute name="contextRef">
              <xsl:text>Context</xsl:text>
              <xsl:value-of select="(position() - 1) * 21 + 0"/>
            </xsl:attribute>
            <xsl:value-of select="msxsl:node-set($Obosn_Statusa_ZastrLiczaEnumerator)/dict[@key=$Obosn_Statusa_ZastrLiczaEnumerator_Key]/@value"/>
          </npf-dic:Obosn_Statusa_ZastrLiczaEnumerator>        
        </xsl:if>      
        <xsl:if test="F13">
          <npf-dic:Data_Nachalo5LetnegoPerioda>
            <xsl:attribute name="contextRef">
              <xsl:text>Context</xsl:text>
              <xsl:value-of select="(position() - 1) * 21 + 0"/>
            </xsl:attribute>
            <xsl:value-of select="F13"/>
          </npf-dic:Data_Nachalo5LetnegoPerioda>        
        </xsl:if>
        <xsl:if test="F14">
          <npf-dic:Data_PrekrDog_OPS>
            <xsl:attribute name="contextRef">
              <xsl:text>Context</xsl:text>
              <xsl:value-of select="(position() - 1) * 21 + 0"/>
            </xsl:attribute>
            <xsl:value-of select="F14"/>
          </npf-dic:Data_PrekrDog_OPS>        
        </xsl:if>
        <xsl:if test="F15">
          <npf-dic:Data_NachaloVyplat_PozhiznPens>
            <xsl:attribute name="contextRef">
              <xsl:text>Context</xsl:text>
              <xsl:value-of select="(position() - 1) * 21 + 0"/>
            </xsl:attribute>
            <xsl:value-of select="F15"/>
          </npf-dic:Data_NachaloVyplat_PozhiznPens>        
        </xsl:if>
        <xsl:if test="F16">
          <npf-dic:Data_NachaloVyplat_SrochPens>
            <xsl:attribute name="contextRef">
              <xsl:text>Context</xsl:text>
              <xsl:value-of select="(position() - 1) * 21 + 0"/>
            </xsl:attribute>
            <xsl:value-of select="F16"/>
          </npf-dic:Data_NachaloVyplat_SrochPens>        
        </xsl:if>
        <xsl:if test="F17">
          <npf-dic:Data_Nazn_EdinovrVypl>
            <xsl:attribute name="contextRef">
              <xsl:text>Context</xsl:text>
              <xsl:value-of select="(position() - 1) * 21 + 0"/>
            </xsl:attribute>
            <xsl:value-of select="F17"/>
          </npf-dic:Data_Nazn_EdinovrVypl>        
        </xsl:if>
        <xsl:if test="F18">
          <npf-dic:Data_OkonchVyplat_SrochPens>
            <xsl:attribute name="contextRef">
              <xsl:text>Context</xsl:text>
              <xsl:value-of select="(position() - 1) * 21 + 0"/>
            </xsl:attribute>
            <xsl:value-of select="F18"/>
          </npf-dic:Data_OkonchVyplat_SrochPens>        
        </xsl:if>
        <xsl:if test="F19">
          <npf-dic:Data_Smert_ZastrLicza>
            <xsl:attribute name="contextRef">
              <xsl:text>Context</xsl:text>
              <xsl:value-of select="(position() - 1) * 21 + 0"/>
            </xsl:attribute>
            <xsl:value-of select="F19"/>
          </npf-dic:Data_Smert_ZastrLicza>        
        </xsl:if>
        <xsl:if test="F20">
          <npf-dic:Obyaz_OPS_Nakopl_5let decimals="2" unitRef="rub">
            <xsl:attribute name="contextRef">
              <xsl:text>Context</xsl:text>
              <xsl:value-of select="(position() - 1) * 21 + 1"/>
            </xsl:attribute>
            <xsl:value-of select="F20"/>
          </npf-dic:Obyaz_OPS_Nakopl_5let>        
        </xsl:if>
        <xsl:if test="F21">
          <npf-dic:Obyaz_OPS_Nakopl_5let decimals="2" unitRef="rub">
            <xsl:attribute name="contextRef">
              <xsl:text>Context</xsl:text>
              <xsl:value-of select="(position() - 1) * 21 + 2"/>
            </xsl:attribute>
            <xsl:value-of select="F21"/>
          </npf-dic:Obyaz_OPS_Nakopl_5let>        
        </xsl:if>
        <xsl:if test="F22">
          <npf-dic:Obyaz_OPS_Nakopl_5let decimals="2" unitRef="rub">
            <xsl:attribute name="contextRef">
              <xsl:text>Context</xsl:text>
              <xsl:value-of select="(position() - 1) * 21 + 3"/>
            </xsl:attribute>
            <xsl:value-of select="F22"/>
          </npf-dic:Obyaz_OPS_Nakopl_5let>        
        </xsl:if>
        <xsl:if test="F23">
          <npf-dic:Obyaz_OPS_Nakopl_5let decimals="2" unitRef="rub">
            <xsl:attribute name="contextRef">
              <xsl:text>Context</xsl:text>
              <xsl:value-of select="(position() - 1) * 21 + 4"/>
            </xsl:attribute>
            <xsl:value-of select="F23"/>
          </npf-dic:Obyaz_OPS_Nakopl_5let>        
        </xsl:if>
        <xsl:if test="F24">
          <npf-dic:Obyaz_OPS_NakoplIzPfr_5let decimals="2" unitRef="rub">
            <xsl:attribute name="contextRef">
              <xsl:text>Context</xsl:text>
              <xsl:value-of select="(position() - 1) * 21 + 5"/>
            </xsl:attribute>
            <xsl:value-of select="F24"/>
          </npf-dic:Obyaz_OPS_NakoplIzPfr_5let>        
        </xsl:if>
        <xsl:if test="F25">
          <npf-dic:Obyaz_OPS_NakoplIzPfr_5let decimals="2" unitRef="rub">
            <xsl:attribute name="contextRef">
              <xsl:text>Context</xsl:text>
              <xsl:value-of select="(position() - 1) * 21 + 6"/>
            </xsl:attribute>
            <xsl:value-of select="F25"/>
          </npf-dic:Obyaz_OPS_NakoplIzPfr_5let>        
        </xsl:if>
        <xsl:if test="F26">
          <npf-dic:Obyaz_OPS_NakoplIzPfr_5let decimals="2" unitRef="rub">
            <xsl:attribute name="contextRef">
              <xsl:text>Context</xsl:text>
              <xsl:value-of select="(position() - 1) * 21 + 7"/>
            </xsl:attribute>
            <xsl:value-of select="F26"/>
          </npf-dic:Obyaz_OPS_NakoplIzPfr_5let>        
        </xsl:if>
        <xsl:if test="F27">
          <npf-dic:Obyaz_OPS_NakoplIzPfr_5let decimals="2" unitRef="rub">
            <xsl:attribute name="contextRef">
              <xsl:text>Context</xsl:text>
              <xsl:value-of select="(position() - 1) * 21 + 8"/>
            </xsl:attribute>
            <xsl:value-of select="F27"/>
          </npf-dic:Obyaz_OPS_NakoplIzPfr_5let>        
        </xsl:if>
        <xsl:if test="F28">
          <npf-dic:Obyaz_OPS_NakoplIzDrugix_5let decimals="2" unitRef="rub">
            <xsl:attribute name="contextRef">
              <xsl:text>Context</xsl:text>
              <xsl:value-of select="(position() - 1) * 21 + 5"/>
            </xsl:attribute>
            <xsl:value-of select="F28"/>
          </npf-dic:Obyaz_OPS_NakoplIzDrugix_5let>        
        </xsl:if>
        <xsl:if test="F29">
          <npf-dic:Obyaz_OPS_NakoplIzDrugix_5let decimals="2" unitRef="rub">
            <xsl:attribute name="contextRef">
              <xsl:text>Context</xsl:text>
              <xsl:value-of select="(position() - 1) * 21 + 6"/>
            </xsl:attribute>
            <xsl:value-of select="F29"/>
          </npf-dic:Obyaz_OPS_NakoplIzDrugix_5let>        
        </xsl:if>      
        <xsl:if test="F30">
          <npf-dic:Obyaz_OPS_NakoplIzDrugix_5let decimals="2" unitRef="rub">
            <xsl:attribute name="contextRef">
              <xsl:text>Context</xsl:text>
              <xsl:value-of select="(position() - 1) * 21 + 7"/>
            </xsl:attribute>
            <xsl:value-of select="F30"/>
          </npf-dic:Obyaz_OPS_NakoplIzDrugix_5let>        
        </xsl:if>
        <xsl:if test="F31">
          <npf-dic:Obyaz_OPS_NakoplIzDrugix_5let decimals="2" unitRef="rub">
            <xsl:attribute name="contextRef">
              <xsl:text>Context</xsl:text>
              <xsl:value-of select="(position() - 1) * 21 + 8"/>
            </xsl:attribute>
            <xsl:value-of select="F31"/>
          </npf-dic:Obyaz_OPS_NakoplIzDrugix_5let>        
        </xsl:if>
        <xsl:if test="F32">
          <npf-dic:OPS_Vyplata_SovokPens decimals="2" unitRef="rub">
            <xsl:attribute name="contextRef">
              <xsl:text>Context</xsl:text>
              <xsl:value-of select="(position() - 1) * 21 + 5"/>
            </xsl:attribute>
            <xsl:value-of select="F32"/>
          </npf-dic:OPS_Vyplata_SovokPens>        
        </xsl:if>
        <xsl:if test="F33">
          <npf-dic:OPS_Vyplata_SovokPens decimals="2" unitRef="rub">
            <xsl:attribute name="contextRef">
              <xsl:text>Context</xsl:text>
              <xsl:value-of select="(position() - 1) * 21 + 9"/>
            </xsl:attribute>
            <xsl:value-of select="F33"/>
          </npf-dic:OPS_Vyplata_SovokPens>        
        </xsl:if>
        <xsl:if test="F34">
          <npf-dic:OPS_Vyplata_SovokPens decimals="2" unitRef="rub">
            <xsl:attribute name="contextRef">
              <xsl:text>Context</xsl:text>
              <xsl:value-of select="(position() - 1) * 21 + 10"/>
            </xsl:attribute>
            <xsl:value-of select="F34"/>
          </npf-dic:OPS_Vyplata_SovokPens>        
        </xsl:if>      
        <xsl:if test="F35">
          <npf-dic:OPS_Vyplata_SovokPens decimals="2" unitRef="rub">
            <xsl:attribute name="contextRef">
              <xsl:text>Context</xsl:text>
              <xsl:value-of select="(position() - 1) * 21 + 11"/>
            </xsl:attribute>
            <xsl:value-of select="F35"/>
          </npf-dic:OPS_Vyplata_SovokPens>        
        </xsl:if>
        <xsl:if test="F36">
          <npf-dic:OPS_Vyplata_VypPravopriem decimals="2" unitRef="rub">
            <xsl:attribute name="contextRef">
              <xsl:text>Context</xsl:text>
              <xsl:value-of select="(position() - 1) * 21 + 5"/>
            </xsl:attribute>
            <xsl:value-of select="F36"/>
          </npf-dic:OPS_Vyplata_VypPravopriem>        
        </xsl:if>      
        <xsl:if test="F37">
          <npf-dic:OPS_InvestDox decimals="2" unitRef="rub">
            <xsl:attribute name="contextRef">
              <xsl:text>Context</xsl:text>
              <xsl:value-of select="(position() - 1) * 21 + 5"/>
            </xsl:attribute>
            <xsl:value-of select="F37"/>
          </npf-dic:OPS_InvestDox>        
        </xsl:if>
        <xsl:if test="F38">
          <npf-dic:OPS_InvestDox decimals="2" unitRef="rub">
            <xsl:attribute name="contextRef">
              <xsl:text>Context</xsl:text>
              <xsl:value-of select="(position() - 1) * 21 + 6"/>
            </xsl:attribute>
            <xsl:value-of select="F38"/>
          </npf-dic:OPS_InvestDox>        
        </xsl:if>      
        <xsl:if test="F39">
          <npf-dic:OPS_InvestDox decimals="2" unitRef="rub">
            <xsl:attribute name="contextRef">
              <xsl:text>Context</xsl:text>
              <xsl:value-of select="(position() - 1) * 21 + 7"/>
            </xsl:attribute>
            <xsl:value-of select="F39"/>
          </npf-dic:OPS_InvestDox>        
        </xsl:if>
        <xsl:if test="F40">
          <npf-dic:OPS_InvestDox decimals="2" unitRef="rub">
            <xsl:attribute name="contextRef">
              <xsl:text>Context</xsl:text>
              <xsl:value-of select="(position() - 1) * 21 + 8"/>
            </xsl:attribute>
            <xsl:value-of select="F40"/>
          </npf-dic:OPS_InvestDox>        
        </xsl:if>
        <xsl:if test="F41">
          <npf-dic:OPS_perevod_PFR_dr_NPF_so_sch_zl decimals="2" unitRef="rub">
            <xsl:attribute name="contextRef">
              <xsl:text>Context</xsl:text>
              <xsl:value-of select="(position() - 1) * 21 + 5"/>
            </xsl:attribute>
            <xsl:value-of select="F41"/>
          </npf-dic:OPS_perevod_PFR_dr_NPF_so_sch_zl>        
        </xsl:if>
        <xsl:if test="F42">
          <npf-dic:OPS_perevod_PFR_dr_NPF_so_sch_zl decimals="2" unitRef="rub">
            <xsl:attribute name="contextRef">
              <xsl:text>Context</xsl:text>
              <xsl:value-of select="(position() - 1) * 21 + 6"/>
            </xsl:attribute>
            <xsl:value-of select="F42"/>
          </npf-dic:OPS_perevod_PFR_dr_NPF_so_sch_zl>        
        </xsl:if>      
        <xsl:if test="F43">
          <npf-dic:OPS_perevod_PFR_dr_NPF_so_sch_zl decimals="2" unitRef="rub">
            <xsl:attribute name="contextRef">
              <xsl:text>Context</xsl:text>
              <xsl:value-of select="(position() - 1) * 21 + 7"/>
            </xsl:attribute>
            <xsl:value-of select="F43"/>
          </npf-dic:OPS_perevod_PFR_dr_NPF_so_sch_zl>        
        </xsl:if>
        <xsl:if test="F44">
          <npf-dic:OPS_perevod_PFR_dr_NPF_so_sch_zl decimals="2" unitRef="rub">
            <xsl:attribute name="contextRef">
              <xsl:text>Context</xsl:text>
              <xsl:value-of select="(position() - 1) * 21 + 8"/>
            </xsl:attribute>
            <xsl:value-of select="F44"/>
          </npf-dic:OPS_perevod_PFR_dr_NPF_so_sch_zl>        
        </xsl:if>
        <xsl:if test="F45">
          <npf-dic:SaldoInyxPostuplenij_Vyplat decimals="2" unitRef="rub">
            <xsl:attribute name="contextRef">
              <xsl:text>Context</xsl:text>
              <xsl:value-of select="(position() - 1) * 21 + 0"/>
            </xsl:attribute>
            <xsl:value-of select="F45"/>
          </npf-dic:SaldoInyxPostuplenij_Vyplat>        
        </xsl:if>
        <xsl:if test="F46">
          <npf-dic:Perevod_RezFondPoOPS decimals="2" unitRef="rub">
            <xsl:attribute name="contextRef">
              <xsl:text>Context</xsl:text>
              <xsl:value-of select="(position() - 1) * 21 + 0"/>
            </xsl:attribute>
            <xsl:value-of select="F46"/>
          </npf-dic:Perevod_RezFondPoOPS>        
        </xsl:if>
        <xsl:if test="F47">
          <npf-dic:Perevod_SrPenNak_NaznachSrPensVypl decimals="2" unitRef="rub">
            <xsl:attribute name="contextRef">
              <xsl:text>Context</xsl:text>
              <xsl:value-of select="(position() - 1) * 21 + 5"/>
            </xsl:attribute>
            <xsl:value-of select="F47"/>
          </npf-dic:Perevod_SrPenNak_NaznachSrPensVypl>        
        </xsl:if>
        <xsl:if test="F48">
          <npf-dic:Perevod_VyplatnojRezerv decimals="2" unitRef="rub">
            <xsl:attribute name="contextRef">
              <xsl:text>Context</xsl:text>
              <xsl:value-of select="(position() - 1) * 21 + 5"/>
            </xsl:attribute>
            <xsl:value-of select="F48"/>
          </npf-dic:Perevod_VyplatnojRezerv>        
        </xsl:if>
        <xsl:if test="F49">
          <npf-dic:RazmerSrPensNak_SchetZastrLicza decimals="2" unitRef="rub">
            <xsl:attribute name="contextRef">
              <xsl:text>Context</xsl:text>
              <xsl:value-of select="(position() - 1) * 21 + 0"/>
            </xsl:attribute>
            <xsl:value-of select="F49"/>
          </npf-dic:RazmerSrPensNak_SchetZastrLicza>        
        </xsl:if>      
        <xsl:if test="F50">
          <npf-dic:RazmerSrPensNak_SchetZastrLicza decimals="2" unitRef="rub">
            <xsl:attribute name="contextRef">
              <xsl:text>Context</xsl:text>
              <xsl:value-of select="(position() - 1) * 21 + 12"/>
            </xsl:attribute>
            <xsl:value-of select="F50"/>
          </npf-dic:RazmerSrPensNak_SchetZastrLicza>        
        </xsl:if>
        <xsl:if test="F51">
          <npf-dic:RazmerSrPensNak_SchetZastrLicza decimals="2" unitRef="rub">
            <xsl:attribute name="contextRef">
              <xsl:text>Context</xsl:text>
              <xsl:value-of select="(position() - 1) * 21 + 13"/>
            </xsl:attribute>
            <xsl:value-of select="F51"/>
          </npf-dic:RazmerSrPensNak_SchetZastrLicza>        
        </xsl:if>      
        <xsl:if test="F52">
          <npf-dic:RazmerSrPensNak_SchetZastrLicza decimals="2" unitRef="rub">
            <xsl:attribute name="contextRef">
              <xsl:text>Context</xsl:text>
              <xsl:value-of select="(position() - 1) * 21 + 14"/>
            </xsl:attribute>
            <xsl:value-of select="F52"/>
          </npf-dic:RazmerSrPensNak_SchetZastrLicza>        
        </xsl:if>
        <xsl:if test="F53">
          <npf-dic:InvestDoxod_SrPensNak_SchetZastraxLicza decimals="2" unitRef="rub">
            <xsl:attribute name="contextRef">
              <xsl:text>Context</xsl:text>
              <xsl:value-of select="(position() - 1) * 21 + 0"/>
            </xsl:attribute>
            <xsl:value-of select="F53"/>
          </npf-dic:InvestDoxod_SrPensNak_SchetZastraxLicza>        
        </xsl:if>
        <xsl:if test="F54">
          <npf-dic:InvestDoxod_SrPensNak_SchetZastraxLicza decimals="2" unitRef="rub">
            <xsl:attribute name="contextRef">
              <xsl:text>Context</xsl:text>
              <xsl:value-of select="(position() - 1) * 21 + 15"/>
            </xsl:attribute>
            <xsl:value-of select="F54"/>
          </npf-dic:InvestDoxod_SrPensNak_SchetZastraxLicza>        
        </xsl:if>
        <xsl:if test="F55">
          <npf-dic:InvestDoxod_SrPensNak_SchetZastraxLicza decimals="2" unitRef="rub">
            <xsl:attribute name="contextRef">
              <xsl:text>Context</xsl:text>
              <xsl:value-of select="(position() - 1) * 21 + 16"/>
            </xsl:attribute>
            <xsl:value-of select="F55"/>
          </npf-dic:InvestDoxod_SrPensNak_SchetZastraxLicza>        
        </xsl:if>      
        <xsl:if test="F56">
          <npf-dic:InvestDoxod_SrPensNak_SchetZastraxLicza decimals="2" unitRef="rub">
            <xsl:attribute name="contextRef">
              <xsl:text>Context</xsl:text>
              <xsl:value-of select="(position() - 1) * 21 + 17"/>
            </xsl:attribute>
            <xsl:value-of select="F56"/>
          </npf-dic:InvestDoxod_SrPensNak_SchetZastraxLicza>        
        </xsl:if>
        <xsl:if test="F57">
          <npf-dic:Garant_Vozmeshhenie decimals="2" unitRef="rub">
            <xsl:attribute name="contextRef">
              <xsl:text>Context</xsl:text>
              <xsl:value-of select="(position() - 1) * 21 + 5"/>
            </xsl:attribute>
            <xsl:value-of select="F57"/>
          </npf-dic:Garant_Vozmeshhenie>        
        </xsl:if>
        <xsl:if test="F58">
          <npf-dic:Garant_Vospolnenie decimals="2" unitRef="rub">
            <xsl:attribute name="contextRef">
              <xsl:text>Context</xsl:text>
              <xsl:value-of select="(position() - 1) * 21 + 5"/>
            </xsl:attribute>
            <xsl:value-of select="F58"/>
          </npf-dic:Garant_Vospolnenie>        
        </xsl:if>
        <xsl:if test="F59">
          <npf-dic:Garant_Vospolnenie decimals="2" unitRef="rub">
            <xsl:attribute name="contextRef">
              <xsl:text>Context</xsl:text>
              <xsl:value-of select="(position() - 1) * 21 + 18"/>
            </xsl:attribute>
            <xsl:value-of select="F59"/>
          </npf-dic:Garant_Vospolnenie>        
        </xsl:if>
        <xsl:if test="F60">
          <npf-dic:Garant_Vospolnenie decimals="2" unitRef="rub">
            <xsl:attribute name="contextRef">
              <xsl:text>Context</xsl:text>
              <xsl:value-of select="(position() - 1) * 21 + 19"/>
            </xsl:attribute>
            <xsl:value-of select="F60"/>
          </npf-dic:Garant_Vospolnenie>        
        </xsl:if>      
        <xsl:if test="F61">
          <npf-dic:Garant_Vospolnenie decimals="2" unitRef="rub">
            <xsl:attribute name="contextRef">
              <xsl:text>Context</xsl:text>
              <xsl:value-of select="(position() - 1) * 21 + 20"/>
            </xsl:attribute>
            <xsl:value-of select="F61"/>
          </npf-dic:Garant_Vospolnenie>        
        </xsl:if>
        <xsl:if test="F62">
          <npf-dic:RazmerPensii_OtchData_Pozhiznennaya decimals="2" unitRef="rub">
            <xsl:attribute name="contextRef">
              <xsl:text>Context</xsl:text>
              <xsl:value-of select="(position() - 1) * 21 + 0"/>
            </xsl:attribute>
            <xsl:value-of select="F62"/>
          </npf-dic:RazmerPensii_OtchData_Pozhiznennaya>        
        </xsl:if>
        <xsl:if test="F63">
          <npf-dic:RazmerPensii_OtchData_Srochnaya decimals="2" unitRef="rub">
            <xsl:attribute name="contextRef">
              <xsl:text>Context</xsl:text>
              <xsl:value-of select="(position() - 1) * 21 + 0"/>
            </xsl:attribute>
            <xsl:value-of select="F63"/>
          </npf-dic:RazmerPensii_OtchData_Srochnaya>        
        </xsl:if>      
      </xsl:for-each>
      <npf-dic:Nomer_Liczenzii>
        <xsl:attribute name="contextRef">
          <xsl:text>Context</xsl:text>
          <xsl:value-of select="$rows * 21 + 1"/>
        </xsl:attribute>
        <xsl:value-of select="resume/fund/@lic"/>
      </npf-dic:Nomer_Liczenzii>
      <npf-dic:Kod_OGRN>
        <xsl:attribute name="contextRef">
          <xsl:text>Context</xsl:text>
          <xsl:value-of select="$rows * 21 + 1"/>
        </xsl:attribute>
        <xsl:value-of select="resume/fund/@ogrn"/>      
      </npf-dic:Kod_OGRN>
      <npf-dic:Kod_INN>
        <xsl:attribute name="contextRef">
          <xsl:text>Context</xsl:text>
          <xsl:value-of select="$rows * 21 + 1"/>
        </xsl:attribute>
        <xsl:value-of select="resume/fund/@inn"/>      
      </npf-dic:Kod_INN>
      <npf-dic:Kod_OKATO_Territoriya>
        <xsl:attribute name="contextRef">
          <xsl:text>Context</xsl:text>
          <xsl:value-of select="$rows * 21 + 1"/>
        </xsl:attribute>
        <xsl:value-of select="resume/fund/@okato"/>      
      </npf-dic:Kod_OKATO_Territoriya>
      <npf-dic:LiczoOtvZaPrOblast>
        <xsl:attribute name="contextRef">
          <xsl:text>Context</xsl:text>
          <xsl:value-of select="$rows * 21 + 2"/>
        </xsl:attribute>
        <xsl:value-of select="resume/NisResponsible/@fio"/>
      </npf-dic:LiczoOtvZaPrOblast>
      <npf-dic:DolzhLiczaOtvZaPrOblast>
        <xsl:attribute name="contextRef">
          <xsl:text>Context</xsl:text>
          <xsl:value-of select="$rows * 21 + 2"/>
        </xsl:attribute>
        <xsl:value-of select="resume/NisResponsible/@pos"/>      
      </npf-dic:DolzhLiczaOtvZaPrOblast>
      <npf-dic:KontInfLiczaOtvZaPrOblast>
        <xsl:attribute name="contextRef">
          <xsl:text>Context</xsl:text>
          <xsl:value-of select="$rows * 21 + 2"/>
        </xsl:attribute>
        <xsl:value-of select="resume/NisResponsible/@phone"/>      
      </npf-dic:KontInfLiczaOtvZaPrOblast>
      <npf-dic:FIOLiczaOsushhFunkEdIspOrgFonda>
        <xsl:attribute name="contextRef">
          <xsl:text>Context</xsl:text>
          <xsl:value-of select="$rows * 21 + 1"/>
        </xsl:attribute>
        <xsl:value-of select="resume/CEO/@fio"/>      
      </npf-dic:FIOLiczaOsushhFunkEdIspOrgFonda>
      <npf-dic:DolzhLiczaOsushhFunkEdIspOrgFonda>
        <xsl:attribute name="contextRef">
          <xsl:text>Context</xsl:text>
          <xsl:value-of select="$rows * 21 + 1"/>
        </xsl:attribute>
        <xsl:value-of select="resume/CEO/@pos"/>          
      </npf-dic:DolzhLiczaOsushhFunkEdIspOrgFonda>
    </xbrl>
  </xsl:template>
</xsl:stylesheet>
