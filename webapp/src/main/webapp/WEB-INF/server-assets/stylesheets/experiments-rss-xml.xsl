<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:ae="http://www.ebi.ac.uk/arrayexpress/XSLT/Extension"
                xmlns:saxon="http://saxon.sf.net/"
                xmlns:fn="http://www.w3.org/2005/xpath-functions"
                extension-element-prefixes="ae xs fn saxon"
                exclude-result-prefixes="ae xs fn saxon"
                version="2.0">

    <xsl:param name="page"/>
    <xsl:param name="pagesize"/>
    
    <xsl:variable name="vPage" select="if ($page) then $page cast as xs:integer else 1"/>
    <xsl:variable name="vPageSize" select="if ($pagesize) then $pagesize cast as xs:integer else 25"/>
    
    <xsl:param name="sortby"/>
    <xsl:param name="sortorder"/>

    <xsl:variable name="vSortBy" select="if ($sortby) then $sortby else 'releasedate'"/>
    <xsl:variable name="vSortOrder" select="if ($sortorder) then $sortorder else 'descending'"/>

    <xsl:param name="queryid"/>
    <xsl:param name="querystring"/>

    <xsl:param name="host"/>
    <xsl:param name="basepath"/>

    <xsl:variable name="vBaseUrl">http://<xsl:value-of select="$host"/><xsl:value-of select="$basepath"/></xsl:variable>

    <xsl:output name="xml" omit-xml-declaration="no" method="xml" encoding="UTF-8" indent="no"/>
    
    <xsl:param name="initial" />
    
     <xsl:param name="total"/>

    
  <xsl:variable name="vTotal" select="if ($total) then $total cast as xs:integer else -1"/>
<!--     <xsl:variable name="vTotal" select="100"/> -->

<!--     <xsl:include href="ae-sort-experiments.xsl"/> -->

    <xsl:function name="ae:dateTimeToRfc822">
        <xsl:param name="pDateTime"/>
        <xsl:value-of select="fn:format-dateTime($pDateTime, '[FNn,*-3], [D01] [MNn,*-3] [Y0001] [H01]:[m01]:[s01] +0000', 'en', (), ())"/>
    </xsl:function>

    <xsl:template match="/">

        <rss version="2.0" xmlns:atom="http://www.w3.org/2005/Atom">
            <channel>
                <xsl:variable name="vCurrentDate" select="ae:dateTimeToRfc822(fn:current-dateTime())"/>
                <title>
                    <xsl:text>ArrayExpress Archive - Experiments</xsl:text>
                    <xsl:if test="$vPageSize &lt; $vTotal">
                        <xsl:text> (first </xsl:text>
                        <xsl:value-of select="$vPageSize"/>
                        <xsl:text> of </xsl:text>
                        <xsl:value-of select="$vTotal"/>
                        <xsl:text>)</xsl:text>
                    </xsl:if>
                </title>
                <link>
                    <xsl:value-of select="$vBaseUrl"/>
                    <xsl:text>/browse.html?</xsl:text>
                    <xsl:value-of select="$querystring"/>
               </link>
                <description><xsl:text>The ArrayExpress Archive is a database of functional genomics experiments including gene expression where you can query and download data collected to MIAME and MINSEQE standards</xsl:text></description>
                <language><xsl:text>en</xsl:text></language>
                <pubDate><xsl:value-of select="$vCurrentDate"/></pubDate>
                <lastBuildDate><xsl:value-of select="$vCurrentDate"/></lastBuildDate>
                <docs><xsl:text>http://blogs.law.harvard.edu/tech/rss</xsl:text></docs>
                <generator><xsl:text>ArrayExpress</xsl:text></generator>
                <managingEditor><xsl:text>arrayexpress@ebi.ac.uk (ArrayExpress Team)</xsl:text></managingEditor>
                <webMaster><xsl:text>arrayexpress@ebi.ac.uk (ArrayExpress Team)</xsl:text></webMaster>
                <atom:link href="{$vBaseUrl}/rss/experiments" rel="self" type="application/rss+xml" />
                
     						
							<xsl:apply-templates select="//experiment">

							</xsl:apply-templates>

            </channel>
        </rss>

    </xsl:template>

    <xsl:template match="experiment">
            <item>
                <title>
                    <xsl:value-of select="accession"/>
                    <xsl:text> - </xsl:text>
                    <xsl:choose>
                        <xsl:when test="fn:string-length(name) > 0">
                            <xsl:value-of select="name"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:text>Untitled experiment</xsl:text>
                        </xsl:otherwise>
                    </xsl:choose>
                </title>
                <link>
                    <xsl:value-of select="$vBaseUrl"/>/experiments/<xsl:value-of select="accession"/>
                </link>
                <guid>
                    <xsl:attribute name="isPermaLink">true</xsl:attribute>
                    <xsl:value-of select="$vBaseUrl"/>/experiments/<xsl:value-of select="accession"/>
                </guid>

                <description>
                    <xsl:for-each select="description[contains(text, '(Generated description)')]">
                        <xsl:value-of select="fn:replace(text, '[(]Generated description[)]', '', 'i')"/>
                        <xsl:if test="position() != last()">
                            <xsl:text>&lt;br/&gt;</xsl:text>
                        </xsl:if>
                    </xsl:for-each>
                    <xsl:if test="(count(description[contains(text, '(Generated description)')]) > 0)">
                        <xsl:text>&lt;br/&gt;&lt;br/&gt;</xsl:text>
                    </xsl:if>
                    <xsl:for-each select="description[string-length(text) > 0 and not(contains(text, '(Generated description)'))]">
                        <xsl:sort select="id" data-type="number"/>
                        <xsl:value-of select="saxon:serialize(text, 'xml')"/>
                        <xsl:if test="position() != last()">
                            <xsl:text>&lt;br/&gt;</xsl:text>
                        </xsl:if>
                    </xsl:for-each>
                </description>
                <xsl:for-each select="experimentdesign">
                    <category domain="{$vBaseUrl}">
                        <xsl:value-of select="."/>
                    </category>
                </xsl:for-each>
                <xsl:if test="releasedate > ''">
                    <pubDate>
                        <xsl:value-of select="ae:dateTimeToRfc822(fn:dateTime(releasedate, xs:time('00:00:00')))"/>
                    </pubDate>
                </xsl:if>
            </item>
    </xsl:template>

</xsl:stylesheet>
