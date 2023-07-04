<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:i18n="xalan://org.mycore.services.i18n.MCRTranslation"
    xmlns:mcrver="xalan://org.mycore.common.MCRCoreVersion"
    xmlns:mcrxsl="xalan://org.mycore.common.xml.MCRXMLFunctions"
    xmlns:calendar="xalan://java.util.GregorianCalendar"
    exclude-result-prefixes="i18n mcrver mcrxsl calendar">

  <xsl:import href="resource:xsl/layout/mir-common-layout.xsl" />
  <xsl:param name="MIR.TestInstance" select="'true'"/>
  <xsl:param name="MIR.Matomo" select="false" />

  <xsl:template name="mir.navigation">

    <div id="header_box" class="clearfix container">
      <div id="options_nav_box" class="mir-prop-nav">
        <nav class="navbar navbar-expand-lg navbar-dark ml-auto flex-row">

          <button
            class="navbar-toggler"
            type="button"
            data-toggle="collapse"
            data-target="#mir-main-nav-collapse-box"
            aria-controls="mir-main-nav-collapse-box"
            aria-expanded="false"
            aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
          </button>

          <div id="mir-main-nav-collapse-box" class="collapse navbar-collapse mir-main-nav__entries">
            <ul class="navbar-nav mr-auto mt-2 mt-lg-0">
              <xsl:for-each select="$loaded_navigation_xml/menu">
                <xsl:choose>
                  <xsl:when test="@id='about'"/>
                  <xsl:when test="@id='rights'"/>
                  <xsl:when test="@id='technical'"/>
                  <xsl:when test="@id='user'"/>
                  <xsl:otherwise>
                    <xsl:apply-templates select="."/>
                  </xsl:otherwise>
                </xsl:choose>
              </xsl:for-each>
              <xsl:call-template name="mir.basketMenu" />
              <xsl:if test="not(mcrxsl:isCurrentUserGuestUser())">
                <xsl:call-template name="mir.loginMenu" />
              </xsl:if>
              <xsl:call-template name="mir.languageMenu" />
            </ul>
          </div>
        </nav>
      </div>
      <div id="project_logo_box">
        <a href="{concat($WebApplicationBaseURL,substring($loaded_navigation_xml/@hrefStartingPage,2),$HttpSession)}"
           class="">
          <span id="logo_modul">CrossAsia</span>
          <span id="logo_slogan">E-Publishing</span>
        </a>
      </div>
    </div>
  </xsl:template>

  <xsl:template name="mir.jumbotwo">
    <!-- show only on startpage -->
    <xsl:if test="//div/@class='jumbotwo'">
    </xsl:if>
  </xsl:template>

  <xsl:template name="mir.footer">
    <div class="container">
      <div class="row">
        <div class="col-3">
          <h4><xsl:value-of select="i18n:translate('project.layout.footer.about')" /></h4>
          <ul class="internal_links">
            <xsl:apply-templates select="$loaded_navigation_xml/menu[@id='about']/*" mode="footerMenu"/>
          </ul>
        </div>
        <div class="col-3">
          <h4><xsl:value-of select="i18n:translate('project.layout.footer.rights')" /></h4>
          <ul class="internal_links">
            <xsl:apply-templates select="$loaded_navigation_xml/menu[@id='rights']/*" mode="footerMenu" />
          </ul>
        </div>
        <div class="col-3">
          <h4><xsl:value-of select="i18n:translate('project.layout.footer.technical')" /></h4>
          <ul class="internal_links">
            <xsl:apply-templates select="$loaded_navigation_xml/menu[@id='technical']/*" mode="footerMenu" />
          </ul>
        </div>
        <div class="col-3">
          <h4><xsl:value-of select="i18n:translate('project.layout.footer.service')" /></h4>
          <div class="logo-block-sbb">
            <img src="{$WebApplicationBaseURL}mir-layout/images/LogoSBB.png" alt="" mode="footerMenu" />
          </div>
        </div>
      </div>
    </div>
  </xsl:template>

  <xsl:template name="mir.powered_by">
    <xsl:variable name="mcr_version" select="concat('MyCoRe ',mcrver:getCompleteVersion())" />
    <div id="powered_by" >
      <div class="container">
        <div class="row">
          <div class="col-12 text-right" title="{$mcr_version}">
            <xsl:variable name="tmp" select="calendar:new()"/>
            <span>©<xsl:value-of select="calendar:get($tmp, 1)"/> Copyright CrossAsia</span>
          </div>
        </div>
      </div>
    </div>
    <xsl:if test="contains($MIR.TestInstance, 'true')">
      <div id="watermark_testenvironment">Testumgebung</div>
    </xsl:if>

    <!-- Matomo -->
    <!-- #OSTA-66 -->
    <xsl:if test="contains($MIR.Matomo, 'true')">
      <script type="text/javascript">
        var _paq = window._paq = window._paq || [];
        _paq.push(['disableCookies']);
        _paq.push(['trackPageView']);
        _paq.push(['enableLinkTracking']);
        (function() {
        var u="https://webstats.sbb.berlin/";
        _paq.push(['setTrackerUrl', u+'matomo.php']);
        _paq.push(['setSiteId', '82']);
        var d=document, g=d.createElement('script'), s=d.getElementsByTagName('script')[0];
        g.type='text/javascript'; g.async=true; g.src=u+'matomo.js'; s.parentNode.insertBefore(g,s);
        })();
      </script>
    </xsl:if>

  </xsl:template>

</xsl:stylesheet>
