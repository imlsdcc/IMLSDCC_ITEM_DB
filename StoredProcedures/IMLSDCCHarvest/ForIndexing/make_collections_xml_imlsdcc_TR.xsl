<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:oai="http://www.openarchives.org/OAI/2.0/"
    xmlns:oai_dc="http://www.openarchives.org/OAI/2.0/oai_dc/"
    xmlns:imlsdccProf="http://imlsdcc.grainger.uiuc.edu/profile#"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:dcterms="http://purl.org/dc/terms/"
    xmlns:cld="http://purl.org/cld/terms/" xmlns:imlsdcc="http://imlsdcc.grainger.uiuc.edu/types#"
    xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:vcard="http://www.w3.org/2001/vcard-rdf/3.0#"
    xmlns:gen="http://example.org/gen/terms#" xmlns:ui="http://www.library.uiuc.edu/uiLib">

   <xsl:output method="xml" indent="yes" encoding="UTF-8"/>
    <!-- RIGHT NOW THIS IGNORES VCARD VALUES 
        which may be the only values available for certain elements for certain collections)
        WILL HAVE TO FIX THIS LOSSINESSS when Tom fixes provider -->

    <xsl:template match="/">
        <xsl:element name="record">
            <xsl:element name="metadata">
                <xsl:element name="dc">
            <xsl:apply-templates select="//imlsdccProf:collectionDescription/*"/></xsl:element>
            </xsl:element>
        </xsl:element>
    </xsl:template>

    <!-- just create custom templates for those things you want to do custom things with -->


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
        <xsl:choose>
            <!-- GEM subjects: create hierarchy
                Note i know that there are only two levels of a GEM hierarchy; if there were more would need a recursive solution
                Note that the resulting hierarchy is UGLY, but it should work as a DB blob... -->
            <xsl:when test="@xsi:type='imlsdcc:GEM'">
                <xsl:choose>
                    <xsl:when test="contains(.,'--')">
                        <xsl:variable name="GemTopLevelValue" select="substring-before(.,'--')"/>
                        <xsl:choose>
                            <xsl:when
                                test="./preceding-sibling::*[@xsi:type='imlsdcc:GEM' and starts-with(.,$GemTopLevelValue)]"/>
                            <xsl:when
                                test="not(./preceding-sibling::*[@xsi:type='imlsdcc:GEM' and starts-with(.,$GemTopLevelValue)])"> 
                                <xsl:element name="gemSubject">
                                    <xsl:element name="subject">
                                    <xsl:value-of select="$GemTopLevelValue"/></xsl:element>
                                    <xsl:element name="gemSubject">
                                        <xsl:element name="subject">
                                        <xsl:value-of select="substring-after(.,'--')"/></xsl:element>
                                    </xsl:element>
                                    <xsl:for-each select="following-sibling::*[@xsi:type='imlsdcc:GEM' and starts-with(.,$GemTopLevelValue) and contains(.,'--')]">
                                        <xsl:element name="gemSubject">
                                            <xsl:element name="subject">
                                            <xsl:value-of select="substring-after(.,'--')"/></xsl:element>
                                        </xsl:element>
                                    </xsl:for-each>   
                                </xsl:element>                                                   
                            </xsl:when>
                        </xsl:choose>
                    </xsl:when>
                    <xsl:otherwise>
                        <!-- checks if the value of the current gem subject is the value of 
                            top-level used previously; if so, doesn't create repeat element -->
                        <xsl:variable name="startsWith" select="text()"></xsl:variable>
                        <xsl:choose>
                            <xsl:when test="./preceding-sibling::*[@xsi:type='imlsdcc:GEM' and starts-with(.,$startsWith) and contains(.,'--')]" />
                            <xsl:otherwise>
                                <xsl:element name="gemSubject">
                                    <xsl:value-of select="."/>
                                </xsl:element>
                            </xsl:otherwise>
                        </xsl:choose>                       
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>

            <!-- non-GEM subjects -->
            <xsl:otherwise>
                <xsl:element name="subject">
                    <xsl:value-of select="."/>
                </xsl:element>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>


    <xsl:template match="cld:isLocatedAt">
        <xsl:element name="relation">
            <xsl:value-of select="."/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="dcterms:accessRights">
        <xsl:element name="rights">
            <xsl:value-of select="."/>
        </xsl:element>
    </xsl:template>

    <!-- added this template so as to remove possibility of vcards from these two elements
        for now we will ignore anything that's a vcard - until tom can repair inconsistencies
        in vcard xml formats -->
    <xsl:template match="dc:contributor|dc:source|dc:relation">
        <xsl:choose>
            <xsl:when test="starts-with(text(), 'http://imlsdcc')" />
            <xsl:otherwise>
                <xsl:element name="{local-name()}">
                    <xsl:value-of select="." />
                </xsl:element>
            </xsl:otherwise>                          
        </xsl:choose>
    </xsl:template>

    <xsl:template match="dc:creator">     
            <xsl:choose>
                <!-- for now we will ignore anything that's a vcard - until tom can repair inconsistencies
                    in vcard xml formats -->
                <xsl:when
                    test="starts-with(text(), 'http://imlsdcc.grainger.uiuc.edu/Registry/Project/?')">
                    <!--
                    <xsl:variable name="creatorVCard" select="."/>
                    <xsl:if test="//imlsdccProf:projectDescription[@ xml:base=$creatorVCard]">
                        <xsl:value-of
                            select="//imlsdccProf:projectDescription[@ xml:base=$creatorVCard]/dc:identifier[not(@*)]"/>
                        <xsl:text> </xsl:text>
                        <xsl:value-of
                            select="//imlsdccProf:projectDescription[@ xml:base=$creatorVCard]/dc:title"/>
                        <xsl:text> </xsl:text>
                        <xsl:value-of
                            select="//imlsdccProf:projectDescription[@ xml:base=$creatorVCard]/cld:isLocatedAt"
                        />
                    </xsl:if>-->
                </xsl:when> 
                <xsl:otherwise>
                    <xsl:element name="creator">
                    <xsl:value-of select="."/>
                    </xsl:element>
                </xsl:otherwise>
            </xsl:choose>     
    </xsl:template>

    <xsl:template match="dc:publisher">        
            <!-- for now we will ignore anything that's a vcard - until tom can repair inconsistencies
                in vcard xml formats -->
            <xsl:choose>
                <xsl:when
                    test="starts-with(text(), 'http://imlsdcc.grainger.uiuc.edu/Registry/Institution/?')">
                    <!--
                    <xsl:variable name="publisherVCard" select="."/>
                    <xsl:if test="//vcard:VCARD[@ xml:base=$publisherVCard]">
                        <xsl:value-of select="//vcard:VCARD[@ xml:base=$publisherVCard]/vcard:FN"/>
                        <xsl:text> </xsl:text>
                        <xsl:for-each select="//vcard:VCARD[@ xml:base=$publisherVCard]/vcard:ADR/*">
                            <xsl:value-of select="."/>
                            <xsl:text>, </xsl:text>
                        </xsl:for-each>
                    </xsl:if> -->
                </xsl:when>
                <xsl:otherwise>
                    <xsl:element name="hostInstitution">
                    <xsl:value-of select="."/>
                        </xsl:element>
                </xsl:otherwise>
            </xsl:choose>
    </xsl:template>

<!-- What's happening here? -->
    <xsl:template match="dcterms:isPartOf">
        <xsl:if test="starts-with(text(), 'http://imlsdcc.grainger.uiuc.edu/Registry/Collection/?')">
            <xsl:element name="relation">
                <xsl:text>Parent Collection: </xsl:text>
                <xsl:variable name="isPartOfLink" select="."/>
                <xsl:value-of
                    select="document($isPartOfLink)/imlsdccProf:collectionDescription/dc:title"/>
                <xsl:text> </xsl:text>
                <xsl:value-of
                    select="document($isPartOfLink)/imlsdccProf:collectionDescription/gen:isLocatedAt"
                />
            </xsl:element>
        </xsl:if>

    </xsl:template>
    
    <!-- anything else copy; if a link, make a link -->
    <xsl:template match="*">
        <xsl:element name="{local-name()}">
            <xsl:choose>
                <xsl:when test="./@xsi:type='dct:URI'">
                    <xsl:element name="a">
                        <xsl:attribute name="href">
                            <xsl:value-of select="."/>
                        </xsl:attribute>
                        <xsl:value-of select="."/>
                    </xsl:element>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="."/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:element>
    </xsl:template>


</xsl:stylesheet>
