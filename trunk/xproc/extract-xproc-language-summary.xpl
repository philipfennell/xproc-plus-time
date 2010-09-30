<?xml version="1.0" encoding="UTF-8"?>
<p:pipeline
		xmlns:c="http://www.w3.org/ns/xproc-step"
		xmlns:p="http://www.w3.org/ns/xproc"
		xmlns:xhtml="http://www.w3.org/1999/xhtml"
		exclude-inline-prefixes="xhtml"
		xml:base=".."
		name="extract-xproc-language-summary"
		version="1.0">
	<p:documentation></p:documentation>
	
	<p:serialization port="result" encoding="utf-8" indent="true" media-type="application/xproc+xml" method="xml"/>
	
	<p:filter select="//xhtml:div[@class='appendix'][xhtml:h2/xhtml:a/@id = 'language-summary']"/>
	
</p:pipeline>