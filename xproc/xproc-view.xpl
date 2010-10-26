<?xml version="1.0" encoding="UTF-8"?>
<p:pipeline
		xmlns:c="http://www.w3.org/ns/xproc-step"
		xmlns:p="http://www.w3.org/ns/xproc"
		xmlns:xpt="http://xproc-plus-time.googlecode.com"
		xml:base=".."
		name="xproc-view"
		version="1.0">
	<p:documentation>Generates a 'view' of an XProc pipeline using SVG.</p:documentation>
	
	<p:import href="xproc/lib-xpt.xpl"/>
	
	<p:serialization port="result" encoding="utf-8" indent="true" 
			media-type="application/xproc+xml" method="xml"/>
	
	
	<xpt:parse name="parsed-pipeline"/>
	
	<p:store href="logs/parsed-pipeline.xpl" encoding="utf-8" indent="true"
			media-type="application/xproc+xml" method="xml"/>
	
	<p:xslt name="view">
		<p:documentation>Generate a view.</p:documentation>
		<p:input port="source">
			<p:pipe port="result" step="parsed-pipeline"/>
		</p:input>
		<p:input port="stylesheet">
			<p:document href="xslt/line-view.xsl"/>
<!--			<p:document href="xslt/highlighting-connections-view.xsl"/>-->
		</p:input>
	</p:xslt>
	
</p:pipeline>