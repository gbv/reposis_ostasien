<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:mcri18n="xalan://org.mycore.services.i18n.MCRTranslation"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  exclude-result-prefixes="mcri18n">

  <xsl:template match="index-search-form">
    <form action="../servlets/solr/find" id="project-searchMainPage" class="form-inline" role="search">
      <div class="input-group input-group-lg w-100">
        <input
          name="condQuery"
          placeholder="{mcri18n:translate('ostasien.index.search.placeholder.default')}"
          class="form-control search-query"
          id="project-searchInput"
          type="text" />
        <div class="input-group-append">
          <button type="submit" class="btn btn-secondary">
            <i class="fa fa-search"></i>
          </button>
        </div>
      </div>
    </form>
  </xsl:template>
</xsl:stylesheet>
