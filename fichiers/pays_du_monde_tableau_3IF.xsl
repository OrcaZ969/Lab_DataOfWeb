<?xml version="1.0" encoding="UTF-8"?>

<!-- New document created with EditiX at Mon Feb 24 16:08:25 CET 2020 -->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:output method="html"/>
	<xsl:template match="/"> 
	<html> 
	 <head> 
	    <title> 
	    Pays du monde 
	  </title> 
	 </head> 
	 
	 <body style="background-color:white;">  
	   <h1>Les pays du monde</h1> 
	      Mise en forme par : AKAYDIN Aydin, ZHANG Mengxin (B3??)
		  <xsl:apply-templates select="//metadonnees"/> 
		  <xsl:call-template name="voisin"/>
		  <xsl:call-template name="continent"/>	
	</body> 
	</html> 
	</xsl:template> 
		
	<xsl:template match="metadonnees">
	 <p style="text-align:center; color:blue;">
		Objectif : <xsl:value-of select="objectif"/>
	 </p><hr/>
	</xsl:template>	
	
	<xsl:template name="continent">
		<xsl:for-each select="//infosContinent/continent[not(.=../preceding::infosContinent/continent)]">
			<xsl:if test='not(.="")'>
				<xsl:variable name="continent" select="."/>
				<h3>Pays du continent : <xsl:copy-of select="$continent" /> par sous-régions :</h3>
				<xsl:for-each select="//infosContinent/subregion[(../continent=$continent)and(not(.=../preceding::infosContinent/subregion))]">
					<xsl:variable name="subregion" select="."/>
					<h4><xsl:copy-of select="$subregion" /> (<xsl:number value="count(//country[infosContinent/subregion=$subregion])" />pays)</h4>
						<table border="3" width="100%" align="center">
						<tr>
							<th>N°</th>
							<th>Nom</th>
							<th>Capitale</th>
							<th>Voisins</th>
							<th>Coordonnees</th>
							<th>Drapeau</th>
						</tr>
							<xsl:apply-templates select="//country[infosContinent/subregion=$subregion]"/>
						</table>
				</xsl:for-each>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>
	
	
	<xsl:template match="country">
		<tr>
	            <td><xsl:value-of select="position()"/></td>
	            <td ><span style=" color:green;"><xsl:value-of select="name/common"/></span>
	                   (<xsl:value-of select="name/official"/>)
					   <br/>
					   <span style=" color:blue;">
					   <xsl:if test="name/native_name[@lang='eng']/official">Nom anglais: 
					   <xsl:value-of select="name/native_name[@lang='eng']/official"/>
						</xsl:if></span>
						
				</td>
	            <td><xsl:value-of select="capital"/></td>
	            <td>	
					<xsl:choose>
					  <xsl:when test="count(borders/neighbour)=0">
						île
					  </xsl:when>
					  <xsl:otherwise>
							<xsl:variable name="total" select="count(borders/neighbour)"/>					
							<xsl:for-each select="borders/neighbour">
								<xsl:variable name="code" select="."></xsl:variable>
								<xsl:choose>
									<xsl:when test="not(position() = $total)">
										<xsl:value-of select="//country[.//codes/cca3/text() = $code]/name/common"/>,
									</xsl:when>
									<xsl:otherwise> 
										<xsl:value-of select="//country[.//codes/cca3/text() = $code]/name/common"/>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:for-each>
					  </xsl:otherwise>
					</xsl:choose> 
					
				</td>
	            <td>
					Latitude : <xsl:value-of select="coordinates/@lat"/><br/>
					Longitude : <xsl:value-of select="coordinates/@long"/>
				</td>
				<xsl:variable name="lowercase" select="'abcdefghijklmnopqrstuvwxyz'" />
				<xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />
	
	            <td><img src="{concat(concat('http://www.geonames.org/flags/x/',translate(codes/cca2, $uppercase, $lowercase)),'.gif')}" alt="" height="40" width="60"/> </td>
	         </tr>
	</xsl:template>
	
	<xsl:template name="voisin">
		<hr/>
		  <p>Pays avec 6 voisins :
				<xsl:variable name="total" select="count(//country[count(borders/neighbour)=6])"/>
				<xsl:for-each select="//country[count(borders/neighbour)=6]">
					<xsl:choose>
						<xsl:when test="not(position() = $total)">
							<xsl:value-of select="name/common"/><span>, </span>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="name/common"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:for-each>
		  </p>
		  Pays ayant le plus de voisins :
		  <xsl:for-each select="//country">
				<xsl:sort select="(count(borders/neighbour))" order="descending" data-type="number"/>
				<xsl:if test="position() = 1">
					<xsl:value-of select="name/common"/>, nob de voisins :
					<xsl:value-of select="count(borders/neighbour)"/>
				</xsl:if>
		  </xsl:for-each> 
		  <hr/>
		  <p></p>
	</xsl:template>
	</xsl:stylesheet>


