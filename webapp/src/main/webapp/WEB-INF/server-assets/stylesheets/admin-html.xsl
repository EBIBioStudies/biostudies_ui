<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:ae="http://www.ebi.ac.uk/arrayexpress/xslt"
                xmlns:html="http://www.w3.org/1999/xhtml"
                extension-element-prefixes="ae html"
                exclude-result-prefixes="ae html"
                version="2.0">

    <xsl:param name="userid"/>

    <!-- dynamically set by QueryServlet: host name (as seen from client) and base context path of webapp -->
    <xsl:param name="host"/>
    <xsl:param name="basepath"/>

    <xsl:include href="ae-file-functions.xsl"/>

    <xsl:variable name="vBaseUrl">http://<xsl:value-of select="$host"/><xsl:value-of select="$basepath"/></xsl:variable>

    <xsl:output omit-xml-declaration="yes" method="html"
                indent="no" encoding="ISO-8859-1" doctype-public="-//W3C//DTD HTML 4.01 Transitional//EN"/>

    <xsl:include href="ae-html-page.xsl"/>

    <xsl:template match="/">
        <html lang="en">
            <xsl:call-template name="page-header">
                <xsl:with-param name="pTitle">Administration | ArrayExpress Archive | EBI</xsl:with-param>
                <xsl:with-param name="pExtraCode">
                    <link rel="stylesheet" href="{$basepath}/assets/stylesheets/ae_common_20.css" type="text/css"/>
                    <link rel="stylesheet" href="{$basepath}/assets/stylesheets/ae_files_100924.css" type="text/css"/>
                    <script src="{$basepath}/assets/scripts/jquery-1.4.2.min.js" type="text/javascript"/>
                    <script src="{$basepath}/assets/scripts/ae_files_100924.js" type="text/javascript"/>
                </xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="page-body"/>
        </html>
    </xsl:template>

    <xsl:template name="ae-contents">
        <div class="ae_left_container_100pc assign_font">
            <div id="ae_files_content">
                <xsl:choose>
                    <xsl:when test="'0' = $userid">
                    </xsl:when>
                    <xsl:otherwise>
                        <div class="ae_protected_area">
                            <div>Sorry, the access to the resource you are requesting is restricted. You may wish to go <a href="javascript:history.back()" title="Click to go to the page you just left">back</a>, or to <a href="{$basepath}" title="ArrayExpress Home">ArrayExpress Home</a>.</div>
                            <div>We value your feedback. If you believe there was an error and wish to report it, please do not hesitate to drop us a line to <strong>arrayexpress(at)ebi.ac.uk</strong> or use <a href="${interface.application.link.www_domain}/support/" title="EBI Support">EBI Support Feedback</a> form.</div>
                        </div>
                    </xsl:otherwise>
                </xsl:choose>
            </div>
        </div>
    </xsl:template>
</xsl:stylesheet>
