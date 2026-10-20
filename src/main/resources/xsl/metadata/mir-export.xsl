<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:i18n="xalan://org.mycore.services.i18n.MCRTranslation"
  xmlns:exslt="http://exslt.org/common" xmlns:mods="http://www.loc.gov/mods/v3" exclude-result-prefixes="exslt i18n mods">
  <xsl:import href="xslImport:modsmeta:metadata/mir-export.xsl" />
  <xsl:param name="MCR.Export.Transformers" />
  <xsl:template match="/">
    <!-- START ostasien adaptions (OSTA-12) -->
    <!--
    <xsl:variable name="objectId" select="/mycoreobject/@ID" />
    <xsl:variable name="transformerTokens">
      <xsl:call-template name="Tokenizer">
        <xsl:with-param name="string" select="$MCR.Export.Transformers" />
        <xsl:with-param name="delimiter" select="','" />
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="transformers" select="exslt:node-set($transformerTokens)/token" />
    <xsl:if test="$transformers">
      <div id="mir-export">
        <xsl:call-template name="exportTransformer">
          <xsl:with-param name="transformer" select="$transformers[1]" />
          <xsl:with-param name="objectId" select="$objectId" />
        </xsl:call-template>
        <xsl:for-each select="$transformers[position()>1]">
          <xsl:call-template name="printSeparator" />
          <xsl:call-template name="exportTransformer">
            <xsl:with-param name="transformer" select="." />
            <xsl:with-param name="objectId" select="$objectId" />
          </xsl:call-template>
        </xsl:for-each>
      </div>
    </xsl:if>
    -->
    <xsl:variable name="mods" select="mycoreobject/metadata/def.modsContainer/modsContainer/mods:mods" />
    <div id="mir-export">
      <xsl:call-template name="exportLink">
        <xsl:with-param name="transformer" select="'bibtex'"/>
        <xsl:with-param name="linkText" select="'BibTeX'"/>
      </xsl:call-template>
      <xsl:call-template name="printSeperator" />
      <xsl:call-template name="exportLink">
        <xsl:with-param name="transformer" select="'mods'"/>
        <xsl:with-param name="linkText" select="'MODS'"/>
      </xsl:call-template>
      <xsl:call-template name="printSeperator" />
      <xsl:call-template name="exportLink">
        <xsl:with-param name="transformer" select="'marcxml'"/>
        <xsl:with-param name="linkText" select="'MARCXML'"/>
      </xsl:call-template>
      <xsl:call-template name="printSeperator" />
      <xsl:call-template name="exportLink">
        <xsl:with-param name="transformer" select="'ris'"/>
        <xsl:with-param name="linkText" select="'RIS'"/>
      </xsl:call-template>
      <xsl:call-template name="printSeperator" />
      <xsl:call-template name="exportLink">
        <xsl:with-param name="transformer" select="'isi'"/>
        <xsl:with-param name="linkText" select="'ISI'"/>
      </xsl:call-template>
      <xsl:call-template name="printSeperator" />
      <xsl:call-template name="exportLink">
        <xsl:with-param name="transformer" select="'pica3'"/>
        <xsl:with-param name="linkText" select="'PICA'"/>
      </xsl:call-template>
      <xsl:call-template name="printSeperator" />
      <xsl:call-template name="exportLink">
        <xsl:with-param name="transformer" select="'mods2csv'"/>
        <xsl:with-param name="linkText" select="'CSV'"/>
      </xsl:call-template>
      <xsl:call-template name="printSeperator" />
      <xsl:call-template name="exportLink">
        <xsl:with-param name="transformer" select="'mods2dc'"/>
        <xsl:with-param name="linkText" select="'DC'"/>
      </xsl:call-template>
      <xsl:call-template name="printSeperator" />
      <xsl:call-template name="exportLink">
        <xsl:with-param name="transformer" select="'datacite'"/>
        <xsl:with-param name="linkText" select="'DataCite'"/>
      </xsl:call-template>
    </div>
    <!-- END ostasien adaptions (OSTA-12) -->
    <xsl:apply-imports />
  </xsl:template>
  <xsl:template name="exportTransformer">
    <xsl:param name="transformer" />
    <xsl:param name="objectId"  />
    <xsl:call-template name="exportLink">
      <xsl:with-param name="transformer" select="substring-before($transformer,':')" />
      <xsl:with-param name="linkText" select="substring-after($transformer,':')" />
      <xsl:with-param name="objectId" select="$objectId" />
    </xsl:call-template>
  </xsl:template>
  <xsl:template name="exportLink">
    <xsl:param name="transformer" />
    <xsl:param name="linkText" />
    <xsl:param name="objectId"  />
    <a>
      <xsl:attribute name="href">
        <!-- START ostasien adaptions (OSTA-12) -->
        <!--
        <xsl:value-of select="concat($WebApplicationBaseURL,'receive/',$objectId,'?XSL.Transformer=',$transformer)" />
        -->
        <xsl:value-of select="concat($WebApplicationBaseURL,'receive/',/mycoreobject/@ID,'?XSL.Transformer=',$transformer)" />
        <!-- END ostasien adaptions (OSTA-12) -->
      </xsl:attribute>
      <xsl:value-of select="$linkText" />
    </a>
  </xsl:template>
  <xsl:template name="printSeparator">
    <span><xsl:text>, </xsl:text></span>
  </xsl:template>
  <!-- START ostasien adaptions (OSTA-12) -->
  <xsl:template name="printSeperator">
    <span><xsl:text>, </xsl:text></span>
  </xsl:template>
  <!-- END ostasien adaptions (OSTA-12) -->
</xsl:stylesheet>
