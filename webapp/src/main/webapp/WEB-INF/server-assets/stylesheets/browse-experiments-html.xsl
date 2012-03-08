<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:aejava="java:uk.ac.ebi.arrayexpress.utils.saxon.ExtFunctions"
                xmlns:html="http://www.w3.org/1999/xhtml"
                extension-element-prefixes="xs aejava  html"
                exclude-result-prefixes="xs aejava html"
                version="2.0">

    <xsl:param name="page"/>
    <xsl:param name="pagesize"/>
    
    <xsl:variable name="vPage" select="if ($page) then $page cast as xs:integer else 1"/>
    <xsl:variable name="vPageSize" select="if ($pagesize) then $pagesize cast as xs:integer else 25"/>
  

    
    <xsl:param name="queryid"/>
    <xsl:param name="userid"/>

    <xsl:param name="detailedview"/>

    <xsl:param name="host"/>
    <xsl:param name="basepath"/>
    
    
    <xsl:param name="total"/>
    <xsl:param name="totalsamples"/>
    <xsl:param name="totalassays"/>
    
    <xsl:variable name="vTotal" select="if ($total) then $total cast as xs:integer else -1"/>
    <xsl:variable name="vTotalSamples" select="if ($totalsamples) then $totalsamples cast as xs:integer else -1"/>
    <xsl:variable name="vTotalAssays" select="if ($totalassays) then $totalassays cast as xs:integer else -1"/>

   

    <xsl:variable name="vBaseUrl">http://<xsl:value-of select="$host"/><xsl:value-of select="$basepath"/></xsl:variable>

    <xsl:output omit-xml-declaration="yes" method="html" indent="no" encoding="UTF-8"/>


    <xsl:include href="ae-highlight.xsl"/>

    <xsl:variable name="vDetailedViewMainTrClass">tr_main<xsl:if test="'true' = $detailedview"> exp_expanded</xsl:if></xsl:variable>
    <xsl:variable name="vDetailedViewExtStyle"><xsl:if test="'true' != $detailedview">display:none</xsl:if></xsl:variable>
    <xsl:variable name="vDetailedViewMainTdClass">td_main<xsl:if test="'true' = $detailedview"> td_expanded</xsl:if></xsl:variable>

    <xsl:template match="/">
   		<h1>Teste2</h1>
      
     
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

        <tr id="ae_results_summary_info">
            <td colspan="9">
                <div id="ae_results_total"><xsl:value-of select="$vTotal"/></div>
                <div id="ae_results_total_samples"><xsl:value-of select="$vTotalSamples"/></div>
                <div id="ae_results_total_assays"><xsl:value-of select="$vTotalAssays"/></div>
                <div id="ae_results_from"><xsl:value-of select="$vFrom"/></div>
                <div id="ae_results_to"><xsl:value-of select="$vTo"/></div>
                <div id="ae_results_page"><xsl:value-of select="$vPage"/></div>
                <div id="ae_results_pagesize"><xsl:value-of select="$vPageSize"/></div>
            </td>
        </tr>

        <xsl:choose>
            <xsl:when test="$vTotal > 0">
            <xsl:apply-templates select="//experiment"></xsl:apply-templates>
            </xsl:when>
            <xsl:otherwise>
                <tr class="ae_results_tr_error">
                    <td colspan="9">
                            <div>There are no experiments matching your search criteria found in ArrayExpress Archive.</div>
                            <div>More information on query syntax available in <a href="${interface.application.link.query_help}">ArrayExpress Query Help</a>.</div>
                    </td>
                </tr>
            </xsl:otherwise>
        </xsl:choose>
        
    </xsl:template>

    <xsl:template match="experiment">
   
        <xsl:variable name="vExpId" select="string(id)"/>
        <xsl:variable name="vAccession" select="string(accession)"/>
        <xsl:variable name="vFiles" select="../folder"/>


    <!--    <xsl:if test="position() >= $pFrom and not(position() > $pTo)"> -->
            <tr id="{$vExpId}_main" class="{$vDetailedViewMainTrClass}">
                <td class="{$vDetailedViewMainTdClass}"><div class="table_row_expand"/></td>
                <td class="{$vDetailedViewMainTdClass}">
                    <div class="acc">
                        <div>
                            <a href="{$basepath}/experiments/{accession}">
                                <xsl:call-template name="highlight">
                                    <xsl:with-param name="pText" select="accession" />
                                    <xsl:with-param name="pFieldName" select="'accession'" />
                                </xsl:call-template>
                            </a>
                        </div>
                        <div>
                            <xsl:attribute name="class">
                                <xsl:text>acc_status</xsl:text>
                            <xsl:if test="source/@migrated = 'true'">
                                <xsl:text> migrated</xsl:text>
                            </xsl:if>
                            <xsl:if test="source/@identical = 'true'">
                                <xsl:text> identical</xsl:text>
                            </xsl:if>
                            </xsl:attribute>
                        <xsl:if test="not($userid)"> curator logged in
                            <xsl:choose>
                                <xsl:when test="source/@id = 'ae1' and source/@migrated != 'true'">
                                    <span>&#183;</span>
                                    <span class="ae1">1</span>
                                </xsl:when>
                                <xsl:when test="source/@id = 'ae1' and source/@migrated = 'true'">
                                    <span>
                                        <xsl:choose>
                                            <xsl:when test="false() and source/@identical = 'false'">
                                                <a href="{$basepath}/experiments/diff/{$vAccession}/ae2">2</a>
                                            </xsl:when>
                                            <xsl:otherwise>2</xsl:otherwise>
                                        </xsl:choose>
                                    </span>
                                    <span class="ae1">
                                        <xsl:choose>
                                            <xsl:when test="false() and source/@identical = 'false'">
                                                <a href="{$basepath}/experiments/diff/{$vAccession}/ae1">1</a>
                                            </xsl:when>
                                            <xsl:otherwise>1</xsl:otherwise>
                                        </xsl:choose>
                                    </span>
                                </xsl:when>
                                <xsl:when test="source/@id = 'ae2' and source/@migrated = 'true'">
                                    <span class="ae2">
                                        <xsl:choose>
                                            <xsl:when test="false() and source/@identical = 'false'">
                                                <a href="{$basepath}/experiments/diff/{$vAccession}/ae2">2</a>
                                            </xsl:when>
                                            <xsl:otherwise>2</xsl:otherwise>
                                        </xsl:choose>
                                    </span>
                                    <span>
                                        <xsl:choose>
                                            <xsl:when test="false() and source/@identical = 'false'">
                                                <a href="{$basepath}/experiments/diff/{$vAccession}/ae1">1</a>
                                            </xsl:when>
                                            <xsl:otherwise>1</xsl:otherwise>
                                        </xsl:choose>
                                    </span>
                                </xsl:when>
                                <xsl:otherwise>
                                    <span class="ae2">2</span>
                                    <span>&#183;</span>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:if>
                        <xsl:if test="not(user/@id = '1')">
                            <span class="lock">&#160;</span>
                        </xsl:if>
                        </div>
                    </div>
                </td>
                <td class="{$vDetailedViewMainTdClass}">
                    <div>
                        <xsl:call-template name="highlight">
                            <xsl:with-param name="pText" select="name"/>
                            <xsl:with-param name="pFieldName"/>
                        </xsl:call-template>
                    </div>
                </td>
                <td class="ae_align_right {$vDetailedViewMainTdClass}">
                    <div>
                        <xsl:call-template name="highlight">
                            <xsl:with-param name="pText" select="assays"/>
                            <xsl:with-param name="pFieldName" select="'assaycount'"/>
                        </xsl:call-template>
                    </div>
                </td>
                <td class="{$vDetailedViewMainTdClass}">
                    <div>
                        <xsl:call-template name="highlight">
                            <xsl:with-param name="pText" select="string-join(species, ', ')"/>
                            <xsl:with-param name="pFieldName" select="'species'"/>
                        </xsl:call-template>
                    </div>
                </td>
                <td class="{$vDetailedViewMainTdClass}">
                    <div>
                        <xsl:call-template name="highlight">
                            <xsl:with-param name="pText" select="releasedate"/>
                            <xsl:with-param name="pFieldName" select="'date'"/>
                        </xsl:call-template>
                    </div>
                </td>
                <td class="td_main_img ae_align_center {$vDetailedViewMainTdClass}">
                    <div>
                        <xsl:call-template name="data-files-main">
                            <xsl:with-param name="pKind" select="'fgem'"/>
                            <xsl:with-param name="pFiles" select="$vFiles"/>
                        </xsl:call-template>
                    </div>
                </td>
                <td class="td_main_img ae_align_center {$vDetailedViewMainTdClass}">
                    <div>
                        <xsl:call-template name="data-files-main">
                            <xsl:with-param name="pKind" select="'raw'"/>
                            <xsl:with-param name="pFiles" select="$vFiles"/>
                        </xsl:call-template>
                    </div>
                </td>
                <td class="td_main_img ae_align_center {$vDetailedViewMainTdClass}">
                    <div>
                        <xsl:choose>
                            <xsl:when test="@loadedinatlas"><a href="${interface.application.link.atlas.exp_query.url}{$vAccession}?ref=aebrowse"><img src="{$basepath}/assets/images/basic_tick.gif" width="16" height="16" alt="*"/></a></xsl:when>
                            <xsl:otherwise><img src="{$basepath}/assets/images/silk_data_unavail.gif" width="16" height="16" alt="-"/></xsl:otherwise>
                        </xsl:choose>
                    </div>
                </td>
            </tr>
            
            <!-- Here -->
            
            <tr id="{$vExpId}_ext" style="{$vDetailedViewExtStyle}">
                <td colspan="9" class="td_ext">
                    <div class="tbl">
                        <table cellpadding="0" cellspacing="0" border="0">
                            <xsl:variable name="vDescription" select="description[string-length(text) > 0 and not(contains(text, '(Generated description)'))]"/>
                           
                            <xsl:if test="$vDescription">
                                <tr>
                                    <td class="name"><div class="name">Description</div></td>
                                    <td class="value">
                                        <div class="value">
                                            <xsl:for-each select="$vDescription">
                                                <xsl:sort select="id" data-type="number"/>
                                                <xsl:apply-templates select="text" mode="highlight"/>
                                            </xsl:for-each>
                                        </div>
                                    </td>
                                </tr>
                            </xsl:if>

                            <xsl:if test="minseqescores">
                                <tr>
                                    <td class="name"><div class="name">MINSEQE score</div></td>
                                    <td class="value">
                                        <div class="value">
                                            <xsl:call-template name="min-score">
                                                <xsl:with-param name="pScores" select="minseqescores"/>
                                                <xsl:with-param name="pKind" select="'minseqe'"/>
                                            </xsl:call-template>
                                        </div>
                                    </td>
                                </tr>
                            </xsl:if>

                            <xsl:if test="miamescores">
                                <tr>
                                    <td class="name"><div class="name">MIAME score</div></td>
                                    <td class="value">
                                        <div class="value">
                                            <xsl:call-template name="min-score">
                                                <xsl:with-param name="pScores" select="miamescores"/>
                                                <xsl:with-param name="pKind" select="'miame'"/>
                                            </xsl:call-template>
                                        </div>
                                    </td>
                                </tr>
                            </xsl:if>

                            <xsl:if test="provider[role!='data_coder']">
                                <tr>
                                    <td class="name"><div class="name">Contact<xsl:if test="count(provider[role!='data_coder']) > 1">s</xsl:if></div></td>
                                    <td class="value">
                                        <div class="value">
                                            <xsl:call-template name="providers"/>
                                        </div>
                                    </td>
                                </tr>
                            </xsl:if>

                            <xsl:if test="bibliography/*">
                                <tr>
                                    <td class="name"><div class="name">Citation<xsl:if test="count(bibliography/*) > 1">s</xsl:if></div></td>
                                    <td class="value"><div class="value"><xsl:apply-templates select="bibliography"/></div></td>
                                </tr>
                            </xsl:if>
                          
<!-- here -->
                           <tr>
                                <td class="name"><div class="name">Links</div></td>
                                <td class="value">
                                    <div class="value">
                                        <xsl:if test="@loadedinatlas">
                                            <div><a href="${interface.application.link.atlas.exp_query.url}{$vAccession}?ref=aebrowse">Query Gene Expression Atlas</a></div>
                                        </xsl:if>
                                        <xsl:if test="secondaryaccession">
                                            <div><xsl:call-template name="secondaryaccession"/></div>
                                        </xsl:if>
                                        <xsl:if test="arraydesign">
                                            <xsl:for-each select="arraydesign">
                                                <div>
                                                    <a href="{$basepath}/arrays/{accession}">
                                                        <xsl:text>Array design </xsl:text>
                                                        <xsl:call-template name="highlight">
                                                            <xsl:with-param name="pText" select="concat(accession, ' - ', name)"/>
                                                            <xsl:with-param name="pFieldName" select="'array'"/>
                                                        </xsl:call-template>
                                                    </a>
                                                </div>
                                            </xsl:for-each>
                                        </xsl:if>
                                        <xsl:if test="source/@id = 'ae2'">
                                            <div>
                                                <a href="{$basepath}/protocols/browse.html?keywords=experiment%3A{$vAccession}">
                                                    <xsl:text>Experimental protocols</xsl:text>
                                                </a>
                                            </div>
                                        </xsl:if>
                                    </div>
                                </td>
                            </tr>
 							
                            <tr>
                                <td class="name"><div class="name">Files</div></td>
                                <xsl:choose>
                               		    <xsl:when test="$vFiles/file[@kind='raw' or @kind='fgem' or @kind='adf' or @kind='idf' or @kind='sdrf' or @kind='biosamples']">
                                        <td class="attrs">
                                            <div class="attrs">
                                                <table cellpadding="0" cellspacing="0" border="0">
                                                    <tbody>
                                                        <xsl:call-template name="data-files">
                                                            <xsl:with-param name="pFiles" select="$vFiles"/>
                                                        </xsl:call-template>
                                                        <xsl:call-template name="magetab-files">
                                                            <xsl:with-param name="pFiles" select="$vFiles"/> 
                                                        </xsl:call-template>
                                                        <xsl:call-template name="image-files">
                                                            <xsl:with-param name="pFiles" select="$vFiles"/>
                                                        </xsl:call-template>
                                                        <xsl:call-template name="magetab-files-array">
                                                            <xsl:with-param name="pFiles" select="$vFiles"/>
                                                        </xsl:call-template>
                                                    </tbody>
                                                </table>
                                            </div>
                                            <div class="attrs">
                                                <a href="{$basepath}/files/{$vAccession}">
                                                    <img src="{$basepath}/assets/images/silk_ftp.gif" width="16" height="16" alt=""/>
                                                    <xsl:text>Browse all available files</xsl:text>
                                                </a>
                                            </div>

                                        </td>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <td class="value">
                                            <div class="value">
                                                <a href="{$basepath}/files/{$vAccession}">
                                                    <img src="{$basepath}/assets/images/silk_ftp.gif" width="16" height="16" alt=""/>
                                                    <xsl:text>Browse all available files</xsl:text>
                                                </a>
                                            </div>    
                                        </td>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </tr>
                            
                           
                            
                       
                            <xsl:variable name="vExpTypeAndDesign" select="experimenttype | experimentdesign"/>
                            <xsl:if test="$vExpTypeAndDesign">
                                <tr>

                                    <td class="name"><div class="name">Experiment type<xsl:if test="count($vExpTypeAndDesign) > 1">s</xsl:if></div></td>
                                    <td class="value">
                                        <div class="value">
                                            <xsl:call-template name="highlight">
                                                <xsl:with-param name="pText" select="string-join(experimenttype, ', ')"/>
                                                <xsl:with-param name="pFieldName" select="'exptype'"/>
                                            </xsl:call-template>
                                            <xsl:if test="count(experimenttype) > 0 and count(experimentdesign) > 0">, </xsl:if>
                                            <xsl:call-template name="highlight">
                                                <xsl:with-param name="pText" select="string-join(experimentdesign, ', ')"/>
                                                <xsl:with-param name="pFieldName" select="'expdesign'"/>
                                            </xsl:call-template>
                                        </div>
                                    </td>
                                </tr>
                            </xsl:if>

                             <xsl:if test="experimentalfactor/name">
                                <tr>
                                    <td class="name"><div class="name">Experimental factors</div></td>
                                    <td class="attrs"><div class="attrs">
                                        <table cellpadding="0" cellspacing="0" border="0">
                                            <thead>
                                                <tr>
                                                    <th class="attr_name">Factor name</th>
                                                    <th class="attr_value">Factor values</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <xsl:for-each select="experimentalfactor">
                                                    <tr>
                                                        <td class="attr_name">
                                                            <xsl:call-template name="highlight">
                                                                <xsl:with-param name="pText" select="name"/>
                                                                <xsl:with-param name="pFieldName" select="'ef'"/>
                                                            </xsl:call-template>
                                                        </td>
                                                        <td class="attr_value">
                                                            <xsl:call-template name="highlight">
                                                                <xsl:with-param name="pText" select="string-join(value, ', ')"/>
                                                                <xsl:with-param name="pFieldName" select="'efv'"/>
                                                            </xsl:call-template>
                                                        </td>
                                                    </tr>
                                                </xsl:for-each>
                                            </tbody>
                                        </table></div>
                                   </td>
                                </tr>
                            </xsl:if>

                          <xsl:if test="sampleattribute/category">
                                <tr>
                                    <td class="name"><div class="name">Sample attributes</div></td>
                                    <td class="attrs"><div class="attrs">
                                        <table cellpadding="0" cellspacing="0" border="0">
                                            <thead>
                                                <tr>
                                                    <th class="attr_name">Attribute name</th>
                                                    <th class="attr_value">Attribute values</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <xsl:for-each select="sampleattribute">
                                                    <tr>
                                                         <td class="attr_name">
                                                            <xsl:call-template name="highlight">
                                                                <xsl:with-param name="pText" select="category"/>
                                                                <xsl:with-param name="pFieldName"/>
                                                            </xsl:call-template>
                                                        </td>
                                                        <td class="attr_value">
                                                            <xsl:call-template name="highlight">
                                                                <xsl:with-param name="pText" select="string-join(value, ', ')"/>
                                                                <xsl:with-param name="pFieldName" select="'sa'"/>
                                                            </xsl:call-template>
                                                        </td> 
                                                    </tr>
                                                </xsl:for-each>
                                            </tbody>
                                        </table></div>
                                    </td>
                                </tr>
                            </xsl:if>
                          
                            
                      <xsl:if test="submissiondate | lastupdatedate | releasedate">
                                <tr>
                                    <td class="name">
                                        <div class="name">
                                            <xsl:if test="submissiondate">
                                                <div>Submitted on</div>
                                            </xsl:if>
                                            <xsl:if test="lastupdatedate">
                                                <div>Last updated on</div>
                                            </xsl:if>
                                            <xsl:if test="releasedate">
                                                <div>Released on</div>
                                            </xsl:if>
                                        </div>
                                    </td>
                                    <td class="value">
                                        <div class="value">
                                            <xsl:if test="submissiondate">
                                                <div>
                                                    <xsl:apply-templates select="submissiondate/text()" mode="highlight"/>
                                                </div>
                                            </xsl:if>
                                            <xsl:if test="lastupdatedate">
                                                <div>
                                                    <xsl:apply-templates select="lastupdatedate/text()" mode="highlight"/>
                                                </div>
                                            </xsl:if>
                                           <xsl:if test="releasedate">
                                                <div>
                                                    <xsl:apply-templates select="releasedate/text()" mode="highlight">
                                                        <xsl:with-param name="pFieldName" select="'date'"/>
                                                    </xsl:apply-templates>
                                                </div>
                                            </xsl:if>
                                        </div>
                                    </td> 
                                </tr>
                            </xsl:if>  
                             
                        </table>
                    </div>
                </td>
            </tr>
    <!--  </xsl:if> -->
     </xsl:template>

    <xsl:template match="bibliography">
        <div>
            <xsl:variable name="vTitle">
                <xsl:if test="string-length(title) > 0">
                    <xsl:call-template name="highlight">
                        <xsl:with-param name="pText" select="aejava:trimTrailingDot(title)"/>
                        <xsl:with-param name="pFieldName"/>
                    </xsl:call-template>
                </xsl:if>
            </xsl:variable>
            <xsl:variable name="vPubInfo">
                <xsl:if test="string-length(authors) > 0">
                    <xsl:call-template name="highlight">
                        <xsl:with-param name="pText" select="aejava:trimTrailingDot(authors)"/>
                        <xsl:with-param name="pFieldName"/>
                    </xsl:call-template>
                    <xsl:text>. </xsl:text>
                </xsl:if>
                <xsl:if test="string-length(publication) > 0">
                    <em>
                        <xsl:call-template name="highlight">
                            <xsl:with-param name="pText" select="publication"/>
                            <xsl:with-param name="pFieldName"/>
                        </xsl:call-template>
                    </em><xsl:text>&#160;</xsl:text></xsl:if>
                <xsl:if test="string-length(volume) > 0">
                    <xsl:call-template name="highlight">
                        <xsl:with-param name="pText" select="volume"/>
                        <xsl:with-param name="pFieldName"/>
                    </xsl:call-template>
                    <xsl:if test="string-length(issue) > 0">
                        <xsl:text>(</xsl:text>
                        <xsl:call-template name="highlight">
                            <xsl:with-param name="pText" select="issue"/>
                            <xsl:with-param name="pFieldName"/>
                        </xsl:call-template>
                        <xsl:text>)</xsl:text>
                    </xsl:if>
                </xsl:if>
                <xsl:if test="string-length(pages) > 0">
                    <xsl:text>:</xsl:text>
                    <xsl:call-template name="highlight">
                        <xsl:with-param name="pText" select="pages"/>
                        <xsl:with-param name="pFieldName"/>
                    </xsl:call-template>
                </xsl:if>
                <xsl:if test="string-length(year) > 0">
                    <xsl:text>&#160;(</xsl:text>
                    <xsl:call-template name="highlight">
                        <xsl:with-param name="pText" select="year"/>
                        <xsl:with-param name="pFieldName"/>
                    </xsl:call-template>
                    <xsl:text>)</xsl:text>
                </xsl:if>
            </xsl:variable>
            <xsl:choose>
                <xsl:when test="doi">
                    <a href="http://dx.doi.org/{doi}"><xsl:copy-of select="$vTitle"/></a>
                    <xsl:text>. </xsl:text>
                    <xsl:copy-of select="$vPubInfo"/>
                </xsl:when>
                <xsl:when test="uri[starts-with(., 'http')]">
                    <a href="{uri}"><xsl:copy-of select="$vTitle"/></a>
                    <xsl:text>. </xsl:text>
                    <xsl:copy-of select="$vPubInfo"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:copy-of select="$vTitle"/>
                    <xsl:text>. </xsl:text>
                    <xsl:copy-of select="$vPubInfo"/>
                    <xsl:if test="string-length(uri) > 0">
                        <xsl:text> (</xsl:text>
                        <xsl:call-template name="highlight">
                            <xsl:with-param name="pText" select="uri"/>
                            <xsl:with-param name="pFieldName"/>
                        </xsl:call-template>
                        <xsl:text>)</xsl:text>
                    </xsl:if>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:if test="accession">
                <xsl:if test="number(accession) > 0">
                    <xsl:text>, </xsl:text>
                    <a href="http://www.ncbi.nlm.nih.gov/pubmed/{accession}">
                        <xsl:text>PubMed </xsl:text>
                        <xsl:call-template name="highlight">
                            <xsl:with-param name="pText" select="accession"/>
                            <xsl:with-param name="pFieldName" select="'pmid'"/>
                        </xsl:call-template>
                    </a>
                </xsl:if>
            </xsl:if>
        </div>
    </xsl:template>

    <xsl:template name="secondaryaccession">
        <xsl:for-each select="secondaryaccession">
            <xsl:choose>
                <xsl:when test="string-length(.) = 0"/>
                <xsl:when test="substring(., 1, 3)='GSE' or substring(., 1, 3)='GDS'">
                    <a href="http://www.ncbi.nlm.nih.gov/projects/geo/query/acc.cgi?acc={.}">
                        <xsl:text>GEO - </xsl:text>
                        <xsl:call-template name="highlight">
                            <xsl:with-param name="pText" select="."/>
                            <xsl:with-param name="pFieldName" select="'accession'"/>
                        </xsl:call-template>
                    </a>
                </xsl:when>
                <xsl:when test="substring(., 1, 2)='E-' and substring(., 7, 1)='-'">
                    <a href="{$basepath}/experiments/{.}">
                        <xsl:text>ArrayExpress - </xsl:text>
                        <xsl:call-template name="highlight">
                            <xsl:with-param name="pText" select="."/>
                            <xsl:with-param name="pFieldName" select="'accession'"/>
                        </xsl:call-template>
                    </a>
                </xsl:when>
                <xsl:when test="substring(., 1, 3)='SRP' or substring(., 1, 3)='ERP'">
                    <a href="http://www.ebi.ac.uk/ena/data/view/{.}">
                        <xsl:text>ENA - </xsl:text>
                        <xsl:call-template name="highlight">
                            <xsl:with-param name="pText" select="."/>
                            <xsl:with-param name="pFieldName" select="'accession'"/>
                        </xsl:call-template>
                    </a>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:call-template name="highlight">
                        <xsl:with-param name="pText" select="."/>
                        <xsl:with-param name="pFieldName" select="'accession'"/>
                    </xsl:call-template>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:if test="position() != last() and string-length(.) > 0">, </xsl:if>
        </xsl:for-each>
    </xsl:template>

    <xsl:template name="providers">
        <xsl:for-each select="provider[not(contact=following-sibling::provider/contact) and role!='data_coder']">
            <xsl:sort select="role='submitter'" order="descending"/>
            <xsl:sort select="lower-case(contact)"/>
            <xsl:choose>
                <xsl:when test="role='submitter' and string-length(email) > 0">
                    <a href="mailto:{email}">
                        <xsl:call-template name="highlight">
                            <xsl:with-param name="pText" select="concat(contact, ' &lt;', email, '&gt;')"/>
                            <xsl:with-param name="pFieldName"/>
                        </xsl:call-template>
                    </a>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:call-template name="highlight">
                        <xsl:with-param name="pText" select="contact"/>
                        <xsl:with-param name="pFieldName"/>
                    </xsl:call-template>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:if test="position()!=last()">, </xsl:if>
        </xsl:for-each>
    </xsl:template>

    <xsl:template name="min-score">
        <xsl:param name="pScores"/>
        <xsl:param name="pKind"/>

        <table class="min-score-tbl" border="0" cellpadding="0" cellspacing="0">
            <thead>
                <tr>
                    <xsl:if test="$pKind = 'miame'">
                        <th>Array designs</th>
                    </xsl:if>
                    <xsl:if test="$pKind = 'minseqe'">
                        <th>Expt. design</th>
                    </xsl:if>
                    <th>Protocols</th>
                    <th>Factors</th>
                    <th>Processed data</th>
                    <xsl:if test="$pKind = 'miame'">
                        <th>Raw data</th>
                    </xsl:if>
                    <xsl:if test="$pKind = 'minseqe'">
                        <th>Sequence Reads</th>
                    </xsl:if>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>
                        <xsl:if test="$pKind = 'miame'">
                            <xsl:call-template name="min-score-tick">
                                <xsl:with-param name="pValue" select="$pScores/reportersequencescore"/>
                            </xsl:call-template>
                        </xsl:if>
                        <xsl:if test="$pKind = 'minseqe'">
                            <xsl:call-template name="min-score-tick">
                                <xsl:with-param name="pValue" select="$pScores/experimentdesignscore"/>
                            </xsl:call-template>
                       </xsl:if>
                    </td>
                    <td>
                        <xsl:call-template name="min-score-tick">
                            <xsl:with-param name="pValue" select="$pScores/protocolscore"/>
                        </xsl:call-template>
                    </td>
                    <td>
                        <xsl:call-template name="min-score-tick">
                            <xsl:with-param name="pValue" select="$pScores/factorvaluescore"/>
                        </xsl:call-template>
                    </td>
                    <td>
                        <xsl:call-template name="min-score-tick">
                            <xsl:with-param name="pValue" select="$pScores/derivedbioassaydatascore"/>
                        </xsl:call-template>
                    </td>
                    <td>
                        <xsl:call-template name="min-score-tick">
                            <xsl:with-param name="pValue" select="$pScores/measuredbioassaydatascore"/>
                        </xsl:call-template>
                    </td>
                </tr>
            </tbody>
        </table>
    </xsl:template>

    <xsl:template name="min-score-tick">
        <xsl:param name="pValue"/>

        <xsl:choose>
            <xsl:when test="$pValue='1'">
                <img src="{$basepath}/assets/images/basic_tick.gif" width="16" height="16" alt="*"/>
            </xsl:when>
            <xsl:otherwise>
                <img src="{$basepath}/assets/images/silk_data_unavail.gif" width="16" height="16" alt="-"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="data-files">
        <xsl:param name="pFiles"/>
        <xsl:variable name="vAccession" select="string(accession)"/>
        <xsl:variable name="vFiles" select="$pFiles/file[@kind = 'raw' or @kind = 'fgem']"/>
        <xsl:if test="$vFiles">
            <tr>
                <td class="attr_name">Data Archives</td>
                <td class="attr_value">
                    <xsl:for-each select="$vFiles">
                        <xsl:sort select="@kind"/>
                        <xsl:sort select="lower-case(@name)"/>
                        <a href="{$vBaseUrl}/files/{$vAccession}/{@name}">
                            <xsl:value-of select="@name"/>
                        </a>
                        <xsl:if test="position() != last()">
                            <xsl:text>, </xsl:text>
                        </xsl:if>
                    </xsl:for-each>
                </td>
            </tr>
        </xsl:if>
    </xsl:template>

    <xsl:template name="magetab-files">
        <xsl:param name="pFiles"/>

        <xsl:variable name="vAccession" select="string(accession)"/>
        <xsl:variable name="vFiles" select="$pFiles/file[@extension = 'txt' and (@kind = 'idf' or @kind = 'sdrf')]"/>
        <xsl:if test="$vFiles">
            <xsl:for-each-group select="$vFiles" group-by="@kind">
                <xsl:sort select="@kind"/>
                <tr>
                    <td class="attr_name">
                        <xsl:choose>
                            <xsl:when test="current-grouping-key() = 'idf'">Investigation Description</xsl:when>
                            <xsl:when test="current-grouping-key() = 'sdrf'">Sample and Data Relationship</xsl:when>
                        </xsl:choose>
                    </td>
                    <td class="attr_value">
                        <xsl:for-each select="current-group()">
                            <xsl:sort select="lower-case(@name)"/>
                            <a href="{$vBaseUrl}/files/{$vAccession}/{@name}">
                                <xsl:value-of select="@name"/>
                            </a>
                            <xsl:text> | </xsl:text>
                            <a href="{$vBaseUrl}/experiments/{$vAccession}/{replace(@name, '[^\.]+\.(.*)(idf|sdrf).+', '$1')}{current-grouping-key()}.html">
                                <xsl:text>view</xsl:text>
                            </a><img class="new" src="assets/images/silk_new.gif" width="16" height="13" alt="new!"/>
                            <xsl:if test="position() != last()">
                                <xsl:text>, </xsl:text>
                            </xsl:if>
                        </xsl:for-each>
                    </td>
                </tr>

            </xsl:for-each-group>

        </xsl:if>
    </xsl:template>

    <xsl:template name="magetab-files-array">
        <xsl:param name="pFiles"/>

        <xsl:variable name="vArrayAccession" select="distinct-values(arraydesign/accession)"/>
        <xsl:variable name="vFiles" select="$pFiles/file[@extension = 'txt' and @kind = 'adf']"/>
        <xsl:if test="$vFiles">
            <tr>
                <td class="attr_name">Array Design</td>
                <td class="attr_value">
                    <xsl:for-each select="$vFiles">
                        <xsl:sort select="@name"/>
                        <a href="{$vBaseUrl}/files/{../@accession}/{@name}"><xsl:value-of select="@name"/></a>
                        <xsl:if test="position() != last()">
                            <xsl:text>, </xsl:text>
                        </xsl:if>
                    </xsl:for-each>
                </td>
            </tr>
        </xsl:if>
    </xsl:template>

    <xsl:template name="image-files">
        <xsl:param name="pFiles"/>

        <xsl:variable name="vAccession" select="string(accession)"/>
        <xsl:variable name="vFiles" select="$pFiles/file[@kind = 'biosamples' and (@extension = 'png' or @extension = 'svg')]"/>
        <xsl:if test="$vFiles">
            <tr>
                <td class="attr_name">Experiment Design Images</td>
                <td class="attr_value">
                    <xsl:for-each select="$vFiles">
                        <xsl:sort select="lower-case(@extension)"/>
                        <a href="{$vBaseUrl}/files/{$vAccession}/{@name}"><xsl:value-of select="@name"/></a>
                        <xsl:if test="position() != last()">
                            <xsl:text>, </xsl:text>
                        </xsl:if>
                    </xsl:for-each>
                </td>
            </tr>
        </xsl:if>
    </xsl:template>

    <xsl:template name="data-files-main">
        <xsl:param name="pFiles"/>

        <xsl:param name="pKind"/>
        <xsl:variable name="vAccession" select="string(accession)"/>
        <xsl:variable name="vFiles" select="$pFiles/file[@kind = $pKind]"/>
        <xsl:variable name="vImg">
            <xsl:choose>
                <xsl:when test="$pKind = 'raw' and seqdatauri">
                    <img src="{$basepath}/assets/images/data_link_ena.gif" width="23" height="16" alt="Link to sequence data"/>
                </xsl:when>
                <xsl:when test="$pKind = 'raw' and contains($vFiles[1]/@dataformat, 'CEL')">
                    <img src="{$basepath}/assets/images/silk_data_save_affy.gif" width="16" height="16" alt="Click to download Affymetrix data"/>
                </xsl:when>
                <xsl:when test="$pKind = 'raw'">
                    <img src="{$basepath}/assets/images/silk_data_save.gif" width="16" height="16" alt="Click to download raw data"/>
                </xsl:when>
                <xsl:otherwise>
                    <img src="{$basepath}/assets/images/silk_data_save.gif" width="16" height="16" alt="Click to download processed data"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <xsl:variable name="vLinkUrl">
            <xsl:choose>
                <xsl:when test="$pKind = 'raw' and seqdatauri">
                    <xsl:value-of select="seqdatauri"/>
                </xsl:when>
                <xsl:when test="count($vFiles) > 1">
                    <xsl:value-of select="$basepath"/>
                    <xsl:text>/files/</xsl:text>
                    <xsl:value-of select="$vAccession"/>
                    <xsl:text>?kind=</xsl:text>
                    <xsl:value-of select="$pKind"/>
                </xsl:when>
                <xsl:when test="$vFiles">
                    <xsl:value-of select="$vBaseUrl"/>
                    <xsl:text>/files/</xsl:text>
                    <xsl:value-of select="$vAccession"/>
                    <xsl:text>/</xsl:text>
                    <xsl:value-of select="$vFiles/@name"/>
                </xsl:when>
            </xsl:choose>
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="string-length($vLinkUrl)>0"><a href="{$vLinkUrl}"><xsl:copy-of select="$vImg"/></a></xsl:when>
            <xsl:otherwise><img src="{$basepath}/assets/images/silk_data_unavail.gif" width="16" height="16" alt="-"/></xsl:otherwise>
        </xsl:choose>
    </xsl:template>




</xsl:stylesheet>
