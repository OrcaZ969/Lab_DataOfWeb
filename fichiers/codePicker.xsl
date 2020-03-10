<?xml version="1.0" encoding="UTF-8"?>

<!-- New document created with EditiX at Mon Feb 24 16:08:25 CET 2020 -->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="/">
<xsl:for-each select="//country">
	<p><xsl:value-of select="codes/cca3"/></p>
</xsl:for-each>
</xsl:template>
</xsl:stylesheet>