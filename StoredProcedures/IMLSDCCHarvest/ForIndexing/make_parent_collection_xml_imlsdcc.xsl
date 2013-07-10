<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:oai="http://www.openarchives.org/OAI/2.0/"
    xmlns:ui="http://www.library.uiuc.edu/uiLib"
    xmlns:oai_dc="http://www.openarchives.org/OAI/2.0/oai_dc/"
    xmlns:imlsdccProf="http://imlsdcc.grainger.uiuc.edu/profile#"
    xmlns:dcterms="http://purl.org/dc/terms/" 
    xmlns:cld="http://purl.org/cld/terms/"
    xmlns:imlsdcc="http://imlsdcc.grainger.uiuc.edu/types#"
    xmlns:dc="http://purl.org/dc/elements/1.1/"
    xmlns:vcard="http://www.w3.org/2001/vcard-rdf/3.0#"
    xmlns:gen="http://example.org/gen/terms#">
    
    <xsl:output method="xml" indent="yes" encoding="UTF-8"/>
    
    <xsl:template match="/">
        <xsl:apply-templates select="//imlsdccProf:collectionDescription"/>
    </xsl:template>
    
    <xsl:template match="imlsdccProf:collectionDescription">
        <xsl:element name="record">
            <xsl:element name="metadata">
                <xsl:element name="dc">
                    <xsl:apply-templates select="dc:identifier"/>
                    <xsl:apply-templates select="dcterms:spatial"/>
                    <xsl:apply-templates select="dcterms:temporal"/>
                    <xsl:apply-templates select="dcterms:abstract"/>
                    <xsl:apply-templates select="cld:itemFormat"/>
                    <xsl:apply-templates select="cld:itemType"/>
                    <xsl:apply-templates select="dc:subject"/>
                    <xsl:apply-templates select="dc:description"/>
                    <xsl:apply-templates select="dc:title"/>
                    <xsl:apply-templates select="dc:publisher"/>
                    <xsl:apply-templates select="dc:creator"/>
                    <xsl:apply-templates select="dc:source"/>
                    <xsl:apply-templates select="dc:rights"/>
                    <xsl:apply-templates select="dcterms:accessRights"/>
                    <xsl:apply-templates select="dc:contributor"/>                    
                </xsl:element>
            </xsl:element>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="dc:identifier">
        <xsl:element name="identifier">
            <xsl:value-of select="."/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="dcterms:spatial">
        <xsl:element name="coverage">
            <xsl:value-of select="."/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="dcterms:temporal">
        <xsl:element name="coverage">
            <xsl:value-of select="."/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="dcterms:abstract">
        <xsl:element name="description">
            <xsl:value-of select="."/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="cld:itemFormat">
        <xsl:element name="format">
            <xsl:value-of select="."/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="cld:itemType">
        <xsl:element name="type">
            <xsl:value-of select="."/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="dc:subject">
        <xsl:element name="subject">
            <xsl:value-of select="."/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="dc:description">
        <xsl:element name="description">
            <xsl:value-of select="."/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="dc:title">
        <xsl:element name="title">
            <xsl:value-of select="."/>
        </xsl:element>
    </xsl:template>
    
  
    <xsl:template match="dc:source">
        <xsl:element name="source">
            <xsl:value-of select="."/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="dc:rights">
        <xsl:element name="rights">
            <xsl:value-of select="."/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="dcterms:accessRights">
        <xsl:element name="rights">
            <xsl:value-of select="."/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="dc:contributor">
        <xsl:element name="contributor">
            <xsl:value-of select="."/>
        </xsl:element>
    </xsl:template>
    
    
    <xsl:template match="dc:creator">
        <xsl:choose>
            <xsl:when test="starts-with(text(), 'http://imlsdcc.grainger.uiuc.edu/Registry/Project/?')">
                <xsl:variable name="creatorVCard" select="."/>
                <xsl:if test="//imlsdccProf:projectDescription[@ xml:base=$creatorVCard]">
                    <xsl:element name="creator">
                        <xsl:value-of select="//imlsdccProf:projectDescription[@ xml:base=$creatorVCard]/dc:identifier[not(@*)]"/><xsl:text> </xsl:text>
                        <xsl:value-of select="//imlsdccProf:projectDescription[@ xml:base=$creatorVCard]/dc:title"/><xsl:text> </xsl:text>
                        <xsl:value-of select="//imlsdccProf:projectDescription[@ xml:base=$creatorVCard]/cld:isLocatedAt"/>
                    </xsl:element>
                </xsl:if>
            </xsl:when>
            <xsl:otherwise>
                <xsl:element name="creator">
                    <xsl:value-of select="."/>
                </xsl:element>
            </xsl:otherwise>
        </xsl:choose>       
    </xsl:template>
    
    <xsl:template match="dc:publisher">
        <xsl:choose>
            <xsl:when test="starts-with(text(), 'http://imlsdcc.grainger.uiuc.edu/Registry/Institution/?')">
                <xsl:variable name="publisherVCard" select="."/>
                <xsl:if test="//vcard:VCARD[@ xml:base=$publisherVCard]">
                    <xsl:element name="publisher">
                        <xsl:value-of select="//vcard:VCARD[@ xml:base=$publisherVCard]/vcard:FN"/>
                        <xsl:text> </xsl:text>
                        <xsl:for-each select="//vcard:VCARD[@ xml:base=$publisherVCard]/vcard:ADR/*">
                            <xsl:value-of select="."/>
                            <xsl:text>, </xsl:text>
                        </xsl:for-each>
                    </xsl:element>
                </xsl:if>
            </xsl:when>
            <xsl:otherwise>
                <xsl:element name="publisher">
                    <xsl:value-of select="."/>
                </xsl:element>
            </xsl:otherwise>
        </xsl:choose>       
    </xsl:template>
    
    
    
  
    
</xsl:stylesheet>
