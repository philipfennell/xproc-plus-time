<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step 
		xmlns:p="http://www.w3.org/ns/xproc"
		xmlns:terms="http://example.org/service/terms/"
		name="term-aggregation">
	
	<p:input port="source"/>
	<p:output port="result"/>
	
	<p:pipeinfo>
		<smil:timesheet xmlns:smil="http://www.w3.org/ns/SMIL30">
			<smil:par>
				<smil:item select="#service1" begin="aggregate-terms.begin" 
						dur="11s"/>
				<smil:item select="#service2" begin="aggregate-terms.begin" 
						dur="11s"/>
				<smil:item select="#service3" begin="aggregate-terms.begin" 
						dur="11s"/>
			</smil:par>
		</smil:timesheet>
	</p:pipeinfo>

	<p:declare-step type="terms:get">
		<p:documentation>
			Makes an HTTP request to a term extraction service.
		</p:documentation>
		<p:input port="source"/>
		<p:output port="result" sequence="true"/>
		<p:option name="href"/>

		<!-- ===================================================================
			Omitted for brevity's sake, but it would use the p:http-request 
			step to submit the text that you want terms to be extract from.
		==================================================================== -->
		
		<p:identity/>
	</p:declare-step>

	<terms:get xml:id="service1" name="OpenCalais" 
			href="http://opencalais.com/"/>
	<terms:get xml:id="service2" name="MetaCarta" 
			href="http://www.metacarta.com/"/>
	<terms:get xml:id="service3" name="Yahoo" 
			href="http://search.yahooapis.com/"/>
	 
	<p:wrap-sequence xml:id="aggregate-terms" name="aggregate" 
			wrapper="terms:group">
		<p:input port="source">
			<p:pipe step="OpenCalais" port="result"/>
			<p:pipe step="MetaCarta" port="result"/>
			<p:pipe step="Yahoo" port="result"/>
		</p:input>
	</p:wrap-sequence>
</p:declare-step> 