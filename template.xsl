<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output
  method="xml"
  indent="no"
  encoding="utf-8"
  omit-xml-declaration="yes"
  doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
  doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" />

<!-- VARIABLES -->
<!-- <xsl:variable name="datafile" select="'data.xml'" /> -->

<!-- BLOCKS -->
<!-- render block -->
<xsl:template match="renderblock">
  <xsl:variable name="blockid" select="@ref" />
  <xsl:apply-templates select="/email/block[@id=$blockid]"/>
</xsl:template>

<!-- block -->
<xsl:template match="block" name="block">
  <td>
    <xsl:if test="@width">
      <xsl:attribute name="width"><xsl:value-of select="@width" /></xsl:attribute>
    </xsl:if>

    <xsl:if test="@height">
      <xsl:attribute name="height"><xsl:value-of select="@height" /></xsl:attribute>
    </xsl:if>

    <xsl:if test="@bgcolor">
      <xsl:attribute name="bgcolor"><xsl:value-of select="@bgcolor" /></xsl:attribute>
    </xsl:if>

    <xsl:if test="@align">
      <xsl:attribute name="align"><xsl:value-of select="@align" /></xsl:attribute>
    </xsl:if>

    <xsl:if test="@valign">
      <xsl:attribute name="valign"><xsl:value-of select="@valign" /></xsl:attribute>
    </xsl:if>



    <table border="0" cellpadding="0" cellspacing="0">
      <xsl:choose>
        <xsl:when test="@border">
          <xsl:attribute name="border"><xsl:value-of select="@border" /></xsl:attribute>
          <xsl:attribute name="frame"><xsl:value-of select="'box'" /></xsl:attribute>
          <xsl:attribute name="rules"><xsl:value-of select="'all'" /></xsl:attribute>
        </xsl:when>
        <xsl:otherwise>
          <xsl:attribute name="border"><xsl:value-of select="0" /></xsl:attribute>
        </xsl:otherwise>
      </xsl:choose>

      <xsl:if test="@bordercolor">
        <xsl:attribute name="bordercolor"><xsl:value-of select="@bordercolor" /></xsl:attribute>
      </xsl:if>

      <xsl:apply-templates select="row"/>
    </table>
  </td>
</xsl:template>

<!-- row -->
<xsl:template match="row">
  <tr>
    <xsl:apply-templates />
  </tr>
</xsl:template>

<!-- image -->
<xsl:template match="image">
  <xsl:variable name="file"><xsl:value-of select="text()" /></xsl:variable>
  <xsl:variable name="width"><xsl:value-of select="concat('{', $file, '_width}')" /></xsl:variable>
  <xsl:variable name="height"><xsl:value-of select="concat('{', $file, '_height}')" /></xsl:variable>
  <xsl:variable name="src"><xsl:value-of select="concat('<%=config.images_url%>', $file)" /></xsl:variable>

  <td>
    <xsl:choose>
      <xsl:when test="@width">
        <xsl:attribute name="width"><xsl:value-of select="@width" /></xsl:attribute>
      </xsl:when>
      <xsl:otherwise>
        <xsl:attribute name="width"><xsl:value-of select="$width" /></xsl:attribute>
      </xsl:otherwise>
    </xsl:choose>

    <xsl:choose>
      <xsl:when test="@height">
        <xsl:attribute name="height"><xsl:value-of select="@height" /></xsl:attribute>
      </xsl:when>
      <xsl:otherwise>
        <xsl:attribute name="height"><xsl:value-of select="$height" /></xsl:attribute>
      </xsl:otherwise>
    </xsl:choose>


    <xsl:if test="@align">
      <xsl:attribute name="align"><xsl:value-of select="@align" /></xsl:attribute>
    </xsl:if>

    <xsl:if test="@valign">
      <xsl:attribute name="valign"><xsl:value-of select="@valign" /></xsl:attribute>
    </xsl:if>

    <xsl:choose>
      <xsl:when test="@link">
        <a style="text-decoration: none; display:block" target="_blank">
          <xsl:attribute name="href"><xsl:value-of disable-output-escaping="yes" select="@link" /></xsl:attribute>
          <img style="display: block;" border="0">
            <xsl:attribute name="alt"><xsl:value-of select="@desc" /></xsl:attribute>
            <xsl:attribute name="title"><xsl:value-of select="@desc" /></xsl:attribute>
            <xsl:attribute name="width"><xsl:value-of select="$width" /></xsl:attribute>
            <xsl:attribute name="height"><xsl:value-of select="$height" /></xsl:attribute>
            <xsl:attribute name="src"><xsl:value-of select="concat('<%=config.imagesUrl%>', $file)" /></xsl:attribute>
          </img>
        </a>
      </xsl:when>
      <xsl:otherwise>
        <img style="display: block;" border="0">
          <xsl:attribute name="alt"><xsl:value-of select="@desc" /></xsl:attribute>
          <xsl:attribute name="title"><xsl:value-of select="@desc" /></xsl:attribute>
          <xsl:attribute name="width"><xsl:value-of select="$width" /></xsl:attribute>
          <xsl:attribute name="height"><xsl:value-of select="$height" /></xsl:attribute>
          <xsl:attribute name="src"><xsl:value-of select="concat('<%=config.imagesUrl%>', $file)" /></xsl:attribute>
        </img>
      </xsl:otherwise>
    </xsl:choose>
  </td>

</xsl:template>

<!-- spacer -->
<xsl:template match="spacer">
  <td>
    <xsl:if test="@align">
      <xsl:attribute name="align"><xsl:value-of select="@align" /></xsl:attribute>
    </xsl:if>

    <xsl:if test="@valign">
      <xsl:attribute name="valign"><xsl:value-of select="@valign" /></xsl:attribute>
    </xsl:if>

    <img style="display: block;" border="0" alt="">
      <xsl:attribute name="width"><xsl:value-of select="@width" /></xsl:attribute>
      <xsl:attribute name="height"><xsl:value-of select="@height" /></xsl:attribute>
    <xsl:attribute name="src"><xsl:value-of select="<%= config.imagesPath %>spacer.gif" /></xsl:attribute>
    </img>
  </td>

</xsl:template>

<!-- text -->
<xsl:template match="text">

  <xsl:variable name="face">
    <xsl:call-template name="fontprop">
      <xsl:with-param name="styleid" select="@style" />
      <xsl:with-param name="prop" select="'font-family'" />
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="size">
    <xsl:call-template name="fontprop">
      <xsl:with-param name="styleid" select="@style" />
      <xsl:with-param name="prop" select="'size'" />
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="color">
    <xsl:call-template name="fontprop">
      <xsl:with-param name="styleid" select="@style" />
      <xsl:with-param name="prop" select="'color'" />
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="style">
    <xsl:call-template name="renderstyle">
      <xsl:with-param name="styleid" select="@style" />
    </xsl:call-template>
  </xsl:variable>

  <td>
    <xsl:if test="@width">
      <xsl:attribute name="width"><xsl:value-of select="@width" /></xsl:attribute>
    </xsl:if>

    <xsl:if test="@bgcolor">
      <xsl:attribute name="bgcolor"><xsl:value-of select="@bgcolor" /></xsl:attribute>
    </xsl:if>

    <xsl:if test="@height">
      <xsl:attribute name="height"><xsl:value-of select="@height" /></xsl:attribute>
    </xsl:if>

    <xsl:if test="@align">
      <xsl:attribute name="align"><xsl:value-of select="@align" /></xsl:attribute>
    </xsl:if>

    <xsl:if test="@valign">
      <xsl:attribute name="valign"><xsl:value-of select="@valign" /></xsl:attribute>
    </xsl:if>

    <xsl:choose>
      <xsl:when test="@link">
        <a style="text-decoration: none; display:block"  target="_blank">
          <xsl:attribute name="href"><xsl:value-of select="@link" /></xsl:attribute>
          <font>
            <xsl:attribute name="face"><xsl:value-of select="$face" /></xsl:attribute>
            <xsl:attribute name="size"><xsl:value-of select="$size" /></xsl:attribute>
            <xsl:attribute name="color"><xsl:value-of select="$color" /></xsl:attribute>
            <xsl:attribute name="style"><xsl:value-of select="$style" /></xsl:attribute>
            <xsl:apply-templates />
          </font>
        </a>
      </xsl:when>
      <xsl:otherwise>
        <font>
          <xsl:attribute name="face"><xsl:value-of select="$face" /></xsl:attribute>
          <xsl:attribute name="size"><xsl:value-of select="$size" /></xsl:attribute>
          <xsl:attribute name="color"><xsl:value-of select="$color" /></xsl:attribute>
          <xsl:attribute name="style"><xsl:value-of select="$style" /></xsl:attribute>

          <xsl:choose>
            <xsl:when test="text()">
              <xsl:variable name="value"><xsl:value-of disable-output-escaping="yes" select="text()" /></xsl:variable>
              <xsl:value-of select="Lorem"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:apply-templates />
              </xsl:otherwise>
          </xsl:choose>
        </font>
      </xsl:otherwise>
    </xsl:choose>
  </td>
</xsl:template>

<!-- style -->
<xsl:template name="renderstyle">
  <xsl:param name="styleid" />

  <xsl:variable name="result">
    <xsl:for-each select="document('styles.xml')/styles/style[@id=$styleid]/prop">
      <xsl:if test="@name != 'size'">
        <xsl:value-of select="concat(@name, ':', text(), ';')" />
      </xsl:if>
    </xsl:for-each>
  </xsl:variable>

  <xsl:value-of select="$result" />
</xsl:template>

<!-- fontprop -->
<xsl:template name="fontprop">
  <xsl:param name="styleid" />
  <xsl:param name="prop" />

  <xsl:value-of select="document('styles.xml')/styles/style[@id=$styleid]/prop[@name=$prop]" />
</xsl:template>

<xsl:template match="bold">
    <b>
        <xsl:apply-templates />
    </b>
</xsl:template>

<xsl:template match="italic">
    <i>
        <xsl:apply-templates />
    </i>
</xsl:template>

<xsl:template match="br">
    <br />
</xsl:template>

<!-- INIT BLOCK -->
<xsl:template match="email">
  <html xmlns="http://www.w3.org/1999/xhtml">
    <head>
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
      <meta name="viewport" content="width=device-width"/>
      <title><xsl:value-of select="Lorem" /></title>
      <style type="text/css">
        .ReadMsgBody { width: 100%; }
        .ExternalClass {width: 100%; }
        .ExternalClass * {line-height: 100%;}
      </style>
    </head>
    <body>
      <xsl:attribute name="bgcolor"><xsl:value-of select="Lorem" /></xsl:attribute>
      <table border="0" cellpadding="0" cellspacing="0" width="100%">
        <xsl:attribute name="bgcolor"><xsl:value-of select="Lorem" /></xsl:attribute>
        <tr>
          <td>
            <table border="0" cellpadding="0" cellspacing="0" align="center">
              <xsl:attribute name="width"><xsl:value-of select="Lorem" /></xsl:attribute>
              <tr>
                <xsl:apply-templates select="block[@id='main']"/>
              </tr>
            </table>
            </td>
        </tr>
      </table>
    </body>
  </html>
</xsl:template>
</xsl:stylesheet>
