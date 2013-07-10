<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [

<!ENTITY XMLNS_OAI_2_0 "http://www.openarchives.org/OAI/2.0/">
<!ENTITY XMLNS_OAI_2_0_DC "http://www.openarchives.org/OAI/2.0/oai_dc/">
<!ENTITY XMLNS_PROV "http://www.openarchives.org/OAI/2.0/provenance">
<!ENTITY XMLNS_DC "http://purl.org/dc/elements/1.1/">
<!ENTITY XMLNS_DCT "http://purl.org/dc/terms/">
<!ENTITY XMLNS_TYP "http://purl.org/dc/dcmitype/">
<!ENTITY XMLNS_XSI "http://www.w3.org/2001/XMLSchema-instance">

<!ENTITY XMLNS_UILIB "http://www.library.uiuc.edu/uiLib">

<!ENTITY ABC "ABCDEFGHIJKLMNOPQRSTUVWXYZ">
<!ENTITY abc "abcdefghijklmnopqrstuvwxyz">
]>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:oai="&XMLNS_OAI_2_0;"
    xmlns:oai20="&XMLNS_OAI_2_0;"
    xmlns:oai_dc="&XMLNS_OAI_2_0_DC;" xmlns:dc="&XMLNS_DC;" xmlns:dct="&XMLNS_DCT;"
    xmlns:prov="&XMLNS_PROV;" xmlns:typ="&XMLNS_TYP;" xmlns="&XMLNS_DC;" xmlns:xsi="&XMLNS_XSI;"
    xmlns:ui="&XMLNS_UILIB;" exclude-result-prefixes="oai20 oai_dc xsi prov" version="2.0">
    <xd:doc xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> Jun 10, 2010</xd:p>
            <xd:p><xd:b>Author:</xd:b> mctang2</xd:p>
            <xd:p/>
        </xd:desc>
    </xd:doc>
    
    <xsl:namespace-alias stylesheet-prefix="dc" result-prefix="#default"/>
    <xsl:output method="xml" encoding="UTF-8" indent="yes" omit-xml-declaration="yes"/>
    <xsl:variable name="types" select="document('../filters/refs/facetTypesTest.xml')"/>
    
    <xsl:template match="/">
        <xsl:element name="oai:record">
            <xsl:element name="oai:metadata">
                <xsl:element name="oai_dc:dc">
                    <xsl:apply-templates select="oai20:record/oai20:metadata/oai_dc:dc/dc:type"/>
                    <xsl:apply-templates select="oai20:record/oai20:metadata/oai_dc:dc/dc:format"/>
                </xsl:element>
            </xsl:element>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="//dc:type">
        <xsl:element name="dc:type">
            <xsl:value-of select="normalize-space(.)" />
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="//dc:format">
        <xsl:call-template name="findType">
            <xsl:with-param name="normFacetCnt">
                <xsl:value-of select="1"/>
            </xsl:with-param>
        </xsl:call-template>
    </xsl:template>
    
    <xsl:template name="findType" xmlns:xs="http://www.w3.org/2001/XMLSchema">
        <xsl:param name="normFacetCnt" as="xs:integer" required="yes" />
        <xsl:variable name="normFacet"><xsl:value-of select="$types/types/type[number($normFacetCnt)]"/></xsl:variable>
        <xsl:variable name="normFacetValue"><xsl:value-of select="$types/types/type[number($normFacetCnt)]/@facetTerm"/></xsl:variable>
        <xsl:variable name="text">
            <xsl:value-of select="translate(normalize-space(.),'&ABC;','&abc;')"/>
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="contains($text, normalize-space($normFacet))">
                <xsl:element name="dc:type">
                    <xsl:value-of select="normalize-space($normFacetValue)" />
                </xsl:element>
            </xsl:when>
            <xsl:when test="$normFacetCnt&lt;count($types/types/type)">
                <xsl:call-template name="findType">
                    <xsl:with-param name="normFacetCnt">
                        <xsl:value-of select="$normFacetCnt+1"/>
                    </xsl:with-param>
                </xsl:call-template>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
</xsl:stylesheet>
