<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step 
		xmlns:c="http://www.w3.org/ns/xproc-step"
		xmlns:cx="http://xmlcalabash.com/ns/extensions"
		xmlns:ml="http://xmlcalabash.com/ns/extensions/marklogic"
		xmlns:p="http://www.w3.org/ns/xproc" 
		xml:base="../../../"
		name="build-request"
		version="1.0">
	
	<p:input port="source">
		<p:document href="test/resources/ldc/ldc_example_04_subset3.xml"/>
	</p:input>
	<p:output port="result"/>
	
	<p:import href="test/resources/xproc/library-1.0.xpl"/>
	
	
	<p:wrap-sequence wrapper="c:body">
		<p:documentation>Wrap the ingestion record.</p:documentation>
		<p:input port="source" select="/ingestionRecord/match_data"/>
	</p:wrap-sequence>
	<p:add-attribute match="/c:body" attribute-name="content-type" attribute-value="application/xml"/>
	<p:add-attribute match="/c:body" attribute-name="encoding" attribute-value="utf-8"/>
	
	<p:wrap-sequence wrapper="c:request">
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
