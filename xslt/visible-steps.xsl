<?xml version="1.0" encoding="UTF-8"?>
<xsl:transform 
		xmlns:c="http://www.w3.org/ns/xproc-step"
		xmlns:css="http://www.w3.org/TR/CSS2"
		xmlns:cx="http://xmlcalabash.com/ns/extensions"
		xmlns:ml="http://xmlcalabash.com/ns/extensions/marklogic" 
		xmlns:p="http://www.w3.org/ns/xproc"
		xmlns:xpt="http://xproc-plus-time.googlecode.com"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:xs="http://www.w3.org/2001/XMLSchema"
		xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
		exclude-result-prefixes="xs xsi" 
		version="2.0">
	
	<xsl:output encoding="UTF-8" indent="yes" media-type="application/xproc+xml" method="xml"/>
	
	<xsl:include href="common.xsl"/>
	
	
	<!--  -->
	<xsl:template match="/">
		<xsl:variable name="visible" as="element()">
			<xsl:apply-templates select="*" mode="p:visible"/>
		</xsl:variable>
		
		<xsl:apply-templates select="$visible" mode="xpt:position"/>
	</xsl:template>
	
	
	<!-- Steps that should be visible have their css:visibility attribute set to 
		 'visible'. -->
	<xsl:template match="*" mode="p:visible">
		<xsl:copy>
			<xsl:copy-of select="@*"/>
			<xsl:attribute name="css:visibility" select="if (name() = ('p:declare-step')) then 'hidden' else 'visible'"/>
			<xsl:apply-templates select="* | text()" mode="#current"/>
		</xsl:copy>
	</xsl:template>
	
	
	<!--  -->
	<xsl:template match="p:declare-step" mode="xpt:position" priority="1">
		<xsl:copy copy-namespaces="yes">
			<xsl:copy-of select="@*"/>
			<xsl:apply-templates select="* | text()" mode="#current"/>
		</xsl:copy>
	</xsl:template>
	
	
	<!--  -->
	<xsl:template match="*[@css:visibility]" mode="xpt:position">
		<xsl:copy copy-namespaces="no">
			<xsl:copy-of select="@*"/>
			<xsl:attribute name="xpt:position" select="count(preceding-sibling::*[@css:visibility = 'visible']) + 1"/>
			<xsl:apply-templates select="* | text()" mode="#current"/>
		</xsl:copy>
	</xsl:template>
	
	
	<!--  -->
	<xsl:template match="*" mode="xpt:position">
		<xsl:copy copy-namespaces="no">
			<xsl:copy-of select="@*"/>
			
			<xsl:apply-templates select="* | text()" mode="#current"/>
		</xsl:copy>
	</xsl:template>
</xsl:transform>