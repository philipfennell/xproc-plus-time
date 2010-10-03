<?xml version="1.0" encoding="UTF-8"?>
<xsl:transform 
		xmlns="http://www.w3.org/2000/svg" 
		xmlns:c="http://www.w3.org/ns/xproc-step"
		xmlns:cx="http://xmlcalabash.com/ns/extensions"
		xmlns:ml="http://xmlcalabash.com/ns/extensions/marklogic" 
		xmlns:p="http://www.w3.org/ns/xproc"
		xmlns:svg="http://www.w3.org/2000/svg" 
		xmlns:xlink="http://www.w3.org/1999/xlink"
		xmlns:xpt="http://xproc-plus-time.googlecode.com"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:xs="http://www.w3.org/2001/XMLSchema"
		xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
		exclude-result-prefixes="c cx ml p svg xlink xpt xs xsi" 
		version="2.0">
	
	<xsl:import href="xproc2svg.xsl"/>
	
	
	<xsl:output encoding="UTF-8" indent="yes" media-type="application/svg+xml" method="xml"/>

	<xsl:strip-space elements="*"/>

	<xsl:variable name="vSpacing" as="xs:integer" select="100"/>

	<xsl:attribute-set name="line">
		<xsl:attribute name="stroke-dasharray">2,2</xsl:attribute>
	</xsl:attribute-set>
	
	<xsl:attribute-set name="connection">
		<xsl:attribute name="fill">#000000</xsl:attribute>
		<xsl:attribute name="stroke">#000000</xsl:attribute>
		<xsl:attribute name="stroke-width">1px</xsl:attribute>
	</xsl:attribute-set>
	
	
	
	<!--  -->
	<xsl:template match="/p:declare-step" mode="p:pipeline">
		<svg version="1.1">
			<xsl:call-template name="svg:dimensions"/>
			
			<g transform="translate(168,0)">
				<xsl:apply-templates select="*[xpt:isVisible(.)]" mode="p:steps"/>
			</g>
		</svg>
	</xsl:template>
	

	<!-- Ignore unsupported steps. -->
	<xsl:template match="*" mode="p:steps">
		<g xsl:use-attribute-sets="step"
				transform="{concat('translate(62, ', $vSpacing * (count(preceding-sibling::*[xpt:isVisible(.)]) + 1), ')')}">
			
			<xsl:apply-templates select="p:input" mode="p:ports"/>
			
			<g xsl:use-attribute-sets="labels">
				<text x="12" y="-7">
					<xsl:value-of select="name()"/>
				</text>
				<line xsl:use-attribute-sets="step line" x1="0" y1="0" x2="180" y2="0"/>
				<circle xsl:use-attribute-sets="step" cx="0" cy="0" r="6"/>
				<text xsl:use-attribute-sets="name" x="12" y="16">
					<xsl:value-of select="(@name, 'anonymous')[1]"/>
				</text>
			</g>
		</g>
	</xsl:template>


	<!-- Input port. -->
	<xsl:template match="p:input[p:pipe]" mode="p:ports" priority="1">
		<xsl:variable name="boundStep" as="element()*" select="../preceding-sibling::*[@name = current()/p:pipe/@step]"/>
		<xsl:variable name="boundPort" as="element()" select="$boundStep/p:output[@port = current()/p:pipe/@port]"/>
		
		<line xsl:use-attribute-sets="connection" 
				x1="0" y1="{number($boundStep/@xpt:position) * $vSpacing}" 
				x2="0" y2="{number(../@xpt:position) * $vSpacing}"/>
	</xsl:template>


	<!-- Output port. -->
	<xsl:template match="p:output" mode="p:ports">
		<!--<rect class="port output" x="20" y="-32" width="20" height="32"/>-->
	</xsl:template>
	
</xsl:transform>