<?xml version="1.0" encoding="UTF-8"?>
<xsl:transform 
		xmlns="http://www.w3.org/2000/svg" 
		xmlns:c="http://www.w3.org/ns/xproc-step"
		xmlns:css="http://www.w3.org/TR/CSS2"
		xmlns:cx="http://xmlcalabash.com/ns/extensions"
		xmlns:ml="http://xmlcalabash.com/ns/extensions/marklogic" 
		xmlns:p="http://www.w3.org/ns/xproc"
		xmlns:xpt="http://xproc-plus-time.googlecode.com"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:xs="http://www.w3.org/2001/XMLSchema"
		xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
		exclude-result-prefixes="c cx ml p xs xsi" 
		version="2.0">
	
	
	<xsl:template match="p:import | p:input | p:output | p:serialization | p:option | p:document | p:inline | p:data | p:empty | p:pipe | p:pipeinfo | p:documentation" mode="#all">
		<xsl:copy-of select="."/>
	</xsl:template>
	
</xsl:transform>