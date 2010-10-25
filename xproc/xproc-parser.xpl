<?xml version="1.0" encoding="UTF-8"?>
<p:pipeline
		xmlns:c="http://www.w3.org/ns/xproc-step" 
		xmlns:p="http://www.w3.org/ns/xproc"
		xmlns:xpt="http://xproc-plus-time.googlecode.com"
		xml:base=".."
		name="xproc-parser"
		version="1.0">
	<p:documentation>Parses and pre-processes an XProc pipeline ready for transformation into SVG.</p:documentation>
	
	
	<p:serialization port="result" encoding="utf-8" indent="true" 
		media-type="application/xproc+xml" method="xml"/>
	
	<p:import href="xproc/lib-xpt.xpl"/>
	
	<xpt:parse/>
	
</p:pipeline>