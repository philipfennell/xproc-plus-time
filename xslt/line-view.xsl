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

	<xsl:variable name="aspectRation" as="xs:decimal" select="0.618"/>
	<xsl:variable name="vSpacing" as="xs:integer" select="100"/>
	<xsl:variable name="hSpacing" as="xs:integer" select="xs:integer(ceiling($aspectRation * $vSpacing))"/>
	<xsl:variable name="vSpacing2" as="xs:integer" select="$hSpacing * $aspectRation"/>
	
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
		<xsl:variable name="stepName" as="xs:string" select="xpt:normaliseName(@name)"/>
		
		<svg version="1.1">
			<xsl:namespace name="xlink">http://www.w3.org/1999/xlink</xsl:namespace>
			<xsl:call-template name="svg:dimensions"/>
			
			<!--<xsl:apply-templates select="self::p:declare-step" mode="xpt:interaction"/>-->
			
			<xsl:apply-templates select="*[xpt:isVisible(.)]" mode="xpt:interaction"/>
			
			<g transform="translate(242,{$hSpacing * count(p:input)})">
				
				<xsl:variable name="firstStep" as="element()" select="*[xpt:isVisible(.)][1]"/>
				
				<xsl:apply-templates select="p:input" mode="p:pipeline-inputs"/>
				
				<xsl:apply-templates select="p:output" mode="p:pipeline-outputs"/>
								
				<xsl:apply-templates select="*[xpt:isVisible(.)]" mode="p:steps"/>
			</g>
		</svg>
	</xsl:template>
	
	
	<xsl:template match="*" mode="xpt:interaction">
		<set xlink:href="#{@name}Symbol" attributeName="stroke" 		attributeType="CSS" to="#6666FF" 	begin="mouseover" end="mouseout"/>
		<set xlink:href="#{@name}Symbol" attributeName="stroke-width" 	attributeType="CSS" to="5px" 		begin="mouseover" end="mouseout"/>
		
		<xsl:apply-templates select="p:input" mode="#current">
			<xsl:with-param name="stepName" as="xs:string" select="@name"/>
		</xsl:apply-templates>
		
		<xsl:apply-templates select="descendant-or-self::p:output" mode="#current">
			<xsl:with-param name="stepName" as="xs:string" select="@name"/>
		</xsl:apply-templates>
	</xsl:template>
	
	
	<xsl:template match="p:input" mode="xpt:interaction">
		<xsl:param name="stepName" as="xs:string"/>
		
		<set xlink:role="connection" xlink:href="#{@xml:id}" attributeName="stroke" 		attributeType="CSS" to="#6666FF" 	begin="{$stepName}Symbol.mouseover" end="{$stepName}Symbol.mouseout"/>
		<set xlink:role="connection" xlink:href="#{@xml:id}" attributeName="stroke-width"	attributeType="CSS" to="5px" 		begin="{$stepName}Symbol.mouseover" end="{$stepName}Symbol.mouseout"/>
	</xsl:template>
	
	
	<xsl:template match="p:output" mode="xpt:interaction">
		<xsl:param name="stepName" as="xs:string"/>
		<xsl:variable name="contextNode" select="current()"/>
		
		<xsl:for-each select="tokenize(@xpt:boundPorts, ' ')">
			<!-- From. -->
			<set xlink:href="#{$stepName}Symbol" attributeName="stroke" 		attributeType="CSS" to="#6666FF" 	begin="{current()}.mouseover" end="{current()}.mouseout"/>
			<set xlink:href="#{$stepName}Symbol" attributeName="stroke-width" 	attributeType="CSS" to="5px" 		begin="{current()}.mouseover" end="{current()}.mouseout"/>
			
			<!-- Connection. -->
			<set xlink:role="connection" xlink:href="#{current()}" attributeName="stroke" 		attributeType="CSS" to="#6666FF" 	begin="mouseover" end="mouseout"/>
			<set xlink:role="connection" xlink:href="#{current()}" attributeName="stroke-width"	attributeType="CSS" to="5px" 		begin="mouseover" end="mouseout"/>
			<set xlink:role="connection" xlink:href="#{current()}" attributeName="stroke" 		attributeType="CSS" to="#6666FF" 	begin="{$stepName}Symbol.mouseover" end="{$stepName}Symbol.mouseout"/>
			<set xlink:role="connection" xlink:href="#{current()}" attributeName="stroke-width"	attributeType="CSS" to="5px" 		begin="{$stepName}Symbol.mouseover" end="{$stepName}Symbol.mouseout"/>
			
			<!-- To. -->
			<xsl:variable name="boundStep" as="xs:string" select="root($contextNode)//node()[@xml:id = current()]/../@name"/>
			<set xlink:href="#{$boundStep}Symbol" attributeName="stroke" 		attributeType="CSS" to="#6666FF" 	begin="{current()}.mouseover" end="{current()}.mouseout"/>
			<set xlink:href="#{$boundStep}Symbol" attributeName="stroke-width" 	attributeType="CSS" to="5px" 		begin="{current()}.mouseover" end="{current()}.mouseout"/>
		</xsl:for-each>
	</xsl:template>
	
	
	<!-- Connect the pipeline's inputs to their bound steps. -->
	<xsl:template match="p:input" mode="p:pipeline-inputs">
		<xsl:variable name="stepName" as="xs:string" select="xpt:normaliseName(../@name)"/>
		<xsl:variable name="hPosn" as="xs:integer" select="position()"/>
		<xsl:variable name="contextPort" as="element()" select="."/>
		<xsl:variable name="hOffset" as="xs:integer" select="($hPosn * $hSpacing) + 186"/>
		
		<g class="input {@port}" transform="translate({$hOffset}, {-1 * (($hPosn - 1) * $hSpacing)})">
			<xsl:variable name="boundPorts" as="element()*" 
					select="for $portId in tokenize(@xpt:boundPorts, ' ') return id($portId)"/>
			
			<xsl:for-each select="$boundPorts">
				<xsl:variable name="distance" as="xs:integer" select="../@xpt:position"/>
				
				<!-- Set the control point that governs the direction of the end of the path. -->
				<xsl:variable name="directionIn" as="xs:string" select="if (xs:boolean(@primary) = true()) then xpt:fromNorth() else xpt:fromEast()"/>
				
				<xsl:variable name="pathData" select="string-join(
					(
					'm0,0',
									
					concat('l0,', ($vSpacing * ($distance - 1)) + (($hPosn - 1) * $hSpacing)),
					
					concat('c', 0, ',', $vSpacing), 
					$directionIn,
					concat((-1 * $hOffset), ',', $vSpacing)
					), ' ')"/>
				<g transform="translate({../@xpt:position * 0},0)">
					<path id="{@xml:id}" xsl:use-attribute-sets="connection" d="{$pathData}"/>
				</g>
			</xsl:for-each>
			
			<g xsl:use-attribute-sets="labels" transform="translate(-180,0)">
				<text x="0" y="-7"><xsl:value-of select="name($contextPort)"/></text>
				<line xsl:use-attribute-sets="step line" x1="0" y1="0" x2="180" y2="0"/>
				<text xsl:use-attribute-sets="name" x="0" y="16">
					<xsl:value-of select="$contextPort/@port"/>
				</text>
			</g>
			
			<!-- id="{$stepName}InputSymbol" -->
			<rect xsl:use-attribute-sets="step" x="-6" y="{-6}" width="12" height="12" rx="2" ry="2"/>
		</g>
	</xsl:template>
	
	
	<!-- Connect the pipeline's outputs to their bound steps. -->
	<xsl:template match="p:output" mode="p:pipeline-outputs">
		<xsl:variable name="lastStep" as="element()" select="../element()[@css:visibility = 'visible'][last()]"/>
		<xsl:variable name="stepName" as="xs:string" select="xpt:normaliseName(../@name)"/>
		<xsl:variable name="hPosn" as="xs:integer" select="position() - 1"/>
		<xsl:variable name="contextPort" as="element()" select="."/>
		<xsl:variable name="hOffset" as="xs:integer" select="($hPosn * $hSpacing) + 124"/>
		
		<g class="output {@port}" transform="translate({$hOffset}, {(($lastStep/@xpt:position + 1) * $vSpacing)})">
			<xsl:variable name="boundPorts" as="element()*" 
					select="for $portId in tokenize(@xpt:boundPorts, ' ') return id($portId)"/>
			
			<xsl:for-each select="$boundPorts">
				<xsl:variable name="distance" as="xs:integer" select="../../@xpt:position"/>
				
				<!-- Set the control point that governs the direction of the start of the path. -->
				<xsl:variable name="directionOut" as="xs:string" select="if (xs:boolean(@primary) = true()) then xpt:toSouth() else string-join((string($hOffset - $hSpacing), string($vSpacing * 0)), ',')"/>
				<xsl:variable name="lastStepOffset" as="xs:integer" select="xs:integer($lastStep/@xpt:position) * $vSpacing"/>
				<xsl:variable name="pathData" select="string-join(
					(
					concat('m', -1 * $hOffset, ',', -1 * (($lastStepOffset - ($distance * $vSpacing)) + $vSpacing)),
					
					concat('c', $directionOut), 
					concat($hOffset, ',', 0),
					concat($hOffset, ',', if (xs:boolean(@primary) = true()) then $vSpacing else $hSpacing),
					
					concat('l0,', ($lastStepOffset - ($distance * $vSpacing) + ($hPosn * (if (xs:boolean(@primary) = true()) then $hSpacing else $vSpacing))))
					), ' ')"/>
				
				<path id="{@xml:id}" xsl:use-attribute-sets="connection" d="{$pathData}"/>
			</xsl:for-each>
			
			<!-- id="{$stepName}OutputSymbol"-->
			<g transform="translate(0,{($hPosn * $hSpacing)})">
				<g xsl:use-attribute-sets="labels" transform="translate(-180,0)">
					<text x="0" y="-7"><xsl:value-of select="name($contextPort)"/></text>
					<line xsl:use-attribute-sets="step line" x1="0" y1="0" x2="180" y2="0"/>
					<text xsl:use-attribute-sets="name" x="0" y="16">
						<xsl:value-of select="$contextPort/@port"/>
					</text>
				</g>
				<rect xsl:use-attribute-sets="step" x="-6" y="-6" width="12" height="12" rx="2" ry="2"/>
			</g>
		</g>
	</xsl:template>
	
	
	<!-- Ignore unsupported steps. -->
	<xsl:template match="*" mode="p:steps">
		<xsl:call-template name="xpt:step">
			<xsl:with-param name="stepSymbol" as="element()">
				<circle id="{@name}Symbol" xsl:use-attribute-sets="step" cx="180" cy="0" r="6"/>
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
					<xsl:value-of select="if (string-length(@name) gt 24) then concat(substring(@name, 1, 24), '...') else @name"/>
				</text>
			</g>
		</g>
	</xsl:template>
	

	<!-- Port. -->
	<xsl:template match="p:output" mode="p:ports" priority="1">
		<xsl:variable name="contextPort" as="element()" select="."/>
		<xsl:variable name="parentStep" as="element()" select="../.."/>
		<xsl:variable name="connectionIds" as="xs:string*" 
				select="tokenize(@xpt:boundPorts, ' ')"/>
		<xsl:variable name="boundPorts" as="element()*" 
				select="for $idref in $connectionIds return id($idref)"/>
		
		<xsl:for-each select="$boundPorts">
			<xsl:variable name="boundStep" as="element()" 
					select=".."/>
			<xsl:variable name="contextPosn" as="xs:integer"
					select="xs:integer(number($parentStep/@xpt:position))"/>
			<xsl:variable name="boundStepPosn" as="xs:integer"
					select="xs:integer(number($boundStep/@xpt:position))"/>
			<xsl:variable name="distance" as="xs:integer" 
					select="$boundStepPosn - $contextPosn"/>
			<xsl:variable name="length" 
					select="$distance * $vSpacing"/>
			<xsl:variable name="boundInputPort" as="element()?" select="p:input[p:pipe/@step = $parentStep/@name]"/>
			
			<!-- Set the control point that governs the direction of the start of the path. -->
			<xsl:variable name="directionOut" as="xs:string" select="if (xs:boolean($contextPort/@primary) = true()) then xpt:toSouth() else xpt:toEast()"/>
			<!-- Set the control point that governs the direction of the end of the path. -->
			<xsl:variable name="directionIn" as="xs:string" select="if (xs:boolean($boundInputPort/@primary) = true()) then xpt:fromNorth() else xpt:fromEast()"/>
			<xsl:variable name="pathData" as="xs:string"
				select="if ($distance gt 1) then 
						string-join(
							(
								'm0,0',
								concat('c', $directionOut), 
								concat(62, ',', 0),
								concat(62, ',', $vSpacing),
								
								concat('l0,', $vSpacing * ($distance - 2)),
								
								concat('c', 0, ',', $vSpacing), 
								$directionIn,
								concat(-1 * $hSpacing, ',', $vSpacing)
							),
						' ') 
					else 
						concat('M0,0 L0,', $length)"/>
			<xsl:variable name="pathId" as="xs:string" select="@xml:id"/>
			
			<path id="{$pathId}" class="connection" xsl:use-attribute-sets="connection" d="{$pathData}"/>
		</xsl:for-each>
	</xsl:template>
	
	
	<xsl:function name="xpt:toEast" as="xs:string">
		<xsl:value-of select="string-join((string($hSpacing), string($vSpacing * 0)), ',')"/>
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
	
	
	<xsl:template match="text()" mode="#all"/>
	
	
	<!--  -->
	<xsl:template name="svg:dimensions" as="attribute()*">
		<xsl:attribute name="width" select="($hSpacing * (count(p:input | p:output))) + 242 + 186"/>
		<xsl:attribute name="height" select="$vSpacing * (count(*[xpt:isVisible(.)]) + count(p:input | p:output))"/>
	</xsl:template>
	
	
	<!--  -->
	<xsl:function name="xpt:isVisible" as="xs:boolean">
		<xsl:param name="contextNode" as="element()"/>
		
		<xsl:value-of select="if ($contextNode/@css:visibility = 'visible') then true() else false()"/>
	</xsl:function>
	
	
	<!--  -->
	<xsl:function name="xpt:normaliseName" as="xs:string">
		<xsl:param name="stepName"/>
		
		<xsl:value-of select="translate($stepName, '-', '')"/>
	</xsl:function>
	
</xsl:transform>