<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step 
		xmlns:c="http://www.w3.org/ns/xproc-step"
		xmlns:p="http://www.w3.org/ns/xproc"
		xmlns:xhtml="http://www.w3.org/1999/xhtml"
		xmlns:xf="http://www.w3.org/2002/xforms"
		name="multiple-inputs"
		version="1.0">
	<p:input port="source">
		<p:inline exclude-inline-prefixes="c p xf xhtml">
			<html xmlns="http://www.w3.org/1999/xhtml">
				<head>
					<title>Multiple Inputs Test</title>
				</head>
				<body/>
			</html>
		</p:inline>
	</p:input>
	<p:input port="model" primary="false">
		<p:inline exclude-inline-prefixes="c p xf xhtml">
			<xf:model/>
		</p:inline>
	</p:input>
	
	<p:input port="controls" primary="false">
		<p:inline exclude-inline-prefixes="c p">
			<xf:group/>
		</p:inline>
	</p:input>
	
	<p:output port="result"/>
	
	<p:serialization port="result" encoding="utf-8" indent="true" 
			media-type="application/xhtml+xml" method="xml"/>
	
	<p:insert name="add-model" match="/xhtml:html/xhtml:head" position="first-child">
		<p:input port="source">
			<p:pipe port="source" step="multiple-inputs"/>
		</p:input>
		<p:input port="insertion">
			<p:pipe port="model" step="multiple-inputs"/>
		</p:input>
	</p:insert>
	
	<p:insert name="add-controls" match="/xhtml:html/xhtml:boby" position="last-child">
		<p:input port="insertion">
			<p:pipe port="controls" step="multiple-inputs"/>
		</p:input>
	</p:insert>
</p:declare-step>