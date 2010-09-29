<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step 
		xmlns:p="http://www.w3.org/ns/xproc"
		xmlns:c="http://www.w3.org/ns/xproc-step"
		name="transform-and-validate"
		version="1.0">
	<p:input port="source">
		<p:inline>
			<doc>Hello world!</doc>		
		</p:inline>
	</p:input>
	<p:output port="result"/>
	
	<p:xslt name="xml-to-xhtml">
		<p:input port="stylesheet">
			<p:document href="xml-to-xhtml.xslt"/>
		</p:input>
		<p:input port="parameters">
			<p:empty/>
		</p:input>
	</p:xslt>
	
	<p:validate-with-xml-schema name="validate-xhtml">
		<p:input port="schema">
			<p:document href="xhtml.xsd"/>
		</p:input>
	</p:validate-with-xml-schema>
</p:declare-step>