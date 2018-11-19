<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl"
    xmlns:npf-dic="http://www.cbr.ru/xbrl/nso/npf/dic" xmlns:xbrli="http://www.xbrl.org/2003/instance" xmlns:dim-int="http://www.cbr.ru/xbrl/udr/dim/dim-int"
>
  <xsl:output method="xml" indent="yes"/>

  <xsl:template match="/root">

    <xsl:variable name="id" select="resume/report/@id" />
    <xsl:variable name="periodBegin" select="resume/report/@periodBegin" />
    <xsl:variable name="periodEnd" select="resume/report/@periodEnd" />
    <xsl:variable name="periodPrebegin" select="resume/report/@periodPrebegin" />
    <xsl:variable name="rows" select="count(//row)" />

    <xsl:variable name="Pol_UchastnikEnumerator">
      <dict key="Ж" value="Pol_ZHMember" />
      <dict key="М" value="Pol_MMember" />
      <dict key="-" value="Ne_PrimenimoMember" />
    </xsl:variable>

    <xsl:variable name="Statust_UchastnikEnumerator">
      <dict key="НП" value="NPMember" />
      <dict key="ВПН" value="VPNMember" />
      <dict key="ПВ" value="PVMember" />
      <dict key="ПО" value="POMember" />
      <dict key="ВС" value="VSMember" />
      <dict key="ИД" value="IDMember" />
      <dict key="СМ" value="SMMember" />
      <dict key="-" value="Ne_PrimenimoMember" />
      <dict key="прочие" value="ProchieMember" />
    </xsl:variable>

    <xsl:variable name="Usl_FondirovaniyaEnumerator">
      <dict key="фондированная" value="FondirovannayaMember" />
      <dict key="не фондированная" value="NeFondirovannayaMember" />
      <dict key="частично фондированная" value="CHastichnoFondirovannayaMember" />
    </xsl:variable>

    <xsl:variable name="Otv_DopFondirovanieEnumerator">
      <dict key="фонд" value="FondMember" />
      <dict key="-" value="Ne_PrimenimoMember" />
      <dict key="смешанная" value="SmeshannayaMember" />
      <dict key="вкладчик" value="VkladchikMember" />
      <dict key="участник" value="UchastnikMember" />
    </xsl:variable>

    <xsl:variable name="Period_Dejst_GarantDoxodEnumerator">
      <dict key="период действия пенсионного договора" value="Period_Dejst_PensDogMember" />
      <dict key="1 год в соответствии с пенсионными правилами" value="P1God_Sootv_PensPravilaMember" />
      <dict key="период накопления" value="Period_NakoplMember" />
      <dict key="период выплат" value="Period_VyplatMember" />
      <dict key="другой период (указать)" value="Drugoj_PeriodMember" />
    </xsl:variable>

    <xsl:variable name="Zavis_Ur_Indeksaczii_PensEnumerator">
      <dict key="индексация не предусмотрена" value="Indeks_NePredusmotrenaMember" />
      <dict key="иные показатели" value="Inye_PokazateliMember" />
      <dict key="индекс потребительских цен" value="Indeks_PotrebCZenMember" />
      <dict key="ключевая ставка Банка России" value="Klyuch_Stavka_BRMember" />
      <dict key="ставка рефинансирования Банка России" value="Stavka_Refin_BRMember" />
      <dict key="доходность облигаций/депозитов на рынке" value="Doxod_OblDep_RynokMember" />

    </xsl:variable>

    <xsl:variable name="Nalichie_PravopreemstvaEnumerator">
      <dict key="Полное" value="PolnoeMember" />
      <dict key="Накопительное" value="NakopitelnoeMember" />
      <dict key="Выплатное" value="VyplatnoeMember" />
      <dict key="Нет" value="NetMember" />
      <dict key="Прочее" value="ProcheeMember" />
    </xsl:variable>

    <xsl:variable name="Period_Vyplaty_PensiyaEnumerator">
      <dict key="До исчерпания" value="IscherpanoMember" />
      <dict key="Пожизненно" value="PozhiznennoMember" />
      <dict key="-" value="Ne_PrimenimoMember" />
      <dict key="Срочно" value="SrochnoMember" />
      <dict key="Смешанно" value="SmeshanoMember" />
    </xsl:variable>

    <xbrli:xbrl xmlns:xbrldi="http://xbrl.org/2006/xbrldi" xmlns:iso4217="http://www.xbrl.org/2003/iso4217" xmlns:mem-int="http://www.cbr.ru/xbrl/udr/dom/mem-int" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:link="http://www.xbrl.org/2003/linkbase" xmlns:npf-dic="http://www.cbr.ru/xbrl/nso/npf/dic" xmlns:xbrli="http://www.xbrl.org/2003/instance" xmlns:dim-int="http://www.cbr.ru/xbrl/udr/dim/dim-int">
      <link:schemaRef xlink:type="simple" xlink:href="http://www.cbr.ru/xbrl/nso/npf/rep/2018-03-31/ep/ep_nso_npf_q_30d_reestr_0420258.xsd"/>
      <xsl:for-each select="row">

        <xbrli:context>
          <xsl:attribute name="id">
            <xsl:text>Context</xsl:text>
            <xsl:value-of select="(position() - 1) * 4 + 1"/>
          </xsl:attribute>
          <xbrli:entity>
            <xbrli:identifier scheme="http://www.cbr.ru">
              <xsl:value-of select="$id"/>
            </xbrli:identifier>
          </xbrli:entity>
          <xbrli:period>
            <xbrli:instant><xsl:value-of select="$periodEnd"/></xbrli:instant>
          </xbrli:period>
          <xbrli:scenario>
            <xbrldi:typedMember dimension="dim-int:ID_Dogovora_S_VkladchTaxis">
              <dim-int:ID_Dogovora_Typedname>
                <xsl:value-of select="F1"/>
              </dim-int:ID_Dogovora_Typedname>
            </xbrldi:typedMember>
            <xbrldi:typedMember dimension="dim-int:ID_uchastnikaTaxis">
              <dim-int:ID_FL_YULTypedName>
                <xsl:value-of select="F2"/>
              </dim-int:ID_FL_YULTypedName>
            </xbrldi:typedMember>
            <xbrldi:typedMember dimension="dim-int:ID_vkladchikaTaxis">
              <dim-int:ID_FL_YULTypedName>
                <xsl:value-of select="F0"/>
              </dim-int:ID_FL_YULTypedName>
            </xbrldi:typedMember>
          </xbrli:scenario>
        </xbrli:context>
        <xbrli:context>
          <xsl:attribute name="id">
            <xsl:text>Context</xsl:text>
            <xsl:value-of select="(position() - 1) * 4 + 2"/>
          </xsl:attribute>
          <xbrli:entity>
            <xbrli:identifier scheme="http://www.cbr.ru">
              <xsl:value-of select="$id"/>
            </xbrli:identifier>
          </xbrli:entity>
          <xbrli:period>
            <xbrli:startDate><xsl:value-of select="$periodBegin"/></xbrli:startDate>
            <xbrli:endDate><xsl:value-of select="$periodEnd"/></xbrli:endDate>
          </xbrli:period>
          <xbrli:scenario>
            <xbrldi:typedMember dimension="dim-int:ID_Dogovora_S_VkladchTaxis">
              <dim-int:ID_Dogovora_Typedname>
                <xsl:value-of select="F1"/>
              </dim-int:ID_Dogovora_Typedname>
            </xbrldi:typedMember>
            <xbrldi:typedMember dimension="dim-int:ID_uchastnikaTaxis">
              <dim-int:ID_FL_YULTypedName>
                <xsl:value-of select="F2"/>
              </dim-int:ID_FL_YULTypedName>
            </xbrldi:typedMember>
            <xbrldi:typedMember dimension="dim-int:ID_vkladchikaTaxis">
              <dim-int:ID_FL_YULTypedName>
                <xsl:value-of select="F0"/>
              </dim-int:ID_FL_YULTypedName>
            </xbrldi:typedMember>
          </xbrli:scenario>
        </xbrli:context>
        <xbrli:context>
          <xsl:attribute name="id">
            <xsl:text>Context</xsl:text>
            <xsl:value-of select="(position() - 1) * 4 + 3"/>
          </xsl:attribute>
          <xbrli:entity>
            <xbrli:identifier scheme="http://www.cbr.ru">
              <xsl:value-of select="$id"/>
            </xbrli:identifier>
          </xbrli:entity>
          <xbrli:period>
            <xbrli:instant>2017-12-31</xbrli:instant>
          </xbrli:period>
          <xbrli:scenario>
            <xbrldi:typedMember dimension="dim-int:ID_Dogovora_S_VkladchTaxis">
              <dim-int:ID_Dogovora_Typedname>
                <xsl:value-of select="F1"/>
              </dim-int:ID_Dogovora_Typedname>
            </xbrldi:typedMember>
            <xbrldi:typedMember dimension="dim-int:ID_uchastnikaTaxis">
              <dim-int:ID_FL_YULTypedName>
                <xsl:value-of select="F2"/>
              </dim-int:ID_FL_YULTypedName>
            </xbrldi:typedMember>
            <xbrldi:typedMember dimension="dim-int:ID_vkladchikaTaxis">
              <dim-int:ID_FL_YULTypedName>
                <xsl:value-of select="F0"/>
              </dim-int:ID_FL_YULTypedName>
            </xbrldi:typedMember>
          </xbrli:scenario>
        </xbrli:context>

        <xsl:if test="F33 or F34 or F35">

          <xbrli:context>
            <xsl:attribute name="id">
              <xsl:text>Context</xsl:text>
              <xsl:value-of select="(position() - 1) * 4 + 4"/>
            </xsl:attribute>
            <xbrli:entity>
              <xbrli:identifier scheme="http://www.cbr.ru">
                <xsl:value-of select="$id"/>
              </xbrli:identifier>
            </xbrli:entity>
            <xbrli:period>
              <xbrli:startDate><xsl:value-of select="$periodBegin"/></xbrli:startDate>
              <xbrli:endDate><xsl:value-of select="$periodEnd"/></xbrli:endDate>
            </xbrli:period>
            <xbrli:scenario>
              <xbrldi:explicitMember dimension="dim-int:Pens_Vyplaty_Otch_PeriodAxis">mem-int:PensiyaMember</xbrldi:explicitMember>
              <xbrldi:typedMember dimension="dim-int:ID_Dogovora_S_VkladchTaxis">
                <dim-int:ID_Dogovora_Typedname>
                  <xsl:value-of select="F1"/>
                </dim-int:ID_Dogovora_Typedname>
              </xbrldi:typedMember>
              <xbrldi:typedMember dimension="dim-int:ID_uchastnikaTaxis">
                <dim-int:ID_FL_YULTypedName>
                  <xsl:value-of select="F2"/>
                </dim-int:ID_FL_YULTypedName>
              </xbrldi:typedMember>
              <xbrldi:typedMember dimension="dim-int:ID_vkladchikaTaxis">
                <dim-int:ID_FL_YULTypedName>
                  <xsl:value-of select="F0"/>
                </dim-int:ID_FL_YULTypedName>
              </xbrldi:typedMember>
            </xbrli:scenario>
          </xbrli:context>

        </xsl:if>

      </xsl:for-each>

      <xbrli:context>
        <xsl:attribute name="id">
          <xsl:text>Context</xsl:text>
          <xsl:value-of select="$rows * 4 + 1"/>
        </xsl:attribute>
        <xbrli:entity>
          <xbrli:identifier scheme="http://www.cbr.ru">
            <xsl:value-of select="$id"/>
          </xbrli:identifier>
        </xbrli:entity>
        <xbrli:period>
          <xbrli:instant>
            <xsl:value-of select="$periodEnd"/>
          </xbrli:instant>
        </xbrli:period>
        <xbrli:scenario>
          <xbrldi:typedMember dimension="dim-int:PrOblastOtcetnostiTaxis">
            <dim-int:PrOblastOtchTypedName>Формат XBRL</dim-int:PrOblastOtchTypedName>
          </xbrldi:typedMember>
        </xbrli:scenario>
      </xbrli:context>
      <xbrli:context>
        <xsl:attribute name="id">
          <xsl:text>Context</xsl:text>
          <xsl:value-of select="$rows * 4 + 2"/>
        </xsl:attribute>
        <xbrli:entity>
          <xbrli:identifier scheme="http://www.cbr.ru">
            <xsl:value-of select="$id"/>
          </xbrli:identifier>
        </xbrli:entity>
        <xbrli:period>
          <xbrli:instant>
            <xsl:value-of select="$periodEnd"/>
          </xbrli:instant>
        </xbrli:period>
        <xbrli:scenario>
          <xbrldi:typedMember dimension="dim-int:PrOblastOtcetnostiTaxis">
            <dim-int:PrOblastOtchTypedName>NIS</dim-int:PrOblastOtchTypedName>
          </xbrldi:typedMember>
        </xbrli:scenario>
      </xbrli:context>
      <xbrli:context>
        <xsl:attribute name="id">
          <xsl:text>Context</xsl:text>
          <xsl:value-of select="$rows * 4 + 3"/>
        </xsl:attribute>
        <xbrli:entity>
          <xbrli:identifier scheme="http://www.cbr.ru">
            <xsl:value-of select="$id"/>
          </xbrli:identifier>
        </xbrli:entity>
        <xbrli:period>
          <xbrli:instant>
            <xsl:value-of select="$periodEnd"/>
          </xbrli:instant>
        </xbrli:period>
        <xbrli:scenario>
          <xbrldi:typedMember dimension="dim-int:PrOblastOtcetnostiTaxis">
            <dim-int:PrOblastOtchTypedName>Формы отчетности</dim-int:PrOblastOtchTypedName>
          </xbrldi:typedMember>
        </xbrli:scenario>
      </xbrli:context>
      <xbrli:context>
        <xsl:attribute name="id">
          <xsl:text>Context</xsl:text>
          <xsl:value-of select="$rows * 4 + 4"/>
        </xsl:attribute>
        <xbrli:entity>
          <xbrli:identifier scheme="http://www.cbr.ru">
            <xsl:value-of select="$id"/>
          </xbrli:identifier>
        </xbrli:entity>
        <xbrli:period>
          <xbrli:instant>
            <xsl:value-of select="$periodPrebegin"/>
          </xbrli:instant>
        </xbrli:period>
      </xbrli:context>
      <xbrli:context>
        <xsl:attribute name="id">
          <xsl:text>Context</xsl:text>
          <xsl:value-of select="$rows * 4 + 5"/>
        </xsl:attribute>
        <xbrli:entity>
          <xbrli:identifier scheme="http://www.cbr.ru">
            <xsl:value-of select="$id"/>
          </xbrli:identifier>
        </xbrli:entity>
        <xbrli:period>
          <xbrli:startDate>
            <xsl:value-of select="$periodBegin"/>
          </xbrli:startDate>
          <xbrli:endDate>
            <xsl:value-of select="$periodEnd"/>
          </xbrli:endDate>
        </xbrli:period>
      </xbrli:context>
      <xbrli:context>
        <xsl:attribute name="id">
          <xsl:text>Context</xsl:text>
          <xsl:value-of select="$rows * 4 + 6"/>
        </xsl:attribute>
        <xbrli:entity>
          <xbrli:identifier scheme="http://www.cbr.ru">
            <xsl:value-of select="$id"/>
          </xbrli:identifier>
        </xbrli:entity>
        <xbrli:period>
          <xbrli:instant>
            <xsl:value-of select="$periodEnd"/>
          </xbrli:instant>
        </xbrli:period>
      </xbrli:context>
      <xbrli:unit id="RUB">
        <xbrli:measure>iso4217:RUB</xbrli:measure>
      </xbrli:unit>
      <xbrli:unit id="decimal">
        <xbrli:measure>xbrli:pure</xbrli:measure>
      </xbrli:unit>

      <xsl:for-each select="row">
        <xsl:if test="F3">
          <npf-dic:Nomer_Dog_Vkladchik>
            <xsl:attribute name="contextRef">
              <xsl:text>Context</xsl:text>
              <xsl:value-of select="(position() - 1) * 4 + 1"/>
            </xsl:attribute>
            <xsl:value-of select="F3"/>
          </npf-dic:Nomer_Dog_Vkladchik>
        </xsl:if>
        <xsl:if test="F4">
          <npf-dic:Data_ZaklDog_Vkladchik>
            <xsl:attribute name="contextRef">
              <xsl:text>Context</xsl:text>
              <xsl:value-of select="(position() - 1) * 4 + 1"/>
            </xsl:attribute>
            <xsl:value-of select="F4"/>
          </npf-dic:Data_ZaklDog_Vkladchik>
        </xsl:if>
        <xsl:if test="F5">
          <npf-dic:PolnNaim_Vkladchik>
            <xsl:attribute name="contextRef">
              <xsl:text>Context</xsl:text>
              <xsl:value-of select="(position() - 1) * 4 + 1"/>
            </xsl:attribute>
            <xsl:value-of select="F5"/>
          </npf-dic:PolnNaim_Vkladchik>
        </xsl:if>
        <xsl:if test="F6">
          <npf-dic:INN_TIN_Vkladchik>
            <xsl:attribute name="contextRef">
              <xsl:text>Context</xsl:text>
              <xsl:value-of select="(position() - 1) * 4 + 1"/>
            </xsl:attribute>
            <xsl:value-of select="F6"/>
          </npf-dic:INN_TIN_Vkladchik>
        </xsl:if>
        <xsl:if test="F7">
          <npf-dic:Nomer_PensSchet>
            <xsl:attribute name="contextRef">
              <xsl:text>Context</xsl:text>
              <xsl:value-of select="(position() - 1) * 4 + 1"/>
            </xsl:attribute>
            <xsl:value-of select="F7"/>
          </npf-dic:Nomer_PensSchet>
        </xsl:if>
        <xsl:if test="F8">
          <npf-dic:INN_TIN_Uchastnik>
            <xsl:attribute name="contextRef">
              <xsl:text>Context</xsl:text>
              <xsl:value-of select="(position() - 1) * 4 + 1"/>
            </xsl:attribute>
            <xsl:value-of select="F8"/>
          </npf-dic:INN_TIN_Uchastnik>
        </xsl:if>
        <xsl:if test="F9">
          <npf-dic:Data_Rozhd_Uchastnik>
            <xsl:attribute name="contextRef">
              <xsl:text>Context</xsl:text>
              <xsl:value-of select="(position() - 1) * 4 + 1"/>
            </xsl:attribute>
            <xsl:value-of select="F9"/>
          </npf-dic:Data_Rozhd_Uchastnik>
        </xsl:if>
        <xsl:if test="F10">
          <npf-dic:Data_Smert_Uchastnik>
            <xsl:attribute name="contextRef">
              <xsl:text>Context</xsl:text>
              <xsl:value-of select="(position() - 1) * 4 + 1"/>
            </xsl:attribute>
            <xsl:value-of select="F10"/>
          </npf-dic:Data_Smert_Uchastnik>
        </xsl:if>
        <xsl:if test="F11">
          <npf-dic:Pol_UchastnikEnumerator>
            <xsl:variable name="Pol_UchastnikEnumerator_Key">
              <xsl:value-of select="F11"/>
            </xsl:variable>
            <xsl:attribute name="contextRef">
              <xsl:text>Context</xsl:text>
              <xsl:value-of select="(position() - 1) * 4 + 1"/>
            </xsl:attribute>
            <xsl:text>mem-int:</xsl:text>
            <xsl:value-of select="msxsl:node-set($Pol_UchastnikEnumerator)/dict[@key=$Pol_UchastnikEnumerator_Key]/@value"/>
          </npf-dic:Pol_UchastnikEnumerator>
        </xsl:if>
        <xsl:if test="F12">
          <npf-dic:Nomer_PensSxemy>
            <xsl:attribute name="contextRef">
              <xsl:text>Context</xsl:text>
              <xsl:value-of select="(position() - 1) * 4 + 1"/>
            </xsl:attribute>
            <xsl:value-of select="F12"/>
          </npf-dic:Nomer_PensSxemy>
        </xsl:if>
        <xsl:if test="F13">
          <npf-dic:Statust_UchastnikEnumerator>
            <xsl:variable name="Statust_UchastnikEnumerator_Key">
              <xsl:value-of select="F13"/>
            </xsl:variable>
            <xsl:attribute name="contextRef">
              <xsl:text>Context</xsl:text>
              <xsl:value-of select="(position() - 1) * 4 + 1"/>
            </xsl:attribute>
            <xsl:text>mem-int:</xsl:text>
            <xsl:value-of select="msxsl:node-set($Statust_UchastnikEnumerator)/dict[@key=$Statust_UchastnikEnumerator_Key]/@value"/>
          </npf-dic:Statust_UchastnikEnumerator>
        </xsl:if>
        <xsl:if test="F14">
          <npf-dic:Usl_FondirovaniyaEnumerator>
            <xsl:variable name="Usl_FondirovaniyaEnumerator_Key">
              <xsl:value-of select="F14"/>
            </xsl:variable>
            <xsl:attribute name="contextRef">
              <xsl:text>Context</xsl:text>
              <xsl:value-of select="(position() - 1) * 4 + 1"/>
            </xsl:attribute>
            <xsl:text>mem-int:</xsl:text>
            <xsl:value-of select="msxsl:node-set($Usl_FondirovaniyaEnumerator)/dict[@key=$Usl_FondirovaniyaEnumerator_Key]/@value"/>
          </npf-dic:Usl_FondirovaniyaEnumerator>
        </xsl:if>
        <xsl:if test="F15">
          <npf-dic:Otv_DopFondirovanieEnumerator>
            <xsl:variable name="Otv_DopFondirovanieEnumerator_Key">
              <xsl:value-of select="F15"/>
            </xsl:variable>
            <xsl:attribute name="contextRef">
              <xsl:text>Context</xsl:text>
              <xsl:value-of select="(position() - 1) * 4 + 1"/>
            </xsl:attribute>
            <xsl:text>mem-int:</xsl:text>
            <xsl:value-of select="msxsl:node-set($Otv_DopFondirovanieEnumerator)/dict[@key=$Otv_DopFondirovanieEnumerator_Key]/@value"/>
          </npf-dic:Otv_DopFondirovanieEnumerator>
        </xsl:if>
        <xsl:if test="F16">
          <npf-dic:Ur_GarantDoxod decimals="2" unitRef="decimal">
            <xsl:attribute name="contextRef">
              <xsl:text>Context</xsl:text>
              <xsl:value-of select="(position() - 1) * 4 + 2"/>
            </xsl:attribute>
            <xsl:value-of select="F16"/>
          </npf-dic:Ur_GarantDoxod>
        </xsl:if>
        <xsl:if test="F17">
          <npf-dic:Period_Dejst_GarantDoxodEnumerator>
            <xsl:variable name="Period_Dejst_GarantDoxodEnumerator_Key">
              <xsl:value-of select="F17"/>
            </xsl:variable>
            <xsl:attribute name="contextRef">
              <xsl:text>Context</xsl:text>
              <xsl:value-of select="(position() - 1) * 4 + 1"/>
            </xsl:attribute>
            <xsl:text>mem-int:</xsl:text>
            <xsl:value-of select="msxsl:node-set($Period_Dejst_GarantDoxodEnumerator)/dict[@key=$Period_Dejst_GarantDoxodEnumerator_Key]/@value"/>
          </npf-dic:Period_Dejst_GarantDoxodEnumerator>
        </xsl:if>
        <xsl:if test="F20">
          <npf-dic:Zavis_Ur_Indeksaczii_PensEnumerator>
            <xsl:variable name="Zavis_Ur_Indeksaczii_PensEnumerator_Key">
              <xsl:value-of select="F20"/>
            </xsl:variable>
            <xsl:attribute name="contextRef">
              <xsl:text>Context</xsl:text>
              <xsl:value-of select="(position() - 1) * 4 + 1"/>
            </xsl:attribute>
            <xsl:text>mem-int:</xsl:text>
            <xsl:value-of select="msxsl:node-set($Zavis_Ur_Indeksaczii_PensEnumerator)/dict[@key=$Zavis_Ur_Indeksaczii_PensEnumerator_Key]/@value"/>
          </npf-dic:Zavis_Ur_Indeksaczii_PensEnumerator>
        </xsl:if>
        <xsl:if test="F21">
          <npf-dic:Zavis_Ur_Indeksaczii_PensInyePokazateli>
            <xsl:attribute name="contextRef">
              <xsl:text>Context</xsl:text>
              <xsl:value-of select="(position() - 1) * 4 + 1"/>
            </xsl:attribute>
            <xsl:value-of select="F21"/>
          </npf-dic:Zavis_Ur_Indeksaczii_PensInyePokazateli>
        </xsl:if>
        <xsl:if test="F22">
          <npf-dic:Nalichie_PravopreemstvaEnumerator>
            <xsl:variable name="Nalichie_PravopreemstvaEnumerator_Key">
              <xsl:value-of select="F22"/>
            </xsl:variable>
            <xsl:attribute name="contextRef">
              <xsl:text>Context</xsl:text>
              <xsl:value-of select="(position() - 1) * 4 + 1"/>
            </xsl:attribute>
            <xsl:text>mem-int:</xsl:text>
            <xsl:value-of select="msxsl:node-set($Nalichie_PravopreemstvaEnumerator)/dict[@key=$Nalichie_PravopreemstvaEnumerator_Key]/@value"/>
          </npf-dic:Nalichie_PravopreemstvaEnumerator>
        </xsl:if>
        <xsl:if test="F23">
          <npf-dic:Summa_NaPensSchete_Otch_data decimals="2" unitRef="RUB">
            <xsl:attribute name="contextRef">
              <xsl:text>Context</xsl:text>
              <xsl:value-of select="(position() - 1) * 4 + 3"/>
            </xsl:attribute>
            <xsl:value-of select="F23"/>
          </npf-dic:Summa_NaPensSchete_Otch_data>
        </xsl:if>
        <xsl:if test="F24">
          <npf-dic:Data_Nach_Vypl_Pens>
            <xsl:attribute name="contextRef">
              <xsl:text>Context</xsl:text>
              <xsl:value-of select="(position() - 1) * 4 + 1"/>
            </xsl:attribute>
            <xsl:value-of select="F24"/>
          </npf-dic:Data_Nach_Vypl_Pens>
        </xsl:if>
        <xsl:if test="F25">
          <npf-dic:Period_Vyplaty_PensiyaEnumerator>
            <xsl:variable name="Period_Vyplaty_PensiyaEnumerator_Key">
              <xsl:value-of select="F25"/>
            </xsl:variable>
            <xsl:attribute name="contextRef">
              <xsl:text>Context</xsl:text>
              <xsl:value-of select="(position() - 1) * 4 + 1"/>
            </xsl:attribute>
            <xsl:text>mem-int:</xsl:text>
            <xsl:value-of select="msxsl:node-set($Period_Vyplaty_PensiyaEnumerator)/dict[@key=$Period_Vyplaty_PensiyaEnumerator_Key]/@value"/>
          </npf-dic:Period_Vyplaty_PensiyaEnumerator>
        </xsl:if>
        <xsl:if test="F26">
          <npf-dic:Period_Vypl_Pens>
            <xsl:attribute name="contextRef">
              <xsl:text>Context</xsl:text>
              <xsl:value-of select="(position() - 1) * 4 + 1"/>
            </xsl:attribute>
            <xsl:value-of select="F26"/>
          </npf-dic:Period_Vypl_Pens>
        </xsl:if>
        <xsl:if test="F27">
          <npf-dic:Data_Okonch_Vypl_Pens>
            <xsl:attribute name="contextRef">
              <xsl:text>Context</xsl:text>
              <xsl:value-of select="(position() - 1) * 4 + 1"/>
            </xsl:attribute>
            <xsl:value-of select="F27"/>
          </npf-dic:Data_Okonch_Vypl_Pens>
        </xsl:if>
        <xsl:if test="F28">
          <npf-dic:Data_Prekr_Uchastiya>
            <xsl:attribute name="contextRef">
              <xsl:text>Context</xsl:text>
              <xsl:value-of select="(position() - 1) * 4 + 1"/>
            </xsl:attribute>
            <xsl:value-of select="F28"/>
          </npf-dic:Data_Prekr_Uchastiya>
        </xsl:if>
        <xsl:if test="F29">
          <npf-dic:NPO_Vznos decimals="2" unitRef="RUB">
            <xsl:attribute name="contextRef">
              <xsl:text>Context</xsl:text>
              <xsl:value-of select="(position() - 1) * 4 + 2"/>
            </xsl:attribute>
            <xsl:value-of select="F29"/>
          </npf-dic:NPO_Vznos>
        </xsl:if>
        <xsl:if test="F31">
          <npf-dic:SummaPerevodov_Schet_OtchPer decimals="2" unitRef="RUB">
            <xsl:attribute name="contextRef">
              <xsl:text>Context</xsl:text>
              <xsl:value-of select="(position() - 1) * 4 + 2"/>
            </xsl:attribute>
            <xsl:value-of select="F31"/>
          </npf-dic:SummaPerevodov_Schet_OtchPer>
        </xsl:if>
        <xsl:if test="F32">
          <npf-dic:InyePerevody_Schet_OtchPer decimals="2" unitRef="RUB">
            <xsl:attribute name="contextRef">
              <xsl:text>Context</xsl:text>
              <xsl:value-of select="(position() - 1) * 4 + 2"/>
            </xsl:attribute>
            <xsl:value-of select="F32"/>
          </npf-dic:InyePerevody_Schet_OtchPer>
        </xsl:if>
        <xsl:if test="F33 or F34 or F35">
          <npf-dic:Pens_Vyplaty_Period decimals="2" unitRef="RUB">
            <xsl:attribute name="contextRef">
              <xsl:text>Context</xsl:text>
              <xsl:value-of select="(position() - 1) * 4 + 4"/>
            </xsl:attribute>
            <xsl:value-of select="sum((F33 | F34 | F35)[number(.) = number(.)])"/>
          </npf-dic:Pens_Vyplaty_Period>
        </xsl:if>
        <xsl:if test="F36">
          <npf-dic:Summa_NaPensSchete_Otch_data decimals="2" unitRef="RUB">
            <xsl:attribute name="contextRef">
              <xsl:text>Context</xsl:text>
              <xsl:value-of select="(position() - 1) * 4 + 1"/>
            </xsl:attribute>
            <xsl:value-of select="F36"/>
          </npf-dic:Summa_NaPensSchete_Otch_data>
        </xsl:if>
        <xsl:if test="F37">
          <npf-dic:Summa_ObyazatVykupSumma_KonPer decimals="2" unitRef="RUB">
            <xsl:attribute name="contextRef">
              <xsl:text>Context</xsl:text>
              <xsl:value-of select="(position() - 1) * 4 + 1"/>
            </xsl:attribute>
            <xsl:value-of select="F37"/>
          </npf-dic:Summa_ObyazatVykupSumma_KonPer>
        </xsl:if>
        <xsl:if test="F38">
          <npf-dic:Summa_ObyazatPeredPravopreemnik_KonPer decimals="2" unitRef="RUB">
            <xsl:attribute name="contextRef">
              <xsl:text>Context</xsl:text>
              <xsl:value-of select="(position() - 1) * 4 + 1"/>
            </xsl:attribute>
            <xsl:value-of select="F38"/>
          </npf-dic:Summa_ObyazatPeredPravopreemnik_KonPer>
        </xsl:if>
      </xsl:for-each>

      <npf-dic:LiczoOtvZaPrOblast>
        <xsl:attribute name="contextRef">
          <xsl:text>Context</xsl:text>
          <xsl:value-of select="$rows * 4 + 1"/>
        </xsl:attribute>
        <xsl:value-of select="resume/XbrlResponsible/@fio"/>
      </npf-dic:LiczoOtvZaPrOblast>
      <npf-dic:DolzhLiczaOtvZaPrOblast>
        <xsl:attribute name="contextRef">
          <xsl:text>Context</xsl:text>
          <xsl:value-of select="$rows * 4 + 1"/>
        </xsl:attribute>
        <xsl:value-of select="resume/XbrlResponsible/@pos"/>
      </npf-dic:DolzhLiczaOtvZaPrOblast>
      <npf-dic:KontInfLiczaOtvZaPrOblast>
        <xsl:attribute name="contextRef">
          <xsl:text>Context</xsl:text>
          <xsl:value-of select="$rows * 4 + 1"/>
        </xsl:attribute>
        <xsl:value-of select="resume/XbrlResponsible/@phone"/>
      </npf-dic:KontInfLiczaOtvZaPrOblast>
      <npf-dic:LiczoOtvZaPrOblast>
        <xsl:attribute name="contextRef">
          <xsl:text>Context</xsl:text>
          <xsl:value-of select="$rows * 4 + 2"/>
        </xsl:attribute>
        <xsl:value-of select="resume/NisResponsible/@fio"/>
      </npf-dic:LiczoOtvZaPrOblast>
      <npf-dic:DolzhLiczaOtvZaPrOblast>
        <xsl:attribute name="contextRef">
          <xsl:text>Context</xsl:text>
          <xsl:value-of select="$rows * 4 + 2"/>
        </xsl:attribute>
        <xsl:value-of select="resume/NisResponsible/@pos"/>
      </npf-dic:DolzhLiczaOtvZaPrOblast>
      <npf-dic:KontInfLiczaOtvZaPrOblast>
        <xsl:attribute name="contextRef">
          <xsl:text>Context</xsl:text>
          <xsl:value-of select="$rows * 4 + 2"/>
        </xsl:attribute>
        <xsl:value-of select="resume/NisResponsible/@phone"/>
      </npf-dic:KontInfLiczaOtvZaPrOblast>
      <npf-dic:LiczoOtvZaPrOblast>
        <xsl:attribute name="contextRef">
          <xsl:text>Context</xsl:text>
          <xsl:value-of select="$rows * 4 + 3"/>
        </xsl:attribute>
        <xsl:value-of select="resume/FormResponsible/@fio"/>
      </npf-dic:LiczoOtvZaPrOblast>
      <npf-dic:DolzhLiczaOtvZaPrOblast>
        <xsl:attribute name="contextRef">
          <xsl:text>Context</xsl:text>
          <xsl:value-of select="$rows * 4 + 3"/>
        </xsl:attribute>
        <xsl:value-of select="resume/FormResponsible/@pos"/>
      </npf-dic:DolzhLiczaOtvZaPrOblast>
      <npf-dic:KontInfLiczaOtvZaPrOblast>
        <xsl:attribute name="contextRef">
          <xsl:text>Context</xsl:text>
          <xsl:value-of select="$rows * 4 + 3"/>
        </xsl:attribute>
        <xsl:value-of select="resume/FormResponsible/@phone"/>
      </npf-dic:KontInfLiczaOtvZaPrOblast>
      <npf-dic:RezervPozhiznVyplat_NachPer decimals="2" unitRef="RUB">
        <xsl:attribute name="contextRef">
          <xsl:text>Context</xsl:text>
          <xsl:value-of select="$rows * 4 + 4"/>
        </xsl:attribute>
        <xsl:value-of select="resume/totals/@lifetimeResOnBegin"/>
      </npf-dic:RezervPozhiznVyplat_NachPer>
      <npf-dic:NPO_PensVyplaty decimals="2" unitRef="RUB">
        <xsl:attribute name="contextRef">
          <xsl:text>Context</xsl:text>
          <xsl:value-of select="$rows * 4 + 5"/>
        </xsl:attribute>
        <xsl:value-of select="resume/totals/@npoPaid"/>
      </npf-dic:NPO_PensVyplaty>
      <npf-dic:Summaperevodov_RezervPozhiznVyplat_OtchPer decimals="2" unitRef="RUB">
        <xsl:attribute name="contextRef">
          <xsl:text>Context</xsl:text>
          <xsl:value-of select="$rows * 4 + 5"/>
        </xsl:attribute>
        <xsl:value-of select="resume/totals/@lifetimeResTrans"/>
      </npf-dic:Summaperevodov_RezervPozhiznVyplat_OtchPer>

      <npf-dic:RezervPozhiznVyplat_KonPer decimals="2" unitRef="RUB">
        <xsl:attribute name="contextRef">
          <xsl:text>Context</xsl:text>
          <xsl:value-of select="$rows * 4 + 6"/>
        </xsl:attribute>
        <xsl:value-of select="resume/totals/@lifetimeRes"/>
      </npf-dic:RezervPozhiznVyplat_KonPer>
      <npf-dic:Nomer_Liczenzii contextRef="Context15570">
        <xsl:attribute name="contextRef">
          <xsl:text>Context</xsl:text>
          <xsl:value-of select="$rows * 4 + 6"/>
        </xsl:attribute>
        <xsl:value-of select="resume/fund/@lic"/>
      </npf-dic:Nomer_Liczenzii>
      <npf-dic:Kod_OKATO_Territoriya>
        <xsl:attribute name="contextRef">
          <xsl:text>Context</xsl:text>
          <xsl:value-of select="$rows * 4 + 6"/>
        </xsl:attribute>
        <xsl:value-of select="resume/fund/@okato"/>
      </npf-dic:Kod_OKATO_Territoriya>
      <npf-dic:Kod_INN>
        <xsl:attribute name="contextRef">
          <xsl:text>Context</xsl:text>
          <xsl:value-of select="$rows * 4 + 6"/>
        </xsl:attribute>
        <xsl:value-of select="resume/fund/@inn"/>
      </npf-dic:Kod_INN>
      <npf-dic:Kod_OGRN>
        <xsl:attribute name="contextRef">
          <xsl:text>Context</xsl:text>
          <xsl:value-of select="$rows * 4 + 6"/>
        </xsl:attribute>
        <xsl:value-of select="resume/fund/@ogrn"/>
      </npf-dic:Kod_OGRN>
      <npf-dic:FIOLiczaOsushhFunkEdIspOrgFonda>
        <xsl:attribute name="contextRef">
          <xsl:text>Context</xsl:text>
          <xsl:value-of select="$rows * 4 + 6"/>
        </xsl:attribute>
        <xsl:value-of select="resume/CEO/@fio"/>
      </npf-dic:FIOLiczaOsushhFunkEdIspOrgFonda>
      <npf-dic:DolzhLiczaOsushhFunkEdIspOrgFonda>
        <xsl:attribute name="contextRef">
          <xsl:text>Context</xsl:text>
          <xsl:value-of select="$rows * 4 + 6"/>
        </xsl:attribute>
        <xsl:value-of select="resume/CEO/@pos"/>
      </npf-dic:DolzhLiczaOsushhFunkEdIspOrgFonda>

      <!--<npf-dic:Nomer_Dog_Vkladchik contextRef="Context53">1</npf-dic:Nomer_Dog_Vkladchik>
      <npf-dic:Data_ZaklDog_Vkladchik contextRef="Context53">2002-08-15</npf-dic:Data_ZaklDog_Vkladchik>
      <npf-dic:PolnNaim_Vkladchik contextRef="Context53">ФЛ</npf-dic:PolnNaim_Vkladchik>
      <npf-dic:INN_TIN_Vkladchik contextRef="Context53">27410130305</npf-dic:INN_TIN_Vkladchik>
      <npf-dic:Nomer_PensSchet contextRef="Context53">ИПС 110</npf-dic:Nomer_PensSchet>
      <npf-dic:INN_TIN_Uchastnik contextRef="Context53">27410130305</npf-dic:INN_TIN_Uchastnik>
      <npf-dic:Data_Rozhd_Uchastnik contextRef="Context53">1959-01-25</npf-dic:Data_Rozhd_Uchastnik>
      <npf-dic:Data_Smert_Uchastnik contextRef="Context476">2017-04-01</npf-dic:Data_Smert_Uchastnik>
      <npf-dic:Pol_UchastnikEnumerator contextRef="Context53">mem-int:(:Pol_MMember|Pol_ZHMember)</npf-dic:Pol_UchastnikEnumerator>
      <npf-dic:Nomer_PensSxemy contextRef="Context53">3181803</npf-dic:Nomer_PensSxemy>
      <npf-dic:Statust_UchastnikEnumerator contextRef="Context53">mem-int:(NPMember|VPNMember|PVMember|POMember|VSMember|IDMember|SMMember|Ne_PrimenimoMember|ProchieMember)</npf-dic:Statust_UchastnikEnumerator>
      <npf-dic:Usl_FondirovaniyaEnumerator contextRef="Context53">mem-int:FondirovannayaMember</npf-dic:Usl_FondirovaniyaEnumerator>
      <npf-dic:Otv_DopFondirovanieEnumerator contextRef="Context53">mem-int:FondMember</npf-dic:Otv_DopFondirovanieEnumerator>
      <npf-dic:Ur_GarantDoxod decimals="2" contextRef="Context54" unitRef="decimal">0</npf-dic:Ur_GarantDoxod>
      <npf-dic:Period_Dejst_GarantDoxodEnumerator contextRef="Context53">mem-int:Period_Dejst_PensDogMember</npf-dic:Period_Dejst_GarantDoxodEnumerator>
      -->
      <!-- Период действия гарантированного дохода -->
      <!--
      -->
      <!-- Величина минимальной индексации, в процентах -->
      <!--
      <npf-dic:Zavis_Ur_Indeksaczii_PensEnumerator contextRef="Context53">mem-int:Indeks_NePredusmotrenaMember</npf-dic:Zavis_Ur_Indeksaczii_PensEnumerator>
      -->
      <!-- Зависимость уровня индексации пенсии -->
      <!--
      <npf-dic:Nalichie_PravopreemstvaEnumerator contextRef="Context53">mem-int:PolnoeMember</npf-dic:Nalichie_PravopreemstvaEnumerator>
      <npf-dic:Summa_NaPensSchete_Otch_data decimals="2" contextRef="Context55" unitRef="RUB">1044328.17</npf-dic:Summa_NaPensSchete_Otch_data>
      <npf-dic:Data_Nach_Vypl_Pens contextRef="Context53">2014-02-01</npf-dic:Data_Nach_Vypl_Pens>
      <npf-dic:Period_Vyplaty_PensiyaEnumerator contextRef="Context53">mem-int:IscherpanoMember</npf-dic:Period_Vyplaty_PensiyaEnumerator>
      <npf-dic:Period_Vypl_Pens contextRef="Context53">один раз в 1 месяцев</npf-dic:Period_Vypl_Pens>
      -->
      <!-- Дата окончания пенсионных выплат-->
      <!--
      <npf-dic:Data_Prekr_Uchastiya contextRef="Context3009">2018-01-18</npf-dic:Data_Prekr_Uchastiya>
      <npf-dic:NPO_Vznos decimals="2" contextRef="Context2270" unitRef="RUB">100</npf-dic:NPO_Vznos>
      -->
      <!-- Финансовый результат от размещения пенсионных резервов за отчетный период, учтенный на счете-->
      <!--
      -->
      <!-- Сумма переводов по счету за отчетный период-->
      <!--
      -->
      <!-- Иные переводы по счету за отчетный период-->
      <!--
      <npf-dic:Pens_Vyplaty_Period decimals="2" contextRef="Context56" unitRef="RUB">88406.85</npf-dic:Pens_Vyplaty_Period>
      -->
      <!-- выкупная?правопреемники?-->
      <!--
      <npf-dic:Summa_NaPensSchete_Otch_data decimals="2" contextRef="Context53" unitRef="RUB">955921.32</npf-dic:Summa_NaPensSchete_Otch_data>
      <npf-dic:Summa_ObyazatVykupSumma_KonPer decimals="2" contextRef="Context53" unitRef="RUB">955921.32</npf-dic:Summa_ObyazatVykupSumma_KonPer>-->
      <!-- Сумма обязательств на конец отчетного периода перед правопреемником-->
    </xbrli:xbrl>

  </xsl:template>
</xsl:stylesheet>
