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
	
	<xsl:import href="normalise-xproc.xsl"/>
	
	<xsl:output encoding="UTF-8" indent="yes" media-type="application/xml" method="xml"/>

	<xsl:strip-space elements="*"/>

	<xsl:variable name="vSpacing" as="xs:integer" select="162"/>

	<!--  -->
	<xsl:template match="/">
		<xsl:variable name="normalisedPipeline" as="document-node()">
			<xsl:document>
				<xsl:apply-imports/>
			</xsl:document>
		</xsl:variable>
		
		<xsl:apply-templates select="$normalisedPipeline" mode="p:steps"/>
	</xsl:template>
	
	

	<!--  -->
	<xsl:template match="/p:declare-step" mode="p:steps">
		<svg version="1.1">
			<xsl:call-template name="svg:dimensions"/>
		
			<style type="text/css">
					<![CDATA[
					.step {
						fill:#FFFFFF;
						stroke:#000000;
						stroke-width:1px;
					}
					
					.labels {
						font-size:12px;
						font-family:sans-serif;
						fill:#000000;
						stroke:none;
					}
					
					.name {
						font-style:italic;
					}
					]]>
				</style>
			
			<xsl:apply-templates select="*[@xpt:visible = true()]" mode="#current"/>
		</svg>
	</xsl:template>
	
	
	


	<!-- Ignore unsupported steps. -->
	<xsl:template match="*" mode="p:steps">
		<g class="step"
				transform="{concat('translate(62, ', $vSpacing * (count(preceding-sibling::*[@xpt:visible = true()]) + 1), ')')}">
			<rect class="step" x="0" y="0" width="162" height="100"/>
			<xsl:apply-templates select="p:input | p:output" mode="p:ports"/>
			<g class="labels">
				<text class="type" x="10" y="26">
					<xsl:value-of select="name()"/>
				</text>
				<text class="name" x="10" y="42">
					<xsl:value-of select="(@name, 'anonymous')[1]"/>
				</text>
			</g>
		</g>
	</xsl:template>
	
	
	<!--  -->


	<!-- Input port. -->
	<xsl:template match="p:input" mode="p:ports">
		<rect class="port input" x="20" y="-32" width="20" height="32"/>
	</xsl:template>


	<!-- Output port. -->
	<xsl:template match="p:output" mode="p:ports">
		<rect class="port output" x="20" y="-32" width="20" height="32"/>
	</xsl:template>


	<!--  -->
	<xsl:template name="svg:dimensions" as="attribute()*">
		<xsl:attribute name="width" select="'1024'"/>
		<xsl:attribute name="height" select="$vSpacing * (count(*[@xpt:visible = true()]) + 1)"/>
	</xsl:template>
</xsl:transform>