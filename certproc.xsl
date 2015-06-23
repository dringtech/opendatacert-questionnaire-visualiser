<xsl:stylesheet version="1.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
 <xsl:output omit-xml-declaration="yes" indent="yes"/>
 <xsl:strip-space elements="*"/>

<xsl:output method="html"></xsl:output>
<xsl:variable name='newline'><xsl:text>&#xa;</xsl:text></xsl:variable>

<xsl:template match="/">
    <xsl:apply-templates/>
</xsl:template>

<xsl:template name="dumper" match="*">
    <xsl:param name="level">0</xsl:param>
    <div>
    <pre>
        <xsl:value-of select="name()"/>
        <xsl:if test="@id">#<xsl:value-of select="@id"/></xsl:if>
        <xsl:value-of select="$newline"/>
    </pre>
    <xsl:apply-templates>
        <xsl:with-param name="level" select="$level + 1"/>
    </xsl:apply-templates>
    </div>
</xsl:template>

<xsl:template match="questionnaire">
    <xsl:apply-templates/>
</xsl:template>

<xsl:template match="levels">
    <h1>Levels</h1>
    <dl>
    <xsl:apply-templates select="level"/>
    </dl>
</xsl:template>

<xsl:template match="level">
    <dt><xsl:value-of select="@id"/></dt>
    <dd><xsl:value-of select="text()"/></dd>
</xsl:template>

<xsl:template match="group">
    <xsl:param name="level"/>
    <div>
        <h1><xsl:apply-templates select="label"/></h1>
        <xsl:apply-templates select="help"/>
        <xsl:apply-templates select="if|question|group">
            <xsl:with-param name="level" select="$level + 1"/>
        </xsl:apply-templates>
    </div>
</xsl:template>

<xsl:template match="help">
    <div class="help"><xsl:value-of select="text()"/></div>
</xsl:template>

<xsl:template match="label">
    <xsl:value-of select="text()"/>
</xsl:template>

<xsl:template match="question">
    <div>
    <h2><xsl:apply-templates select="label"/></h2>
    <xsl:apply-templates select="help"/>
    <xsl:apply-templates select="input|radioset|yesno"/>
    <xsl:apply-templates select="if|requirement"/>
    </div>
</xsl:template>

<xsl:template match="input">
    <div><p>Type: INPUT</p></div>
</xsl:template>

<xsl:template match="radioset">
    <div><p>Type: RADIOSET</p>
    <ul>
        <xsl:for-each select="option">
            <li><xsl:value-of select="label/text()"/> (<xsl:value-of select="help/text()"/>)</li>
        </xsl:for-each>
    </ul>
    </div>
</xsl:template>

<xsl:template match="requirement">
    <div>Requirement: <xsl:copy-of select="text()|*"/></div>
</xsl:template>

</xsl:stylesheet>
