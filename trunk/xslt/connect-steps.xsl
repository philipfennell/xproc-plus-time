<?xml version="1.0" encoding="UTF-8"?>
<xsl:transform 
		xmlns:c="http://www.w3.org/ns/xproc-step"
		xmlns:cx="http://xmlcalabash.com/ns/extensions"
		xmlns:ml="http://xmlcalabash.com/ns/extensions/marklogic" 
		xmlns:p="http://www.w3.org/ns/xproc"
		xmlns:xpt="http://xproc-plus-time.googlecode.com"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:xs="http://www.w3.org/2001/XMLSchema"
		xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
		exclude-result-prefixes="cx ml xs xsi" 
		version="2.0">
	
	<xsl:output encoding="UTF-8" indent="yes" media-type="application/xproc+xml" method="xml"/>
	
	<xsl:strip-space elements="*"/>
	
	
	<!--  -->
	<xsl:template match="/">
		<xsl:variable name="labelPipeline" as="element()">
			<xsl:apply-templates select="*" mode="p:label-ports"/>
		</xsl:variable>
		
		<xsl:apply-templates select="$labelPipeline" mode="p:connect"/>
	</xsl:template>
	
	
	<!--  -->
	<xsl:template match="p:input | p:output" mode="p:label-ports">
		<xsl:copy>
			<xsl:attribute name="xml:id" select="generate-id()"/>
			<xsl:copy-of select="@*"/>
			<xsl:apply-templates select="* | text()" mode="#current"/>
		</xsl:copy>
	</xsl:template>
	
	
	<!--  -->
	<xsl:template match="p:declare-step/p:output" mode="p:connect">
		<xsl:variable name="parentStep" as="element()" select="if (name(..) = 'p:declare-step') then .. else ../.."/>
		<xsl:copy>
			<xsl:copy-of select="@*"/>
			<xsl:attribute name="xpt:boundPorts" select="../*[last()]//p:output/@xml:id"/>
			<xsl:apply-templates select="* | text()" mode="#current"/>
		</xsl:copy>
	</xsl:template>
	
	
	<!--  -->
	<xsl:template match="p:output" mode="p:connect">
		<xsl:variable name="parentStep" as="element()" select="if (name(..) = 'p:declare-step') then .. else ../.."/>
		<xsl:copy>
			<xsl:copy-of select="@*"/>
			<xsl:attribute name="xpt:boundPorts" select="string-join(xpt:find-bound-ports($parentStep, self::*), ' ')"/>
			<xsl:apply-templates select="* | text()" mode="#current"/>
		</xsl:copy>
	</xsl:template>
	
	
	<!-- Returns a white-space separated list of port ids. -->
	<xsl:function name="xpt:find-bound-ports" as="xs:string*">
		<xsl:param name="contextStep" as="element()"/>
		<xsl:param name="contextPort" as="element()"/>
		
		<xsl:sequence select="root($contextStep)//p:input[p:pipe/@step = $contextStep/@name][p:pipe/@port = $contextPort/@port]/@xml:id"/>
	</xsl:function>
	
	
	<!--  -->
	<xsl:template match="*" mode="p:connect p:label-ports">
		<xsl:copy>
			<xsl:copy-of select="@*"/>
			
			<xsl:apply-templates select="* | text()" mode="#current"/>
		</xsl:copy>
	</xsl:template>
</xsl:transform>