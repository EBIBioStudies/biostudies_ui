<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="1.0">

    <xsl:template name="ae-sort-experiments">
        <xsl:param name="pExperiments"/>
        <xsl:param name="pFrom"/>
        <xsl:param name="pTo"/>
        <xsl:param name="pSortBy"/>
        <xsl:param name="pSortOrder"/>
        <xsl:choose>
            <xsl:when test="$pSortBy='accession'">
                <xsl:apply-templates select="$pExperiments">
                    <xsl:sort select="substring(accession/text(),3,4)" order="{$pSortOrder}"/>
                    <!-- sort by experiment 4-letter code -->
                    <xsl:sort select="substring(accession/text(),8)" order="{$pSortOrder}" data-type="number"/>
                    <!-- sort by number -->
                    <xsl:with-param name="pFrom" select="$pFrom"/>
                    <xsl:with-param name="pTo" select="$pTo"/>
                </xsl:apply-templates>
            </xsl:when>
            <xsl:when test="$pSortBy='assays'">
                <xsl:apply-templates select="$pExperiments">
                    <xsl:sort select="assays" order="{$pSortOrder}" data-type="number"/>
                    <!-- then sort by accession -->
                    <xsl:sort select="substring(accession/text(),3,4)" order="ascending"/>
                    <!-- sort by experiment 4-letter code -->
                    <xsl:sort select="substring(accession/text(),8)" order="ascending" data-type="number"/>
                    <!-- sort by number -->

                    <xsl:with-param name="pFrom" select="$pFrom"/>
                    <xsl:with-param name="pTo" select="$pTo"/>
                </xsl:apply-templates>
            </xsl:when>
            <xsl:when test="$pSortBy='releasedate'">
                <xsl:apply-templates select="$pExperiments">
                    <!-- year -->
                    <xsl:sort select="substring-before(releasedate/text(),'-')" order="{$pSortOrder}" data-type="number"/>
                    <!-- month -->
                    <xsl:sort select="substring-before(substring-after(releasedate/text(),'-'),'-')" order="{$pSortOrder}"
                              data-type="number"/>
                    <!-- day -->
                    <xsl:sort select="substring-after(substring-after(releasedate/text(),'-'),'-')" order="{$pSortOrder}"
                              data-type="number"/>
                    <!-- then sort by accession -->
                    <xsl:sort select="substring(accession/text(),3,4)" order="ascending"/>
                    <!-- sort by experiment 4-letter code -->
                    <xsl:sort select="substring(accession/text(),8)" order="ascending" data-type="number"/>
                    <!-- sort by number -->

                    <xsl:with-param name="pFrom" select="$pFrom"/>
                    <xsl:with-param name="pTo" select="$pTo"/>
                </xsl:apply-templates>
            </xsl:when>
            <xsl:when test="$pSortBy='species'">
                <xsl:apply-templates select="$pExperiments">
                    <xsl:sort select="species[1]" order="{$pSortOrder}"/>
                    <xsl:sort select="species[2]" order="{$pSortOrder}"/>
                    <xsl:sort select="species[2]" order="{$pSortOrder}"/>
                    <!-- then sort by accession -->
                    <xsl:sort select="substring(accession/text(),3,4)" order="ascending"/>
                    <!-- sort by experiment 4-letter code -->
                    <xsl:sort select="substring(accession/text(),8)" order="ascending" data-type="number"/>
                    <!-- sort by number -->

                    <xsl:with-param name="pFrom" select="$pFrom"/>
                    <xsl:with-param name="pTo" select="$pTo"/>
                </xsl:apply-templates>
            </xsl:when>
            <xsl:when test="$pSortBy='fgem'">
                <xsl:apply-templates select="$pExperiments">
                    <xsl:sort select="file[kind = 'fgem']/bioassays" order="{$pSortOrder}" data-type="number"/>
                    <!-- then sort by accession -->
                    <xsl:sort select="substring(accession/text(),3,4)" order="ascending"/>
                    <!-- sort by experiment 4-letter code -->
                    <xsl:sort select="substring(accession/text(),8)" order="ascending" data-type="number"/>
                    <!-- sort by number -->

                    <xsl:with-param name="pFrom" select="$pFrom"/>
                    <xsl:with-param name="pTo" select="$pTo"/>
                </xsl:apply-templates>
            </xsl:when>
            <xsl:when test="$pSortBy='raw'">
                <xsl:apply-templates select="$pExperiments">
                    <xsl:sort select="file[kind = 'raw']/bioassays" order="{$pSortOrder}" data-type="number"/>
                    <!-- then sort by accession -->
                    <xsl:sort select="substring(accession/text(),3,4)" order="ascending"/>
                    <!-- sort by experiment 4-letter code -->
                    <xsl:sort select="substring(accession/text(),8)" order="ascending" data-type="number"/>
                    <!-- sort by number -->

                    <xsl:with-param name="pFrom" select="$pFrom"/>
                    <xsl:with-param name="pTo" select="$pTo"/>
                </xsl:apply-templates>
            </xsl:when>
            <xsl:when test="$pSortBy='atlas'">
                <xsl:apply-templates select="$pExperiments">
                    <xsl:sort select="@loadedinatlas" order="{$pSortOrder}"/>
                    <!-- then sort by accession -->
                    <xsl:sort select="substring(accession/text(),3,4)" order="ascending"/>
                    <!-- sort by experiment 4-letter code -->
                    <xsl:sort select="substring(accession/text(),8)" order="ascending" data-type="number"/>
                    <!-- sort by number -->

                    <xsl:with-param name="pFrom" select="$pFrom"/>
                    <xsl:with-param name="pTo" select="$pTo"/>
                </xsl:apply-templates>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates select="$pExperiments">
                    <xsl:sort select="*[name()=$pSortBy]" order="{$pSortOrder}"/>
                    <!-- then sort by accession -->
                    <xsl:sort select="substring(accession/text(),3,4)" order="ascending"/>
                    <!-- sort by experiment 4-letter code -->
                    <xsl:sort select="substring(accession/text(),8)" order="ascending" data-type="number"/>
                    <!-- sort by number -->

                    <xsl:with-param name="pFrom" select="$pFrom"/>
                    <xsl:with-param name="pTo" select="$pTo"/>
                </xsl:apply-templates>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
</xsl:stylesheet>