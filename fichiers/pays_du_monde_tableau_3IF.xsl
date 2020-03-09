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
		  <hr/>
		  <p>Pays avec 6 voisins :
				<xsl:for-each select="//country[count(borders/neighbour)=6]">
					<xsl:value-of select="name/common"/><span>, </span>
				</xsl:for-each>
		  </p>
		  Pays ayant le plus de voisins :
		  <xsl:for-each select="//country[(count(borders/neighbour))>= (count(//country/borders/neighbour))]">
				<xsl:value-of select="name/common"/>, nob de voisins :
				<xsl:value-of select="count(borders/neighbour)"/>
		  </xsl:for-each> 
		  <hr/>
		  <p></p>
		  
		  
		  <h3>Pays du continent : Americas par sous-régions :</h3>
		  <h4>Caribbean (<xsl:number value="count(//country[infosContinent/subregion='Caribbean'])" />pays)</h4>
			<table border="3" width="1200" align="center">
			<tr>
	            <th>N°</th>
	            <th>Nom</th>
	            <th>Capitale</th>
	            <th>Voisins</th>
	            <th>Coordonnees</th>
	            <th>Drapeau</th>
	        </tr>
				<xsl:apply-templates select="//country[infosContinent/subregion='Caribbean']"/>
			</table>
			
		  <h4>South America (<xsl:number value="count(//country[infosContinent/subregion='South America'])" />pays)</h4>
			<table border="3" width="1200" align="center">
			<tr>
	            <th>N°</th>
	            <th>Nom</th>
	            <th>Capitale</th>
	            <th>Voisins</th>
	            <th>Coordonnees</th>
	            <th>Drapeau</th>
	        </tr>
				<xsl:apply-templates select="//country[infosContinent/subregion='South America']"/>
			</table>
			
	</body> 
	</html> 
	</xsl:template> 
	<xsl:template match="metadonnees">
	 <p style="text-align:center; color:blue;">
		Objectif : <xsl:value-of select="objectif"/>
	 </p><hr/>
	</xsl:template>	
	<xsl:template match="country/infosContinent">		
	</xsl:template>	
	<xsl:template match="country">
		<tr>
	            <td><xsl:value-of select="count(./preceding-sibling::*)"/></td>
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
					<xsl:if test="landlocked=false">
						île
					</xsl:if>
					<xsl:for-each select="borders">
						<xsl:value-of select="neighbour"/>
					</xsl:for-each>
					
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
	</xsl:stylesheet>


