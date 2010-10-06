<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step 
		xmlns:c="http://www.w3.org/ns/xproc-step"
		xmlns:cx="http://xmlcalabash.com/ns/extensions"
		xmlns:ml="http://xmlcalabash.com/ns/extensions/marklogic"
		xmlns:p="http://www.w3.org/ns/xproc" 
		xml:base=".."
		name="build-request"
		version="1.0">
	
	<p:input port="source">
		<p:inline exclude-inline-prefixes="c cx ml p">
			<ingestionRecord><match_data/></ingestionRecord>
		</p:inline>
	</p:input>
	<p:output port="result"/>
	
	<p:import href="xproc/library-1.0.xpl"/>
	
	
	<p:wrap-sequence name="foo" wrapper="c:body">
		<p:documentation>Wrap the ingestion record.</p:documentation>
		<p:input port="source" select="/ingestionRecord/match_data"/>
	</p:wrap-sequence>
	
	<!--<p:sink/>-->
	
	<p:add-attribute match="/c:body" attribute-name="content-type" attribute-value="application/xml">
		<!--<p:input port="source">
			<p:pipe port="source" step="build-request"/>
		</p:input>-->
	</p:add-attribute>
	
	<p:add-attribute match="/c:body" attribute-name="encoding" attribute-value="utf-8"/>
	
	<!--<p:sink/>-->
	
	<p:wrap-sequence wrapper="c:request">
		<!--<p:input port="source">
			<p:pipe port="result" step="foo"/>
		</p:input>-->
		<p:documentation>Build the request.</p:documentation>
	</p:wrap-sequence>
	
	<p:add-attribute match="/c:request" attribute-name="href" attribute-value="http://carrow:8050/idr-pd/match/handler.xqy"/>
	
	<p:add-attribute match="/c:request" attribute-name="method" attribute-value="POST"/>
	
	<p:identity name="request"/>
	
	<p:http-request name="response" encoding="utf-8" indent="true" media-type="application/xml" method="xml">
		<p:documentation>Submit request.</p:documentation>
	</p:http-request>
	
	<p:wrap-sequence wrapper="c:result">
		<p:documentation>Handle response.</p:documentation>
	</p:wrap-sequence>
	
	<p:insert match="/c:result" position="first-child">
		<p:input port="insertion">
			<p:pipe port="result" step="request"/>
		</p:input>
	</p:insert>
	
	<p:wrap-sequence wrapper="c:results"/>
</p:declare-step>
