<?xml version="1.0" encoding="UTF-8"?>

<!-- New document created with EditiX at Mon Feb 24 16:08:25 CET 2020 -->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:param name="code" />

<xsl:template match="/">
	<p id="capital"><xsl:value-of select="//country[codes/cca3=$code]/capital"/></p>
	<p id="name"><xsl:value-of select="//country[codes/cca3=$code]/name/official"/></p>
</xsl:template>
</xsl:stylesheet>