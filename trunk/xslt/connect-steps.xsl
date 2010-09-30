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
	
	
	<!--  -->
	<xsl:template match="/">
		<xsl:apply-templates select="*" mode="p:connect">
			<xsl:with-param name="p:stepDeclarations" as="element(p:library)" 
					select="doc('../xproc/xproc-steps-lib.xpl')/p:library"
					tunnel="yes"/>
		</xsl:apply-templates>
	</xsl:template>
	
	
	<!--  -->
	<xsl:template match="*" mode="p:connect">
		<xsl:param name="p:stepDeclarations" as="element(p:library)" tunnel="yes"/>
		<xsl:variable name="p:contextStepDeclaration" as="element()?" 
				select="$p:stepDeclarations/p:declare-step[@type = name(current())]"/>
		<xsl:variable name="declaredPorts" as="xs:string*" select="">
			<xsl:for-each select="p:contextStepDeclaration/(p:input | p:output)">
				<xsl:value-of select="string-join((local-name(), @port), ':')"/>
			</xsl:for-each>
		</xsl:variable>
		
		<xsl:copy>
			<xsl:copy-of select="@*"/>
			<xsl:if test="not(@name)">
				<xsl:attribute name="name" select="concat('anon', generate-id())"/>
			</xsl:if>
			<xsl:for-each select="p:input | p:output">
				<xsl:choose>
					<xsl:when test="string-join((local-name(), @port), ':') = $declaredPorts">
						<xsl:copy-of select="current()"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:copy-of select="p:contextStepDeclaration/(p:input | p:output)[local-name() = local-name(current()) and @port = current()/@port]"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:for-each>
			<xsl:apply-templates select="* except (p:input, p:output) | text()" mode="#current"/>
		</xsl:copy>
	</xsl:template>
	
	
	<!--  -->
	<xsl:template match="p:input" mode="p:ports">
		
	</xsl:template>
	
	
</xsl:transform>