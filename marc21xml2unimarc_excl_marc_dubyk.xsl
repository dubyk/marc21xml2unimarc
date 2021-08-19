<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" exclude-result-prefixes="marc"
	xmlns="http://www.loc.gov/MARC21/slim"
	xmlns:marc="http://www.loc.gov/MARC21/slim"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xsi:schemaLocation="http://www.loc.gov/MARC21/slim http://www.loc.gov/standards/marcxml/schema/MARC21slim.xsd"
	>
  <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
  <xsl:strip-space elements="*"/>


 <!-- <xsl:template match="/">
    <collection xmlns="http://www.loc.gov/MARC21/slim" xsi:schemaLocation="http://www.loc.gov/MARC21/slim http://www.loc.gov/standards/marcxml/schema/MARC21slim.xsd">
      <xsl:for-each select="marc:collection">
        <xsl:if test="@name"><xsl:attribute name="name"><xsl:value-of select="@name"/></xsl:attribute></xsl:if>
		  <xsl:for-each select="marc:record">
		    <record>
			   <xsl:call-template name="record"/>
          </record>
        </xsl:for-each>
      </xsl:for-each>
    </collection>   
  </xsl:template> 
-->

<!--  <xsl:template match="marc:record">
    <xsl:copy>
          <xsl:for-each select="record">
            <record>
              <xsl:call-template name="."/>
            </record>
          </xsl:for-each>
     </xsl:copy>
  </xsl:template>   -->


<xsl:template match="/">
    <xsl:choose>
      <xsl:when test="marc:collection">
         <collection xmlns="http://www.loc.gov/MARC21/slim" xsi:schemaLocation="http://www.loc.gov/MARC21/slim http://www.loc.gov/standards/marcxml/schema/MARC21slim.xsd">
           <xsl:choose>
             <xsl:when test="marc:collection/marc:record">
               <xsl:for-each select="marc:collection/marc:record">
                 <record>
                    <xsl:call-template name="record"/>
                 </record>
               </xsl:for-each>
             </xsl:when>
             <xsl:when test="marc:collection/record">
               <xsl:for-each select="marc:collection/record">
                 <record>
                   <xsl:call-template name="record"/>
                 </record>
               </xsl:for-each>
             </xsl:when>
             <xsl:otherwise>
             </xsl:otherwise>
           </xsl:choose>
         </collection>
      </xsl:when>
      <xsl:when test="collection">
        <collection xmlns="http://www.loc.gov/MARC21/slim" xsi:schemaLocation="http://www.loc.gov/MARC21/slim http://www.loc.gov/standards/marcxml/schema/MARC21slim.xsd">
          <xsl:choose>
            <xsl:when test="collection/marc:record">
              <xsl:for-each select="collection/marc:record">
		          <record>
			         <xsl:call-template name="record"/>
                </record>
              </xsl:for-each>
            </xsl:when>
            <xsl:when test="collection/record">
              <xsl:for-each select="collection/record">
		          <record>
			         <xsl:call-template name="record"/>
                </record>
              </xsl:for-each>
            </xsl:when>
            <xsl:otherwise>
            </xsl:otherwise>
          </xsl:choose>
        </collection>
      </xsl:when>
      <xsl:when test="marc:record">
        <collection xmlns="http://www.loc.gov/MARC21/slim" xsi:schemaLocation="http://www.loc.gov/MARC21/slim http://www.loc.gov/standards/marcxml/schema/MARC21slim.xsd">
          <record>
			   <xsl:call-template name="record"/>
          </record>
        </collection>
      </xsl:when>
      <xsl:when test="record">
        <collection xmlns="http://www.loc.gov/MARC21/slim" xsi:schemaLocation="http://www.loc.gov/MARC21/slim http://www.loc.gov/standards/marcxml/schema/MARC21slim.xsd">
          <record>
			   <xsl:call-template name="record"/>
          </record>
        </collection>
      </xsl:when>
      <xsl:otherwise>
      </xsl:otherwise>
    </xsl:choose>
</xsl:template>



<!-- WORK for record
  <xsl:template match="marc:record">
          <xsl:for-each select=".">
            <record>
              <xsl:call-template name="record"/>
            </record>
          </xsl:for-each>
  </xsl:template>
-->

    
<!--  <xsl:template match="/">
    <xsl:choose>
      <xsl:when test="collection">
        <collection 
         xmlns="http://www.loc.gov/MARC21/slim" 
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
			xsi:schemaLocation="http://www.loc.gov/MARC21/slim http://www.loc.gov/standards/marcxml/schema/MARC21slim.xsd">
          <xsl:for-each select="collection/record">
            <record>
              <xsl:call-template name="record"/>
            </record>
          </xsl:for-each>
        </collection>
      </xsl:when>
      <xsl:otherwise>
        <record 
          xmlns="http://www.loc.gov/MARC21/slim" 
          xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
          xsi:schemaLocation="http://www.loc.gov/MARC21/slim http://www.loc.gov/standards/marcxml/schema/MARC21slim.xsd">
          <xsl:for-each select="record">
            <xsl:call-template name="record"/>
          </xsl:for-each>
        </record>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>  
-->
  <xsl:template name="record">
    <xsl:if test="@type"><xsl:attribute name="type"><xsl:value-of select="@type"/></xsl:attribute></xsl:if>
    <xsl:if test="@number"><xsl:attribute name="number"><xsl:value-of select="@number"/></xsl:attribute></xsl:if>
    
    
    <!-- Leader -->
    <xsl:call-template name="transform-leader"/>
    
      
      <!--  001 -->
      <xsl:for-each select="marc:controlfield[@tag = '001']">
       <controlfield tag="001"><xsl:value-of select="text()"/></controlfield>
      </xsl:for-each>

      <!--  005 -->
      <xsl:for-each select="marc:controlfield[@tag='005']">
       <controlfield tag="005"><xsl:value-of select="text()"/></controlfield>
      </xsl:for-each>

      <!--  020 > 010 ISBN -->
      <xsl:for-each select="marc:datafield[@tag = '020']">
       <xsl:if test="marc:subfield[@code='a'] or marc:subfield[@code='q'] or marc:subfield[@code='c'] or marc:subfield[@code='z']">
        <datafield tag="010">
         <xsl:attribute name="ind1"><xsl:value-of select="@ind1"/></xsl:attribute>
         <xsl:attribute name="ind2"><xsl:value-of select="@ind2"/></xsl:attribute>
         <!-- this code code removes all non-numeric characters -->
         <xsl:for-each select="marc:subfield[@code = 'a']"><subfield code="a"><xsl:value-of select="translate(text(),translate(text(),'0123456789-xXхХ',''),'')"/></subfield></xsl:for-each>
         <xsl:for-each select="marc:subfield[@code = 'q']"><subfield code="b"><xsl:value-of select="text()"/></subfield></xsl:for-each>
         <xsl:for-each select="marc:subfield[@code = 'c']"><subfield code="d"><xsl:value-of select="text()"/></subfield></xsl:for-each>
         <xsl:for-each select="marc:subfield[@code = 'z']"><subfield code="z"><xsl:value-of select="translate(text(),translate(text(),'0123456789-xXхХ',''),'')"/></subfield></xsl:for-each>
        </datafield>
       </xsl:if>
      </xsl:for-each>

      <!--  022 > 011 ISSN -->      
      <xsl:for-each select= "marc:datafield[@tag = '022']">
       <xsl:if test="marc:subfield[@code='a'] or marc:subfield[@code='y'] or marc:subfield[@code='z']">
        <datafield tag="011">
         <xsl:attribute name="ind1"><xsl:value-of select="@ind1"/></xsl:attribute>
         <xsl:attribute name="ind2"><xsl:value-of select="@ind2"/></xsl:attribute>
         <xsl:for-each select= "marc:subfield[@code = 'a']"><subfield code="a"><xsl:value-of select="text()"/></subfield></xsl:for-each>
         <!--<xsl:for-each select= "marc:subfield[@code='?']"><subfield code="b"><xsl:value-of select="text()" /></subfield></xsl:for-each>-->
         <!--<xsl:for-each select= "marc:subfield[@code='?']"><subfield code="d"><xsl:value-of select="text()" /></subfield></xsl:for-each>-->
         <xsl:for-each select= "marc:subfield[@code = 'y']"><subfield code="z"><xsl:value-of select="text()"/></subfield></xsl:for-each>
         <xsl:for-each select= "marc:subfield[@code = 'z']"><subfield code="y"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        </datafield>
       </xsl:if>
      </xsl:for-each>

     <xsl:for-each select= "marc:datafield[@tag='024']">
     <xsl:if test="marc:subfield[@code='a'] or marc:subfield[@code='q'] or marc:subfield[@code='d'] or marc:subfield[@code='c'] or marc:subfield[@code='z'] or marc:subfield[@code='2'] or marc:subfield[@code='6'] or marc:subfield[@code='8']">
     <datafield tag="017">
      <xsl:attribute name="ind1"><xsl:value-of select="@ind1" /></xsl:attribute>
      <xsl:attribute name="ind2"><xsl:value-of select="@ind2" /></xsl:attribute>
      <xsl:for-each select= "marc:subfield[@code='a']"><subfield code="a"><xsl:value-of select="text()" /></subfield></xsl:for-each>
      <xsl:for-each select= "marc:subfield[@code='q']"><subfield code="b"><xsl:value-of select="text()" /></subfield></xsl:for-each>
      <xsl:for-each select= "marc:subfield[@code='d']"><subfield code="c"><xsl:value-of select="text()" /></subfield></xsl:for-each>
      <xsl:for-each select= "marc:subfield[@code='c']"><subfield code="d"><xsl:value-of select="text()" /></subfield></xsl:for-each>
      <xsl:for-each select= "marc:subfield[@code='z']"><subfield code="z"><xsl:value-of select="text()" /></subfield></xsl:for-each>
      <xsl:for-each select= "marc:subfield[@code='2']"><subfield code="2"><xsl:value-of select="text()" /></subfield></xsl:for-each>
      <xsl:for-each select= "marc:subfield[@code='6']"><subfield code="6"><xsl:value-of select="text()" /></subfield></xsl:for-each>
      <xsl:for-each select= "marc:subfield[@code='8']"><subfield code="8"><xsl:value-of select="text()" /></subfield></xsl:for-each>
     </datafield>
     </xsl:if>
     </xsl:for-each>

      <xsl:for-each select= "marc:datafield[@tag = '015']">
      <xsl:if test="marc:subfield[@code='a'] or marc:subfield[@code='2']">
       <datafield tag="020">
        <xsl:attribute name="ind1"><xsl:value-of select="' '"/></xsl:attribute>
        <xsl:attribute name="ind2"><xsl:value-of select="' '"/></xsl:attribute>
        <xsl:for-each select= "marc:subfield[@code = '2']"><subfield code="a"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'a']"><subfield code="b"><xsl:value-of select="text()"/></subfield>
                                                           <subfield code="z"><xsl:value-of select="text()"/></subfield></xsl:for-each>
       </datafield>
      </xsl:if>
      </xsl:for-each>

      <xsl:for-each select= "marc:datafield[@tag = '017']">
      <xsl:if test="marc:subfield[@code='a'] or marc:subfield[@code='b']">
       <datafield tag="021">
        <xsl:attribute name="ind1"><xsl:value-of select="' '"/></xsl:attribute>
        <xsl:attribute name="ind2"><xsl:value-of select="' '"/></xsl:attribute>
        <xsl:for-each select= "marc:subfield[@code = 'a']"><subfield code="b"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'b']"><subfield code="a"><xsl:value-of select="text()"/></subfield></xsl:for-each>
       </datafield>
      </xsl:if>
      </xsl:for-each>

      <xsl:for-each select= "marc:datafield[@tag = '086']">
      <xsl:if test="marc:subfield[@code='a'] or marc:subfield[@code='2'] or marc:subfield[@code='z']">
       <datafield tag="022">
        <xsl:attribute name="ind1"><xsl:value-of select="' '"/></xsl:attribute>
        <xsl:attribute name="ind2"><xsl:value-of select="' '"/></xsl:attribute>
        <xsl:for-each select= "marc:subfield[@code = '2']"><subfield code="a"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'a']"><subfield code="b"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'z']"><subfield code="z"><xsl:value-of select="text()"/></subfield></xsl:for-each>
       </datafield>
      </xsl:if>
      </xsl:for-each>

      <xsl:for-each select= "marc:datafield[@tag = '035']">
      <xsl:if test="marc:subfield[@code='a'] or marc:subfield[@code='z']">
       <datafield tag="035" ind1=" " ind2=" ">
        <xsl:for-each select= "marc:subfield[@code = 'a']"><subfield code="a"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'z']"><subfield code="z"><xsl:value-of select="text()"/></subfield></xsl:for-each>
       </datafield>
      </xsl:if>
      </xsl:for-each>

      <xsl:for-each select= "marc:datafield[@tag = '030']">
      <xsl:if test="marc:subfield[@code='a'] or marc:subfield[@code='z']">
       <datafield tag="040">
        <xsl:attribute name="ind1"><xsl:value-of select="' '"/></xsl:attribute>
        <xsl:attribute name="ind2"><xsl:value-of select="' '"/></xsl:attribute>
        <xsl:for-each select= "marc:subfield[@code = 'a']"><subfield code="a"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'z']"><subfield code="z"><xsl:value-of select="text()"/></subfield></xsl:for-each>
       </datafield>
      </xsl:if>
      </xsl:for-each>

      <xsl:for-each select= "marc:datafield[@tag = '028']">
      <xsl:if test="marc:subfield[@code='a'] or marc:subfield[@code='b']">
       <datafield tag="071">
        <xsl:attribute name="ind1"><xsl:value-of select="@ind1"/></xsl:attribute>
        <xsl:attribute name="ind2"><xsl:choose><xsl:when test="@ind2 = 0">0</xsl:when><xsl:otherwise>1</xsl:otherwise></xsl:choose></xsl:attribute>
        <xsl:for-each select= "marc:subfield[@code = 'a']"><subfield code="a"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'b']"><subfield code="b"><xsl:value-of select="text()"/></subfield></xsl:for-each>
       </datafield>
      </xsl:if>
      </xsl:for-each>
      
      <!-- get 040^b for 008/loc -->
      <xsl:variable name="f040b" select="marc:datafield[@tag='040']/marc:subfield[@code='b']"/>
      <xsl:variable name="f008"  select="marc:controlfield[@tag='008']"/>
      
      <!-- 008 > 100-->
      <!-- <xsl:for-each select="marc:controlfield[@tag = '008']"> -->
       <!-- FIXME: Dummy indicators -->
       <datafield tag="100">
        <xsl:attribute name="ind1"><xsl:value-of select="' '"/></xsl:attribute>
        <xsl:attribute name="ind2"><xsl:value-of select="' '"/></xsl:attribute>
        <subfield code="a">
         <!--  008/0-5 ~> 100/0/7-->
         <xsl:variable name="u100a_date_entered_0_7">
          <xsl:choose>
           <xsl:when test="$f008 and string-length($f008) &gt;= 6">
            <xsl:choose>
             <xsl:when test="substring($f008, 1, 2) &lt; 70"><xsl:value-of select="concat('20', substring($f008, 1, 6))"/></xsl:when>
             <xsl:otherwise>                                 <xsl:value-of select="concat('19', substring($f008, 1, 6))"/></xsl:otherwise>
            </xsl:choose>
           </xsl:when>
           <xsl:otherwise><xsl:value-of select="'        '"/></xsl:otherwise>
          </xsl:choose>
         </xsl:variable>
         <xsl:variable name="u100a_typeofPubDate_8">
          <xsl:choose>
           <xsl:when test="substring($f008, 7, 1) = 'c'">a</xsl:when>
           <xsl:when test="substring($f008, 7, 1) = 'd'">b</xsl:when>
           <xsl:when test="substring($f008, 7, 1) = 'u'">c</xsl:when>
           <xsl:when test="substring($f008, 7, 1) = 's'">d</xsl:when>
           <xsl:when test="substring($f008, 7, 1) = 'r'">e</xsl:when>
           <xsl:when test="substring($f008, 7, 1) = 'q'">f</xsl:when>
           <xsl:when test="substring($f008, 7, 1) = 'm'">g</xsl:when>
           <xsl:when test="substring($f008, 7, 1) = 't'">h</xsl:when>
           <xsl:when test="substring($f008, 7, 1) = 'p'">i</xsl:when>
           <xsl:when test="substring($f008, 7, 1) = 'e'">j</xsl:when>
           <xsl:when test="substring($f008, 7, 1) = 'b'">u</xsl:when>
           <xsl:otherwise><xsl:value-of select="' '"/></xsl:otherwise>
          </xsl:choose>
         </xsl:variable>
         <xsl:variable name="u100a_1date_9_12">
          <xsl:choose>
           <xsl:when test="$f008 and string-length($f008) &gt;= 12"><xsl:value-of  select="substring($f008, 8,  4)"/></xsl:when>
           <xsl:otherwise><xsl:value-of select="'    '"/></xsl:otherwise>
          </xsl:choose>
         </xsl:variable>
         <xsl:variable name="u100a_2date_13_16">
          <xsl:choose>
           <xsl:when test="$f008 and string-length($f008) &gt;= 16"><xsl:value-of select="substring($f008, 12, 4)"/></xsl:when>
           <xsl:otherwise><xsl:value-of select="'    '"/></xsl:otherwise>
          </xsl:choose>
         </xsl:variable>
         <xsl:variable name="u100_targetAudience_17_19">
          <xsl:choose>
           <xsl:when test="substring($f008, 23, 1) = 'a'">b||</xsl:when>
           <xsl:when test="substring($f008, 23, 1) = 'b'">c||</xsl:when>
           <xsl:when test="substring($f008, 23, 1) = 'j'">a||</xsl:when>
           <xsl:when test="substring($f008, 23, 1) = 'c'">d||</xsl:when>
           <xsl:when test="substring($f008, 23, 1) = 'd'">e||</xsl:when>
           <xsl:when test="substring($f008, 23, 1) = 'e'">k||</xsl:when>
           <xsl:when test="substring($f008, 23, 1) = 'g'">m||</xsl:when>
           <xsl:when test="substring($f008, 23, 1) = '|'">|||</xsl:when>
           <xsl:when test="substring($f008, 23, 1) = ' '">u||</xsl:when>
           <xsl:otherwise>u||</xsl:otherwise>
          </xsl:choose>
         </xsl:variable>
         <xsl:variable name="u100a_governmentPublication_20">
          <xsl:choose>
           <xsl:when test="substring($f008, 29, 1) = 'f'">a</xsl:when>
           <xsl:when test="substring($f008, 29, 1) = 's'">b</xsl:when>
           <xsl:when test="substring($f008, 29, 1) = 'l'">d</xsl:when>
           <xsl:when test="substring($f008, 29, 1) = 'c'">e</xsl:when>
           <xsl:when test="substring($f008, 29, 1) = 'i'">f</xsl:when>
           <xsl:when test="substring($f008, 29, 1) = 'z'">g</xsl:when>
           <xsl:when test="substring($f008, 29, 1) = 'o'">h</xsl:when>
           <xsl:when test="substring($f008, 29, 1) = 'u'">u</xsl:when>
           <xsl:when test="substring($f008, 29, 1) = ' '">y</xsl:when>
           <xsl:when test="substring($f008, 29, 1) = 'z'">z</xsl:when>
           <xsl:when test="substring($f008, 29, 1) = '|'">|</xsl:when>
           <xsl:otherwise>y</xsl:otherwise>
          </xsl:choose>
         </xsl:variable>
         <xsl:variable name="u100a_mrc_21">
          <xsl:choose>
           <xsl:when test="$f008 and string-length($f008) &gt;= 39"><xsl:value-of select="translate(substring($f008, 39, 1), ' o', '01')"/></xsl:when>
           <xsl:otherwise><xsl:value-of select="' '"/></xsl:otherwise>
          </xsl:choose>
         </xsl:variable>
         <!-- <xsl:variable name="mrc">
          <xsl:choose>
           <xsl:when test="substring($f008, 39, 1) = ' '">0</xsl:when>
           <xsl:otherwise>1</xsl:otherwise>
          </xsl:choose>
         </xsl:variable>-->
         <xsl:variable name="u100a_loc_22_24">
          <xsl:choose>
           <xsl:when test="$f040b and string-length($f040b) = 3"><xsl:value-of select="$f040b"/></xsl:when>
           <xsl:otherwise><xsl:value-of select="'   '"/></xsl:otherwise>
           <!-- <xsl:otherwise><xsl:value-of select="'eng'"/></xsl:otherwise> -->  <!-- Expected default for MARC21 -->
          </xsl:choose>
         </xsl:variable>
         <xsl:variable name="u100a_tc_25">
          <xsl:choose>
           <xsl:when test="substring($f008, 39, 1) = 'o'">b</xsl:when>
           <xsl:otherwise>y</xsl:otherwise>
          </xsl:choose>
         </xsl:variable>
         <xsl:variable name="u100a_coding_26_29">
          <xsl:choose>
           <xsl:when test="substring(../leader, 10, 1) = 'a'"><xsl:value-of select="'50  '"/></xsl:when>
           <!-- what if MARC-8 encoding, and not UTF8? -->
           <!--<xsl:otherwise><xsl:value-of select="'    '"/></xsl:otherwise>-->
           <xsl:otherwise><xsl:value-of select="'50  '"/></xsl:otherwise>
          </xsl:choose>
         </xsl:variable>
         <xsl:variable name="u100a_acs_30_33"><xsl:value-of select="'    '"/></xsl:variable>
         <xsl:variable name="u100a_sot_34_35">
          <xsl:choose>
           <xsl:when test="substring($f008, 34, 1) = 'a'">ba</xsl:when> <!-- Unimarc (ba = Latin) >> marc21 (a - Basic Roman) -->
           <xsl:when test="substring($f008, 34, 1) = 'b'">ba</xsl:when> <!-- Unimarc (ba = Latin) >> marc21 (b - Extended Roman) -->
           <xsl:when test="substring($f008, 34, 1) = 'c'">ca</xsl:when> <!-- Unimarc (ca = Cyrillic) >> marc21 (c - Cyrillic) -->
           <xsl:when test="substring($f008, 34, 1) = 'd'">da</xsl:when> <!-- Unimarc (da = Japanese – script unspecified) >> marc21 (d - Japanese) -->
           <!--<xsl:when test="substring($f008, 34, 1) = 'd'">db</xsl:when>--> <!-- Unimarc (db = Japanese – kanji) >> marc21 (d - Japanese) -->
           <!--<xsl:when test="substring($f008, 34, 1) = 'd'">dc</xsl:when>--> <!-- Unimarc (dc = Japanese – kana) >> marc21 (d - Japanese) -->
           <xsl:when test="substring($f008, 34, 1) = 'e'">ea</xsl:when> <!-- Unimarc (ea = Chinese) >> marc21 (e - Chinese) -->
           <xsl:when test="substring($f008, 34, 1) = 'f'">fa</xsl:when> <!-- Unimarc (fa = Arabic) >> marc21 (f - Arabic) -->
           <xsl:when test="substring($f008, 34, 1) = 'g'">ga</xsl:when> <!-- Unimarc (ga = Greek) >> marc21 (g - Greek) -->
           <xsl:when test="substring($f008, 34, 1) = 'h'">ha</xsl:when> <!-- Unimarc (ha = Hebrew) >> marc21 (h - Hebrew) -->
           <xsl:when test="substring($f008, 34, 1) = 'i'">ia</xsl:when> <!-- Unimarc (ia = Thai) >> marc21 (i - Thai) -->
           <!--<xsl:when test="substring($f008, 34, 1) = '?'">ja</xsl:when>--> <!-- Unimarc (ja = Devanagari) >> marc21 () -->
           <xsl:when test="substring($f008, 34, 1) = 'k'">ka</xsl:when> <!-- Unimarc (ka = Korean) >> marc21 (k - Korean) -->
           <xsl:when test="substring($f008, 34, 1) = 'l'">la</xsl:when> <!-- Unimarc (la = Tamil) >> marc21 (l - Tamil) -->
           <xsl:when test="substring($f008, 34, 1) = '?'">ma</xsl:when> <!-- Unimarc (ma = Georgian) >> marc21 () -->
           <xsl:when test="substring($f008, 34, 1) = '?'">mb</xsl:when> <!-- Unimarc (mb = Armenian) >> marc21 () -->
           <xsl:when test="substring($f008, 34, 1) = 'u'">zz</xsl:when> <!-- Unimarc (zz = Other) >> marc21 (u - Unknown) -->
           <xsl:when test="substring($f008, 34, 1) = 'z'">zz</xsl:when> <!-- Unimarc (zz = Other) >> marc21 (z - Other) -->
           <xsl:when test="substring($f008, 34, 1) = '|'">zz</xsl:when> <!-- Unimarc (zz = Other) >> marc21 (| - No attempt to code) -->
           <xsl:when test="substring($f008, 34, 1) = '#'">zz</xsl:when> <!-- Unimarc (zz = Other) >> marc21 (# - No alphabet or script given/No key title) -->
           <xsl:when test="substring($f008, 34, 1) = ' '">zz</xsl:when> <!-- Unimarc (zz = Other) >> marc21 () -->
           <xsl:otherwise>zz</xsl:otherwise> <!-- Unimarc (zz = Other) >> marc21 (?) -->
          </xsl:choose>
         </xsl:variable>
         <xsl:value-of select="concat($u100a_date_entered_0_7, $u100a_typeofPubDate_8, $u100a_1date_9_12, $u100a_2date_13_16, $u100_targetAudience_17_19, $u100a_governmentPublication_20, $u100a_mrc_21, $u100a_loc_22_24, $u100a_tc_25, $u100a_coding_26_29, $u100a_acs_30_33, $u100a_sot_34_35)" />
        </subfield>
       </datafield>
       <datafield tag="105" ind1=" " ind2=" ">
        <subfield code="a">
         <xsl:variable name="u105a_ic_0_3"><xsl:value-of select="substring($f008, 19, 4)"/></xsl:variable>
         <xsl:variable name="u105a_focc_4_7"><xsl:value-of select="translate (substring($f008, 25, 4), 'bciaderyspltnwfgv', 'abcdefghijnprnzzz')"/></xsl:variable>
         <xsl:variable name="u105a_cc_8"><xsl:value-of select="substring($f008, 30, 1)"/></xsl:variable>
         <xsl:variable name="u105a_fi_9"><xsl:value-of select="substring($f008, 31, 1)"/></xsl:variable>
         <xsl:variable name="u105a_ii_10"><xsl:value-of select="substring($f008, 32, 1)"/></xsl:variable>
         <xsl:variable name="u105a_lc_11">
          <xsl:choose>
           <xsl:when test="substring($f008, 34, 1) = '1'">a</xsl:when>
           <xsl:when test="substring($f008, 34, 1) = '0'">y</xsl:when>
           <xsl:otherwise>|</xsl:otherwise>
          </xsl:choose>
         </xsl:variable>
         <xsl:variable name="u105a_bc_12">
          <xsl:choose>
           <xsl:when test="substring($f008, 35, 1) = ' '">y</xsl:when>
           <xsl:otherwise><xsl:value-of select="substring($f008, 35, 1)"/></xsl:otherwise>
          </xsl:choose>
         </xsl:variable>
         <xsl:value-of select="concat($u105a_ic_0_3, $u105a_focc_4_7, $u105a_cc_8, $u105a_fi_9, $u105a_ii_10, $u105a_lc_11, $u105a_bc_12)"/>
        </subfield>
       </datafield>
       <xsl:if test="$f008 and string-length($f008) > 23">
        <datafield tag="106" ind1=" " ind2=" ">
         <subfield code="a">
          <xsl:choose>
           <xsl:when test="substring($f008, 24, 1) = ' '">y</xsl:when>
           <xsl:otherwise><xsl:value-of select="substring($f008, 24, 1)"/></xsl:otherwise>
          </xsl:choose>
         </subfield>
        </datafield>
       </xsl:if>
       <xsl:choose>
        <xsl:when test="substring(../leader, 8, 1) = 's'">
         <datafield tag="110" ind1=" " ind2=" ">
          <subfield code="a">
           <xsl:variable name="tos">
            <xsl:choose>
             <xsl:when test="substring($f008, 22, 1) = 'p'">a</xsl:when>
             <xsl:when test="substring($f008, 22, 1) = 'm'">b</xsl:when>
             <xsl:when test="substring($f008, 22, 1) = 'n'">c</xsl:when>
             <xsl:when test="substring($f008, 22, 1) = ' '">z</xsl:when>
             <xsl:when test="substring($f008, 22, 1) = '|'">|</xsl:when>
             <xsl:otherwise>z</xsl:otherwise>
            </xsl:choose>
           </xsl:variable>
           <xsl:variable name="foi">
            <xsl:choose>
             <xsl:when test="substring($f008, 19, 1) = 'd'">a</xsl:when>
             <xsl:when test="substring($f008, 19, 1) = 'c'">b</xsl:when>
             <xsl:when test="substring($f008, 19, 1) = 'w'">c</xsl:when>
             <xsl:when test="substring($f008, 19, 1) = 'e'">d</xsl:when>
             <xsl:when test="substring($f008, 19, 1) = 's'">e</xsl:when>
             <xsl:when test="substring($f008, 19, 1) = 'm'">f</xsl:when>
             <xsl:when test="substring($f008, 19, 1) = 'b'">g</xsl:when>
             <xsl:when test="substring($f008, 19, 1) = 'q'">h</xsl:when>
             <xsl:when test="substring($f008, 19, 1) = 't'">i</xsl:when>
             <xsl:when test="substring($f008, 19, 1) = 'f'">j</xsl:when>
             <xsl:when test="substring($f008, 19, 1) = 'a'">k</xsl:when>
             <xsl:when test="substring($f008, 19, 1) = 'g'">l</xsl:when>
             <xsl:when test="substring($f008, 19, 1) = 'h'">m</xsl:when>
             <xsl:when test="substring($f008, 19, 1) = 'i'">n</xsl:when>
             <xsl:when test="substring($f008, 19, 1) = 'j'">o</xsl:when>
             <xsl:when test="substring($f008, 19, 1) = 'u'">u</xsl:when>
             <xsl:when test="substring($f008, 19, 1) = ' '">y</xsl:when>
             <xsl:when test="substring($f008, 19, 1) = 'z'">z</xsl:when>
             <xsl:when test="substring($f008, 19, 1) = '|'">|</xsl:when>
             <xsl:when test="substring($f008, 19, 1) = 'n'">|</xsl:when>
             <xsl:otherwise>y</xsl:otherwise>
            </xsl:choose>
           </xsl:variable>
           <xsl:variable name="r">
            <xsl:choose>
             <xsl:when test="substring($f008, 20, 1) = 'r'">a</xsl:when>
             <xsl:when test="substring($f008, 20, 1) = 'n'">b</xsl:when>
             <xsl:when test="substring($f008, 20, 1) = 'u'">u</xsl:when>
             <xsl:when test="substring($f008, 20, 1) = 'x'">y</xsl:when>
             <xsl:when test="substring($f008, 20, 1) = '|'">|</xsl:when>
             <xsl:when test="substring($f008, 20, 1) = ' '">|</xsl:when>
             <xsl:otherwise>u</xsl:otherwise>
            </xsl:choose>
           </xsl:variable>
           <xsl:variable name="tomc">
            <xsl:choose>
             <xsl:when test="substring($f008, 25, 1) = 'b'">a</xsl:when>
             <xsl:when test="substring($f008, 25, 1) = 'c'">b</xsl:when>
             <xsl:when test="substring($f008, 25, 1) = 'i'">c</xsl:when>
             <xsl:when test="substring($f008, 25, 1) = 'a'">d</xsl:when>
             <xsl:when test="substring($f008, 25, 1) = 'd'">e</xsl:when>
             <xsl:when test="substring($f008, 25, 1) = 'e'">f</xsl:when>
             <xsl:when test="substring($f008, 25, 1) = 'r'">g</xsl:when>
             <xsl:when test="substring($f008, 25, 1) = 'y'">h</xsl:when>
             <xsl:when test="substring($f008, 25, 1) = 's'">i</xsl:when>
             <xsl:when test="substring($f008, 25, 1) = 'p'">j</xsl:when>
             <xsl:when test="substring($f008, 25, 1) = 'o'">k</xsl:when>
             <xsl:when test="substring($f008, 25, 1) = 'l'">l</xsl:when>
             <xsl:when test="substring($f008, 25, 1) = 'w'">m</xsl:when>
             <xsl:when test="substring($f008, 25, 1) = 'g'">n</xsl:when>
             <xsl:when test="substring($f008, 25, 1) = 'v'">o</xsl:when>
             <xsl:when test="substring($f008, 25, 1) = 'h'">p</xsl:when>
             <xsl:when test="substring($f008, 25, 1) = 'n'">r</xsl:when>
             <xsl:when test="substring($f008, 25, 1) = ' '">z</xsl:when>
             <xsl:when test="substring($f008, 25, 1) = '|'">|</xsl:when>
             <xsl:otherwise>z</xsl:otherwise>
            </xsl:choose>
           </xsl:variable>
           <xsl:variable name="nocc"><xsl:value-of select="substring($f008, 26, 3)"/></xsl:variable>
           <xsl:variable name="ci"><xsl:value-of select="substring($f008, 30, 1)"/></xsl:variable>
           <xsl:variable name="tpa">|</xsl:variable>
           <xsl:variable name="iac">|</xsl:variable>
           <xsl:variable name="cia">|</xsl:variable>
           <xsl:value-of select="concat($tos, $foi, $r, $tomc, $nocc, $ci, $tpa, $iac, $cia)"/>
          </subfield>
         </datafield>
        </xsl:when>
       </xsl:choose>
      <!-- </xsl:for-each> -->
      
      <!-- в marc21 складніше: 1 код мови завжди йде в 008/35..37  
      також 1-ший та 2,3... коди йдуть в повторення 041a  -->
      <!-- 041 > 101 -->      
      <xsl:choose>
        <xsl:when test="marc:datafield[@tag = '041']/marc:subfield[@code='a']">
          <xsl:for-each select= "marc:datafield[@tag = '041']">
            <datafield tag="101">
              <xsl:attribute name="ind1"><xsl:value-of select="@ind1"/></xsl:attribute>
              <xsl:attribute name="ind2"><xsl:value-of select="@ind2"/></xsl:attribute>
              <xsl:for-each select= "marc:subfield[@code = 'a']"><subfield code="a"><xsl:value-of select="text()"/></subfield></xsl:for-each>
              <xsl:for-each select= "marc:subfield[@code = 'b']"><subfield code="d"><xsl:value-of select="text()"/></subfield></xsl:for-each>
              <xsl:for-each select= "marc:subfield[@code = 'd']"><subfield code="a"><xsl:value-of select="text()"/></subfield></xsl:for-each>
              <xsl:for-each select= "marc:subfield[@code = 'e']"><subfield code="h"><xsl:value-of select="text()"/></subfield></xsl:for-each>
              <xsl:for-each select= "marc:subfield[@code = 'f']"><subfield code="e"><xsl:value-of select="text()"/></subfield></xsl:for-each>
              <xsl:for-each select= "marc:subfield[@code = 'g']"><subfield code="i"><xsl:value-of select="text()"/></subfield></xsl:for-each>
              <xsl:for-each select= "marc:subfield[@code = 'h']"><subfield code="c"><xsl:value-of select="text()"/></subfield></xsl:for-each>
            </datafield>
          </xsl:for-each>
        </xsl:when>
        <xsl:otherwise>
        <xsl:variable name="u101a">
          <xsl:variable name="u101a_1">
            <xsl:choose>
              <xsl:when test="substring($f008, 36, 1) = ' ' or substring($f008, 36, 1) =  '|'"></xsl:when>
              <xsl:otherwise><xsl:value-of select="substring($f008, 36, 1)"/></xsl:otherwise>
            </xsl:choose>
           </xsl:variable>
          <xsl:variable name="u101a_2">
            <xsl:choose>
              <xsl:when test="substring($f008, 37, 1) = ' ' or substring($f008, 37, 1) =  '|'"></xsl:when>
              <xsl:otherwise><xsl:value-of select="substring($f008, 37, 1)"/></xsl:otherwise>
            </xsl:choose>
           </xsl:variable>
           <xsl:variable name="u101a_3">
            <xsl:choose>
              <xsl:when test="substring($f008, 38, 1) = ' ' or substring($f008, 38, 1) =  '|'"></xsl:when>
              <xsl:otherwise><xsl:value-of select="substring($f008, 38, 1)"/></xsl:otherwise>
            </xsl:choose>
           </xsl:variable>
           <xsl:value-of select="concat($u101a_1, $u101a_2, $u101a_3)"/>
        </xsl:variable>
        <xsl:if test="$u101a and string-length($u101a) > 0">
          <datafield tag="101" ind1=" " ind2=" ">
            <subfield code="a"><xsl:value-of select="$u101a"/></subfield>
          </datafield>
        </xsl:if>
        </xsl:otherwise>
      </xsl:choose>      
      <!-- <xsl:for-each select= "marc:datafield[@tag = '041']">
       <datafield tag="101">
        <xsl:attribute name="ind1">
         <xsl:value-of select="@ind1"/>
        </xsl:attribute>
        <xsl:attribute name="ind2">
         <xsl:value-of select="' '"/>
        </xsl:attribute>
        <xsl:for-each select= "marc:subfield[@code = 'a']">
         <subfield code="a">
          <xsl:value-of select="text()"/>
         </subfield>
        </xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'b']">
         <subfield code="d">
          <xsl:value-of select="text()"/>
         </subfield>
        </xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'd']">
         <subfield code="a">
          <xsl:value-of select="text()"/>
         </subfield>
        </xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'e']">
         <subfield code="h">
          <xsl:value-of select="text()"/>
         </subfield>
        </xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'f']">
         <subfield code="e">
          <xsl:value-of select="text()"/>
         </subfield>
        </xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'g']">
         <subfield code="i">
          <xsl:value-of select="text()"/>
         </subfield>
        </xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'h']"><subfield code="c"><xsl:value-of select="text()"/></subfield></xsl:for-each>
       </datafield>
      </xsl:for-each>-->

      <!-- в marc21: 1 код країни завжди йде в 008/15..17 
      якщо кодів є 2 і більше, тоді окрім  008/15..17 (1 код) коди йдуть в повторення 044a (1,2,3... код)-->
      <xsl:choose>
        <xsl:when test="marc:datafield[@tag = '044']/marc:subfield[@code='a']">
          <xsl:for-each select= "marc:datafield[@tag = '044']">
            <datafield tag="102" ind1=" " ind2=" ">
              <xsl:for-each select= "marc:subfield[@code = 'a']"><subfield code="a"><xsl:value-of select="text()"/></subfield></xsl:for-each>
            </datafield>
          </xsl:for-each>
        </xsl:when>
        <xsl:otherwise>
        <xsl:variable name="u102a">
          <xsl:variable name="u102a_1">
            <xsl:choose>
              <xsl:when test="substring($f008, 16, 1) = ' ' or substring($f008, 16, 1) =  '|'"></xsl:when>
              <xsl:otherwise><xsl:value-of select="substring($f008, 16, 1)"/></xsl:otherwise>
            </xsl:choose>
           </xsl:variable>
          <xsl:variable name="u102a_2">
            <xsl:choose>
              <xsl:when test="substring($f008, 17, 1) = ' ' or substring($f008, 17, 1) =  '|'"></xsl:when>
              <xsl:otherwise><xsl:value-of select="substring($f008, 17, 1)"/></xsl:otherwise>
            </xsl:choose>
           </xsl:variable>
           <xsl:variable name="u102a_3">
            <xsl:choose>
              <xsl:when test="substring($f008, 18, 1) = ' ' or substring($f008, 18, 1) =  '|'"></xsl:when>
              <xsl:otherwise><xsl:value-of select="substring($f008, 18, 1)"/></xsl:otherwise>
            </xsl:choose>
           </xsl:variable>
           <xsl:value-of select="concat($u102a_1, $u102a_2, $u102a_3)"/>
        </xsl:variable>
        <xsl:if test="$u102a and string-length($u102a) > 0">
          <datafield tag="102" ind1=" " ind2=" ">
            <subfield code="a">
              <xsl:value-of select="$u102a"/>
            </subfield>
          </datafield>
        </xsl:if>
        </xsl:otherwise>
      </xsl:choose>
      <!--<xsl:for-each select= "marc:datafield[@tag = '044']">
       <datafield tag="102">
        <xsl:attribute name="ind1"><xsl:value-of select="' '"/></xsl:attribute>
        <xsl:attribute name="ind2"><xsl:value-of select="' '"/></xsl:attribute>
        <xsl:for-each select= "marc:subfield[@code = 'a']"><subfield code="a"><xsl:value-of select="text()"/></subfield></xsl:for-each> -->
        <!--<xsl:for-each select= "marc:subfield[@code='b']"><subfield code="?"><xsl:value-of select="text()" /></subfield></xsl:for-each>-->
       <!--</datafield>
      </xsl:for-each>-->

      <xsl:variable name="f007"  select="marc:controlfield[@tag='007']"/>
      <xsl:if test="$f007 and string-length($f007) > 0">
       <xsl:variable name="f007_category_of_material_01"><xsl:value-of select="substring($f007, 1, 1)"/></xsl:variable>
       <xsl:choose>
        <xsl:when test="$f007_category_of_material_01 = 'a'"><!-- Map >120 -->
        </xsl:when>
        <xsl:when test="$f007_category_of_material_01 = 'c'"><!-- Electronic resource >135 -->
        </xsl:when>
        <xsl:when test="$f007_category_of_material_01 = 'd'"><!-- Globe  ~>124 -->
        </xsl:when>
        <xsl:when test="$f007_category_of_material_01 = 'f'"><!-- Tactile material >106 > 181 -->
        </xsl:when>
        <xsl:when test="$f007_category_of_material_01 = 'g'"><!-- Graphic projected -->
         <datafield tag="115" ind1=" " ind2=" ">
          <subfield code="a">
            <xsl:value-of select="'b'"/>
          </subfield>
         </datafield>
        </xsl:when>
        <xsl:when test="$f007_category_of_material_01 = 'h'"><!-- Microform  >130 -->
        </xsl:when>
        <xsl:when test="$f007_category_of_material_01 = 'k'"><!-- Nonprojected graphic >116 -->
        </xsl:when>
        <xsl:when test="$f007_category_of_material_01 = 'm'"><!-- Motion picture -->
         <datafield tag="115" ind1=" " ind2=" ">
          <subfield code="a">
            <xsl:value-of select="'a'"/>
          </subfield>
         </datafield>
        </xsl:when>
        <xsl:when test="$f007_category_of_material_01 = 'o'"><!-- Kit >117 -->
        </xsl:when>
        <xsl:when test="$f007_category_of_material_01 = 'q'"><!-- Notated music  >125 -->
        </xsl:when>
        <xsl:when test="$f007_category_of_material_01 = 'r'"><!-- Remote-sensing image >120 >121  -->
        </xsl:when>
        <xsl:when test="$f007_category_of_material_01 = 's'"><!-- Sound recording >126 -->
        </xsl:when>
        <xsl:when test="$f007_category_of_material_01 = 't'"><!-- Text >105 >106 -->
        </xsl:when>
        <xsl:when test="$f007_category_of_material_01 = 'v'"><!-- Videorecording -->
         <datafield tag="115" ind1=" " ind2=" ">
          <subfield code="a">
            <xsl:value-of select="'c'"/>
          </subfield>
         </datafield>
        </xsl:when>
        <xsl:when test="$f007_category_of_material_01 = 'z'"><!-- Unspecified  -->
        </xsl:when>
        <xsl:otherwise></xsl:otherwise>
       </xsl:choose>
      
      </xsl:if>
      
      <xsl:for-each select= "marc:datafield[@tag = '245']">
      <xsl:if test="marc:subfield[@code='a'] or marc:subfield[@code='h'] or marc:subfield[@code='b'] or marc:subfield[@code='c']
                 or marc:subfield[@code='n'] or marc:subfield[@code='p']">
       <datafield tag="200">
        <xsl:attribute name="ind1"><xsl:value-of select="@ind1"/></xsl:attribute>
        <xsl:attribute name="ind2"><xsl:value-of select="@ind2"/></xsl:attribute>
        <!-- <xsl:attribute name="ind2"><xsl:value-of select="' '"/></xsl:attribute> -->
        <xsl:for-each select= "marc:subfield[@code = 'a']">
         <subfield code="a"><xsl:call-template name="removeEndPuctuation"><xsl:with-param name="text" select="text()"/></xsl:call-template></subfield>
         <xsl:if test="contains(text(), ' = ')">
          <subfield code="d"><xsl:value-of select="concat('=', substring-after(text(), ' ='))"/></subfield>
         </xsl:if>
        </xsl:for-each>
        <!-- Форма назви йде в [], часто для випадків без назви --> 
        <xsl:for-each select= "marc:subfield[@code = 'k']"><subfield code="a">[<xsl:value-of select="text()"/>]</subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'h']"><subfield code="b"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'b']"><subfield code="e"><xsl:call-template name="removeEndPuctuation"><xsl:with-param name="text" select="text()"/></xsl:call-template></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'c']">
         <xsl:choose>
          <xsl:when test="contains(text(), ' ; ')">
           <xsl:if test="substring-before(text(), ' ; ')"><subfield code="f"><xsl:value-of select="substring-before(text(), ' ; ')"/></subfield></xsl:if>
           <xsl:call-template name="tokenizeSubfield">
            <xsl:with-param name="list" select="substring-after(text(), ' ; ')"/>
            <xsl:with-param name="delimiter" select="' ; '"/>
            <xsl:with-param name="code" select="'g'"/>
           </xsl:call-template>
          </xsl:when>
          <xsl:otherwise>
           <subfield code="f">
            <xsl:call-template name="removeEndPuctuation">
             <xsl:with-param name="text" select="text()"/>
            </xsl:call-template>
           </subfield>
          </xsl:otherwise>
         </xsl:choose>
        </xsl:for-each>        
        <xsl:for-each select= "marc:subfield[@code = 'n']"><subfield code="h"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'p']"><subfield code="i"><xsl:value-of select="text()"/></subfield></xsl:for-each>
       </datafield>
       <!-- FIXME -->
       <!-- <datafield tag="204">
        <xsl:attribute name="ind1"><xsl:value-of select="' '" /></xsl:attribute>
        <xsl:attribute name="ind2"><xsl:value-of select="' '" /></xsl:attribute>
        <xsl:for-each select= "marc:subfield[@code='h']"><subfield code="a"><xsl:value-of select="text()" /></subfield></xsl:for-each>
       </datafield>  -->
      </xsl:if>
      </xsl:for-each>
      
      <xsl:for-each select= "marc:datafield[@tag = '250']">
      <xsl:if test="marc:subfield[@code='a']">
       <datafield tag="205">
        <xsl:attribute name="ind1"><xsl:value-of select="' '"/></xsl:attribute>
        <xsl:attribute name="ind2"><xsl:value-of select="' '"/></xsl:attribute>
        <xsl:for-each select= "marc:subfield[@code = 'a']"><subfield code="a"><xsl:value-of select="text()"/></subfield></xsl:for-each>
       </datafield>
      </xsl:if> 
      </xsl:for-each>
      
      <!-- 362 > 207 -->
      <xsl:if test="marc:datafield[@tag='362']/marc:subfield[@code='a'] or marc:datafield[@tag='362']/marc:subfield[@code='z']">
      <xsl:for-each select= "marc:datafield[@tag = '362']">
       <datafield tag="207">
        <xsl:attribute name="ind2"><xsl:value-of select="@ind1"/></xsl:attribute>
        <xsl:attribute name="ind1"><xsl:value-of select="@ind2"/></xsl:attribute>        
        <xsl:for-each select= "marc:subfield[@code = 'a']"><subfield code="a"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'z']"><subfield code="z"><xsl:value-of select="text()"/></subfield></xsl:for-each>
       </datafield>
      </xsl:for-each>
      </xsl:if>
      
      <xsl:for-each select= "marc:datafield[@tag = '254']">
       <datafield tag="208">
        <xsl:attribute name="ind1"><xsl:value-of select="' '"/></xsl:attribute>
        <xsl:attribute name="ind2"><xsl:value-of select="' '"/></xsl:attribute>
        <xsl:for-each select= "marc:subfield[@code = 'a']"><subfield code="a"><xsl:value-of select="text()"/></subfield></xsl:for-each>
       </datafield>
      </xsl:for-each>

      <xsl:for-each select= "marc:datafield[@tag = '260']">
       <datafield tag="210">
        <xsl:attribute name="ind1"><xsl:value-of select="' '"/></xsl:attribute>
        <xsl:attribute name="ind2"><xsl:value-of select="' '"/></xsl:attribute>
        <xsl:for-each select= "marc:subfield[@code = 'a']"><subfield code="a"><xsl:call-template name="removeEndPublicationPuctuation"><xsl:with-param name="text" select="text()"/></xsl:call-template></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'b']"><subfield code="c"><xsl:call-template name="removeEndPublicationPuctuation"><xsl:with-param name="text" select="text()"/></xsl:call-template></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'c']"><subfield code="d"><xsl:call-template name="removeEndPublicationPuctuation"><xsl:with-param name="text" select="text()"/></xsl:call-template></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'e']"><subfield code="e"><xsl:call-template name="removeEndPublicationPuctuation"><xsl:with-param name="text" select="text()"/></xsl:call-template></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'f']"><subfield code="g"><xsl:value-of select="text()"/></subfield></xsl:for-each>  
        <xsl:for-each select= "marc:subfield[@code = 'g']"><subfield code="h"><xsl:value-of select="text()"/></subfield></xsl:for-each>
       </datafield>
      </xsl:for-each>

      <xsl:for-each select= "marc:datafield[@tag = '263']">
       <datafield tag="211">
        <xsl:attribute name="ind1"><xsl:value-of select="' '"/></xsl:attribute>
        <xsl:attribute name="ind2"><xsl:value-of select="' '"/></xsl:attribute>
        <xsl:for-each select= "marc:subfield[@code = 'a']"><subfield code="a"><xsl:value-of select="text()"/></subfield></xsl:for-each>
       </datafield>
      </xsl:for-each>

      <!-- 300->215 -->
      <xsl:for-each select= "marc:datafield[@tag = '300']">
      <xsl:if test="marc:subfield[@code='a'] or marc:subfield[@code='b'] or marc:subfield[@code='c'] or marc:subfield[@code='e']">
       <datafield tag="215">
        <xsl:attribute name="ind1"><xsl:value-of select="' '"/></xsl:attribute>
        <xsl:attribute name="ind2"><xsl:value-of select="' '"/></xsl:attribute>
        <xsl:for-each select= "marc:subfield[@code = 'a']"><subfield code="a"><xsl:call-template name="removeEndPhysicalDescriptionPuctuation"><xsl:with-param name="text" select="text()"/></xsl:call-template></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'b']"><subfield code="c"><xsl:call-template name="removeEndPhysicalDescriptionPuctuation"><xsl:with-param name="text" select="text()"/></xsl:call-template></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'c']"><subfield code="d"><xsl:call-template name="removeEndPhysicalDescriptionPuctuation"><xsl:with-param name="text" select="text()"/></xsl:call-template></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'e']"><subfield code="e"><xsl:call-template name="removeEndPhysicalDescriptionPuctuation"><xsl:with-param name="text" select="text()"/></xsl:call-template></subfield></xsl:for-each>
       </datafield>
      </xsl:if>
      </xsl:for-each>
      
      <!-- 336 » 181 -->
      <xsl:for-each select= "marc:datafield[@tag = '336']">
      <xsl:if test="marc:subfield[@code='b'] or marc:subfield[@code='0'] or marc:subfield[@code='2']">
      <datafield tag="181">
        <xsl:attribute name="ind1"><xsl:value-of select="' '"/></xsl:attribute>
        <xsl:attribute name="ind2"><xsl:value-of select="' '"/></xsl:attribute>
        <xsl:for-each select= "marc:subfield[@code = 'b']"><subfield code="c"><xsl:call-template name="removeEndPhysicalDescriptionPuctuation"><xsl:with-param name="text" select="text()"/></xsl:call-template></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = '0']"><subfield code="6"><xsl:call-template name="removeEndPhysicalDescriptionPuctuation"><xsl:with-param name="text" select="text()"/></xsl:call-template></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = '2']"><subfield code="2"><xsl:call-template name="removeEndPhysicalDescriptionPuctuation"><xsl:with-param name="text" select="text()"/></xsl:call-template></subfield></xsl:for-each>
       </datafield>
      </xsl:if>
      </xsl:for-each>
      
      <!-- 336^a » 203^a -->
      <xsl:for-each select= "marc:datafield[@tag = '336']">
      <xsl:if test="marc:subfield[@code='a']">
      <datafield tag="203">
        <xsl:attribute name="ind1"><xsl:value-of select="' '"/></xsl:attribute>
        <xsl:attribute name="ind2"><xsl:value-of select="' '"/></xsl:attribute>
        <xsl:for-each select= "marc:subfield[@code = 'a']"><subfield code="a"><xsl:call-template name="removeEndPhysicalDescriptionPuctuation"><xsl:with-param name="text" select="text()"/></xsl:call-template></subfield></xsl:for-each>
       </datafield>
      </xsl:if>
      </xsl:for-each>
      
      <!-- 337 » 182 -->
      <xsl:for-each select= "marc:datafield[@tag = '337']">
      <xsl:if test="marc:subfield[@code='b'] or marc:subfield[@code='0'] or marc:subfield[@code='2']">
      <datafield tag="182">
        <xsl:attribute name="ind1"><xsl:value-of select="' '"/></xsl:attribute>
        <xsl:attribute name="ind2"><xsl:value-of select="' '"/></xsl:attribute>
        <xsl:for-each select= "marc:subfield[@code = 'b']"><subfield code="c"><xsl:call-template name="removeEndPhysicalDescriptionPuctuation"><xsl:with-param name="text" select="text()"/></xsl:call-template></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = '0']"><subfield code="6"><xsl:call-template name="removeEndPhysicalDescriptionPuctuation"><xsl:with-param name="text" select="text()"/></xsl:call-template></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = '2']"><subfield code="2"><xsl:call-template name="removeEndPhysicalDescriptionPuctuation"><xsl:with-param name="text" select="text()"/></xsl:call-template></subfield></xsl:for-each>
       </datafield>
      </xsl:if>
      </xsl:for-each>
      
      <!-- 337^a » 203^c -->
      <xsl:for-each select= "marc:datafield[@tag = '337']">
      <xsl:if test="marc:subfield[@code='a']">
      <datafield tag="203">
        <xsl:attribute name="ind1"><xsl:value-of select="' '"/></xsl:attribute>
        <xsl:attribute name="ind2"><xsl:value-of select="' '"/></xsl:attribute>
        <xsl:for-each select= "marc:subfield[@code = 'a']"><subfield code="c"><xsl:call-template name="removeEndPhysicalDescriptionPuctuation"><xsl:with-param name="text" select="text()"/></xsl:call-template></subfield></xsl:for-each>
       </datafield>
      </xsl:if>
      </xsl:for-each>
      
      <!-- 338 » 183 -->
      <xsl:for-each select= "marc:datafield[@tag = '338']">
      <xsl:if test="marc:subfield[@code='b'] or marc:subfield[@code='0'] or marc:subfield[@code='2']">
      <datafield tag="183">
        <xsl:attribute name="ind1"><xsl:value-of select="' '"/></xsl:attribute>
        <xsl:attribute name="ind2"><xsl:value-of select="' '"/></xsl:attribute>
        <xsl:for-each select= "marc:subfield[@code = 'b']"><subfield code="a"><xsl:call-template name="removeEndPhysicalDescriptionPuctuation"><xsl:with-param name="text" select="text()"/></xsl:call-template></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = '0']"><subfield code="6"><xsl:call-template name="removeEndPhysicalDescriptionPuctuation"><xsl:with-param name="text" select="text()"/></xsl:call-template></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = '2']"><subfield code="2"><xsl:call-template name="removeEndPhysicalDescriptionPuctuation"><xsl:with-param name="text" select="text()"/></xsl:call-template></subfield></xsl:for-each>
       </datafield>
      </xsl:if>
      </xsl:for-each>
      
      <!-- 338^a » 283^c -->
      <xsl:for-each select= "marc:datafield[@tag = '338']">
      <xsl:if test="marc:subfield[@code='a']">
      <datafield tag="283">
        <xsl:attribute name="ind1"><xsl:value-of select="' '"/></xsl:attribute>
        <xsl:attribute name="ind2"><xsl:value-of select="' '"/></xsl:attribute>
        <xsl:for-each select= "marc:subfield[@code = 'a']"><subfield code="a"><xsl:call-template name="removeEndPhysicalDescriptionPuctuation"><xsl:with-param name="text" select="text()"/></xsl:call-template></subfield></xsl:for-each>
       </datafield>
      </xsl:if>
      </xsl:for-each>
      
      <xsl:for-each select= "marc:datafield[@tag = '490']">
       <datafield tag="225">
        <xsl:attribute name="ind1"><xsl:value-of select="@ind1"/></xsl:attribute>
        <xsl:attribute name="ind2"><xsl:value-of select="' '"/></xsl:attribute>
        <xsl:for-each select= "marc:subfield[@code = 'a']"><subfield code="a"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'v']"><subfield code="v"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'x']"><subfield code="x"><xsl:value-of select="text()"/></subfield></xsl:for-each>
       </datafield>
      </xsl:for-each>
   
   <!-- 440 > 225, but LOC recommended ommit 440 field -->
    <xsl:for-each select= "marc:datafield[@tag = '440']">
       <datafield tag="225">
        <xsl:attribute name="ind1"><xsl:value-of select="@ind1"/></xsl:attribute>
        <xsl:attribute name="ind2"><xsl:value-of select="' '"/></xsl:attribute>
        <xsl:for-each select= "marc:subfield[@code = 'a']"><subfield code="a"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'n']"><subfield code="h"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'p']"><subfield code="i"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'v']"><subfield code="v"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'x']"><subfield code="x"><xsl:value-of select="text()"/></subfield></xsl:for-each>
       </datafield>
      </xsl:for-each>
      
      <xsl:for-each select= "marc:datafield[@tag = '256']">
      <xsl:if test="marc:subfield[@code='a']">
       <datafield tag="230">
        <xsl:attribute name="ind1"><xsl:value-of select="' '"/></xsl:attribute>
        <xsl:attribute name="ind2"><xsl:value-of select="' '"/></xsl:attribute>
        <xsl:for-each select= "marc:subfield[@code = 'a']"><subfield code="a"><xsl:value-of select="text()"/></subfield></xsl:for-each>
       </datafield>
      </xsl:if>
      </xsl:for-each>

      <xsl:for-each select= "marc:datafield[@tag = '500']">
      <xsl:if test="marc:subfield[@code='a']">
       <datafield tag="300">
        <xsl:attribute name="ind1"><xsl:value-of select="' '"/></xsl:attribute>
        <xsl:attribute name="ind2"><xsl:value-of select="' '"/></xsl:attribute>
        <xsl:for-each select= "marc:subfield[@code = 'a']"><subfield code="a"><xsl:value-of select="text()"/></subfield></xsl:for-each>
       </datafield>
      </xsl:if> 
      </xsl:for-each>

      <xsl:for-each select= "marc:datafield[@tag = '525']">
      <xsl:if test="marc:subfield[@code='a']"> 
       <datafield tag="300">
        <xsl:attribute name="ind1"><xsl:value-of select="@ind1"/></xsl:attribute>
        <xsl:attribute name="ind2"><xsl:value-of select="@ind2"/></xsl:attribute>
        <xsl:for-each select= "marc:subfield[@code = 'a']"><subfield code="a"><xsl:value-of select="text()"/></subfield></xsl:for-each>
       </datafield>
      </xsl:if> 
      </xsl:for-each>      
      
      <xsl:for-each select= "marc:datafield[@tag = '555']">
      <xsl:if test="marc:subfield[@code='a']"> 
       <datafield tag="300">
        <xsl:attribute name="ind1"><xsl:value-of select="@ind1"/></xsl:attribute>
        <xsl:attribute name="ind2"><xsl:value-of select="@ind2"/></xsl:attribute>
        <xsl:for-each select= "marc:subfield[@code = 'a']"><subfield code="a"><xsl:value-of select="text()"/></subfield></xsl:for-each>
       </datafield>
      </xsl:if> 
      </xsl:for-each>
 
      <!-- 546 > 302 http://www.uc.pt/sibuc/Pdfs/Tabela_equivalencias_Unimarc-MARC21 -->
      <xsl:for-each select= "marc:datafield[@tag = '546']">
      <xsl:if test="marc:subfield[@code='a']"> 
       <datafield tag="302">
        <xsl:attribute name="ind1"><xsl:value-of select="@ind1"/></xsl:attribute>
        <xsl:attribute name="ind2"><xsl:value-of select="@ind2"/></xsl:attribute>
        <xsl:for-each select= "marc:subfield[@code = 'a']"><subfield code="a"><xsl:value-of select="text()"/></subfield></xsl:for-each>
       </datafield>
      </xsl:if> 
      </xsl:for-each>

      <xsl:for-each select= "marc:datafield[@tag = '580']">
      <xsl:if test="marc:subfield[@code='a']">
       <datafield tag="311">
        <xsl:attribute name="ind1"><xsl:value-of select="@ind1"/></xsl:attribute>
        <xsl:attribute name="ind2"><xsl:value-of select="@ind2"/></xsl:attribute>
        <xsl:for-each select= "marc:subfield[@code = 'a']"><subfield code="a"><xsl:value-of select="text()"/></subfield></xsl:for-each>
       </datafield>
      </xsl:if> 
      </xsl:for-each>    
      
      <xsl:for-each select= "marc:datafield[@tag = '545']">
      <xsl:if test="marc:subfield[@code='a']">
       <datafield tag="314">
        <xsl:attribute name="ind1"><xsl:value-of select="@ind1"/></xsl:attribute>
        <xsl:attribute name="ind2"><xsl:value-of select="@ind2"/></xsl:attribute>
        <xsl:for-each select= "marc:subfield[@code = 'a']"><subfield code="a"><xsl:value-of select="text()"/></subfield></xsl:for-each>
       </datafield>
      </xsl:if> 
      </xsl:for-each>     
      
      <!-- 310 > 326: first 326 has non repeatable 310 -->
      <xsl:for-each select= "marc:datafield[@tag = '310']">
      <xsl:if test="marc:subfield[@code='a']"> 
       <datafield tag="326">
        <xsl:attribute name="ind1"><xsl:value-of select="@ind1"/></xsl:attribute>
        <xsl:attribute name="ind2"><xsl:value-of select="@ind2"/></xsl:attribute>
        <xsl:for-each select= "marc:subfield[@code = 'a']"><subfield code="a"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'b']"><subfield code="b"><xsl:value-of select="text()"/></subfield></xsl:for-each>
       </datafield>
      </xsl:if> 
      </xsl:for-each>

      <!-- 321 > 326: second and next 326 has repeatable 321 -->
      <xsl:for-each select= "marc:datafield[@tag = '321']">
      <xsl:if test="marc:subfield[@code='a']"> 
       <datafield tag="326">
        <xsl:attribute name="ind1"><xsl:value-of select="@ind1"/></xsl:attribute>
        <xsl:attribute name="ind2"><xsl:value-of select="@ind2"/></xsl:attribute>
        <xsl:for-each select= "marc:subfield[@code = 'a']"><subfield code="a"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'b']"><subfield code="b"><xsl:value-of select="text()"/></subfield></xsl:for-each>
       </datafield>
      </xsl:if> 
      </xsl:for-each>
            
      <xsl:for-each select= "marc:datafield[@tag = '504']">
      <xsl:if test="marc:subfield[@code='a']">
       <datafield tag="320" ind1=" " ind2=" ">
        <xsl:for-each select= "marc:subfield[@code = 'a']"><subfield code="a"><xsl:value-of select="text()"/></subfield></xsl:for-each>
       </datafield>
      </xsl:if> 
      </xsl:for-each>

      <xsl:for-each select= "marc:datafield[@tag = '505']">
      <xsl:if test="marc:subfield[@code='a'] or marc:subfield[@code='r'] or marc:subfield[@code='t'] or marc:subfield[@code='g']
                 or marc:subfield[@code='u']">
       <datafield tag="327">
        <xsl:attribute name="ind1"><xsl:value-of select="translate (@ind1, '0128', '102 ')" /></xsl:attribute>
        <xsl:attribute name="ind2"><xsl:choose><xsl:when test="@ind2 = 0">1</xsl:when><xsl:otherwise><xsl:value-of select="' '"/></xsl:otherwise></xsl:choose></xsl:attribute>
        <xsl:for-each select= "marc:subfield[@code = 'a']"><subfield code="a"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'r']"><subfield code="b"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 't']"><xsl:if test="text() and string-length(text()) > 0"><subfield code="c"><xsl:value-of select="text()"/></subfield></xsl:if></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'g']"><subfield code="p"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'u']"><subfield code="u"><xsl:value-of select="text()"/></subfield></xsl:for-each>
       </datafield>
      </xsl:if>  
      </xsl:for-each>
      
      <xsl:for-each select= "marc:datafield[@tag = '502']">
      <xsl:if test="marc:subfield[@code='a']">
       <datafield tag="328">
        <xsl:attribute name="ind1"><xsl:value-of select="@ind1"/></xsl:attribute>
        <xsl:attribute name="ind2"><xsl:value-of select="@ind2"/></xsl:attribute>
        <xsl:for-each select= "marc:subfield[@code = 'a']"><subfield code="a"><xsl:value-of select="text()"/></subfield></xsl:for-each>
       </datafield>
      </xsl:if>   
      </xsl:for-each>           
      <xsl:for-each select= "marc:datafield[@tag = '095']">
      <xsl:if test="marc:subfield[@code='b']">
       <datafield tag="328">
        <xsl:attribute name="ind1"><xsl:value-of select="@ind1"/></xsl:attribute>
        <xsl:attribute name="ind2"><xsl:value-of select="@ind2"/></xsl:attribute>
        <xsl:for-each select= "marc:subfield[@code = 'b']"><subfield code="c"><xsl:value-of select="text()"/></subfield></xsl:for-each>
       </datafield>
      </xsl:if> 
      </xsl:for-each>      
      
      <xsl:for-each select= "marc:datafield[@tag = '520']">
      <xsl:if test="marc:subfield[@code='a']">
       <datafield tag="330">
        <xsl:attribute name="ind1"><xsl:value-of select="' '"/></xsl:attribute>
        <xsl:attribute name="ind2"><xsl:value-of select="' '"/></xsl:attribute>
        <xsl:for-each select= "marc:subfield[@code = 'a']"><subfield code="a"><xsl:value-of select="text()"/></subfield></xsl:for-each>
       </datafield>
      </xsl:if>  
      </xsl:for-each>

      <xsl:for-each select= "marc:datafield[@tag = '524']">
      <xsl:if test="marc:subfield[@code='a']">
       <datafield tag="332">
        <xsl:attribute name="ind1"><xsl:value-of select="' '"/></xsl:attribute>
        <xsl:attribute name="ind2"><xsl:value-of select="' '"/></xsl:attribute>
        <xsl:for-each select= "marc:subfield[@code = 'a']"><subfield code="a"><xsl:value-of select="text()"/></subfield></xsl:for-each>
       </datafield>
      </xsl:if>  
      </xsl:for-each>

      <xsl:for-each select= "marc:datafield[@tag = '521']">
      <xsl:if test="marc:subfield[@code='a']"> 
       <datafield tag="333">
        <xsl:attribute name="ind1"><xsl:value-of select="@ind1"/></xsl:attribute>
        <xsl:attribute name="ind2"><xsl:value-of select="@ind2"/></xsl:attribute>
        <xsl:for-each select= "marc:subfield[@code = 'a']"><subfield code="a"><xsl:value-of select="text()"/></subfield></xsl:for-each>
       </datafield>
      </xsl:if>  
      </xsl:for-each>

      <xsl:for-each select= "marc:datafield[@tag = '500']">
       <xsl:choose>
        <xsl:when test="contains(subfield[@code = 'a'], 'file')">
         <datafield tag="336">
          <xsl:attribute name="ind1"><xsl:value-of select="' '"/></xsl:attribute>
          <xsl:attribute name="ind2"><xsl:value-of select="' '"/></xsl:attribute>
          <xsl:for-each select= "marc:subfield[@code = 'a']"><subfield code="a"><xsl:value-of select="text()"/></subfield></xsl:for-each>
         </datafield>
        </xsl:when>
       </xsl:choose>
      </xsl:for-each>

      <xsl:for-each select= "marc:datafield[@tag = '538']">
      <xsl:if test="marc:subfield[@code='a']">
       <datafield tag="337">
        <xsl:attribute name="ind1"><xsl:value-of select="' '"/></xsl:attribute>
        <xsl:attribute name="ind2"><xsl:value-of select="' '"/></xsl:attribute>
        <xsl:for-each select= "marc:subfield[@code = 'a']"><subfield code="a"><xsl:value-of select="text()"/></subfield>
        </xsl:for-each>
       </datafield>
      </xsl:if>   
      </xsl:for-each>

      <xsl:for-each select= "marc:datafield[@tag = '037']">
      <xsl:if test="marc:subfield[@code='b'] or marc:subfield[@code='a'] or marc:subfield[@code='f'] or marc:subfield[@code='c']">
       <datafield tag="345">
        <xsl:attribute name="ind1"><xsl:value-of select="' '"/></xsl:attribute>
        <xsl:attribute name="ind2"><xsl:value-of select="' '"/></xsl:attribute>
        <xsl:for-each select= "marc:subfield[@code = 'b']"><subfield code="a"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'a']"><subfield code="b"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'f']"><subfield code="c"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'c']"><subfield code="d"><xsl:value-of select="text()"/></subfield></xsl:for-each>
       </datafield>
      </xsl:if>  
      </xsl:for-each>
      
      <xsl:for-each select= "marc:datafield[@tag = '588']">
      <xsl:if test="marc:subfield[@code='a']">
       <datafield tag="388">
        <xsl:attribute name="ind1"><xsl:value-of select="@ind1"/></xsl:attribute>
        <xsl:attribute name="ind2"><xsl:value-of select="@ind2"/></xsl:attribute>
        <xsl:for-each select= "marc:subfield[@code = 'a']"><subfield code="a"><xsl:value-of select="text()"/></subfield></xsl:for-each>
       </datafield>
      </xsl:if> 
      </xsl:for-each>
      
      <xsl:for-each select= "marc:datafield[@tag = '760']">
      <xsl:if test="marc:subfield[@code='w'] or marc:subfield[@code='t'] or marc:subfield[@code='g'] or marc:subfield[@code='x'] or marc:subfield[@code='z']">
       <datafield tag="410">
        <xsl:attribute name="ind1"><xsl:value-of select="' '"/></xsl:attribute>
        <xsl:attribute name="ind2"><xsl:value-of select="translate(@ind1, '10', '01')"/></xsl:attribute>
        <xsl:for-each select= "marc:subfield[@code = 'w']"><subfield code="3"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 't']"><subfield code="t"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'g']"><subfield code="v"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'x']"><subfield code="x"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'z']"><subfield code="y"><xsl:value-of select="text()"/></subfield></xsl:for-each>
       </datafield>
      </xsl:if>
      </xsl:for-each>

      <xsl:for-each select= "marc:datafield[@tag = '762']">
      <xsl:if test="marc:subfield[@code='w'] or marc:subfield[@code='t'] or marc:subfield[@code='g'] or marc:subfield[@code='x'] or marc:subfield[@code='z']">
       <datafield tag="411">
        <xsl:attribute name="ind1"><xsl:value-of select="' '"/></xsl:attribute>
        <xsl:attribute name="ind2"><xsl:value-of select="translate(@ind1, '10', '01')"/></xsl:attribute>
        <xsl:for-each select= "marc:subfield[@code = 'w']"><subfield code="3"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 't']"><subfield code="t"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'g']"><subfield code="v"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'x']"><subfield code="x"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'z']"><subfield code="y"><xsl:value-of select="text()"/></subfield></xsl:for-each>
       </datafield>
      </xsl:if>
      </xsl:for-each>

      <xsl:for-each select= "marc:datafield[@tag = '770']">
      <xsl:if test="marc:subfield[@code='w'] or marc:subfield[@code='t'] or marc:subfield[@code='g'] or marc:subfield[@code='x'] or marc:subfield[@code='z']">
       <datafield tag="421">
        <xsl:attribute name="ind1"><xsl:value-of select="' '"/></xsl:attribute>
        <xsl:attribute name="ind2"><xsl:value-of select="translate(@ind1, '10', '01')"/></xsl:attribute>
        <xsl:for-each select= "marc:subfield[@code = 'w']"><subfield code="3"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 't']"><subfield code="t"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'g']"><subfield code="v"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'x']"><subfield code="x"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'z']"><subfield code="y"><xsl:value-of select="text()"/></subfield></xsl:for-each>
       </datafield>
      </xsl:if>
      </xsl:for-each>

      <xsl:for-each select= "marc:datafield[@tag = '772']">
      <xsl:if test="marc:subfield[@code='w'] or marc:subfield[@code='t'] or marc:subfield[@code='g'] or marc:subfield[@code='x'] or marc:subfield[@code='z']">
       <datafield tag="422">
        <xsl:attribute name="ind1"><xsl:value-of select="' '"/></xsl:attribute>
        <xsl:attribute name="ind2"><xsl:value-of select="translate(@ind1, '10', '01')"/></xsl:attribute>
        <xsl:for-each select= "marc:subfield[@code = 'w']"><subfield code="3"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 't']"><subfield code="t"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'g']"><subfield code="v"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'x']"><subfield code="x"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'z']"><subfield code="y"><xsl:value-of select="text()"/></subfield></xsl:for-each>
       </datafield>
      </xsl:if>
      </xsl:for-each>

      <xsl:for-each select= "marc:datafield[@tag = '777']">
      <xsl:if test="marc:subfield[@code='w'] or marc:subfield[@code='t'] or marc:subfield[@code='g'] or marc:subfield[@code='x'] or marc:subfield[@code='z']">
       <datafield tag="423">
        <xsl:attribute name="ind1"><xsl:value-of select="' '"/></xsl:attribute>
        <xsl:attribute name="ind2"><xsl:value-of select="translate(@ind1, '10', '01')"/></xsl:attribute>
        <xsl:for-each select= "marc:subfield[@code = 'w']"><subfield code="3"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 't']"><subfield code="t"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'g']"><subfield code="v"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'x']"><subfield code="x"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'z']"><subfield code="y"><xsl:value-of select="text()"/></subfield></xsl:for-each>
       </datafield>
      </xsl:if>
      </xsl:for-each>

      <xsl:for-each select= "marc:datafield[@tag = '780']">
      <xsl:if test="marc:subfield[@code='w'] or marc:subfield[@code='t'] or marc:subfield[@code='g'] or marc:subfield[@code='x'] 
                 or marc:subfield[@code='z'] or marc:subfield[@code='a']">
       <datafield tag="430">
        <xsl:attribute name="ind1"><xsl:value-of select="' '"/></xsl:attribute>
        <xsl:attribute name="ind2"><xsl:value-of select="translate(@ind1, '10', '01')"/></xsl:attribute>
        <xsl:for-each select= "marc:subfield[@code = 'w']"><subfield code="3"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 't']"><subfield code="t"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'a']"><subfield code="a"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'g']"><subfield code="v"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'x']"><subfield code="x"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'z']"><subfield code="y"><xsl:value-of select="text()"/></subfield></xsl:for-each>
       </datafield>
      </xsl:if>
      </xsl:for-each>

      <xsl:for-each select= "marc:datafield[@tag = '785']">
      <xsl:if test="marc:subfield[@code='w'] or marc:subfield[@code='t'] or marc:subfield[@code='g'] or marc:subfield[@code='x'] or marc:subfield[@code='z']">
       <datafield tag="440">
        <xsl:attribute name="ind1"><xsl:value-of select="' '"/></xsl:attribute>
        <xsl:attribute name="ind2"><xsl:value-of select="translate(@ind1, '10', '01')"/></xsl:attribute>
        <xsl:for-each select= "marc:subfield[@code = 'w']"><subfield code="3"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 't']"><subfield code="t"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'g']"><subfield code="v"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'x']"><subfield code="x"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'z']"><subfield code="y"><xsl:value-of select="text()"/></subfield></xsl:for-each>
       </datafield>
      </xsl:if>
      </xsl:for-each>

      <xsl:for-each select= "marc:datafield[@tag = '775']">
      <xsl:if test="marc:subfield[@code='w'] or marc:subfield[@code='t'] or marc:subfield[@code='g'] or marc:subfield[@code='x'] or marc:subfield[@code='z']">
       <datafield tag="451">
        <xsl:attribute name="ind1"><xsl:value-of select="' '"/></xsl:attribute>
        <xsl:attribute name="ind2"><xsl:value-of select="translate(@ind1, '10', '01')"/></xsl:attribute>
        <xsl:for-each select= "marc:subfield[@code = 'w']"><subfield code="3"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 't']"><subfield code="t"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'g']"><subfield code="v"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'x']"><subfield code="x"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'z']"><subfield code="y"><xsl:value-of select="text()"/></subfield></xsl:for-each>
       </datafield>
      </xsl:if>
      </xsl:for-each>
 
      <xsl:for-each select= "marc:datafield[@tag = '776']">
      <xsl:if test="marc:subfield[@code='w'] or marc:subfield[@code='t'] or marc:subfield[@code='g'] or marc:subfield[@code='x'] or marc:subfield[@code='z']">
       <datafield tag="452">
        <xsl:attribute name="ind1"><xsl:value-of select="' '"/></xsl:attribute>
        <xsl:attribute name="ind2"><xsl:value-of select="translate(@ind1, '10', '01')"/></xsl:attribute>
        <xsl:for-each select= "marc:subfield[@code = 'w']"><subfield code="3"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 't']"><subfield code="t"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'g']"><subfield code="v"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'x']"><subfield code="x"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'z']"><subfield code="y"><xsl:value-of select="text()"/></subfield></xsl:for-each>
       </datafield>
      </xsl:if>
      </xsl:for-each>

      <xsl:for-each select= "marc:datafield[@tag = '767']">
      <xsl:if test="marc:subfield[@code='w'] or marc:subfield[@code='t'] or marc:subfield[@code='g'] or marc:subfield[@code='x'] or marc:subfield[@code='z']">
       <datafield tag="453">
        <xsl:attribute name="ind1"><xsl:value-of select="' '"/></xsl:attribute>
        <xsl:attribute name="ind2"><xsl:value-of select="translate(@ind1, '10', '01')"/></xsl:attribute>
        <xsl:for-each select= "marc:subfield[@code = 'w']"><subfield code="3"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 't']"><subfield code="t"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'g']"><subfield code="v"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'x']"><subfield code="x"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'z']"><subfield code="y"><xsl:value-of select="text()"/></subfield></xsl:for-each>
       </datafield>
      </xsl:if> 
      </xsl:for-each>

      <xsl:for-each select= "marc:datafield[@tag = '765']">
      <xsl:if test="marc:subfield[@code='w'] or marc:subfield[@code='t'] or marc:subfield[@code='g'] or marc:subfield[@code='x'] or marc:subfield[@code='z']">
       <datafield tag="454">
        <xsl:attribute name="ind1"><xsl:value-of select="' '"/></xsl:attribute>
        <xsl:attribute name="ind2"><xsl:value-of select="translate(@ind1, '10', '01')"/></xsl:attribute>
        <xsl:for-each select= "marc:subfield[@code = 'w']"><subfield code="3"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 't']"><subfield code="t"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'g']"><subfield code="v"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'x']"><subfield code="x"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'z']"><subfield code="y"><xsl:value-of select="text()"/></subfield></xsl:for-each>
       </datafield>
      </xsl:if> 
      </xsl:for-each>

      <xsl:for-each select= "marc:datafield[@tag = '787']">
      <xsl:if test="marc:subfield[@code='w'] or marc:subfield[@code='t'] or marc:subfield[@code='g'] or marc:subfield[@code='x'] or marc:subfield[@code='z']">
       <datafield>
        <xsl:choose>
         <xsl:when test="contains(subfield[@code = 'i'], 'Reproduction of:')">
          <xsl:attribute name="tag"><xsl:value-of select="455" /></xsl:attribute>
         </xsl:when>
         <xsl:when test="contains(subfield[@code = 'i'], 'Reproduced as:')">
          <xsl:attribute name="tag"><xsl:value-of select="456" /></xsl:attribute>
         </xsl:when>
         <xsl:when test="contains(subfield[@code = 'i'], 'Item reviewed:')">
          <xsl:attribute name="tag"><xsl:value-of select="470" /></xsl:attribute>
         </xsl:when>
         <xsl:otherwise>
          <xsl:attribute name="tag"><xsl:value-of select="488" /></xsl:attribute>
         </xsl:otherwise>
        </xsl:choose>
        <xsl:attribute name="ind1"><xsl:value-of select="' '"/></xsl:attribute>
        <xsl:attribute name="ind2"><xsl:value-of select="translate(@ind1, '10', '01')"/></xsl:attribute>
        <xsl:for-each select= "marc:subfield[@code = 'w']"><subfield code="3"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 't']"><subfield code="t"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'g']"><subfield code="v"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'x']"><subfield code="x"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'z']"><subfield code="y"><xsl:value-of select="text()"/></subfield></xsl:for-each>
       </datafield>
      </xsl:if>
      </xsl:for-each>      

      <xsl:for-each select= "marc:datafield[@tag = '774']">
      <xsl:if test="marc:subfield[@code='w'] or marc:subfield[@code='t'] or marc:subfield[@code='g'] or marc:subfield[@code='x'] or marc:subfield[@code='z']">
       <datafield>
        <xsl:choose>
         <xsl:when test="marc:subfield[@code='i']">
          <xsl:attribute name="tag"><xsl:value-of select="462" /></xsl:attribute>
         </xsl:when>
         <xsl:otherwise>
          <xsl:attribute name="tag"><xsl:value-of select="461" /></xsl:attribute> 
         </xsl:otherwise>
        </xsl:choose>
        <xsl:attribute name="ind1"><xsl:value-of select="' '"/></xsl:attribute>
        <xsl:attribute name="ind2"><xsl:value-of select="translate(@ind1, '10', '01')"/></xsl:attribute>
        <xsl:for-each select= "marc:subfield[@code = 'w']"><subfield code="3"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 't']"><subfield code="t"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'g']"><subfield code="v"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'x']"><subfield code="x"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'z']"><subfield code="y"><xsl:value-of select="text()"/></subfield></xsl:for-each>
       </datafield>
      </xsl:if>
      </xsl:for-each>

      <xsl:for-each select= "marc:datafield[@tag = '773']">
      <xsl:if test="marc:subfield[@code='a'] or marc:subfield[@code='d'] or marc:subfield[@code='b'] or marc:subfield[@code='g'] or marc:subfield[@code='t'] or marc:subfield[@code='w'] or marc:subfield[@code='x'] or marc:subfield[@code='z']">
       <datafield tag="463">
        <xsl:attribute name="ind1"><xsl:value-of select="' '"/></xsl:attribute>
        <xsl:attribute name="ind2"><xsl:value-of select="translate(@ind1, '10', '01')"/></xsl:attribute>
        <xsl:for-each select= "marc:subfield[@code = 'a']"><subfield code="a"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'd']"><subfield code="d"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'b']"><subfield code="e"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <!-- <xsl:for-each select= "marc:subfield[@code = 'g']"><subfield code="v"><xsl:value-of select="text()"/></subfield></xsl:for-each> -->
        <xsl:for-each select= "marc:subfield[@code = 'g']"><subfield code="o"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 't']"><subfield code="t"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <!-- <xsl:for-each select= "marc:subfield[@code = 'w']"><subfield code="3"><xsl:value-of select="text()"/></subfield></xsl:for-each> -->
        <xsl:for-each select= "marc:subfield[@code = 'w']"><subfield code="0"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'x']"><subfield code="x"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'z']"><subfield code="y"><xsl:value-of select="text()"/></subfield></xsl:for-each>
       </datafield>
      </xsl:if>
      </xsl:for-each>

      <xsl:for-each select= "marc:datafield[@tag = '774']">
       <datafield tag="464">
        <xsl:attribute name="ind1">
         <xsl:value-of select="' '"/>
        </xsl:attribute>
        <xsl:attribute name="ind2">
         <xsl:value-of select="translate(@ind1, '10', '01')"/>
        </xsl:attribute>
        <xsl:for-each select= "marc:subfield[@code = 'w']">
         <subfield code="3">
          <xsl:value-of select="text()"/>
         </subfield>
        </xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 't']">
         <subfield code="t">
          <xsl:value-of select="text()"/>
         </subfield>
        </xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'g']">
         <subfield code="v">
          <xsl:value-of select="text()"/>
         </subfield>
        </xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'x']">
         <subfield code="x">
          <xsl:value-of select="text()"/>
         </subfield>
        </xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'z']">
         <subfield code="y">
          <xsl:value-of select="text()"/>
         </subfield>
        </xsl:for-each>
       </datafield>
      </xsl:for-each>

      <xsl:for-each select= "marc:datafield[@tag = '130']">
       <datafield tag="500">
        <xsl:attribute name="ind1"><xsl:value-of select="@ind1"/></xsl:attribute>
        <xsl:attribute name="ind2"><xsl:value-of select="1"/></xsl:attribute>
        <xsl:for-each select= "marc:subfield[@code = 'a']"><subfield code="a"><xsl:call-template name="removeEndPuctuation"><xsl:with-param name="text" select="text()"/></xsl:call-template></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'd']"><subfield code="n"><xsl:call-template name="removeEndPuctuation"><xsl:with-param name="text" select="text()"/></xsl:call-template></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'f']"><subfield code="k"><xsl:call-template name="removeEndPuctuation"><xsl:with-param name="text" select="text()"/></xsl:call-template></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'g']"><subfield code="n"><xsl:call-template name="removeEndPuctuation"><xsl:with-param name="text" select="text()"/></xsl:call-template></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'k']"><subfield code="j"><xsl:call-template name="removeEndPuctuation"><xsl:with-param name="text" select="text()"/></xsl:call-template></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'l']"><subfield code="m"><xsl:call-template name="removeEndPuctuation"><xsl:with-param name="text" select="text()"/></xsl:call-template></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'm']"><subfield code="r"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'n']"><subfield code="h"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'o']"><subfield code="w"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'p']"><subfield code="i"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'r']"><subfield code="u"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 's']"><subfield code="q"><xsl:value-of select="text()"/></subfield></xsl:for-each>
       </datafield>
      </xsl:for-each>

      <xsl:for-each select= "marc:datafield[@tag = '240']">
       <datafield tag="500">
        <xsl:attribute name="ind1">
         <xsl:value-of select="@ind1"/>
        </xsl:attribute>
        <xsl:attribute name="ind2">
         <xsl:value-of select="0"/>
        </xsl:attribute>
        <xsl:for-each select= "marc:subfield[@code = 'a']">
         <subfield code="a">
          <xsl:call-template name="removeEndPuctuation">
           <xsl:with-param name="text" select="text()"/>
          </xsl:call-template>
         </subfield>
        </xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'd']">
         <subfield code="n">
          <xsl:call-template name="removeEndPuctuation">
           <xsl:with-param name="text" select="text()"/>
          </xsl:call-template>
         </subfield>
        </xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'f']">
         <subfield code="k">
          <xsl:call-template name="removeEndPuctuation">
           <xsl:with-param name="text" select="text()"/>
          </xsl:call-template>
         </subfield>
        </xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'g']">
         <subfield code="n">
          <xsl:call-template name="removeEndPuctuation">
           <xsl:with-param name="text" select="text()"/>
          </xsl:call-template>
         </subfield>
        </xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'k']">
         <subfield code="j">
          <xsl:call-template name="removeEndPuctuation">
           <xsl:with-param name="text" select="text()"/>
          </xsl:call-template>
         </subfield>
        </xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'l']">
         <subfield code="m">
          <xsl:call-template name="removeEndPuctuation">
           <xsl:with-param name="text" select="text()"/>
          </xsl:call-template>
         </subfield>
        </xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'm']">
         <subfield code="r">
          <xsl:value-of select="text()"/>
         </subfield>
        </xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'n']">
         <subfield code="h">
          <xsl:value-of select="text()"/>
         </subfield>
        </xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'o']">
         <subfield code="w">
          <xsl:value-of select="text()"/>
         </subfield>
        </xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'p']">
         <subfield code="i">
          <xsl:value-of select="text()"/>
         </subfield>
        </xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'r']">
         <subfield code="u">
          <xsl:value-of select="text()"/>
         </subfield>
        </xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 's']">
         <subfield code="q">
          <xsl:value-of select="text()"/>
         </subfield>
        </xsl:for-each>
       </datafield>
      </xsl:for-each>

      <!-- Tag 730 is not on UNIMARC to MARC 21 Conversion Specifications -->
      <xsl:for-each select= "marc:datafield[@tag = '730']">
       <datafield tag="500">
        <xsl:attribute name="ind1"><xsl:value-of select="@ind1"/></xsl:attribute>
        <xsl:attribute name="ind2"><xsl:value-of select="@ind2"/></xsl:attribute>
        <xsl:for-each select= "marc:subfield[@code = 'a']"><subfield code="a"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'd']"><subfield code="n"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'f']"><subfield code="k"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'g']"><subfield code="n"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'k']"><subfield code="j"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'l']"><subfield code="m"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'm']"><subfield code="r"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'n']"><subfield code="h"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'o']"><subfield code="w"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'p']"><subfield code="i"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'r']"><subfield code="u"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 's']"><subfield code="q"><xsl:value-of select="text()"/></subfield></xsl:for-each>
       </datafield>
      </xsl:for-each>

      <xsl:for-each select= "marc:datafield[@tag = '243']">
       <datafield tag="501">
        <xsl:attribute name="ind1">1</xsl:attribute>
        <xsl:attribute name="ind2"><xsl:value-of select="' '"/>
        </xsl:attribute>
        <xsl:for-each select= "marc:subfield[@code = 'a']"><subfield code="a"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'k']"><subfield code="e"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'f']"><subfield code="k"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'l']"><subfield code="m"><xsl:value-of select="text()"/></subfield></xsl:for-each>
       </datafield>
      </xsl:for-each>

      <xsl:for-each select= "marc:datafield[@tag = '247']">
       <datafield tag="520">
        <xsl:attribute name="ind1"><xsl:value-of select="@ind1"/></xsl:attribute>
        <xsl:attribute name="ind2"><xsl:value-of select="' '"/></xsl:attribute>
        <xsl:for-each select= "marc:subfield[@code = 'a']"><subfield code="a"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'b']"><subfield code="e"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'n']"><subfield code="h"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'p']"><subfield code="i"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'g']"><subfield code="n"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'f']"><subfield code="j"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'x']"><subfield code="x"><xsl:value-of select="text()"/></subfield></xsl:for-each>
       </datafield>
      </xsl:for-each>

      <xsl:for-each select= "marc:datafield[@tag = '222']">
      <xsl:if test="marc:subfield[@code='a'] or marc:subfield[@code = 'b']">
       <datafield tag="530">
        <xsl:attribute name="ind1">0</xsl:attribute>
        <xsl:attribute name="ind2"><xsl:value-of select="' '"/></xsl:attribute>
        <xsl:for-each select= "marc:subfield[@code = 'a']"><subfield code="a"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'b']"><subfield code="b"><xsl:value-of select="text()"/></subfield></xsl:for-each>
       </datafield>
      </xsl:if>
      </xsl:for-each>

      <xsl:for-each select= "marc:datafield[@tag = '210']">
      <xsl:if test="marc:subfield[@code='a'] or marc:subfield[@code = 'b']">
       <datafield tag="531">
        <xsl:attribute name="ind1"><xsl:value-of select="' '"/></xsl:attribute>
        <xsl:attribute name="ind2"><xsl:value-of select="' '"/></xsl:attribute>
        <xsl:for-each select= "marc:subfield[@code = 'a']"><subfield code="a"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'b']"><subfield code="b"><xsl:value-of select="text()"/></subfield></xsl:for-each>
       </datafield>
      </xsl:if>
      </xsl:for-each>

      <xsl:for-each select= "marc:datafield[@tag = '246']">
      <xsl:if test="marc:subfield[@code='a']">
       <datafield tag="532">
        <xsl:attribute name="ind1"><xsl:value-of select="@ind1"/></xsl:attribute>
        <xsl:attribute name="ind2">0</xsl:attribute>
        <xsl:for-each select= "marc:subfield[@code = 'a']"><subfield code="a"><xsl:value-of select="text()"/></subfield></xsl:for-each>
       </datafield>
      </xsl:if>
      </xsl:for-each>      

      <xsl:for-each select= "marc:datafield[@tag = '242']">
       <datafield tag="541">
        <xsl:attribute name="ind1">
         <xsl:value-of select="@ind1"/>
        </xsl:attribute>
        <xsl:attribute name="ind2">
         <xsl:value-of select="' '"/>
        </xsl:attribute>
        <xsl:for-each select= "marc:subfield[@code = 'a']">
         <subfield code="a">
          <xsl:value-of select="text()"/>
         </subfield>
        </xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'b']">
         <subfield code="e">
          <xsl:value-of select="text()"/>
         </subfield>
        </xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'n']">
         <subfield code="h">
          <xsl:value-of select="text()"/>
         </subfield>
        </xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'p']">
         <subfield code="i">
          <xsl:value-of select="text()"/>
         </subfield>
        </xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'y']">
         <subfield code="z">
          <xsl:value-of select="text()"/>
         </subfield>
        </xsl:for-each>
       </datafield>
      </xsl:for-each>

      <!-- <xsl:if test="marc:datafield[@tag='773']/marc:subfield[@code='t']"> -->
       <xsl:for-each select= "marc:datafield[@tag = '773']">
        <xsl:if test="marc:subfield[@code='t']">
         <datafield tag="545">
          <xsl:attribute name="ind1"><xsl:choose><xsl:when test="@ind1 = 0">1</xsl:when><xsl:otherwise>0</xsl:otherwise></xsl:choose></xsl:attribute>
          <xsl:attribute name="ind2"><xsl:value-of select="' '"/></xsl:attribute>
          <xsl:for-each select= "marc:subfield[@code = 't']"><subfield code="a"><xsl:value-of select="text()"/></subfield></xsl:for-each>
         </datafield>
        </xsl:if>
       </xsl:for-each>
      <!-- </xsl:if> -->

      <xsl:for-each select= "marc:datafield[@tag = '600']">
      <xsl:if test="marc:subfield[@code='a'] or 
                    marc:subfield[@code='b'] or 
                    marc:subfield[@code='c'] or 
                    marc:subfield[@code='d'] or
                    marc:subfield[@code='q'] or  
                    marc:subfield[@code='t'] or 
                    marc:subfield[@code='x'] or 
                    marc:subfield[@code='y'] or 
                    marc:subfield[@code='z'] or 
                    marc:subfield[@code='2']">
       <xsl:choose>
        <xsl:when test="@ind1 != 3" >
         <datafield tag="600">
          <xsl:attribute name="ind1"><xsl:value-of select="' '"/></xsl:attribute>
          <xsl:attribute name="ind2"><xsl:choose><xsl:when test="@ind1 = 0">0</xsl:when><xsl:otherwise>1</xsl:otherwise></xsl:choose></xsl:attribute>
          <xsl:call-template name="convertSubjectHeading">
           <xsl:with-param name="ind" select="@ind2"/>
          </xsl:call-template>
          <xsl:for-each select= "marc:subfield[@code = 'a']">
           <xsl:choose>
            <xsl:when test="contains(text(), ', ')">
             <subfield code="a"><xsl:value-of select="substring-before(text(), ', ')"/></subfield>
             <subfield code="b"><xsl:call-template name="removeEndPuctuation"><xsl:with-param name="text" select="substring-after(text(), ', ')"/></xsl:call-template></subfield>
            </xsl:when>
            <xsl:otherwise>
             <subfield code="a"><xsl:call-template name="removeEndPuctuation"><xsl:with-param name="text" select="text()"/></xsl:call-template></subfield>
            </xsl:otherwise>
           </xsl:choose>
          </xsl:for-each>
          <xsl:for-each select= "marc:subfield[@code = 'c']"><subfield code="c"><xsl:call-template name="removeEndPuctuation"><xsl:with-param name="text" select="text()"/></xsl:call-template></subfield></xsl:for-each>
          <xsl:for-each select= "marc:subfield[@code = 'b']"><subfield code="d"><xsl:value-of select="text()"/></subfield></xsl:for-each>
          <xsl:for-each select= "marc:subfield[@code = 'd']"><subfield code="f"><xsl:value-of select="text()"/></subfield></xsl:for-each>
          <xsl:for-each select= "marc:subfield[@code = 'q']"><subfield code="g"><xsl:value-of select="text()"/></subfield></xsl:for-each>
          <xsl:for-each select= "marc:subfield[@code = 't']"><subfield code="t"><xsl:value-of select="text()"/></subfield></xsl:for-each>
          <xsl:for-each select= "marc:subfield[@code = 'x']"><subfield code="x"><xsl:value-of select="text()"/></subfield></xsl:for-each>
          <xsl:for-each select= "marc:subfield[@code = 'z']"><subfield code="y"><xsl:value-of select="text()"/></subfield></xsl:for-each>
          <xsl:for-each select= "marc:subfield[@code = 'y']"><subfield code="z"><xsl:value-of select="text()"/></subfield></xsl:for-each>
          <xsl:for-each select= "marc:subfield[@code = '2']"><subfield code="2"><xsl:value-of select="text()"/></subfield></xsl:for-each>
         </datafield>
        </xsl:when>
        <xsl:when test="@ind1 = 3" >
         <datafield tag="602" ind1=" " ind2=" ">
          <xsl:for-each select= "marc:subfield[@code = 'a']"><subfield code="a"><xsl:value-of select="text()"/></subfield></xsl:for-each>
          <xsl:for-each select= "marc:subfield[@code = 't']"><subfield code="t"><xsl:value-of select="text()"/></subfield></xsl:for-each>
          <xsl:for-each select= "marc:subfield[@code = 'x']"><subfield code="x"><xsl:value-of select="text()"/></subfield></xsl:for-each>
          <xsl:for-each select= "marc:subfield[@code = 'z']"><subfield code="y"><xsl:value-of select="text()"/></subfield></xsl:for-each>
          <xsl:for-each select= "marc:subfield[@code = 'y']"><subfield code="z"><xsl:value-of select="text()"/></subfield></xsl:for-each>
          <xsl:for-each select= "marc:subfield[@code = '2']"><subfield code="2"><xsl:value-of select="text()"/></subfield></xsl:for-each>
         </datafield>
        </xsl:when>
       </xsl:choose>
      </xsl:if>
      </xsl:for-each>

      <xsl:for-each select= "marc:datafield[@tag = '610']">
       <datafield tag="601">
        <xsl:attribute name="ind1"><xsl:value-of select="0"/></xsl:attribute>
        <xsl:attribute name="ind2"><xsl:value-of select="@ind1"/></xsl:attribute>
        <xsl:call-template name="convertSubjectHeading"><xsl:with-param name="ind" select="@ind2"/></xsl:call-template>
        <xsl:for-each select= "marc:subfield[@code = 'a']">
         <xsl:if test="text() and string-length(text()) > 0"><subfield code="a"><xsl:value-of select="text()"/></subfield></xsl:if>
         <xsl:variable name="f601c"><xsl:value-of select="substring-before(substring-after(text(), '('), ')')"/></xsl:variable>
         <xsl:if test="$f601c and string-length($f601c) > 0"><subfield code="c"><xsl:value-of select="$f601c"/></subfield></xsl:if>
        </xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'b']"><subfield code="b"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'c']"><subfield code="e"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'd']"><subfield code="f"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'e']"><subfield code="b"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <!--<xsl:for-each select= "marc:subfield[@code='f']"><subfield code="?"><xsl:value-of select="text()" /></subfield></xsl:for-each>-->
        <!--<xsl:for-each select= "marc:subfield[@code='g']"><subfield code="?"><xsl:value-of select="text()" /></subfield></xsl:for-each>-->
        <xsl:for-each select= "marc:subfield[@code = 'k']"><subfield code="j"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <!--<xsl:for-each select= "marc:subfield[@code='l']"><subfield code="?"><xsl:value-of select="text()" /></subfield></xsl:for-each>-->
        <!--<xsl:for-each select= "marc:subfield[@code='m']"><subfield code="?"><xsl:value-of select="text()" /></subfield></xsl:for-each>-->
        <xsl:for-each select= "marc:subfield[@code = 'n']"><subfield code="d"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <!--<xsl:for-each select= "marc:subfield[@code='o']"><subfield code="?"><xsl:value-of select="text()" /></subfield></xsl:for-each>-->
        <!--<xsl:for-each select= "marc:subfield[@code='p']"><subfield code="?"><xsl:value-of select="text()" /></subfield></xsl:for-each>-->
        <!--<xsl:for-each select= "marc:subfield[@code='r']"><subfield code="?"><xsl:value-of select="text()" /></subfield></xsl:for-each>-->
        <!--<xsl:for-each select= "marc:subfield[@code='s']"><subfield code="?"><xsl:value-of select="text()" /></subfield></xsl:for-each>-->
        <!--<xsl:for-each select= "marc:subfield[@code='t']"><subfield code="?"><xsl:value-of select="text()" /></subfield></xsl:for-each>-->
        <!--<xsl:for-each select= "marc:subfield[@code='u']"><subfield code="?"><xsl:value-of select="text()" /></subfield></xsl:for-each>-->
        <xsl:for-each select= "marc:subfield[@code = 'x']"><subfield code="x"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'y']"><subfield code="z"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'z']"><subfield code="y"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <!--<xsl:for-each select= "marc:subfield[@code='?']"><subfield code="3"><xsl:value-of select="text()" /></subfield></xsl:for-each>-->
       </datafield>
      </xsl:for-each>

      <xsl:for-each select= "marc:datafield[@tag = '611']">
      <xsl:if test="marc:subfield[@code='a'] or marc:subfield[@code='c'] or marc:subfield[@code='d'] or marc:subfield[@code='e']
                 or marc:subfield[@code='k'] or marc:subfield[@code='n'] or marc:subfield[@code='t'] or marc:subfield[@code='x']
                 or marc:subfield[@code='y'] or marc:subfield[@code='z']">
       <datafield tag="601">
        <xsl:attribute name="ind1"><xsl:value-of select="1"/></xsl:attribute>
        <xsl:attribute name="ind2"><xsl:value-of select="@ind1"/></xsl:attribute>
        <xsl:call-template name="convertSubjectHeading"><xsl:with-param name="ind" select="@ind2"/></xsl:call-template>
        <xsl:for-each select= "marc:subfield[@code = 'a']">
         <subfield code="a"><xsl:value-of select="text()"/></subfield>
         <subfield code="c"><xsl:value-of select="substring-before(substring-after(text(), '('), ')')"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'c']"><subfield code="e"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'd']"><subfield code="f"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'e']"><subfield code="b"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <!--<xsl:for-each select= "marc:subfield[@code='f']"><subfield code="?"><xsl:value-of select="text()" /></subfield></xsl:for-each>-->
        <!--<xsl:for-each select= "marc:subfield[@code='g']"><subfield code="?"><xsl:value-of select="text()" /></subfield></xsl:for-each>-->
        <xsl:for-each select= "marc:subfield[@code = 'k']"><subfield code="j"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <!--<xsl:for-each select= "marc:subfield[@code='l']"><subfield code="?"><xsl:value-of select="text()" /></subfield></xsl:for-each>-->
        <xsl:for-each select= "marc:subfield[@code = 'n']"><subfield code="d"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <!--<xsl:for-each select= "marc:subfield[@code='p']"><subfield code="?"><xsl:value-of select="text()" /></subfield></xsl:for-each>-->
        <!--<xsl:for-each select= "marc:subfield[@code='s']"><subfield code="?"><xsl:value-of select="text()" /></subfield></xsl:for-each>-->
        <xsl:for-each select= "marc:subfield[@code = 't']"><subfield code="t"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <!--<xsl:for-each select= "marc:subfield[@code='u']"><subfield code="?"><xsl:value-of select="text()" /></subfield></xsl:for-each>-->
        <xsl:for-each select= "marc:subfield[@code = 'x']"><subfield code="x"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'y']"><subfield code="z"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'z']"><subfield code="y"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <!--<xsl:for-each select= "marc:subfield[@code='?']"><subfield code="3"><xsl:value-of select="text()" /></subfield></xsl:for-each>-->
       </datafield>
      </xsl:if>
      </xsl:for-each>

      <xsl:for-each select= "marc:datafield[@tag = '630']">
      <xsl:if test="marc:subfield[@code='a'] or marc:subfield[@code='n'] or marc:subfield[@code='p'] or marc:subfield[@code='f']
                 or marc:subfield[@code='k'] or marc:subfield[@code='l'] or marc:subfield[@code='g'] or marc:subfield[@code='s']
                 or marc:subfield[@code='r'] or marc:subfield[@code='n'] or marc:subfield[@code='o'] or marc:subfield[@code='r']
                 or marc:subfield[@code='x'] or marc:subfield[@code='y'] or marc:subfield[@code='z'] or marc:subfield[@code='2']">
       <datafield tag="605">
        <xsl:attribute name="ind1"><xsl:value-of select="@ind1"/></xsl:attribute>
        <xsl:attribute name="ind2"><xsl:value-of select="@ind2"/></xsl:attribute>
        <xsl:call-template name="convertSubjectHeading"><xsl:with-param name="ind" select="@ind2"/></xsl:call-template>
        <xsl:for-each select= "marc:subfield[@code = 'a']"><subfield code="a"><xsl:call-template name="removeEndTermPuctuation"><xsl:with-param name="text" select="text()"/></xsl:call-template></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'n']"><subfield code="h"><xsl:call-template name="removeEndTermPuctuation"><xsl:with-param name="text" select="text()"/></xsl:call-template></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'p']"><subfield code="i"><xsl:call-template name="removeEndTermPuctuation"><xsl:with-param name="text" select="text()"/></xsl:call-template></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'f']"><subfield code="k"><xsl:call-template name="removeEndTermPuctuation"><xsl:with-param name="text" select="text()"/></xsl:call-template></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'k']"><subfield code="l"><xsl:call-template name="removeEndTermPuctuation"><xsl:with-param name="text" select="text()"/></xsl:call-template></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'l']"><subfield code="m"><xsl:call-template name="removeEndTermPuctuation"><xsl:with-param name="text" select="text()"/></xsl:call-template></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'g']"><subfield code="n"><xsl:call-template name="removeEndTermPuctuation"><xsl:with-param name="text" select="text()"/></xsl:call-template></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 's']"><subfield code="q"><xsl:call-template name="removeEndTermPuctuation"><xsl:with-param name="text" select="text()"/></xsl:call-template></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'r']"><subfield code="r"><xsl:call-template name="removeEndTermPuctuation"><xsl:with-param name="text" select="text()"/></xsl:call-template></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'n']"><subfield code="s"><xsl:call-template name="removeEndTermPuctuation"><xsl:with-param name="text" select="text()"/></xsl:call-template></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'o']"><subfield code="t"><xsl:call-template name="removeEndTermPuctuation"><xsl:with-param name="text" select="text()"/></xsl:call-template></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'r']"><subfield code="u"><xsl:call-template name="removeEndTermPuctuation"><xsl:with-param name="text" select="text()"/></xsl:call-template></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'x']"><subfield code="x"><xsl:call-template name="removeEndTermPuctuation"><xsl:with-param name="text" select="text()"/></xsl:call-template></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'y']"><subfield code="z"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'z']"><subfield code="y"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = '2']"><subfield code="2"><xsl:value-of select="text()"/></subfield></xsl:for-each>
       </datafield>
      </xsl:if> 
      </xsl:for-each>

      <xsl:for-each select= "marc:datafield[@tag = '650']">
      <xsl:if test="marc:subfield[@code='a'] or marc:subfield[@code='v'] or marc:subfield[@code='x'] or marc:subfield[@code='z']
                 or marc:subfield[@code='y'] or marc:subfield[@code='2']">
       <datafield tag="606">
        <xsl:attribute name="ind1"><xsl:value-of select="@ind1"/></xsl:attribute>
        <xsl:attribute name="ind2"><xsl:value-of select="@ind2"/></xsl:attribute>
        <xsl:call-template name="convertSubjectHeading"><xsl:with-param name="ind" select="@ind2"/></xsl:call-template>
        <xsl:for-each select= "marc:subfield[@code = 'a']"><subfield code="a"><xsl:call-template name="removeEndTermPuctuation"><xsl:with-param name="text" select="text()"/></xsl:call-template></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'v']"><subfield code="j"><xsl:call-template name="removeEndTermPuctuation"><xsl:with-param name="text" select="text()"/></xsl:call-template></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'x']"><subfield code="x"><xsl:call-template name="removeEndTermPuctuation"><xsl:with-param name="text" select="text()"/></xsl:call-template></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'z']"><subfield code="y"><xsl:call-template name="removeEndTermPuctuation"><xsl:with-param name="text" select="text()"/></xsl:call-template></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'y']"><subfield code="z"><xsl:call-template name="removeEndTermPuctuation"><xsl:with-param name="text" select="text()"/></xsl:call-template></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = '2']"><subfield code="2"><xsl:call-template name="removeEndTermPuctuation"><xsl:with-param name="text" select="text()"/></xsl:call-template></subfield></xsl:for-each>
       </datafield>
      </xsl:if> 
      </xsl:for-each>

      <xsl:for-each select= "marc:datafield[@tag = '690']">
      <xsl:if test="marc:subfield[@code='a'] or marc:subfield[@code='v'] or marc:subfield[@code='x'] or marc:subfield[@code='z'] or marc:subfield[@code='y'] or marc:subfield[@code='2']">
       <datafield tag="606">
        <xsl:attribute name="ind1"><xsl:value-of select="@ind1"/></xsl:attribute>
        <xsl:attribute name="ind2"><xsl:value-of select="@ind2"/></xsl:attribute>
        <xsl:call-template name="convertSubjectHeading"><xsl:with-param name="ind" select="@ind2"/></xsl:call-template>
        <subfield code="2">local</subfield>
        <xsl:for-each select= "marc:subfield[@code = 'a']"><subfield code="a"><xsl:call-template name="removeEndTermPuctuation"><xsl:with-param name="text" select="text()"/></xsl:call-template></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'v']"><subfield code="j"><xsl:call-template name="removeEndTermPuctuation"><xsl:with-param name="text" select="text()"/></xsl:call-template></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'x']"><subfield code="x"><xsl:call-template name="removeEndTermPuctuation"><xsl:with-param name="text" select="text()"/></xsl:call-template></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'z']"><subfield code="y"><xsl:call-template name="removeEndTermPuctuation"><xsl:with-param name="text" select="text()"/></xsl:call-template></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'y']"><subfield code="z"><xsl:call-template name="removeEndTermPuctuation"><xsl:with-param name="text" select="text()"/></xsl:call-template></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = '2']"><subfield code="2"><xsl:call-template name="removeEndTermPuctuation"><xsl:with-param name="text" select="text()"/></xsl:call-template></subfield></xsl:for-each>
       </datafield>
      </xsl:if>
      </xsl:for-each>      
      
      <xsl:for-each select= "marc:datafield[@tag = '651']">
      <xsl:if test="marc:subfield[@code='a'] or marc:subfield[@code='v'] or marc:subfield[@code='x'] or marc:subfield[@code='z'] or marc:subfield[@code='y'] or marc:subfield[@code='2']">
       <datafield tag="607">
        <xsl:attribute name="ind1"><xsl:value-of select="@ind1"/></xsl:attribute>
        <xsl:attribute name="ind2"><xsl:value-of select="@ind2"/></xsl:attribute>
        <xsl:call-template name="convertSubjectHeading">
         <xsl:with-param name="ind" select="@ind2"/>
        </xsl:call-template>
        <!--<xsl:for-each select= "marc:subfield[@code = 'a']">
         <subfield code="a"><xsl:value-of select="substring-before(text(), ', ')"/></subfield>
         <subfield code="b"><xsl:value-of select="substring-after(text(), ', ')"/></subfield>
        </xsl:for-each>-->
        <xsl:for-each select= "marc:subfield[@code = 'a']"><subfield code="a"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'v']"><subfield code="j"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'x']"><subfield code="x"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'z']"><subfield code="y"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'y']"><subfield code="z"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = '2']"><subfield code="2"><xsl:value-of select="text()"/></subfield></xsl:for-each>
       </datafield>
      </xsl:if>
      </xsl:for-each>
      
      <xsl:for-each select= "marc:datafield[@tag = '655']">
      <xsl:if test="marc:subfield[@code='a'] or marc:subfield[@code='v'] or marc:subfield[@code='x'] or marc:subfield[@code='z'] or marc:subfield[@code='y'] or marc:subfield[@code='2'] or marc:subfield[@code='0'] or marc:subfield[@code='5']">
       <datafield tag="608">
        <xsl:attribute name="ind1"><xsl:value-of select="@ind1"/></xsl:attribute>
        <xsl:attribute name="ind2"><xsl:value-of select="@ind2"/></xsl:attribute>
        <!-- $a Genre/form data or focus term > $a Початковий елемент заголовку -->
        <xsl:for-each select= "marc:subfield[@code = 'a']"><subfield code="a"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <!-- $v Form subdivision > $j Формальний підзаголовок -->
        <xsl:for-each select= "marc:subfield[@code = 'v']"><subfield code="j"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <!-- $x General subdivision > $x Тематичний підзаголовок -->
        <xsl:for-each select= "marc:subfield[@code = 'x']"><subfield code="x"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <!-- $z Geographic subdivision > $y Географічний підзаголовок -->
        <xsl:for-each select= "marc:subfield[@code = 'z']"><subfield code="y"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <!-- $y Chronological subdivision > $z Хронологічний підзаголовок  --> 
        <xsl:for-each select= "marc:subfield[@code = 'y']"><subfield code="z"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <!-- $2 Source of term > $2 Код системи -->
        <xsl:for-each select= "marc:subfield[@code = '2']"><subfield code="2"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <!-- $0 Authority record control number or standard number > $3 Номер авторитетного запису  -->
        <xsl:for-each select= "marc:subfield[@code = '0']"><subfield code="3"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <!-- $5 Institution to which field applies > $5 Організація, до якої застосовується поле  -->
        <xsl:for-each select= "marc:subfield[@code = '5']"><subfield code="5"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <!-- $b Non-focus term > ? -->
        <!-- $c Facet/hierarchy designation > ? -->
        <!-- $1 Real World Object URI > ? -->
        <!-- $3 Materials specified > ?  -->
        <!-- $6 Linkage > ?  -->
        <!-- $8 Field link and sequence number > ? -->
        <!-- ? > $9 Визначення локальної системи -->
       </datafield>
      </xsl:if>
      </xsl:for-each>
      
      <xsl:for-each select= "marc:datafield[@tag = '653']">
      <xsl:if test="marc:subfield[@code='a']">
       <datafield tag="610">
        <xsl:attribute name="ind1"><xsl:value-of select="@ind1"/></xsl:attribute>
        <xsl:attribute name="ind2"><xsl:value-of select="@ind2"/></xsl:attribute>
        <xsl:for-each select= "marc:subfield[@code = 'a']"><subfield code="a"><xsl:value-of select="text()"/></subfield></xsl:for-each>
       </datafield>
      </xsl:if>
      </xsl:for-each>

      <xsl:for-each select= "marc:datafield[@tag = '752']">
      <xsl:if test="marc:subfield[@code='a'] or marc:subfield[@code='b'] or marc:subfield[@code='c'] or marc:subfield[@code='d']">
       <datafield tag="620" ind1=" " ind2=" ">
        <xsl:for-each select= "marc:subfield[@code = 'a']"><subfield code="a"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'b']"><subfield code="b"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'c']"><subfield code="c"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'd']"><subfield code="d"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <!-- <xsl:for-each select="subfield"><subfield code="@code"><xsl:value-of select="text()"/></subfield></xsl:for-each> -->
       </datafield>
      </xsl:if>
      </xsl:for-each>

      <xsl:for-each select= "marc:datafield[@tag = '753']">
      <xsl:if test="marc:subfield[@code='a'] or marc:subfield[@code='b'] or marc:subfield[@code='c']">
       <datafield tag="626" ind1=" " ind2=" ">
        <xsl:for-each select= "marc:subfield[@code = 'a']"><subfield code="a"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'b']"><subfield code="b"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'c']"><subfield code="c"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <!-- <xsl:for-each select="subfield"><subfield code="@code"><xsl:value-of select="text()"/></subfield></xsl:for-each> -->
       </datafield>
      </xsl:if>
      </xsl:for-each>

      <xsl:for-each select= "marc:datafield[@tag = '095']">
      <xsl:if test="marc:subfield[@code='a']">
       <datafield tag="629">
        <xsl:attribute name="ind1"><xsl:value-of select="@ind1"/></xsl:attribute>
        <xsl:attribute name="ind2"><xsl:value-of select="@ind2"/></xsl:attribute>
        <xsl:for-each select= "marc:subfield[@code = 'a']"><subfield code="a"><xsl:value-of select="text()"/></subfield></xsl:for-each>
       </datafield>
      </xsl:if>
      </xsl:for-each>      

      <xsl:for-each select= "marc:datafield[@tag = '043']">
      <xsl:if test="marc:subfield[@code='a']">
       <datafield tag="660">
        <xsl:attribute name="ind1"><xsl:value-of select="' '"/></xsl:attribute>
        <xsl:attribute name="ind2"><xsl:value-of select="' '"/></xsl:attribute>
        <xsl:for-each select= "marc:subfield[@code = 'a']"><subfield code="a"><xsl:value-of select="text()"/></subfield></xsl:for-each>
       </datafield>
      </xsl:if>
      </xsl:for-each>

      <xsl:for-each select= "marc:datafield[@tag = '045']">
      <xsl:if test="marc:subfield[@code='a']">
       <datafield tag="661">
        <xsl:attribute name="ind1"><xsl:value-of select="' '"/></xsl:attribute>
        <xsl:attribute name="ind2"><xsl:value-of select="' '"/></xsl:attribute>
        <xsl:for-each select= "marc:subfield[@code = 'a']"><subfield code="a"><xsl:value-of select="text()"/></subfield></xsl:for-each>
       </datafield>
      </xsl:if>
      </xsl:for-each>

      <xsl:for-each select= "marc:datafield[@tag = '886']">
      <xsl:if test="marc:subfield[@code='a'] or marc:subfield[@code='b'] or marc:subfield[@code='2']">
       <datafield tag="670">
        <xsl:attribute name="ind1"><xsl:value-of select="' '"/></xsl:attribute>
        <xsl:attribute name="ind2"><xsl:value-of select="' '"/></xsl:attribute>
        <xsl:for-each select= "marc:subfield[@code = 'a']"><subfield code="b"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'b']"><subfield code="c"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = '2']"><subfield code="d"><xsl:value-of select="text()"/></subfield></xsl:for-each>
       </datafield>
      </xsl:if>
      </xsl:for-each>

      <xsl:for-each select= "marc:datafield[@tag = '080']">
      <xsl:if test="marc:subfield[@code='a']">
       <datafield tag="675">
        <xsl:attribute name="ind1"><xsl:value-of select="' '"/></xsl:attribute>
        <xsl:attribute name="ind2"><xsl:value-of select="' '"/></xsl:attribute>
        <xsl:for-each select= "marc:subfield[@code = 'a']"><subfield code="a"><xsl:value-of select="text()"/></subfield></xsl:for-each>
       </datafield>
      </xsl:if>
      </xsl:for-each>

      <xsl:for-each select= "marc:datafield[@tag = '082']">
      <xsl:if test="marc:subfield[@code='a'] or marc:subfield[@code='2']">
       <datafield tag="676">
        <xsl:attribute name="ind1"><xsl:value-of select="' '"/></xsl:attribute>
        <xsl:attribute name="ind2"><xsl:value-of select="' '"/></xsl:attribute>
        <xsl:for-each select= "marc:subfield[@code = 'a']"><subfield code="a"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = '2']"><subfield code="v"><xsl:value-of select="text()"/></subfield></xsl:for-each>
       </datafield>
      </xsl:if>
      </xsl:for-each>

      <xsl:for-each select= "marc:datafield[@tag = '050']">
      <xsl:if test="marc:subfield[@code='a'] or marc:subfield[@code='b']">
       <datafield tag="680">
        <xsl:attribute name="ind1"><xsl:value-of select="' '"/></xsl:attribute>
        <xsl:attribute name="ind2"><xsl:value-of select="' '"/></xsl:attribute>
        <xsl:for-each select= "marc:subfield[@code = 'a']"><subfield code="a"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'b']"><subfield code="b"><xsl:value-of select="text()"/></subfield></xsl:for-each>
       </datafield>
      </xsl:if>
      </xsl:for-each>

      <xsl:for-each select= "marc:datafield[@tag = '084']">
      <xsl:if test="marc:subfield[@code='a'] or marc:subfield[@code='b'] or marc:subfield[@code='2']">
       <datafield tag="686" ind1=" " ind2=" ">
        <xsl:for-each select= "marc:subfield[@code = 'a']"><subfield code="a"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'b']"><subfield code="b"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = '2']"><subfield code="2"><xsl:value-of select="text()"/></subfield></xsl:for-each>
       </datafield>
      </xsl:if>
      </xsl:for-each>
      
      <xsl:if test="marc:datafield[@tag='100']/marc:subfield[@code='a'] or marc:datafield[@tag='100']/marc:subfield[@code='b'] or marc:datafield[@tag='100']/marc:subfield[@code='c'] or marc:datafield[@tag='100']/marc:subfield[@code='d'] or marc:datafield[@tag='100']/marc:subfield[@code='q'] or marc:datafield[@tag='100']/marc:subfield[@code='u'] or marc:datafield[@tag='100']/marc:subfield[@code='4']">
      <xsl:for-each select= "marc:datafield[@tag = '100']">
       <xsl:choose>
        <xsl:when test="@ind1 != 3" >
         <datafield tag="700" ind1=" ">
          <xsl:call-template name="convertPersonalNameSubfields">
           <xsl:with-param name="field" select="."/>
          </xsl:call-template>
         </datafield>
        </xsl:when>
       </xsl:choose>
      </xsl:for-each>
      </xsl:if>

      <xsl:if test="marc:datafield[@tag='700']/marc:subfield[@code='a'] or marc:datafield[@tag='700']/marc:subfield[@code='b'] or marc:datafield[@tag='700']/marc:subfield[@code='c'] or marc:datafield[@tag='700']/marc:subfield[@code='d'] or marc:datafield[@tag='700']/marc:subfield[@code='q'] or marc:datafield[@tag='700']/marc:subfield[@code='u'] or marc:datafield[@tag='700']/marc:subfield[@code='4']">
      <xsl:for-each select= "marc:datafield[@tag = '700']">
       <xsl:choose>
        <xsl:when test="@ind1 != 3" >
         <datafield tag="701" ind1=" ">
          <xsl:call-template name="convertPersonalNameSubfields">
           <xsl:with-param name="field" select="."/>
          </xsl:call-template>
         </datafield>
        </xsl:when>
       </xsl:choose>
      </xsl:for-each>
      </xsl:if>

      <xsl:for-each select= "marc:datafield[@tag = '110']">
       <datafield tag="710" ind1="0" ind2="{@ind1}">
        <xsl:for-each select= "marc:subfield[@code = 'a']"><subfield code="a"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'b']"><subfield code="b"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'n']"><subfield code="d"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'c']"><subfield code="e"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'd']"><subfield code="f"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'e']"><subfield code="j"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'u']"><subfield code="p"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = '4']"><subfield code="4"><xsl:call-template name="getRelCode"><xsl:with-param name="field" select="text()"/></xsl:call-template></subfield></xsl:for-each>
       </datafield>
      </xsl:for-each>

      <xsl:for-each select= "marc:datafield[@tag = '111']">
       <datafield tag="710" ind1="1" ind2="{@ind1}">
        <xsl:for-each select= "marc:subfield[@code = 'a']"><subfield code="a"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'e']"><subfield code="b"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'n']"><subfield code="d"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'c']"><subfield code="e"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'd']"><subfield code="f"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'e']"><subfield code="j"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'u']"><subfield code="p"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = '4']"><subfield code="4"><xsl:call-template name="getRelCode"><xsl:with-param name="field" select="text()"/></xsl:call-template></subfield></xsl:for-each>
       </datafield>
      </xsl:for-each>

      <xsl:for-each select= "marc:datafield[@tag = '710']">
       <datafield tag="711" ind1="0" ind2="{@ind1}">
        <xsl:for-each select= "marc:subfield[@code = 'a']"><subfield code="a"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'b']"><subfield code="b"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'n']"><subfield code="d"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'c']"><subfield code="e"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'd']"><subfield code="f"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'e']"><subfield code="j"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'u']"><subfield code="p"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = '4']"><subfield code="4"><xsl:call-template name="getRelCode"><xsl:with-param name="field" select="text()"/></xsl:call-template></subfield></xsl:for-each>
       </datafield>
      </xsl:for-each>

      <xsl:for-each select= "marc:datafield[@tag = '711']">
       <datafield tag="711" ind1="1" ind2="{@ind1}">
        <xsl:for-each select= "marc:subfield[@code = 'a']"><subfield code="a"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'e']"><subfield code="b"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'n']"><subfield code="d"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'c']"><subfield code="e"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'd']"><subfield code="f"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'e']"><subfield code="j"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'u']"><subfield code="p"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = '4']"><subfield code="4"><xsl:call-template name="getRelCode"><xsl:with-param name="field" select="text()"/></xsl:call-template></subfield></xsl:for-each>
       </datafield>
      </xsl:for-each>

      <xsl:for-each select= "marc:datafield[@tag = '100']">
       <xsl:choose>
        <xsl:when test="@ind1 = 3" >
         <datafield tag="720" ind1=" " ind2=" ">
          <xsl:for-each select= "marc:subfield[@code = 'a']"><subfield code="a"><xsl:value-of select="text()"/></subfield></xsl:for-each>
          <xsl:for-each select= "marc:subfield[@code = 'd']"><subfield code="f"><xsl:value-of select="text()"/></subfield></xsl:for-each>
          <xsl:for-each select= "marc:subfield[@code = 'e']"><subfield code="j"><xsl:value-of select="text()"/></subfield></xsl:for-each>
          <xsl:for-each select= "marc:subfield[@code = '4']"><subfield code="4"><xsl:call-template name="getRelCode"><xsl:with-param name="field" select="text()"/></xsl:call-template></subfield></xsl:for-each>
         </datafield>
        </xsl:when>
       </xsl:choose>
      </xsl:for-each>

      <xsl:for-each select= "marc:datafield[@tag = '700']">
       <xsl:choose>
        <xsl:when test="@ind1 = 3" >
         <datafield tag="721" ind1=" " ind2=" ">
          <xsl:for-each select= "marc:subfield[@code = 'a']"><subfield code="a"><xsl:value-of select="text()"/></subfield></xsl:for-each>
          <xsl:for-each select= "marc:subfield[@code = 'd']"><subfield code="f"><xsl:value-of select="text()"/></subfield></xsl:for-each>
          <xsl:for-each select= "marc:subfield[@code = 'e']"><subfield code="j"><xsl:value-of select="text()"/></subfield></xsl:for-each>
          <xsl:for-each select= "marc:subfield[@code = '4']"><subfield code="4"><xsl:call-template name="getRelCode"><xsl:with-param name="field" select="text()"/></xsl:call-template></subfield></xsl:for-each>
         </datafield>
        </xsl:when>
       </xsl:choose>
      </xsl:for-each>

      <xsl:if test="marc:datafield[@tag='040']/marc:subfield[@code='a'] or 
                    marc:datafield[@tag='040']/marc:subfield[@code='c'] or 
                    marc:datafield[@tag='040']/marc:subfield[@code='d'] or 
                    marc:datafield[@tag='040']/marc:subfield[@code='e']">
      <!-- or marc:controlfield[@tag='003'] -->
      <xsl:for-each select= "marc:datafield[@tag = '040']">
       <xsl:variable name="f040e" select="marc:subfield[@code='e']"/>
       <xsl:for-each select= "marc:subfield[@code = 'a']">
         <datafield tag="801" ind1=" " ind2="0">
         <xsl:variable name="CountryFromMarcOrgCode"><xsl:call-template name="getCountryFromMarcOrgCode"><xsl:with-param name="marcOrgCode" select="text()"/></xsl:call-template></xsl:variable>
         <xsl:if test="$CountryFromMarcOrgCode and string-length($CountryFromMarcOrgCode) > 0"><subfield code="a"><xsl:value-of select="$CountryFromMarcOrgCode"/></subfield></xsl:if>
         <subfield code="b"><xsl:value-of select="text()"/></subfield>
         <xsl:if test="$f040e"><subfield code="g"><xsl:value-of select="$f040e"/></subfield></xsl:if>
         </datafield>
       </xsl:for-each>
       <xsl:for-each select= "marc:subfield[@code = 'c']">
         <datafield tag="801" ind1=" " ind2="1">
         <xsl:variable name="CountryFromMarcOrgCode"><xsl:call-template name="getCountryFromMarcOrgCode"><xsl:with-param name="marcOrgCode" select="text()"/></xsl:call-template></xsl:variable>
         <xsl:if test="$CountryFromMarcOrgCode and string-length($CountryFromMarcOrgCode) > 0"><subfield code="a"><xsl:value-of select="$CountryFromMarcOrgCode"/></subfield></xsl:if>
         <subfield code="b"><xsl:value-of select="text()"/></subfield>
         <xsl:if test="$f040e"><subfield code="g"><xsl:value-of select="$f040e"/></subfield></xsl:if>
         </datafield>
       </xsl:for-each>
       <xsl:for-each select= "marc:subfield[@code = 'd']">
         <datafield tag="801" ind1=" " ind2="2">
         <xsl:variable name="CountryFromMarcOrgCode"><xsl:call-template name="getCountryFromMarcOrgCode"><xsl:with-param name="marcOrgCode" select="text()"/></xsl:call-template></xsl:variable>
         <xsl:if test="$CountryFromMarcOrgCode and string-length($CountryFromMarcOrgCode) > 0"><subfield code="a"><xsl:value-of select="$CountryFromMarcOrgCode"/></subfield></xsl:if>
         <subfield code="b"><xsl:value-of select="text()"/></subfield>
         <xsl:if test="$f040e"><subfield code="g"><xsl:value-of select="$f040e"/></subfield></xsl:if>
         </datafield>
       </xsl:for-each>
       <!-- <xsl:for-each select= "marc:subfield[@code = 'e']"><subfield code="g"><xsl:value-of select="text()"/></subfield></xsl:for-each>  -->
      </xsl:for-each>
      </xsl:if>
      
      <xsl:for-each select="marc:controlfield[@tag = '008']">
       <xsl:choose>
        <xsl:when test="substring(../leader, 8, 1) = 's'">
         <datafield tag="802">
          <xsl:attribute name="ind1"><xsl:value-of select="' '"/></xsl:attribute>
          <xsl:attribute name="ind2"><xsl:value-of select="' '"/></xsl:attribute>
          <subfield code="a">
           <xsl:choose>
            <xsl:when test="substring(text(), 21, 1) = '0'">00</xsl:when>
            <xsl:when test="substring(text(), 21, 1) = '1'">01</xsl:when>
            <xsl:when test="substring(text(), 21, 1) = '4'">04</xsl:when>
            <xsl:when test="substring(text(), 21, 1) = '#'">uu</xsl:when>
            <xsl:when test="substring(text(), 21, 1) = 'z'">zz</xsl:when>
            <xsl:otherwise>zz</xsl:otherwise>
           </xsl:choose>
          </subfield>
         </datafield>
        </xsl:when>
       </xsl:choose>
      </xsl:for-each>

      <!-- 090 > 852-->
      <!-- <xsl:if test="marc:datafield[@tag='090']/marc:subfield[@code='a'] or marc:datafield[@tag='090']/marc:subfield[@code='b'] or marc:datafield[@tag='090']/marc:subfield[@code='x']"> -->
      <xsl:if test="marc:datafield[@tag='090']/marc:subfield[@code='a']">
      <xsl:for-each select= "marc:datafield[@tag = '090']">
       <datafield tag="852" ind1=" " ind2=" ">
        <xsl:for-each select= "marc:subfield[@code = 'a']"><subfield code="j"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <!--<xsl:for-each select= "marc:subfield[@code = 'x']"><subfield code="i"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'b']"><subfield code="i"><xsl:value-of select="text()"/></subfield></xsl:for-each> -->
       </datafield>
      </xsl:for-each>
      </xsl:if>
      
      <!-- 090 > 942 Koha-->
      <xsl:if test="marc:datafield[@tag='090']/marc:subfield[@code='a'] or 
                    marc:datafield[@tag='090']/marc:subfield[@code='b'] or 
                    marc:datafield[@tag='090']/marc:subfield[@code='x']">
      <xsl:for-each select= "marc:datafield[@tag = '090']">
       <datafield tag="942" ind1=" " ind2=" ">
        <xsl:for-each select= "marc:subfield[@code = 'a']"><subfield code="j"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'x']"><subfield code="v"><xsl:value-of select="text()"/></subfield></xsl:for-each>
        <xsl:for-each select= "marc:subfield[@code = 'b']"><subfield code="v"><xsl:value-of select="text()"/></subfield></xsl:for-each>
       </datafield>
      </xsl:for-each>
      </xsl:if>
      
      <xsl:call-template name="datafield856" />
      
      <xsl:for-each select= "marc:datafield[@tag = '830']">
       <datafield tag="886" ind1="2" ind2=" ">
        <subfield code="2">usmarc</subfield>
        <subfield code="a">830</subfield>
        <xsl:variable name="b">
         <xsl:value-of select="concat(@ind1,@ind2)"/>
         <xsl:for-each select= "marc:subfield">
          <xsl:value-of select="concat('$',@code,text())"/>
         </xsl:for-each>
        </xsl:variable>
        <subfield code='b'><xsl:value-of select="$b"/></subfield>
       </datafield>
      </xsl:for-each>
      
      <xsl:for-each select= "marc:datafield[@tag = '515']">
       <datafield tag="886" ind1="2" ind2=" ">
        <subfield code="2">usmarc</subfield>
        <subfield code="a">515</subfield>
        <xsl:variable name="b">
         <xsl:value-of select="concat(@ind1,@ind2)"/>
         <xsl:for-each select= "marc:subfield">
          <xsl:value-of select="concat('$',@code,text())"/>
         </xsl:for-each>
        </xsl:variable>
        <subfield code='b'><xsl:value-of select="$b"/></subfield>
       </datafield>
      </xsl:for-each>
      
      <xsl:for-each select= "marc:datafield[@tag = '530']">
       <datafield tag="886" ind1="2" ind2=" ">
        <subfield code="2">usmarc</subfield>
        <subfield code="a">530</subfield>
        <xsl:variable name="b">
         <xsl:value-of select="concat(@ind1,@ind2)"/>
         <xsl:for-each select= "marc:subfield">
          <xsl:value-of select="concat('$',@code,text())"/>
         </xsl:for-each>
        </xsl:variable>
        <subfield code='b'><xsl:value-of select="$b"/></subfield>
       </datafield>
      </xsl:for-each>

      <xsl:for-each select= "marc:datafield[@tag = '550']">
       <datafield tag="886" ind1="2" ind2=" ">
        <subfield code="2">usmarc</subfield>
        <subfield code="a">550</subfield>
        <xsl:variable name="b">
         <xsl:value-of select="concat(@ind1,@ind2)"/>
         <xsl:for-each select= "marc:subfield">
          <xsl:value-of select="concat('$',@code,text())"/>
         </xsl:for-each>
        </xsl:variable>
        <subfield code='b'><xsl:value-of select="$b"/></subfield>
       </datafield>
      </xsl:for-each>
            
      <xsl:if test="marc:datafield[@tag='590']/marc:subfield[@code='a']">
      <xsl:for-each select= "marc:datafield[@tag = '590']">
       <datafield tag="900">
        <xsl:attribute name="ind1"><xsl:value-of select="@ind1"/></xsl:attribute>
        <xsl:attribute name="ind2"><xsl:value-of select="@ind2"/></xsl:attribute>
        <xsl:for-each select= "marc:subfield[@code = 'a']"><subfield code="a"><xsl:value-of select="text()"/></subfield></xsl:for-each>
       </datafield>
      </xsl:for-each>
      </xsl:if>
      
      <!-- 942 Додаткові дані (Коха) -->
      <xsl:for-each select="marc:datafield[@tag='942']">
      <xsl:if test="marc:subfield[@code = '2'] or
                    marc:subfield[@code = 'c'] or
                    marc:subfield[@code = 's']">
      <datafield tag="{'942'}">
      <!-- ind1 Undefined -->
      <xsl:attribute name="ind1"><xsl:value-of select="@ind1"/></xsl:attribute>
      <!-- ind1 Undefined -->
      <xsl:attribute name="ind2"><xsl:value-of select="@ind2"/></xsl:attribute>
      <!-- 942^2 «« 942^2 Код системи класифікації для розстановки фонду -->
      <xsl:for-each select="marc:subfield[@code = '2']"><xsl:if test="text() and string-length(text()) > 0"><subfield code="2"><xsl:value-of select="text()"/></subfield></xsl:if></xsl:for-each>
      <!-- 942^c «« 942^c Тип одиниці (рівень запису) -->
      <xsl:for-each select="marc:subfield[@code = 'c']"><xsl:if test="text() and string-length(text()) > 0"><subfield code="c"><xsl:value-of select="text()"/></subfield></xsl:if></xsl:for-each>
      <!-- 942^s «« 942^s Позначка про запис серіального видання -->
      <xsl:for-each select="marc:subfield[@code = 's']"><xsl:if test="text() and string-length(text()) > 0"><subfield code="s"><xsl:value-of select="text()"/></subfield></xsl:if></xsl:for-each>
      </datafield>
      </xsl:if>
      </xsl:for-each>
      
      <!-- 952 Дані про примірники та розташування (Koha) -->
      <xsl:for-each select="marc:datafield[@tag='952']">
      <xsl:if test="marc:subfield[@code = '0'] or
          marc:subfield[@code = '1'] or
          marc:subfield[@code = '2'] or
          marc:subfield[@code = '4'] or
          marc:subfield[@code = '7'] or
          marc:subfield[@code = '8'] or
          marc:subfield[@code = 'a'] or
          marc:subfield[@code = 'b'] or
          marc:subfield[@code = 'd'] or
          marc:subfield[@code = 'e'] or
          marc:subfield[@code = 'g'] or
          marc:subfield[@code = 'h'] or
          marc:subfield[@code = 'i'] or
          marc:subfield[@code = 'o'] or
          marc:subfield[@code = 'p'] or
          marc:subfield[@code = 'q'] or
          marc:subfield[@code = 'r'] or
          marc:subfield[@code = 's'] or
          marc:subfield[@code = 'u'] or
          marc:subfield[@code = 'w'] or
          marc:subfield[@code = 'y'] or
          marc:subfield[@code = 'z']">
          <!--
          marc:subfield[@code = 'l'] or
          marc:subfield[@code = 'm'] or
          
          -->
      <datafield tag="{'995'}">
      <!-- ind1 Undefined -->
      <xsl:attribute name="ind1"><xsl:value-of select="@ind1"/></xsl:attribute>
      <!-- ind1 Undefined -->
      <xsl:attribute name="ind2"><xsl:value-of select="@ind2"/></xsl:attribute>
      <!-- 995^0 «« 952^0 Статус вилучення -->
      <xsl:for-each select="marc:subfield[@code = '0']"><xsl:if test="text() and string-length(text()) > 0"><subfield code="0"><xsl:value-of select="text()"/></subfield></xsl:if></xsl:for-each>
      <!-- 995^1 «« 952^4 Стан пошкодження -->
      <xsl:for-each select="marc:subfield[@code = '4']"><xsl:if test="text() and string-length(text()) > 0"><subfield code="1"><xsl:value-of select="text()"/></subfield></xsl:if></xsl:for-each>
      <!-- 995^2 «« 952^1 Статус втрати/відсутності -->
      <xsl:for-each select="marc:subfield[@code = '1']"><xsl:if test="text() and string-length(text()) > 0"><subfield code="2"><xsl:value-of select="text()"/></subfield></xsl:if></xsl:for-each>
      <!-- 995^4 «« 952^2 Джерело класифікації чи схема поличного розташування -->
      <xsl:for-each select="marc:subfield[@code = '2']"><xsl:if test="text() and string-length(text()) > 0"><subfield code="4"><xsl:value-of select="text()"/></subfield></xsl:if></xsl:for-each>
      <!-- 7 	Уніфікований ідентифікатор ресурсів «« 952^u -->
      <xsl:for-each select="marc:subfield[@code = 'u']"><xsl:if test="text() and string-length(text()) > 0"><subfield code="7"><xsl:value-of select="text()"/></subfield></xsl:if></xsl:for-each>
      <!-- 995^o «« 952^7 Тип обігу (не для випожичання) -->
      <xsl:for-each select="marc:subfield[@code = '7']"><xsl:if test="text() and string-length(text()) > 0"><subfield code="o"><xsl:value-of select="text()"/></subfield></xsl:if></xsl:for-each>
      <!-- 995^h «« 952^8 Вид зібрання -->
      <xsl:for-each select="marc:subfield[@code = '8']"><xsl:if test="text() and string-length(text()) > 0"><subfield code="h"><xsl:value-of select="text()"/></subfield></xsl:if></xsl:for-each>
      <!-- 995^b «« 952^a Джерельне місце зберігання примірника (домашній підрозділ) -->
      <xsl:for-each select="marc:subfield[@code = 'a']"><xsl:if test="text() and string-length(text()) > 0"><subfield code="b"><xsl:value-of select="text()"/></subfield></xsl:if></xsl:for-each>
      <!-- 995^c «« 952^b Місце тимчасового зберігання чи видачі (підрозділ зберігання) -->
      <xsl:for-each select="marc:subfield[@code = 'b']"><xsl:if test="text() and string-length(text()) > 0"><subfield code="c"><xsl:value-of select="text()"/></subfield></xsl:if></xsl:for-each>
      <!-- 995^5 «« 952^d Дата надходження -->
      <xsl:for-each select="marc:subfield[@code = 'd']"><xsl:if test="text() and string-length(text()) > 0"><subfield code="5"><xsl:value-of select="text()"/></subfield></xsl:if></xsl:for-each>
      <!-- 995^s «« 952^e Джерело надходження (постачальник) -->
      <xsl:for-each select="marc:subfield[@code = 'e']"><xsl:if test="text() and string-length(text()) > 0"><subfield code="s"><xsl:value-of select="text()"/></subfield></xsl:if></xsl:for-each>
      <!-- 995^p «« 952^g Вартість, звичайна закупівельна ціна -->
      <xsl:for-each select="marc:subfield[@code = 'g']"><xsl:if test="text() and string-length(text()) > 0"><subfield code="p"><xsl:value-of select="text()"/></subfield></xsl:if></xsl:for-each>
      <!-- 995^v «« 952^h Нумерування/хронологія серіальних видань -->
      <xsl:for-each select="marc:subfield[@code = 'h']"><xsl:if test="text() and string-length(text()) > 0"><subfield code="v"><xsl:value-of select="text()"/></subfield></xsl:if></xsl:for-each>
      <!-- 995^j «« 952^i Інвентарний номер -->
      <xsl:for-each select="marc:subfield[@code = 'i']"><xsl:if test="text() and string-length(text()) > 0"><subfield code="j"><xsl:value-of select="text()"/></subfield></xsl:if></xsl:for-each>
      
      <!-- 995^? «« 952^l Видач загалом -->
      <!-- <xsl:for-each select="marc:subfield[@code = 'l']"><xsl:if test="text() and string-length(text()) > 0"><subfield code="l"><xsl:value-of select="text()"/></subfield></xsl:if></xsl:for-each> -->
      <!-- 995^? «« 952^m Продовжень загалом -->
      <!-- <xsl:for-each select="marc:subfield[@code = 'm']"><xsl:if test="text() and string-length(text()) > 0"><subfield code="m"><xsl:value-of select="text()"/></subfield></xsl:if></xsl:for-each> -->
      
      <!-- 995^k «« 952^o Повний (примірниковий) шифр збереження -->
      <xsl:for-each select="marc:subfield[@code = 'o']"><xsl:if test="text() and string-length(text()) > 0"><subfield code="k"><xsl:value-of select="text()"/></subfield></xsl:if></xsl:for-each>
      <!-- 995^f «« 952^p Штрих-код -->
      <xsl:for-each select="marc:subfield[@code = 'p']"><xsl:if test="text() and string-length(text()) > 0"><subfield code="f"><xsl:value-of select="text()"/></subfield></xsl:if></xsl:for-each>
      <!-- 995^n «« 952^q Дата завершення терміну випожичання -->
      <xsl:for-each select="marc:subfield[@code = 'q']"><xsl:if test="text() and string-length(text()) > 0"><subfield code="n"><xsl:value-of select="text()"/></subfield></xsl:if></xsl:for-each>
      <!-- 995^i «« 952^r Дата, коли останній раз бачено примірник -->
      <xsl:for-each select="marc:subfield[@code = 'r']"><xsl:if test="text() and string-length(text()) > 0"><subfield code="i"><xsl:value-of select="text()"/></subfield></xsl:if></xsl:for-each>
      <!-- 995^m «« 952^s Дата останнього випожичання чи повернення -->
      <xsl:for-each select="marc:subfield[@code = 's']"><xsl:if test="text() and string-length(text()) > 0"><subfield code="m"><xsl:value-of select="text()"/></subfield></xsl:if></xsl:for-each>

      <!-- 995^W «« 952^w Дата, для якої чинна ціна заміни -->
      <xsl:for-each select="marc:subfield[@code = 'w']"><xsl:if test="text() and string-length(text()) > 0"><subfield code="W"><xsl:value-of select="text()"/></subfield></xsl:if></xsl:for-each> 

      <!-- 995^r «« 952^y Тип одиниці (рівень примірника) -->
      <xsl:for-each select="marc:subfield[@code = 'y']"><xsl:if test="text() and string-length(text()) > 0"><subfield code="r"><xsl:value-of select="text()"/></subfield></xsl:if></xsl:for-each>
      <!-- 995^u «« 952^z Загальнодоступна примітка щодо примірника -->
      <xsl:for-each select="marc:subfield[@code = 'z']"><xsl:if test="text() and string-length(text()) > 0"><subfield code="u"><xsl:value-of select="text()"/></subfield></xsl:if></xsl:for-each>
      </datafield>
      </xsl:if>
      </xsl:for-each>
      
      <xsl:call-template name="selects">
       <xsl:with-param name="i">900</xsl:with-param>
       <xsl:with-param name="count">1000</xsl:with-param>
      </xsl:call-template>
      

 </xsl:template>

  <xsl:template name="transform-leader">
    <xsl:variable name="leader" select="leader"/>
        <!-- To calculate, but how? -->
        <xsl:variable name="recordLenght">00000</xsl:variable>

        <xsl:variable name="recordStatus">
         <xsl:choose>
          <xsl:when test="substring($leader, 6, 1) = 'a'">c</xsl:when>
          <xsl:when test="substring($leader, 6, 1) = 'p'">c</xsl:when>
          <xsl:otherwise>
           <xsl:choose>
            <xsl:when test="substring($leader, 6, 1)"><xsl:value-of select="substring($leader, 6, 1)"/></xsl:when>
            <xsl:otherwise><xsl:value-of select="' '"/></xsl:otherwise>
           </xsl:choose>
          </xsl:otherwise>
         </xsl:choose>
        </xsl:variable>

        <xsl:variable name="recordType">
         <xsl:choose>
          <xsl:when test="substring($leader, 7, 1) = 'o'">m</xsl:when>
          <xsl:when test="substring($leader, 7, 1) = 'p'">m</xsl:when>
          <xsl:when test="substring($leader, 7, 1) = 't'">b</xsl:when>
          <xsl:otherwise>
           <xsl:choose>
            <xsl:when test="substring($leader, 7, 1)"><xsl:value-of select="substring($leader, 7, 1)"/></xsl:when>
            <xsl:otherwise><xsl:value-of select="' '"/></xsl:otherwise>
           </xsl:choose>
          </xsl:otherwise>
         </xsl:choose>
        </xsl:variable>
        
        <xsl:variable name="bibLvl">
         <xsl:choose>
          <xsl:when test="substring($leader, 8, 1) = 'b'">a</xsl:when>
          <xsl:when test="substring($leader, 8, 1) = 'd'">a</xsl:when>
          <xsl:otherwise>
           <xsl:choose>
            <xsl:when test="substring($leader, 8, 1)"><xsl:value-of select="substring($leader, 8, 1)"/></xsl:when>
            <xsl:otherwise><xsl:value-of select="' '"/></xsl:otherwise>
           </xsl:choose>
          </xsl:otherwise>
         </xsl:choose>
        </xsl:variable>
        
        <xsl:variable name="controlType">
         <xsl:choose>
          <xsl:when test="substring($leader, 9, 1)"><xsl:value-of select="substring($leader, 9, 1)"/></xsl:when>
          <xsl:otherwise><xsl:value-of select="' '"/></xsl:otherwise>
         </xsl:choose>
        </xsl:variable>
        
        <!-- To calculate, but how? -->
        <xsl:variable name="baod">02200</xsl:variable>
        <xsl:variable name="encLvl">
         <xsl:choose>
          <xsl:when test="substring($leader, 18, 1) = '8'">2</xsl:when>
          <xsl:when test="substring($leader, 18, 1) = '5'">3</xsl:when>
          <xsl:when test="substring($leader, 18, 1) = '7'">3</xsl:when>
          <xsl:when test="substring($leader, 18, 1) = '2'">1</xsl:when>
          <xsl:when test="substring($leader, 18, 1) = '3'">1</xsl:when>
          <xsl:when test="substring($leader, 18, 1) = '4'">1</xsl:when>
          <xsl:otherwise>
           <xsl:choose>
            <xsl:when test="substring($leader, 18, 1)"><xsl:value-of select="substring($leader, 18, 1)"/></xsl:when>
            <xsl:otherwise><xsl:value-of select="' '"/></xsl:otherwise>
           </xsl:choose>
          </xsl:otherwise>
         </xsl:choose>
        </xsl:variable>
        <xsl:variable name="dcf">
         <xsl:choose>
          <xsl:when test="substring($leader, 19, 1) = ' '">n</xsl:when>
          <xsl:when test="substring($leader, 19, 1) = 'c'"> </xsl:when>
          <xsl:when test="substring($leader, 19, 1) = 'u'">i</xsl:when>
          <xsl:when test="substring($leader, 19, 1) = 'a'">n</xsl:when>
          <xsl:otherwise>
           <xsl:value-of select="' '"/>
          </xsl:otherwise>
         </xsl:choose>
        </xsl:variable>
       <leader>
        <xsl:value-of
         select="concat($recordLenght, $recordStatus, $recordType, $bibLvl, ' ', $controlType, '22', $baod, $encLvl, $dcf, ' 450 ')"
        />
       </leader>
  </xsl:template>
 
 <xsl:template name="convertPersonalNameSubfields">
  <xsl:param name="field"></xsl:param>
  <xsl:attribute name="ind2">
   <xsl:value-of select="@ind1"/>
  </xsl:attribute>
  <xsl:for-each select= "marc:subfield[@code = 'a']">
   <xsl:choose>
    <xsl:when test="contains(text(), ', ')">
     <subfield code="a"><xsl:value-of select="substring-before(text(), ', ')"/></subfield>
     <subfield code="b"><xsl:call-template name="removeEndAuthorPuctuation"><xsl:with-param name="text" select="substring-after(text(), ', ')"/></xsl:call-template></subfield>
    </xsl:when>
    <xsl:otherwise>
     <subfield code="a"><xsl:call-template name="removeEndAuthorPuctuation"><xsl:with-param name="text" select="text()"/></xsl:call-template></subfield>
    </xsl:otherwise>
   </xsl:choose>
  </xsl:for-each>
  <xsl:for-each select= "marc:subfield[@code = 'b']"><subfield code="d"><xsl:call-template name="removeEndAuthorPuctuation"><xsl:with-param name="text" select="text()"/></xsl:call-template></subfield></xsl:for-each>
  <xsl:for-each select= "marc:subfield[@code = 'c']"><subfield code="c"><xsl:value-of select="text()"/></subfield></xsl:for-each>
  <xsl:for-each select= "marc:subfield[@code = 'd']"><subfield code="f"><xsl:call-template name="removeEndAuthorPuctuation"><xsl:with-param name="text" select="text()"/></xsl:call-template></subfield></xsl:for-each>
  <xsl:for-each select= "marc:subfield[@code = 'e']"><subfield code="j"><xsl:value-of select="text()"/></subfield></xsl:for-each>
  <xsl:for-each select= "marc:subfield[@code = 'q']"><subfield code="g"><xsl:value-of select="text()"/></subfield></xsl:for-each>
  <xsl:for-each select= "marc:subfield[@code = 'u']"><subfield code="p"><xsl:value-of select="text()"/></subfield></xsl:for-each>
  <!--<xsl:for-each select= "marc:subfield[@code='?']"><subfield code="3"><xsl:value-of select="text()" /></subfield></xsl:for-each>-->
  <xsl:for-each select= "marc:subfield[@code = '4']"><subfield code="4"><xsl:call-template name="getRelCode"><xsl:with-param name="field" select="text()"/></xsl:call-template></subfield></xsl:for-each>
 </xsl:template>


 <xsl:template name="getRelCode">
  <xsl:param name="RelCode" select="text()" />
  <xsl:choose>
   <xsl:when test="$RelCode = 'act'"><xsl:value-of select="'005'"/></xsl:when>
   <xsl:when test="$RelCode = 'adp'"><xsl:value-of select="'010'"/></xsl:when>
   <xsl:when test="$RelCode = 'aft'"><xsl:value-of select="'075'"/></xsl:when>
   <xsl:when test="$RelCode = 'anm'"><xsl:value-of select="'018'"/></xsl:when>
   <xsl:when test="$RelCode = 'ann'"><xsl:value-of select="'020'"/></xsl:when>
   <xsl:when test="$RelCode = 'ant'"><xsl:value-of select="'100'"/></xsl:when>
   <xsl:when test="$RelCode = 'aqt'"><xsl:value-of select="'072'"/></xsl:when>
   <xsl:when test="$RelCode = 'arr'"><xsl:value-of select="'030'"/></xsl:when>
   <xsl:when test="$RelCode = 'art'"><xsl:value-of select="'040'"/></xsl:when>
   <xsl:when test="$RelCode = 'asg'"><xsl:value-of select="'050'"/></xsl:when>
   <xsl:when test="$RelCode = 'asn'"><xsl:value-of select="'060'"/></xsl:when>
   <xsl:when test="$RelCode = 'auc'"><xsl:value-of select="'065'"/></xsl:when>
   <xsl:when test="$RelCode = 'aud'"><xsl:value-of select="'090'"/></xsl:when>
   <xsl:when test="$RelCode = 'aui'"><xsl:value-of select="'080'"/></xsl:when>
   <xsl:when test="$RelCode = 'aut'"><xsl:value-of select="'070'"/></xsl:when>
   <xsl:when test="$RelCode = 'bdd'"><xsl:value-of select="'120'"/></xsl:when>
   <xsl:when test="$RelCode = 'bjd'"><xsl:value-of select="'140'"/></xsl:when>
   <xsl:when test="$RelCode = 'bkd'"><xsl:value-of select="'130'"/></xsl:when>
   <xsl:when test="$RelCode = 'bnd'"><xsl:value-of select="'110'"/></xsl:when>
   <xsl:when test="$RelCode = 'bpd'"><xsl:value-of select="'150'"/></xsl:when>
   <xsl:when test="$RelCode = 'bsl'"><xsl:value-of select="'160'"/></xsl:when>
   <xsl:when test="$RelCode = 'ccp'"><xsl:value-of select="'245'"/></xsl:when>
   <xsl:when test="$RelCode = 'chr'"><xsl:value-of select="'200'"/></xsl:when>
   <xsl:when test="$RelCode = 'clb'"><xsl:value-of select="'205'"/></xsl:when>
   <xsl:when test="$RelCode = 'cll'"><xsl:value-of select="'170'"/></xsl:when>
   <xsl:when test="$RelCode = 'cmm'"><xsl:value-of select="'210'"/></xsl:when>
   <xsl:when test="$RelCode = 'cmp'"><xsl:value-of select="'230'"/></xsl:when>
   <xsl:when test="$RelCode = 'cmt'"><xsl:value-of select="'240'"/></xsl:when>
   <xsl:when test="$RelCode = 'cnd'"><xsl:value-of select="'250'"/></xsl:when>
   <xsl:when test="$RelCode = 'cns'"><xsl:value-of select="'190'"/></xsl:when>
   <xsl:when test="$RelCode = 'cov'"><xsl:value-of select="'140'"/></xsl:when>
   <xsl:when test="$RelCode = 'com'"><xsl:value-of select="'220'"/></xsl:when>
   <xsl:when test="$RelCode = 'cph'"><xsl:value-of select="'260'"/></xsl:when>
   <xsl:when test="$RelCode = 'crr'"><xsl:value-of select="'270'"/></xsl:when>
   <xsl:when test="$RelCode = 'csp'"><xsl:value-of select="'255'"/></xsl:when>
   <xsl:when test="$RelCode = 'cst'"><xsl:value-of select="'633'"/></xsl:when>
   <xsl:when test="$RelCode = 'ctg'"><xsl:value-of select="'180'"/></xsl:when>
   <xsl:when test="$RelCode = 'cur'"><xsl:value-of select="'273'"/></xsl:when>
   <xsl:when test="$RelCode = 'cwt'"><xsl:value-of select="'212'"/></xsl:when>
   <xsl:when test="$RelCode = 'dgg'"><xsl:value-of select="'295'"/></xsl:when>
   <xsl:when test="$RelCode = 'dis'"><xsl:value-of select="'305'"/></xsl:when>
   <xsl:when test="$RelCode = 'dnc'"><xsl:value-of select="'275'"/></xsl:when>
   <xsl:when test="$RelCode = 'dnr'"><xsl:value-of select="'320'"/></xsl:when>
   <xsl:when test="$RelCode = 'drt'"><xsl:value-of select="'300'"/></xsl:when>
   <xsl:when test="$RelCode = 'dst'"><xsl:value-of select="'310'"/></xsl:when>
   <xsl:when test="$RelCode = 'dte'"><xsl:value-of select="'280'"/></xsl:when>
   <xsl:when test="$RelCode = 'dto'"><xsl:value-of select="'290'"/></xsl:when>
   <xsl:when test="$RelCode = 'dub'"><xsl:value-of select="'330'"/></xsl:when>
   <xsl:when test="$RelCode = 'edt'"><xsl:value-of select="'340'"/></xsl:when>
   <xsl:when test="$RelCode = 'egr'"><xsl:value-of select="'350'"/></xsl:when>
   <xsl:when test="$RelCode = 'etr'"><xsl:value-of select="'360'"/></xsl:when>
   <xsl:when test="$RelCode = 'exp'"><xsl:value-of select="'365'"/></xsl:when>
   <xsl:when test="$RelCode = 'flm'"><xsl:value-of select="'370'"/></xsl:when>
   <xsl:when test="$RelCode = 'fmo'"><xsl:value-of select="'390'"/></xsl:when>
   <xsl:when test="$RelCode = 'fnd'"><xsl:value-of select="'400'"/></xsl:when>
   <xsl:when test="$RelCode = 'frg'"><xsl:value-of select="'380'"/></xsl:when>
   <xsl:when test="$RelCode = 'hnr'"><xsl:value-of select="'420'"/></xsl:when>
   <xsl:when test="$RelCode = 'ill'"><xsl:value-of select="'440'"/></xsl:when>
   <xsl:when test="$RelCode = 'ilu'"><xsl:value-of select="'430'"/></xsl:when>
   <xsl:when test="$RelCode = 'ins'"><xsl:value-of select="'450'"/></xsl:when>
   <xsl:when test="$RelCode = 'inv'"><xsl:value-of select="'584'"/></xsl:when>
   <xsl:when test="$RelCode = 'itr'"><xsl:value-of select="'903'"/></xsl:when>
   <xsl:when test="$RelCode = 'ive'"><xsl:value-of select="'460'"/></xsl:when>
   <xsl:when test="$RelCode = 'ivr'"><xsl:value-of select="'470'"/></xsl:when>
   <xsl:when test="$RelCode = 'lbt'"><xsl:value-of select="'480'"/></xsl:when>
   <xsl:when test="$RelCode = 'lgd'"><xsl:value-of select="'633'"/></xsl:when>
   <xsl:when test="$RelCode = 'lse'"><xsl:value-of select="'490'"/></xsl:when>
   <xsl:when test="$RelCode = 'lso'"><xsl:value-of select="'500'"/></xsl:when>
   <xsl:when test="$RelCode = 'ltg'"><xsl:value-of select="'510'"/></xsl:when>
   <xsl:when test="$RelCode = 'lyr'"><xsl:value-of select="'520'"/></xsl:when>
   <xsl:when test="$RelCode = 'mod'"><xsl:value-of select="'605'"/></xsl:when>
   <xsl:when test="$RelCode = 'mon'"><xsl:value-of select="'540'"/></xsl:when>
   <xsl:when test="$RelCode = 'mte'"><xsl:value-of select="'530'"/></xsl:when>
   <xsl:when test="$RelCode = 'mus'"><xsl:value-of select="'545'"/></xsl:when>
   <xsl:when test="$RelCode = 'nrt'"><xsl:value-of select="'550'"/></xsl:when>
   <xsl:when test="$RelCode = 'opn'"><xsl:value-of select="'555'"/></xsl:when>
   <xsl:when test="$RelCode = 'org'"><xsl:value-of select="'560'"/></xsl:when>
   <xsl:when test="$RelCode = 'oth'"><xsl:value-of select="'570'"/></xsl:when>
   <xsl:when test="$RelCode = 'pbd'"><xsl:value-of select="'651'"/></xsl:when>
   <xsl:when test="$RelCode = 'pbl'"><xsl:value-of select="'650'"/></xsl:when>
   <xsl:when test="$RelCode = 'pfr'"><xsl:value-of select="'640'"/></xsl:when>
   <xsl:when test="$RelCode = 'pht'"><xsl:value-of select="'600'"/></xsl:when>
   <xsl:when test="$RelCode = 'pop'"><xsl:value-of select="'620'"/></xsl:when>
   <xsl:when test="$RelCode = 'ppm'"><xsl:value-of select="'580'"/></xsl:when>
   <xsl:when test="$RelCode = 'ppt'"><xsl:value-of select="'655'"/></xsl:when>
   <xsl:when test="$RelCode = 'prd'"><xsl:value-of select="'633'"/></xsl:when>
   <xsl:when test="$RelCode = 'prf'"><xsl:value-of select="'590'"/></xsl:when>
   <xsl:when test="$RelCode = 'prg'"><xsl:value-of select="'635'"/></xsl:when>
   <xsl:when test="$RelCode = 'pro'"><xsl:value-of select="'630'"/></xsl:when>
   <xsl:when test="$RelCode = 'prt'"><xsl:value-of select="'610'"/></xsl:when>
   <xsl:when test="$RelCode = 'pta'"><xsl:value-of select="'582'"/></xsl:when>
   <xsl:when test="$RelCode = 'pth'"><xsl:value-of select="'587'"/></xsl:when>
   <xsl:when test="$RelCode = 'rbr'"><xsl:value-of select="'680'"/></xsl:when>
   <xsl:when test="$RelCode = 'rce'"><xsl:value-of select="'670'"/></xsl:when>
   <xsl:when test="$RelCode = 'rcp'"><xsl:value-of select="'660'"/></xsl:when>
   <xsl:when test="$RelCode = 'res'"><xsl:value-of select="'595'"/></xsl:when>
   <xsl:when test="$RelCode = 'rev'"><xsl:value-of select="'675'"/></xsl:when>
   <xsl:when test="$RelCode = 'rpt'"><xsl:value-of select="'710'"/></xsl:when>
   <xsl:when test="$RelCode = 'rth'"><xsl:value-of select="'673'"/></xsl:when>
   <xsl:when test="$RelCode = 'rtm'"><xsl:value-of select="'677'"/></xsl:when>
   <xsl:when test="$RelCode = 'sad'"><xsl:value-of select="'695'"/></xsl:when>
   <xsl:when test="$RelCode = 'sce'"><xsl:value-of select="'690'"/></xsl:when>
   <xsl:when test="$RelCode = 'scl'"><xsl:value-of select="'705'"/></xsl:when>
   <xsl:when test="$RelCode = 'scr'"><xsl:value-of select="'700'"/></xsl:when>
   <xsl:when test="$RelCode = 'sec'"><xsl:value-of select="'710'"/></xsl:when>
   <xsl:when test="$RelCode = 'sgn'"><xsl:value-of select="'720'"/></xsl:when>
   <xsl:when test="$RelCode = 'sng'"><xsl:value-of select="'721'"/></xsl:when>
   <xsl:when test="$RelCode = 'spn'"><xsl:value-of select="'723'"/></xsl:when>
   <xsl:when test="$RelCode = 'stn'"><xsl:value-of select="'725'"/></xsl:when>
   <xsl:when test="$RelCode = 'stl'"><xsl:value-of select="'550'"/></xsl:when>
   <xsl:when test="$RelCode = 'ths'"><xsl:value-of select="'727'"/></xsl:when>
   <xsl:when test="$RelCode = 'trl'"><xsl:value-of select="'730'"/></xsl:when>
   <xsl:when test="$RelCode = 'tyd'"><xsl:value-of select="'740'"/></xsl:when>
   <xsl:when test="$RelCode = 'tyg'"><xsl:value-of select="'750'"/></xsl:when>
   <xsl:when test="$RelCode = 'voc'"><xsl:value-of select="'755'"/></xsl:when>
   <xsl:when test="$RelCode = 'wam'"><xsl:value-of select="'770'"/></xsl:when>
   <xsl:when test="$RelCode = 'wde'"><xsl:value-of select="'760'"/></xsl:when>
   <xsl:otherwise><xsl:value-of select="text()"/></xsl:otherwise>
  </xsl:choose>
 </xsl:template>


 <xsl:template name="tokenizeSubfield">
  <!--passed template parameter -->
  <xsl:param name="list"/>
  <xsl:param name="delimiter"/>
  <xsl:param name="code"/>
  <xsl:choose>
   <xsl:when test="contains($list, $delimiter) and substring-after($list,$delimiter) != ''">
    <subfield>
     <xsl:attribute name="code">
      <xsl:value-of select="$code" />
     </xsl:attribute>
     <!-- get everything in front of the first delimiter -->
     <xsl:value-of select="substring-before($list,$delimiter)"/>
    </subfield>
    <xsl:call-template name="tokenizeSubfield">
     <!-- store anything left in another variable -->
     <xsl:with-param name="list" select="normalize-space(substring-after($list,$delimiter))"/>
     <xsl:with-param name="delimiter" select="$delimiter"/>
     <xsl:with-param name="code" select="$code"/>
    </xsl:call-template>
   </xsl:when>
   <xsl:otherwise>
    <xsl:choose>
     <xsl:when test="$list = ''"/>
     <xsl:otherwise>
      <subfield>
       <xsl:attribute name="code">
        <xsl:value-of select="$code" />
       </xsl:attribute>
       <xsl:call-template name="removeEndPuctuation">
        <xsl:with-param name="text" select="$list"/>
       </xsl:call-template>
       
      </subfield>
     </xsl:otherwise>
    </xsl:choose>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

 <xsl:template name="removeEndPuctuation">
  <xsl:param name="text"/>
  <xsl:choose>
   <!-- <xsl:when test="string-length(translate(substring($text, string-length($text)), ' ,.:;/', '')) = 0"> -->
   <xsl:when test="string-length(translate(substring($text, string-length($text)), ' ,:;/', '')) = 0"> 
    <xsl:value-of
     select="normalize-space(substring($text, 1, string-length($text)-1))"/>
   </xsl:when>
   <xsl:otherwise>
    <xsl:value-of
     select="$text"/>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

 <xsl:template name="removeEndTermPuctuation">
  <xsl:param name="text"/>
  <xsl:choose>
   <xsl:when test="string-length(translate(substring($text, string-length($text)), ' ,:;/', '')) = 0">
    <xsl:value-of
     select="normalize-space(substring($text, 1, string-length($text)-1))"/>
   </xsl:when>
   <xsl:otherwise>
    <xsl:value-of
     select="$text"/>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>
  
  <xsl:template name="removeEndAuthorPuctuation">
  <xsl:param name="text"/>
  <xsl:choose>
   <xsl:when test="string-length(translate(substring($text, string-length($text)), ' ,:;/', '')) = 0">
    <xsl:value-of
     select="normalize-space(substring($text, 1, string-length($text)-1))"/>
   </xsl:when>
   <xsl:otherwise>
    <xsl:value-of
     select="$text"/>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

  <xsl:template name="removeEndPublicationPuctuation">
  <xsl:param name="text"/>
  <xsl:choose>
   <xsl:when test="string-length(translate(substring($text, string-length($text)), ' ,:;/', '')) = 0">
    <xsl:value-of
     select="normalize-space(substring($text, 1, string-length($text)-1))"/>
   </xsl:when>
   <xsl:otherwise>
    <xsl:value-of
     select="$text"/>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>
  
 <xsl:template name="removeEndPhysicalDescriptionPuctuation">
  <xsl:param name="text"/>
  <xsl:choose>
   <xsl:when test="string-length(translate(substring($text, string-length($text)), ' ,:;/', '')) = 0">
    <xsl:value-of
     select="normalize-space(substring($text, 1, string-length($text)-1))"/>
   </xsl:when>
   <xsl:otherwise>
    <xsl:value-of
     select="$text"/>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>
  
 <xsl:template name="convertSubjectHeading">
  <xsl:param name="ind"/>
  <xsl:choose>
   <xsl:when test="$ind = 0">
    <subfield code="2">
     <xsl:value-of select="'lc'"/>
    </subfield>
   </xsl:when>
   <xsl:when test="$ind = 1">
    <subfield code="2">
     <xsl:value-of select="'lcch'"/>
    </subfield>
   </xsl:when>
   <xsl:when test="$ind = 2">
    <subfield code="2">
     <xsl:value-of select="'mesh'"/>
    </subfield>
   </xsl:when>
   <xsl:when test="$ind = 3">
    <subfield code="2">
     <xsl:value-of select="'nal'"/>
    </subfield>
   </xsl:when>
   <!-- What to do if thesaurus source is not specified (ind2 = 4)? --> 
   <xsl:when test="$ind = 5">
    <subfield code="2">
     <xsl:value-of select="'cae'"/>
    </subfield>
   </xsl:when>
   <xsl:when test="$ind = 6">
    <subfield code="2">
     <xsl:value-of select="'caf'"/>
    </subfield>
   </xsl:when>
  </xsl:choose>
 </xsl:template>
 
 <xsl:template name="datafield856">
  <xsl:for-each select= "marc:datafield[@tag=856]">
   <datafield tag="856">
    <xsl:attribute name="ind1">
     <xsl:value-of select="@ind1"/>
    </xsl:attribute>
    <xsl:attribute name="ind2">
     <xsl:value-of select="@ind2"/>
    </xsl:attribute>
    <xsl:for-each select= "marc:subfield[@code]">
     <subfield>
      <xsl:attribute name="code">
       <xsl:choose>
        <xsl:when test="@code = 3">
         <xsl:value-of select="2" />
        </xsl:when>
        <xsl:when test="@code = 2">
         <xsl:value-of select="y" />
        </xsl:when>
        <xsl:when test="@code = y">
         <xsl:value-of select="2" />
        </xsl:when>
        <xsl:otherwise>
         <xsl:value-of select="@code" />
        </xsl:otherwise>
       </xsl:choose>
      </xsl:attribute>
      <xsl:value-of select="text()"/>
     </subfield>
    </xsl:for-each>
   </datafield>
  </xsl:for-each>
 </xsl:template>

 <xsl:template name="getCountryFromMarcOrgCode">
  <xsl:param name="marcOrgCode" select="text()" />
  <xsl:choose>
   <xsl:when test="substring($marcOrgCode, 3, 1) = '-'">
    <xsl:value-of select="substring($marcOrgCode, 1, 2)"/>
   </xsl:when>
   <xsl:when test="$marcOrgCode = 'DLC'">
    <xsl:value-of select="'US'"/>
   </xsl:when>
  </xsl:choose>
 </xsl:template>
 
 <xsl:template name="selects">
  <xsl:param name="i" />
  <xsl:param name="count" />
  
  <xsl:if test="$i &lt;= $count">
   <xsl:for-each select= "marc:datafield[@tag=$i]">
   <xsl:variable name="subfields"><xsl:for-each select= "marc:subfield[@code]"><xsl:value-of select="text()"/></xsl:for-each></xsl:variable>
   <xsl:if test="$subfields and string-length($subfields) > 0 and $i!='942' and $i!='952' ">
   <datafield>
    <xsl:attribute name="tag"><xsl:value-of select="@tag" /></xsl:attribute>
    <xsl:attribute name="ind1">
     <xsl:value-of select="@ind1"/>
    </xsl:attribute>
    <xsl:attribute name="ind2">
     <xsl:value-of select="@ind2"/>
    </xsl:attribute>
    <xsl:for-each select= "marc:subfield[@code]">
     <subfield>
      <xsl:attribute name="code">
       <xsl:value-of select="@code" />
      </xsl:attribute>
      <xsl:value-of select="text()"/>
     </subfield>
    </xsl:for-each>
   </datafield>
   </xsl:if>
   </xsl:for-each>
  </xsl:if>
  
  <!--begin_: RepeatTheLoopUntilFinished-->
  <xsl:if test="$i &lt; $count">
   <xsl:call-template name="selects">
    <xsl:with-param name="i">
     <xsl:value-of select="$i + 1"/>
    </xsl:with-param>
    <xsl:with-param name="count">
     <xsl:value-of select="$count"/>
    </xsl:with-param>
   </xsl:call-template>
  </xsl:if>
 </xsl:template>
</xsl:stylesheet>
