<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:search="java:uk.ac.ebi.arrayexpress.utils.saxon.search.SearchExtension"
                xmlns:html="http://www.w3.org/1999/xhtml"
                extension-element-prefixes="xs search html"
                exclude-result-prefixes="xs search html"
                version="2.0">

    <xsl:param name="sortby"/>
    <xsl:param name="sortorder"/>
    <xsl:param name="page"/>
    <xsl:param name="pagesize"/>

    <xsl:param name="queryid"/>
    <xsl:param name="keywords"/>

    <!-- dynamically set by QueryServlet: host name (as seen from client) and base context path of webapp -->
    <xsl:param name="host"/>
    <xsl:param name="basepath"/>

    <xsl:variable name="vBaseUrl">http://<xsl:value-of select="$host"/><xsl:value-of select="$basepath"/></xsl:variable>

    <xsl:output omit-xml-declaration="yes" method="html"
                indent="no" encoding="ISO-8859-1" doctype-public="-//W3C//DTD HTML 4.01 Transitional//EN"/>

    <xsl:include href="ae-html-page.xsl"/>
    <xsl:include href="ae-sort-arrays.xsl"/>

    <xsl:template match="/">
        <html lang="en">
            <xsl:call-template name="page-header">
                <xsl:with-param name="pTitle">
                    <xsl:text>Platform Designs | ArrayExpress Archive | EBI</xsl:text>
                </xsl:with-param>
                <xsl:with-param name="pExtraCode">
                    <link rel="stylesheet" href="{$basepath}/assets/stylesheets/ae_common_20.css" type="text/css"/>
                    <link rel="stylesheet" href="{$basepath}/assets/stylesheets/ae_arrays_20.css" type="text/css"/>
                    <script src="{$basepath}/assets/scripts/jquery-1.4.2.min.js" type="text/javascript"/>
                    <script src="{$basepath}/assets/scripts/jquery.query-2.1.7m-ebi.js" type="text/javascript"/>
                    <script src="{$basepath}/assets/scripts/ae_arrays_20.js" type="text/javascript"/>
                </xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="page-body"/>
        </html>
    </xsl:template>

    <xsl:template name="ae-contents">

        <xsl:variable name="vFilteredArrays" select="search:queryIndex($queryid)"/>
        <xsl:variable name="vTotal" select="count($vFilteredArrays)"/>

        <xsl:variable name="vPage" as="xs:integer">
            <xsl:choose>
                <xsl:when test="$page"><xsl:value-of select="number($page)"/></xsl:when>
                <xsl:otherwise>1</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <xsl:variable name="vPageSize" as="xs:integer">
            <xsl:choose>
                <xsl:when test="$pagesize"><xsl:value-of select="number($pagesize)"/></xsl:when>
                <xsl:otherwise>25</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <xsl:variable name="vFrom" as="xs:integer">
            <xsl:choose>
                <xsl:when test="$vPage > 0"><xsl:value-of select="1 + ( $vPage - 1 ) * $vPageSize"/></xsl:when>
                <xsl:when test="$vTotal = 0">0</xsl:when>
                <xsl:otherwise>1</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="vTo" as="xs:integer">
            <xsl:choose>
                <xsl:when test="( $vFrom + $vPageSize - 1 ) > $vTotal"><xsl:value-of select="$vTotal"/></xsl:when>
                <xsl:otherwise><xsl:value-of select="$vFrom + $vPageSize - 1"/></xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <div class="ae_left_container_100pc assign_font">
            <div id="ae_content">
                <div id="ae_query_box">
                    <form id="ae_query_form" method="get" action="browse.html">
                        <fieldset id="ae_keywords_fset">
                            <label for="ae_keywords_field">Platform design accessions, names, descriptions and providers</label>
                            <input id="ae_keywords_field" type="text" name="keywords" value="{$keywords}" maxlength="255" class="assign_font"/>
                        </fieldset>
                        <div id="ae_submit_box"><input id="ae_query_submit" type="submit" value="Query"/></div>
                        <div id="ae_results_stats">
                            <xsl:text>&#160;</xsl:text>
                            <div>
                                <xsl:value-of select="$vTotal"/>
                                <xsl:text> platform design</xsl:text>
                                <xsl:if test="$vTotal > 1">
                                    <xsl:text>s</xsl:text>
                                </xsl:if>
                                <xsl:text> found</xsl:text>
                                <xsl:if test="$vTotal > $vPageSize">
                                    <xsl:text>, displaying </xsl:text>
                                    <xsl:value-of select="$vFrom"/>
                                    <xsl:text> - </xsl:text>
                                    <xsl:value-of select="$vTo"/>
                                </xsl:if>
                                <xsl:text>.</xsl:text>
                            </div>
                            <xsl:if test="$vTotal > $vPageSize">
                                <xsl:variable name="vTotalPages" select="floor( ( $vTotal - 1 ) div $vPageSize ) + 1"/>
                                <div id="ae_results_pager">
                                    <div id="total_pages"><xsl:value-of select="$vTotalPages"/></div>
                                    <div id="page"><xsl:value-of select="$vPage"/></div>
                                    <div id="page_size"><xsl:value-of select="$vPageSize"/></div>
                                </div>
                            </xsl:if>
                        </div>
                    </form>
                </div>
                <xsl:choose>
                    <xsl:when test="$vTotal&gt;0">
                        <table id="ae_results_table" border="0" cellpadding="0" cellspacing="0">
                            <thead>
                                <tr>
                                    <th class="col_accession sortable">
                                        <xsl:text>Accession</xsl:text>
                                        <xsl:call-template name="add-sort">
                                            <xsl:with-param name="pKind" select="'accession'"/>
                                        </xsl:call-template>
                                    </th>
                                    <th class="col_name sortable">
                                        <xsl:text>Name</xsl:text>
                                        <xsl:call-template name="add-sort">
                                            <xsl:with-param name="pKind" select="'name'"/>
                                        </xsl:call-template>
                                    </th>
                                    <th class="col_species sortable">
                                        <xsl:text>Species</xsl:text>
                                        <xsl:call-template name="add-sort">
                                            <xsl:with-param name="pKind" select="'species'"/>
                                        </xsl:call-template>
                                    </th>
                                </tr>
                            </thead>
                            <tbody>
                                <xsl:call-template name="ae-sort-arrays">
                                    <xsl:with-param name="pArrays" select="$vFilteredArrays"/>
                                    <xsl:with-param name="pFrom" select="$vFrom"/>
                                    <xsl:with-param name="pTo" select="$vTo"/>
                                    <xsl:with-param name="pSortBy" select="$sortby"/>
                                    <xsl:with-param name="pSortOrder" select="$sortorder"/>
                                </xsl:call-template>
                            </tbody>
                        </table>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:call-template name="block-warning">
                            <xsl:with-param name="pStyle" select="'ae_warn_area'"/>
                            <xsl:with-param name="pMessage">
                                <xsl:text>There are no platform designs matching your search criteria found in ArrayExpress Archive.</xsl:text>
                            </xsl:with-param>
                        </xsl:call-template>
                    </xsl:otherwise>
                </xsl:choose>
            </div>
        </div>
    </xsl:template>

    <xsl:template match="array_design">
        <xsl:param name="pFrom"/>
        <xsl:param name="pTo"/>
        <xsl:if test="position() >= $pFrom and not(position() > $pTo)">
            <tr>
                <td class="col_accession">
                    <div>
                        <a href="{$basepath}/arrays/{accession}">
                            <xsl:value-of select="accession"/>
                        </a>
                        <xsl:if test="not(user/@id = '1')">
                            <img src="{$basepath}/assets/images/silk_lock.gif" width="8" height="9"/>
                        </xsl:if>
                    </div>
                </td>
                <td class="col_name">
                    <div>
                        <xsl:value-of select="name"/>
                        <xsl:if test="count(name) = 0">&#160;</xsl:if>
                    </div>
                </td>
                <td class="col_species">
                    <div>
                        <xsl:value-of select="string-join(species, ', ')"/>
                        <xsl:if test="count(species) = 0"><xsl:text>&#160;</xsl:text></xsl:if>
                    </div>
                </td>
            </tr>
        </xsl:if>
    </xsl:template>

    <xsl:template name="add-sort">
        <xsl:param name="pKind"/>
        <xsl:if test="$pKind = $sortby">
            <xsl:choose>
                <xsl:when test="'ascending' = $sortorder"><img src="{$basepath}/assets/images/mini_arrow_up.gif" width="12" height="16" alt="^"/></xsl:when>
                <xsl:otherwise><img src="{$basepath}/assets/images/mini_arrow_down.gif" width="12" height="16" alt="v"/></xsl:otherwise>
            </xsl:choose>
        </xsl:if>
    </xsl:template>

</xsl:stylesheet>
