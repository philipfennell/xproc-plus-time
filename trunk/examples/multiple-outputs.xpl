<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step 
		xmlns:c="http://www.w3.org/ns/xproc-step" 
		xmlns:p="http://www.w3.org/ns/xproc"
		name="multiple-outputs"
		version="1.0">
	<p:input port="source">
		<p:inline>
			<link href="http://www.w3.org">W3C</link>
		</p:inline>
	</p:input>
	<p:output port="result" primary="true"/>
	<p:output port="link" primary="false">
		<p:pipe port="result" step="source"/>
	</p:output>
	
	<p:identity name="source"/>
	
	<p:load name="target">
		<p:with-option name="href" select="/link/@href"/>
	</p:load>
</p:declare-step>