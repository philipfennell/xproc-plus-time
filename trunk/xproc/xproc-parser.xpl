<?xml version="1.0" encoding="UTF-8"?>
<p:pipeline
		xmlns:p="http://www.w3.org/ns/xproc"
		xmlns:c="http://www.w3.org/ns/xproc-step"
		xml:base=".."
		name="xproc-parser"
		version="1.0">
	<p:documentation>Parses and pre-processes an XProc pipeline ready for transformation into SVG.</p:documentation>
	
	<p:serialization port="result" encoding="utf-8" indent="true" 
			media-type="application/xproc+xml" method="xml"/>
	
	
	
	
	<p:xslt name="connect-steps">
		<p:documentation>Makes step connections explicit.</p:documentation>
		<p:input port="stylesheet">
			<p:document href="xslt/connect-steps.xsl"/>
		</p:input>
	</p:xslt>
	
	<p:xslt name="visible-steps">
		<p:documentation>Tags all steps that are to appear in the view with a css:visibility attribute.</p:documentation>
		<p:input port="stylesheet">
			<p:document href="xslt/visible-steps.xsl"/>
		</p:input>
	</p:xslt>
	
</p:pipeline>