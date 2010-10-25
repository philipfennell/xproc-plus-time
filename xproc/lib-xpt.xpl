<?xml version="1.0" encoding="UTF-8"?>
<p:library 
		xmlns:c="http://www.w3.org/ns/xproc-step" 
		xmlns:p="http://www.w3.org/ns/xproc"
		xmlns:xpt="http://xproc-plus-time.googlecode.com"
		version="1.0">
	
	<p:declare-step type="xpt:parse">
		<p:input port="source"/>
		<p:output port="result"/>
		
		<p:xslt>
			<p:documentation>Normalises XProc pipelines.</p:documentation>
			<p:input port="stylesheet">
				<p:document href="../xslt/normalise-pipeline.xsl"/>
			</p:input>
			<p:input port="parameters">
				<p:empty/>
			</p:input>
		</p:xslt>
		
		<p:xslt name="augment-steps">
			<p:documentation>Adds missing 'implied' information.</p:documentation>
			<p:input port="stylesheet">
				<p:document href="../xslt/augment-steps.xsl"/>
			</p:input>
			<p:input port="parameters">
				<p:empty/>
			</p:input>
		</p:xslt>
		
		<p:xslt name="connect-steps">
			<p:documentation>Makes step connections explicit.</p:documentation>
			<p:input port="stylesheet">
				<p:document href="../xslt/connect-steps.xsl"/>
			</p:input>
			<p:input port="parameters">
				<p:empty/>
			</p:input>
		</p:xslt>
		
		<p:xslt name="visible-steps">
			<p:documentation>Tags all steps that are to appear in the view with a css:visibility attribute.</p:documentation>
			<p:input port="stylesheet">
				<p:document href="../xslt/visible-steps.xsl"/>
			</p:input>
			<p:input port="parameters">
				<p:empty/>
			</p:input>
		</p:xslt>
	</p:declare-step>
</p:library>