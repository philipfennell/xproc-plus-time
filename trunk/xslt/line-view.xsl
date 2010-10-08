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
		exclude-result-prefixes="c css cx ml p svg xlink xpt xs xsi" 
		version="2.0">
	
	
	
	
	<xsl:output encoding="UTF-8" indent="yes" media-type="application/svg+xml" method="xml"/>

	<xsl:strip-space elements="*"/>

	<xsl:variable name="vSpacing" as="xs:integer" select="100"/>
	<xsl:variable name="hSpacing" as="xs:integer" select="xs:integer(ceiling(0.618 * 100))"/>
	
	<xsl:attribute-set name="step">
		<xsl:attribute name="fill">#FFFFFF</xsl:attribute>
		<xsl:attribute name="stroke">#999999</xsl:attribute>
		<xsl:attribute name="stroke-width">3px</xsl:attribute>
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
		<xsl:attribute name="stroke-width">1px</xsl:attribute>
		<xsl:attribute name="stroke-dasharray">2,2</xsl:attribute>
		<xsl:attribute name="stroke">#000000</xsl:attribute>
	</xsl:attribute-set>
	
	<xsl:attribute-set name="connection">
		<xsl:attribute name="fill">none</xsl:attribute>
		<xsl:attribute name="stroke">#999999</xsl:attribute>
		<xsl:attribute name="stroke-width">3px</xsl:attribute>
	</xsl:attribute-set>
	
	
	
	
	<!--  -->
	<xsl:template match="/">
		<xsl:apply-templates select="*" mode="p:pipeline"/>
	</xsl:template>
	
	
	
	<!--  -->
	<xsl:template match="/p:declare-step" mode="p:pipeline">
		<svg version="1.1">
			<xsl:call-template name="svg:dimensions"/>
			
			<g transform="translate(242,0)">
				
				<xsl:call-template name="xpt:step">
					<xsl:with-param name="stepSymbol" as="element()">
						<rect xsl:use-attribute-sets="step" x="174" y="-6" width="12" height="12" rx="2" ry="2"/>
					</xsl:with-param>
				</xsl:call-template>
								
				<xsl:apply-templates select="*[xpt:isVisible(.)]" mode="p:steps"/>
				
				<xsl:variable name="lastStep" as="element()" select="descendant::element()[@css:visibility = 'visible'][not(exists(following-sibling::*[@css:visibility = 'visible']))]"/>
				<g transform="translate(0, {($lastStep/@xpt:position + 1) * $vSpacing})">
					<path id="{generate-id()}" xsl:use-attribute-sets="connection" d="m0,0 l0,-{$vSpacing - 6}">
						<xsl:call-template name="xpt:highlightConnection">
							<xsl:with-param name="connectionId" select="xs:ID(generate-id())"/>
						</xsl:call-template>
					</path>
					<rect xsl:use-attribute-sets="step" x="-6" y="{-6}" width="12" height="12" rx="2" ry="2"/>
				</g>
			</g>
		</svg>
	</xsl:template>
	

	<!-- Ignore unsupported steps. -->
	<xsl:template match="*" mode="p:steps">
		<xsl:call-template name="xpt:step">
			<xsl:with-param name="stepSymbol" as="element()">
				<circle xsl:use-attribute-sets="step" cx="180" cy="0" r="6"/>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
	
	<!--  -->
	<xsl:template name="xpt:step">
		<xsl:param name="stepSymbol" as="element()"/>
		
		<g id="{@name}" xsl:use-attribute-sets="step"
				transform="{concat('translate(0, ', $vSpacing * @xpt:position, ')')}">
			
			<xsl:apply-templates select="if (self::p:declare-step) then p:input else p:pipeinfo/p:output" mode="p:ports"/>
			
			<g xsl:use-attribute-sets="labels" transform="translate(-180,0)">
				<text x="0" y="-7">
					<xsl:value-of select="name()"/>
				</text>
				<line xsl:use-attribute-sets="step line" x1="0" y1="0" x2="180" y2="0"/>
				<xsl:copy-of select="$stepSymbol"/>
				<text xsl:use-attribute-sets="name" x="0" y="16">
					<xsl:value-of select="(@name, 'anonymous')[1]"/>
				</text>
			</g>
		</g>
	</xsl:template>
	

	<!-- Input port. -->
	<xsl:template match="p:input | p:output" mode="p:ports" priority="1">
		<xsl:variable name="contextPort" as="element()" select="."/>
		<xsl:variable name="parentStep" as="element()" select="if (exists(self::p:input)) then .. else ../.."/>
		<xsl:variable name="boundStep" as="element()*" 
				select="//*[@css:visibility = 'visible'][p:input/p:pipe/@step = $parentStep/@name]"/>
		
		<xsl:for-each select="$boundStep">
			<xsl:variable name="contextPosn" as="xs:integer"
					select="xs:integer(number($parentStep/@xpt:position))"/>
			<xsl:variable name="boundStepPosn" as="xs:integer"
					select="xs:integer(number(@xpt:position))"/>
			<xsl:variable name="distance" as="xs:integer" 
					select="$boundStepPosn - $contextPosn"/>
			<xsl:variable name="length" 
					select="$distance * $vSpacing"/>
			<xsl:variable name="boundInputPort" as="element()?" select="p:input[p:pipe/@step = $parentStep/@name]"/>
			
			<!-- Set the control point that governs the direction of the start of the path. -->
			<xsl:variable name="directionOut" as="xs:string" select="if (xs:boolean($contextPort/@primary) = true()) then xpt:toSouth() else xpt:toEast()"/>
			<!-- Set the control point that governs the direction of the end of the path. -->
			<xsl:variable name="directionIn" as="xs:string" select="if (xs:boolean($contextPort/@primary) = true()) then xpt:fromNorth() else xpt:fromEast()"/>
			<xsl:variable name="pathData" as="xs:string"
				select="if ($distance gt 1) then 
						string-join(
							(
								'm0,0',
								concat('c', xpt:toSouth()), 
								concat(62, ',', 0),
								concat(62, ',', $vSpacing),
								
								concat('l0,', $vSpacing * ($distance - 2)),
								
								concat('c', 0, ',', $vSpacing), 
								xpt:fromEast(),
								concat(-1 * $hSpacing, ',', $vSpacing)
							),
						' ') 
					else 
						concat('M0,0 L0,', $length)"/>
			<xsl:variable name="pathId" as="xs:ID" select="xs:ID(generate-id($boundInputPort))"/>
			
			<path id="{$pathId}" xsl:use-attribute-sets="connection" d="{$pathData}">
				<xsl:call-template name="xpt:highlightConnection">
					<xsl:with-param name="connectionId" select="$pathId"/>
				</xsl:call-template>
			</path>
		</xsl:for-each>
	</xsl:template>
	
	
	<xsl:function name="xpt:toEast" as="xs:string">
		<xsl:value-of select="string-join((string($hSpacing * 1), string($vSpacing * 0)), ',')"/>
	</xsl:function>
	
	
	<xsl:function name="xpt:toSouth" as="xs:string">
		<xsl:value-of select="string-join((string($hSpacing * 0), string($vSpacing * 1)), ',')"/>
	</xsl:function>
	
	
	<xsl:function name="xpt:fromEast" as="xs:string">
		<xsl:value-of select="string-join((string($hSpacing * 0), string($vSpacing * 1)), ',')"/>
	</xsl:function>
	
	
	<xsl:function name="xpt:fromNorth" as="xs:string">
		<xsl:value-of select="string-join((string($hSpacing * -1), string($vSpacing * 0)), ',')"/>
	</xsl:function>
	
	
	<!-- Highlight the parent primitive by changing its colour and expanding its
		 stroke width while the mouse is 'hovering' over it. -->
	<xsl:template name="xpt:highlightConnection">
		<xsl:param name="connectionId" as="xs:ID"/>
		
		<set attributeName="stroke" to="#6666FF" attributeType="CSS" begin="{$connectionId}.mouseover" end="{$connectionId}.mouseout"/>
		<set attributeName="stroke-width" to="5" attributeType="CSS" begin="{$connectionId}.mouseover" end="{$connectionId}.mouseout"/>
	</xsl:template>
	
	
	<xsl:template match="text()" mode="#all"/>
	
	
	<!--  -->
	<xsl:template name="svg:dimensions" as="attribute()*">
		<xsl:attribute name="width" select="'1024'"/>
		<xsl:attribute name="height" select="$vSpacing * (count(*[xpt:isVisible(.)]) + 3)"/>
	</xsl:template>
	
	
	<!--  -->
	<xsl:function name="xpt:isVisible" as="xs:boolean">
		<xsl:param name="contextNode" as="element()"/>
		
		<xsl:value-of select="if ($contextNode/@css:visibility = 'visible') then true() else false()"/>
	</xsl:function>
	
</xsl:transform>