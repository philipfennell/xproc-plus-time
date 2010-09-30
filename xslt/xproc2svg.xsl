<?xml version="1.0" encoding="UTF-8"?>
<xsl:transform 
		xmlns="http://www.w3.org/2000/svg" 
		xmlns:c="http://www.w3.org/ns/xproc-step"
		xmlns:css="http://www.w3.org/TR/CSS2"
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
	
	<xsl:import href="visible-steps.xsl"/>
	
	<xsl:output encoding="UTF-8" indent="yes" media-type="application/svg+xml" method="xml"/>

	<xsl:strip-space elements="*"/>

	<xsl:variable name="vSpacing" as="xs:integer" select="180"/>
	
	<xsl:attribute-set name="step">
		<xsl:attribute name="fill">#FFFFFF</xsl:attribute>
		<xsl:attribute name="stroke">#000000</xsl:attribute>
		<xsl:attribute name="stroke-width">1px</xsl:attribute>
	</xsl:attribute-set>
	
	<xsl:attribute-set name="labels">
		<xsl:attribute name="font-size">12px</xsl:attribute>
		<xsl:attribute name="font-family">sans-serif</xsl:attribute>
		<xsl:attribute name="font-weight">bold</xsl:attribute>
		<xsl:attribute name="fill">#000000</xsl:attribute>
		<xsl:attribute name="stroke">none</xsl:attribute>
	</xsl:attribute-set>
	
	<xsl:attribute-set name="name">
		<xsl:attribute name="font-style">italic</xsl:attribute>
		<xsl:attribute name="font-weight">normal</xsl:attribute>
	</xsl:attribute-set>
	
	
	
	
	<!--  -->
	<xsl:template match="/">
		<xsl:variable name="normalisedPipeline" as="document-node()">
			<xsl:document>
				<xsl:apply-imports/>
			</xsl:document>
		</xsl:variable>
		
		<xsl:apply-templates select="$normalisedPipeline" mode="p:pipeline"/>
	</xsl:template>
	
	

	<!--  -->
	<xsl:template match="/p:declare-step" mode="p:pipeline">
		<svg version="1.1">
			<xsl:call-template name="svg:dimensions"/>
		
			<xsl:apply-templates select="*[xpt:isVisible(.)]" mode="p:steps"/>
		</svg>
	</xsl:template>
	
	
	


	<!-- Ignore unsupported steps. -->
	<xsl:template match="*" mode="p:steps">
		<g xsl:use-attribute-sets="step"
				transform="{concat('translate(62, ', $vSpacing * (count(preceding-sibling::*[xpt:isVisible(.)]) + 1), ')')}">
			<rect x="0" y="0" width="180" height="112"/>
			<xsl:apply-templates select="p:input | p:output" mode="p:ports"/>
			<g xsl:use-attribute-sets="labels">
				<text x="12" y="26">
					<xsl:value-of select="name()"/>
				</text>
				<text xsl:use-attribute-sets="name" x="12" y="42">
					<xsl:value-of select="(@name, 'anonymous')[1]"/>
				</text>
			</g>
		</g>
	</xsl:template>
	
	
	<!--  -->


	<!-- Input port. -->
	<xsl:template match="p:input" mode="p:ports">
		<rect class="port input" x="{(count(preceding-sibling::p:input) * 32) + 12}" y="-32" width="20" height="32"/>
	</xsl:template>


	<!-- Output port. -->
	<xsl:template match="p:output" mode="p:ports">
		<rect class="port output" x="{(count(preceding-sibling::p:input) * 32) + 12}" y="112" width="20" height="32"/>
	</xsl:template>


	<!--  -->
	<xsl:template name="svg:dimensions" as="attribute()*">
		<xsl:attribute name="width" select="'1024'"/>
		<xsl:attribute name="height" select="$vSpacing * (count(*[xpt:isVisible(.)]) + 1)"/>
	</xsl:template>
	
	
	<!--  -->
	<xsl:function name="xpt:isVisible" as="xs:boolean">
		<xsl:param name="contextNode" as="element()"/>
		
		<xsl:value-of select="if ($contextNode/@css:visibility = 'visible') then true() else false()"/>
	</xsl:function>
</xsl:transform>