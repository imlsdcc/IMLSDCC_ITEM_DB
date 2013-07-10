<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:oai="http://www.openarchives.org/OAI/2.0/"
    xmlns:ui="http://www.library.uiuc.edu/uiLib"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:dc="http://purl.org/dc/elements/1.1/"
    xmlns:dct="http://purl.org/dc/terms/"
    exclude-result-prefixes="oai xsi ui dc dct">
    <xd:doc xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> Mar 30, 2010</xd:p>
            <xd:p><xd:b>Author:</xd:b> kfenlon2</xd:p>
            <xd:p>Part of indexing; converts metadata record to short display XML blob for database (revised from earlier version for use in transportation portal)</xd:p>
        </xd:desc>
    </xd:doc>
    
    <xsl:output method="xml" indent="yes" omit-xml-declaration="yes" />
    
    <!-- Keeps only the first of each of 4 elements for short display. Cuts off non-URI fields at 1,000 characters, just in case. -->
   <xsl:template match="/">
       <xsl:element name="record">
           <xsl:apply-templates select="oai:record/oai:metadata/ui:dc/dc:title[@ui:usage='display'][1]" />
           <xsl:apply-templates select="oai:record/oai:metadata/ui:dc/dc:identifier[@ui:usage='display' and @xsi:type='dct:URI'][1]" />
           <xsl:apply-templates select="oai:record/oai:metadata/ui:dc/dc:creator[@ui:usage='display'][1]" />
           <xsl:apply-templates select="oai:record/oai:metadata/ui:dc/dc:type[@ui:usage='display'][1]" />
           <xsl:apply-templates select="oai:record/oai:metadata/ui:dc/dct:isPartOf[@ui:usage='display'][1]" />
       </xsl:element>
   </xsl:template>
    
    <xsl:template match="oai:record/oai:metadata/ui:dc/*[@ui:usage='display']">      
        <xsl:element name="property">
            <xsl:attribute name="name">
                <xsl:value-of select="name()"/>
            </xsl:attribute>
        <xsl:choose>
            <xsl:when test="@xsi:type='dct:URI'">
                <xsl:element name="value">
                    <xsl:element name="a">
                        <xsl:attribute name="href">
                            <xsl:value-of select="."/>
                        </xsl:attribute>
                        <xsl:value-of select="."/>
                    </xsl:element>
                </xsl:element>
            </xsl:when>
            <xsl:otherwise>
                <xsl:element name="value">
                    <xsl:value-of select="substring(.,0,1000)"/>
                </xsl:element>
            </xsl:otherwise>
        </xsl:choose>            
        </xsl:element>
    </xsl:template>
</xsl:stylesheet>
