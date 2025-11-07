<?xml version="1.0" encoding="utf-8"?>
  <!-- ============================================== -->
  <!-- $Revision$ $Date$ -->
  <!-- ============================================== -->
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xlink="http://www.w3.org/1999/xlink"
  xmlns:mcrxsl="xalan://org.mycore.common.xml.MCRXMLFunctions"
  xmlns:i18n="xalan://org.mycore.services.i18n.MCRTranslation"
  exclude-result-prefixes="xlink i18n">

  <xsl:output method="html" indent="yes" omit-xml-declaration="yes" media-type="text/html"
    version="5" />
  <xsl:strip-space elements="*" />
  <xsl:include href="resource:xsl/mir-flatmir-layout-utils.xsl"/>
  <xsl:param name="MIR.DefaultLayout.CSS" />
  <xsl:param name="MIR.CustomLayout.CSS" select="''" />
  <xsl:param name="MIR.CustomLayout.JS" select="''" />
  <xsl:param name="MIR.Layout.Theme" />

  <xsl:variable name="PageTitle" select="/*/@title" />

  <xsl:template match="/site">
    <xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;</xsl:text>
    <html lang="{$CurrentLang}" class="no-js">
      <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
        <title>
          <xsl:value-of select="$PageTitle" />
        </title>
        <link href="{$WebApplicationBaseURL}assets/font-awesome/css/all.min.css" rel="stylesheet" />
        <script src="{$WebApplicationBaseURL}mir-layout/assets/jquery/jquery.min.js"></script>
        <script src="{$WebApplicationBaseURL}mir-layout/assets/jquery/plugins/jquery-migrate/jquery-migrate.min.js"></script>
        <xsl:copy-of select="head/*" />
        <link href="{$WebApplicationBaseURL}rsc/sass/mir-layout/scss/{$MIR.Layout.Theme}-{$MIR.DefaultLayout.CSS}.css" rel="stylesheet" />
        <xsl:if test="string-length($MIR.CustomLayout.CSS) &gt; 0">
          <link href="{$WebApplicationBaseURL}css/{$MIR.CustomLayout.CSS}" rel="stylesheet" />
        </xsl:if>
        <xsl:if test="string-length($MIR.CustomLayout.JS) &gt; 0">
          <script src="{$WebApplicationBaseURL}js/{$MIR.CustomLayout.JS}"></script>
        </xsl:if>
        <xsl:call-template name="mir.prop4js" />

        <link href="https://crossasia.org/resources/sheader/css/bootstrap-xasia.min.css" rel="stylesheet" />
        <link href="https://crossasia.org/resources/sheader/css/style-xabs.css" rel="stylesheet" />

      </head>

      <body>

        <div class="xabs">HTML-from-Page-Type-1001</div>
        <script>
          window["isGuest"] = <xsl:value-of select="mcrxsl:isCurrentUserGuestUser()" />;
           <![CDATA[
          $.ajax({
             url: 'https://crossasia.org/',
             data: {
               type: "1001",
               source: window.location.href
             },
             xhrFields: {
               withCredentials: true
             }
           }).done(function(data,state,request) {
            // add content to container
            $(".xabs").html(data);
            // fix outdated fa icon
            $(".fa-file-text").addClass("fa-file-alt");
            $(".fa-file-alt").addClass("fas");
            $(".fa-file-alt").removeClass("fa");
            $(".fa-file-alt").removeClass("fa-file-text");
            let shibbolethID = request.getResponseHeader("x-shibboleth-uid");
            const userKey = "_check_is_passive_user";
            const urlKey = "_check_is_passive_location";

            if(shibbolethID == null && sessionStorage){
              // this should make it possible to login again after logout
              sessionStorage.removeItem(userKey);
              sessionStorage.removeItem(urlKey);
            }
            if(window["isGuest"] && shibbolethID != undefined && shibbolethID != null) {
              // run auth
              if(!sessionStorage) {
                return;
              }

              let passiveCheckUser = sessionStorage.getItem(userKey);
              let passiveCheckUrl = sessionStorage.getItem(urlKey);

              // Check for session cookie that contains the initial location
             if(passiveCheckUrl != null && passiveCheckUrl != undefined && passiveCheckUser == shibbolethID){
                  // If we have the opensaml::FatalProfileException GET arguments
                  // redirect to initial location because isPassive failed
                  if (
                      window.location.search.search(/errorType/) >= 0
                      && window.location.search.search(/RelayState/) >= 0
                      && window.location.search.search(/requestURL/) >= 0
                  ) {
                      window.location = passiveCheckUrl;
                  }
              } else {
                  // Mark browser as being isPassive checked
                  sessionStorage.setItem(userKey, shibbolethID);
                  sessionStorage.setItem(urlKey, window.location);
                  // Redirect to Shibboleth handler
                  window.location = "/Shibboleth.sso/Login?isPassive=true&target=" + encodeURIComponent(window.location);
              }]]>
            }
          });
        </script>

        <xsl:if test="//div/@class='jumbotwo'">
          <xsl:attribute name="class">
            <xsl:text>mir-start_page</xsl:text>
          </xsl:attribute>
        </xsl:if>

        <header>
          <xsl:call-template name="mir.navigation" />
          <noscript>
            <div class="mir-no-script alert alert-warning text-center" style="border-radius: 0;">
              <xsl:value-of select="i18n:translate('mir.noScript.text')" />&#160;
              <a href="http://www.enable-javascript.com/de/" target="_blank">
                <xsl:value-of select="i18n:translate('mir.noScript.link')" />
              </a>
              .
            </div>
          </noscript>
        </header>
        <!-- include Internet Explorer warning -->
        <xsl:call-template name="msie-note" />

        <xsl:call-template name="mir.jumbotwo" />

        <section>
          <div class="container" id="page">
            <div id="main_content">
              <xsl:call-template name="print.writeProtectionMessage" />
              <xsl:call-template name="print.statusMessage" />

              <xsl:choose>
                <xsl:when test="$readAccess='true'">
                  <xsl:if test="breadcrumb/ul[@class='breadcrumb']">
                    <div class="row detail_row bread_plus">
                      <div class="col-12">
                        <ul itemprop="breadcrumb" class="breadcrumb">
                          <li class="breadcrumb-item">
                            <a class="navtrail" href="{$WebApplicationBaseURL}"><xsl:value-of select="i18n:translate('mir.breadcrumb.home')" /></a>
                          </li>
                          <xsl:copy-of select="breadcrumb/ul[@class='breadcrumb']/*" />
                        </ul>
                      </div>
                    </div>
                  </xsl:if>
                  <xsl:copy-of select="*[not(name()='head')][not(name()='breadcrumb')] " />
                </xsl:when>
                <xsl:otherwise>
                  <xsl:call-template name="printNotLoggedIn" />
                </xsl:otherwise>
              </xsl:choose>
            </div>
          </div>
        </section>

        <footer class="flatmir-footer">
          <xsl:call-template name="mir.footer" />
          <xsl:call-template name="mir.powered_by" />
        </footer>

        <script>
          <!-- Bootstrap & Query-Ui button conflict workaround  -->
          if (jQuery.fn.button){jQuery.fn.btn = jQuery.fn.button.noConflict();}
        </script>
        <script src="{$WebApplicationBaseURL}assets/bootstrap/js/bootstrap.bundle.min.js"></script>
        <script src="{$WebApplicationBaseURL}assets/jquery/plugins/jquery-confirm/jquery.confirm.min.js"></script>
        <script src="{$WebApplicationBaseURL}js/mir/base.min.js"></script>
        <script>
          $( document ).ready(function() {
            $('.overtext').tooltip();
            $.confirm.options = {
              title: "<xsl:value-of select="i18n:translate('mir.confirm.title')" />",
              confirmButton: "<xsl:value-of select="i18n:translate('mir.confirm.confirmButton')" />",
              cancelButton: "<xsl:value-of select="i18n:translate('mir.confirm.cancelButton')" />",
              post: false,
              confirmButtonClass: "btn-danger",
              cancelButtonClass: "btn-secondary",
              dialogClass: "modal-dialog modal-lg" // Bootstrap classes for large modal
            }
          });
        </script>
        <!-- alco add placeholder for older browser -->
        <script src="{$WebApplicationBaseURL}assets/jquery/plugins/jquery-placeholder/jquery.placeholder.min.js"></script>
        <script>
          jQuery("input[placeholder]").placeholder();
          jQuery("textarea[placeholder]").placeholder();
        </script>
      </body>
    </html>
  </xsl:template>
  <xsl:template match="/*[not(local-name()='site')]">
    <xsl:message terminate="yes">This is not a site document, fix your properties.</xsl:message>
  </xsl:template>
</xsl:stylesheet>
