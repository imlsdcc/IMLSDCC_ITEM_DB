<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:oai="http://www.openarchives.org/OAI/2.0/"
    xmlns:ui="http://www.library.uiuc.edu/uiLib"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
    
    <xsl:output method="xml" indent="yes" encoding="UTF-8" />
    
    <xsl:variable name="upperCase" select=" 'ABCDEFGHIJKLMNOPQRSTUVWXYZ' "/>
    <xsl:variable name="lowerCase" select=" 'abcdefghijklmnopqrstuvwxyz' "/> 
    
    <xsl:template match="/">
         <xsl:apply-templates select="oai:record"/>
    </xsl:template>
    
    <xsl:template match="oai:record">
        <xsl:element name="record">
            <xsl:value-of select="text()"/>
            <xsl:apply-templates select="oai:metadata"/>            
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="oai:metadata">
        <xsl:element name="metadata">
            <xsl:value-of select="text()"/>
            <xsl:apply-templates select="ui:dc"/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="ui:dc">
        <xsl:element name="dc">
            <xsl:for-each select="child::node()">
                <xsl:if test="name(.)='creator' and @ui:usage='search'">
                    <xsl:element name="author">
                        <xsl:value-of select="translate(text(), $upperCase, $lowerCase)"/>
                    </xsl:element>
                </xsl:if>
                <xsl:if test="name(.)='contributor' and @ui:usage='search' ">
                    <xsl:element name="author">
                        <xsl:value-of select="translate(text(), $upperCase, $lowerCase)"/>
                    </xsl:element>
                </xsl:if>
            </xsl:for-each>
            <xsl:for-each select="child::node()">
                <xsl:if test="name(.)='title' and @ui:usage='search'">
                    <xsl:element name="topic">
                        <xsl:value-of select="translate(text(), $upperCase, $lowerCase)"/>
                    </xsl:element>
                </xsl:if>
                <xsl:if test="name(.)='subject' and @ui:usage='search' ">
                    <xsl:element name="topic">
                        <xsl:value-of select="translate(text(), $upperCase, $lowerCase)"/>
                    </xsl:element>
                </xsl:if>
                <xsl:if test="name(.)='description' and @ui:usage='search' ">
                    <xsl:element name="topic">
                        <xsl:value-of select="translate(text(), $upperCase, $lowerCase)"/>
                    </xsl:element>
                </xsl:if>
                <xsl:if test="name(.)='identifier' and @ui:usage='search' and @xsi:type='dct:URI' ">
                    <xsl:element name="isAvailableAt_URL">
                        <xsl:value-of select="text()"/>
                    </xsl:element>
                </xsl:if>
            </xsl:for-each>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="ui:dc/@* | ui:dc/node()">
        <xsl:if test="(@facetType or @ui:usage='search') and name()!='who' and name()!='what' and name()!='when' and name()!='where' and name()!='creator' and name()!='contributor' and name()!='title' and name()!='subject' and name()!='identifier'">
            <xsl:element name="{local-name()}">
                <xsl:value-of select="translate(text(), $upperCase, $lowerCase)"/>
            </xsl:element>
        </xsl:if>
    </xsl:template>

</xsl:stylesheet>
