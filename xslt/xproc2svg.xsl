<?xml version="1.0" encoding="UTF-8"?>
<xsl:transform 
		xmlns="http://www.w3.org/2000/svg"
		xmlns:c="http://www.w3.org/ns/xproc-step"
		xmlns:cx="http://xmlcalabash.com/ns/extensions"
		xmlns:ml="http://xmlcalabash.com/ns/extensions/marklogic"
		xmlns:p="http://www.w3.org/ns/xproc"
		xmlns:svg="http://www.w3.org/2000/svg"
		xmlns:xlink="http://www.w3.org/1999/xlink"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:xs="http://www.w3.org/2001/XMLSchema"
		xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
		exclude-result-prefixes="c cx ml p svg xlink xs xsi"
		version="2.0">
	
	<xsl:output encoding="UTF-8" indent="yes" media-type="application/xml"
			method="xml"/>
	
	<xsl:strip-space elements="*"/>
	
	
	
	<!--  -->
	<xsl:template match="/">
		<svg version="1.1">
			<xsl:call-template name="svg:dimensions"/>
			
			<xsl:apply-templates select="*" mode="svg:rep"/>
		</svg>
	</xsl:template>
	
	
	<!--  -->
	<xsl:template match="p:declare-step" mode="svg:rep">
		
	</xsl:template>
	
	
	
	<!-- Ignore unsupported steps. -->
	<xsl:template match="p:*" mode="svg:rep"/>
	
	
	<!--  -->
	<xsl:template name="svg:dimensions" as="attribute()*">
		<xsl:attribute name="width" select="1024px"/>
		<xsl:attribute name="height" select="633px"/>
	</xsl:template>
</xsl:transform>