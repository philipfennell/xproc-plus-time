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
	
	
	<!--  -->
	<xsl:template match="/">
		<xsl:apply-templates select="*" mode="p:normalise"/>
	</xsl:template>
	
	
	<!-- Steps that should be visible have their xpt:visible attribute set to 
		 true(). -->
	<xsl:template match="*" mode="p:normalise">
		<xsl:copy>
			<xsl:copy-of select="@*"/>
			<xsl:attribute name="xpt:visible" select="if (name() = ('p:input', 'p:output', 'p:serialization', 'p:import', 'p:declare-step', 'p:pipeinfo', 'p:documentation')) then false() else true()"/>
			<xsl:apply-templates select="* | text()" mode="#current"/>
		</xsl:copy>
	</xsl:template>
</xsl:transform>