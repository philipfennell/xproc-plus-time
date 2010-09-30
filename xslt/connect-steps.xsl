<?xml version="1.0" encoding="UTF-8"?>
<xsl:transform 
		xmlns="http://www.w3.org/2000/svg" 
		xmlns:c="http://www.w3.org/ns/xproc-step"
		xmlns:cx="http://xmlcalabash.com/ns/extensions"
		xmlns:ml="http://xmlcalabash.com/ns/extensions/marklogic" 
		xmlns:p="http://www.w3.org/ns/xproc"
		xmlns:xpt="http://xproc-plus-time.googlecode.com"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:xs="http://www.w3.org/2001/XMLSchema"
		xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
		exclude-result-prefixes="c cx ml p xs xsi" 
		version="2.0">
	
	<xsl:output encoding="UTF-8" indent="yes" media-type="application/xproc+xml" method="xml"/>
	
	<xsl:include href="common.xsl"/>
	
	
	
	
	<xsl:template match="p:input | p:output | p:document| p:inline| p:data | p:pipe | p:pipeinfo | p:documentation" mode="p:visible">
		<xsl:copy-of select="."/>
	</xsl:template>
	
	<xsl:template match="p:input | p:output | p:document| p:inline| p:data | p:pipe | p:pipeinfo | p:documentation" mode="p:visible">
		<xsl:copy-of select="."/>
	</xsl:template>
	
	
	<!--  -->
	<xsl:template match="/">
		<xsl:apply-templates select="*" mode="p:connect"/>
	</xsl:template>
	
	
	<!--  -->
	<xsl:template match="*" mode="p:connect">
		<xsl:copy>
			<xsl:copy-of select="@*"/>
			<xsl:if test="not(@name)">
				<xsl:attribute name="name" select="concat('anon', generate-id())"/>
			</xsl:if>
			<xsl:apply-templates select="* | text()" mode="#current"/>
		</xsl:copy>
	</xsl:template>
	
	
</xsl:transform>