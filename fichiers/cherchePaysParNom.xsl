<?xml version="1.0" encoding="UTF-8"?>

<!-- New document created with EditiX at Mon Feb 24 16:08:25 CET 2020 -->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:param name="name" />

<xsl:template match="/">
	<p id="capital"><xsl:value-of select="//country[name/common=$name]/capital"/></p>
	<p id="cca2"><xsl:value-of select="//country[name/common=$name]/codes/cca2"/></p>
</xsl:template>
</xsl:stylesheet>