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
	
	
	
	
	<xsl:output encoding="UTF-8" indent="yes" media-type="application/svg+xml" method="xml"/>

	<xsl:strip-space elements="*"/>

	<xsl:variable name="vSpacing" as="xs:integer" select="100"/>
	
	<xsl:attribute-set name="step">
		<xsl:attribute name="fill">none</xsl:attribute>
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
	
	<xsl:attribute-set name="line">
		<xsl:attribute name="stroke-dasharray">2,2</xsl:attribute>
	</xsl:attribute-set>
	
	<xsl:attribute-set name="connection">
		<xsl:attribute name="fill">none</xsl:attribute>
		<xsl:attribute name="stroke">#000000</xsl:attribute>
		<xsl:attribute name="stroke-width">1px</xsl:attribute>
	</xsl:attribute-set>
	
	
	
	
	<!--  -->
	<xsl:template match="/">
		<xsl:apply-templates select="*" mode="p:pipeline"/>
	</xsl:template>
	
	
	
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
		<xsl:variable name="boundStep" as="element()*" 
				select="../preceding-sibling::*[@name = current()/p:pipe/@step]"/>
		<xsl:variable name="boundPort" as="element()" 
				select="$boundStep/p:output[@port = current()/p:pipe/@port]"/>
		<xsl:variable name="contextPosn" as="xs:integer"
				select="xs:integer(number($boundStep/@xpt:position))"/>
		<xsl:variable name="boundStepPosn" as="xs:integer"
				select="xs:integer(number(../@xpt:position))"/>
		<xsl:variable name="distance" as="xs:integer" 
			select="$boundStepPosn - $contextPosn"/>
		<xsl:variable name="length" 
				select="((($distance) * $vSpacing)) * -1"/>
		
		<path xsl:use-attribute-sets="connection"
				d="M 0 0 L -{62 * ($distance - 1)} {$length div 2} L 0 {$length}"/>
		
	</xsl:template>


	<!-- Output port. -->
	<xsl:template match="p:output" mode="p:ports">
		<!--<rect class="port output" x="20" y="-32" width="20" height="32"/>-->
	</xsl:template>
	
	
	<xsl:template match="text()" mode="#all"/>
	
	
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