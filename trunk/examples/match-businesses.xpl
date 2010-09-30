<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step 
		xmlns:c="http://www.w3.org/ns/xproc-step"
		xmlns:cx="http://xmlcalabash.com/ns/extensions"
		xmlns:ml="http://xmlcalabash.com/ns/extensions/marklogic"
		xmlns:p="http://www.w3.org/ns/xproc" 
		xml:base="../../../"
		name="match-businesses"
		version="1.0">
	
	<p:input port="source">
		<p:document href="test/resources/ldc/ldc_example_04_subset3.xml"/>
	</p:input>
	<p:output port="result"/>
	
	<p:import href="test/resources/xproc/library-1.0.xpl"/>
	
	<p:for-each>
		<p:iteration-source select="/ldc_data/ldc_business"/>
		
		<p:xslt name="generate-ingestion-record">
			<p:input port="stylesheet">
				<p:document href="test/resources/xslt/ldcBusiness2yellIngestionRecord.xsl"/>
			</p:input>
			<p:input port="parameters">
				<p:empty/>
			</p:input>
			<p:with-param name="SOURCE_NAME" select="'ldc'"/>
		</p:xslt>
		
		<!-- Invoke blue-pill over HTTP. -->
		
		<!-- Wrap the ingestion record. -->
		<p:wrap-sequence wrapper="c:body">
			<p:input port="source" select="/ingestionRecord/match_data"/>
		</p:wrap-sequence>
		<p:add-attribute match="/c:body" attribute-name="content-type" attribute-value="application/xml"/>
		<p:add-attribute match="/c:body" attribute-name="encoding" attribute-value="utf-8"/>
		
		<!-- Build the request. -->
		<p:wrap-sequence wrapper="c:request"/>
		<p:add-attribute match="/c:request" attribute-name="href" attribute-value="http://carrow:8050/idr-pd/match/handler.xqy"/>
		<p:add-attribute match="/c:request" attribute-name="method" attribute-value="POST"/>
		<p:add-attribute match="/c:request" attribute-name="username" attribute-value="admin"/>
		<p:add-attribute match="/c:request" attribute-name="password" attribute-value="admin"/>
		<p:add-attribute match="/c:request" attribute-name="send-authorization" attribute-value="true"/>
		<p:add-attribute match="/c:request" attribute-name="auth-method" attribute-value="digest"/>
		<p:add-attribute match="/c:request" attribute-name="detailed" attribute-value="true"/>
		<p:identity name="request"/>
		
		<!-- Submit request. -->
		<p:http-request name="response" encoding="utf-8" indent="true" media-type="application/xml" method="xml"/>
		
		<!-- Handle response. -->
		<p:wrap-sequence wrapper="c:result"/>
		
		<p:insert match="/c:result" position="first-child">
			<p:input port="insertion">
				<p:pipe port="result" step="request"/>
			</p:input>
		</p:insert>
	</p:for-each>
	
	<p:wrap-sequence wrapper="c:results"/>
</p:declare-step>
