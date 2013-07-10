<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:oai="http://www.openarchives.org/OAI/2.0/"
    xmlns:ui="http://www.library.uiuc.edu/uiLib"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:ns="http://purl.org/dc/elements/1.1/"
    xmlns:dct="http://purl.org/dc/terms/"
    exclude-result-prefixes="oai xsi ui ns dct">
    <xd:doc xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> Mar 30, 2010</xd:p>
            <xd:p><xd:b>Author:</xd:b> kfenlon2</xd:p>
            <xd:p>Part of indexing; converts metadata record to 'more info' display XML blob for database (revised from earlier version for use in transportation portal)</xd:p>
        </xd:desc>
    </xd:doc>
    
    <xsl:output method="xml" indent="yes" omit-xml-declaration="yes" />
    
    <xsl:template match="/">
     <record>     
         <xsl:apply-templates select="oai:record/oai:metadata/ui:dc/*[@ui:usage='display']"/>         
     </record>
    </xsl:template>  
    
    <!-- This XML blob only uses 'display' elements. isPartOf elements ignored.
            Cuts off non-URI fields at 1000 characters -->
    <xsl:template match="*[@ui:usage='display']">
        <xsl:variable name="name" select="name()" />
        <xsl:choose>
            <xsl:when test="./preceding-sibling::*[name(.)=$name and @ui:usage='display']" />           
            <xsl:when test="./preceding-sibling::*[name(.)!=$name]">
                <xsl:element name="property">
                    <xsl:attribute name="name">
                        <xsl:value-of select="$name"/>
                    </xsl:attribute>
                    <xsl:element name="value">
                        <xsl:choose>
                            <xsl:when test="./@xsi:type='dct:URI'">
                                <xsl:element name="a">
                                    <xsl:attribute name="href">
                                        <xsl:value-of select="."/>
                                    </xsl:attribute>
                                    <xsl:value-of select="."/>
                                </xsl:element>
                            </xsl:when>
                            <xsl:otherwise><xsl:value-of select="substring(.,0,1000)"/></xsl:otherwise>
                        </xsl:choose>                       
                    </xsl:element>
                    <xsl:for-each select="./following-sibling::*[name(.)=$name and @ui:usage='display']">
                        <xsl:element name="value">
                            <xsl:choose>
                                <xsl:when test="./@xsi:type='dct:URI'">
                                    <xsl:element name="a">
                                        <xsl:attribute name="href">
                                            <xsl:value-of select="."/>
                                        </xsl:attribute>
                                        <xsl:value-of select="."/>
                                    </xsl:element>
                                </xsl:when>
                                <xsl:otherwise><xsl:value-of select="substring(.,0,1000)"/></xsl:otherwise>
                            </xsl:choose>  
                        </xsl:element>
                    </xsl:for-each>                 
                </xsl:element>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
</xsl:stylesheet>
