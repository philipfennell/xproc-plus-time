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
	
	
	<xsl:import href="line-view.xsl"/>
	
	<xsl:output encoding="UTF-8" indent="yes" media-type="application/svg+xml" method="xml"/>

	<xsl:strip-space elements="*"/>

	<!--  -->
	<xsl:template name="xpt:interaction">
		<xsl:apply-templates select="self::p:declare-step" mode="xpt:interaction"/>
		<xsl:apply-templates select="*[xpt:isVisible(.)]" mode="xpt:interaction"/>
	</xsl:template>
	
	
	<!--  -->
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
	
	
	<!--  -->
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
			<xsl:variable name="boundStep" as="xs:string" select="root($contextNode)//node()[@xml:id = current()]/ancestor::node()[@name][1]/@name"/>
			<set xlink:href="#{$boundStep}Symbol" attributeName="stroke" 		attributeType="CSS" to="#6666FF" 	begin="{current()}.mouseover" end="{current()}.mouseout"/>
			<set xlink:href="#{$boundStep}Symbol" attributeName="stroke-width" 	attributeType="CSS" to="5px" 		begin="{current()}.mouseover" end="{current()}.mouseout"/>
		</xsl:for-each>
	</xsl:template>
	
</xsl:transform>