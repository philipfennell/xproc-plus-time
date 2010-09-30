<?xml version="1.0" encoding="UTF-8"?>
<p:library 
		xmlns:c="http://www.w3.org/ns/xproc-step" 
		xmlns:p="http://www.w3.org/ns/xproc"
		xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
		version="1.0">
	
	
	<p:declare-step type="p:add-attribute">
	     <p:input port="source"/>
	     <p:output port="result"/>
	     <p:option name="match" required="true"/>                      <!-- XSLTMatchPattern -->
		 <p:option name="attribute-name" required="true" xsi:type="xs:QName"/>             <!-- QName -->
	     <p:option name="attribute-prefix"/>                           <!-- NCName -->
	     <p:option name="attribute-namespace"/>                        <!-- anyURI -->
	     <p:option name="attribute-value" required="true"/>            <!-- string -->
	</p:declare-step>
	
	<p:declare-step type="p:add-xml-base">
	     <p:input port="source"/>
	     <p:output port="result"/>
	     <p:option name="all" select="'false'"/>                       <!-- boolean -->
	     <p:option name="relative" select="'true'"/>                   <!-- boolean -->
	</p:declare-step>
	
	<p:declare-step type="p:compare">
	     <p:input port="source" primary="true"/>
	     <p:input port="alternate"/>
	     <p:output port="result" primary="false"/>
	     <p:option name="fail-if-not-equal" select="'false'"/>         <!-- boolean -->
	</p:declare-step>
	
	<p:declare-step type="p:count">
	     <p:input port="source" sequence="true"/>
	     <p:output port="result"/>
	     <p:option name="limit" select="0"/>                           <!-- integer -->
	</p:declare-step>
	
	<p:declare-step type="p:delete">
	     <p:input port="source"/>
	     <p:output port="result"/>
	     <p:option name="match" required="true"/>                      <!-- XSLTMatchPattern -->
	</p:declare-step>
	
	<p:declare-step type="p:directory-list">
	     <p:output port="result"/>
	     <p:option name="path" required="true"/>                       <!-- anyURI -->
	     <p:option name="include-filter"/>                             <!-- RegularExpression -->
	     <p:option name="exclude-filter"/>                             <!-- RegularExpression -->
	</p:declare-step>
	
	<p:declare-step type="p:error">
	     <p:input port="source" primary="false"/>
	     <p:output port="result" sequence="true"/>
	     <p:option name="code" required="true"/>                       <!-- QName -->
	     <p:option name="code-prefix"/>                                <!-- NCName -->
	     <p:option name="code-namespace"/>                             <!-- anyURI -->
	</p:declare-step>
	
	<p:declare-step type="p:escape-markup">
	     <p:input port="source"/>
	     <p:output port="result"/>
	     <p:option name="cdata-section-elements" select="''"/>         <!-- ListOfQNames -->
	     <p:option name="doctype-public"/>                             <!-- string -->
	     <p:option name="doctype-system"/>                             <!-- anyURI -->
	     <p:option name="escape-uri-attributes" select="'false'"/>     <!-- boolean -->
	     <p:option name="include-content-type" select="'true'"/>       <!-- boolean -->
	     <p:option name="indent" select="'false'"/>                    <!-- boolean -->
	     <p:option name="media-type"/>                                 <!-- string -->
	     <p:option name="method" select="'xml'"/>                      <!-- QName -->
	     <p:option name="omit-xml-declaration" select="'true'"/>       <!-- boolean -->
	     <p:option name="standalone" select="'omit'"/>                 <!-- "true" | "false" | "omit" -->
	     <p:option name="undeclare-prefixes"/>                         <!-- boolean -->
	     <p:option name="version" select="'1.0'"/>                     <!-- string -->
	</p:declare-step>
	
	<p:declare-step type="p:filter">
	     <p:input port="source"/>
	     <p:output port="result" sequence="true"/>
	     <p:option name="select" required="true"/>                     <!-- XPathExpression -->
	</p:declare-step>
	
	<p:declare-step type="p:http-request">
	     <p:input port="source"/>
	     <p:output port="result"/>
	     <p:option name="byte-order-mark"/>                            <!-- boolean -->
	     <p:option name="cdata-section-elements" select="''"/>         <!-- ListOfQNames -->
	     <p:option name="doctype-public"/>                             <!-- string -->
	     <p:option name="doctype-system"/>                             <!-- anyURI -->
	     <p:option name="encoding"/>                                   <!-- string -->
	     <p:option name="escape-uri-attributes" select="'false'"/>     <!-- boolean -->
	     <p:option name="include-content-type" select="'true'"/>       <!-- boolean -->
	     <p:option name="indent" select="'false'"/>                    <!-- boolean -->
	     <p:option name="media-type"/>                                 <!-- string -->
	     <p:option name="method" select="'xml'"/>                      <!-- QName -->
	     <p:option name="normalization-form" select="'none'"/>         <!-- NormalizationForm -->
	     <p:option name="omit-xml-declaration" select="'true'"/>       <!-- boolean -->
	     <p:option name="standalone" select="'omit'"/>                 <!-- "true" | "false" | "omit" -->
	     <p:option name="undeclare-prefixes"/>                         <!-- boolean -->
	     <p:option name="version" select="'1.0'"/>                     <!-- string -->
	</p:declare-step>
	
	<p:declare-step type="p:identity">
	     <p:input port="source" sequence="true"/>
	     <p:output port="result" sequence="true"/>
	</p:declare-step>
	
	<p:declare-step type="p:insert">
	     <p:input port="source" primary="true"/>
	     <p:input port="insertion" sequence="true"/>
	     <p:output port="result"/>
	     <p:option name="match" select="'/*'"/>                        <!-- XSLTMatchPattern -->
	     <p:option name="position" required="true"/>                   <!-- "first-child" | "last-child" | "before" | "after" -->
	</p:declare-step>
	
	<p:declare-step type="p:label-elements">
	     <p:input port="source"/>
	     <p:output port="result"/>
	     <p:option name="attribute" select="'xml:id'"/>                <!-- QName -->
	     <p:option name="attribute-prefix"/>                           <!-- NCName -->
	     <p:option name="attribute-namespace"/>                        <!-- anyURI -->
	     <!--<p:option name="label" select="'concat("_",$p:index)'"/>-->      <!-- XPathExpression -->
	     <p:option name="match" select="'*'"/>                         <!-- XSLTMatchPattern -->
	     <p:option name="replace" select="'true'"/>                    <!-- boolean -->
	</p:declare-step>
	
	<p:declare-step type="p:load">
	     <p:output port="result"/>
	     <p:option name="href" required="true"/>                       <!-- anyURI -->
	     <p:option name="dtd-validate" select="'false'"/>              <!-- boolean -->
	</p:declare-step>
	
	<p:declare-step type="p:make-absolute-uris">
	     <p:input port="source"/>
	     <p:output port="result"/>
	     <p:option name="match" required="true"/>                      <!-- XSLTMatchPattern -->
	     <p:option name="base-uri"/>                                   <!-- anyURI -->
	</p:declare-step>
	
	<p:declare-step type="p:namespace-rename">
	     <p:input port="source"/>
	     <p:output port="result"/>
	     <p:option name="from"/>                                       <!-- anyURI -->
	     <p:option name="to"/>                                         <!-- anyURI -->
	     <p:option name="apply-to" select="'all'"/>                    <!-- "all" | "elements" | "attributes" -->
	</p:declare-step>
	
	<p:declare-step type="p:pack">
	     <p:input port="source" sequence="true" primary="true"/>
	     <p:input port="alternate" sequence="true"/>
	     <p:output port="result" sequence="true"/>
	     <p:option name="wrapper" required="true"/>                    <!-- QName -->
	     <p:option name="wrapper-prefix"/>                             <!-- NCName -->
	     <p:option name="wrapper-namespace"/>                          <!-- anyURI -->
	</p:declare-step>
	
	<p:declare-step type="p:parameters">
	     <p:input port="parameters" kind="parameter" primary="false"/>
	     <p:output port="result" primary="false"/>
	</p:declare-step>
	
	<p:declare-step type="p:rename">
	     <p:input port="source"/>
	     <p:output port="result"/>
	     <p:option name="match" required="true"/>                      <!-- XSLTMatchPattern -->
	     <p:option name="new-name" required="true"/>                   <!-- QName -->
	     <p:option name="new-prefix"/>                                 <!-- NCName -->
	     <p:option name="new-namespace"/>                              <!-- anyURI -->
	</p:declare-step>
	
	<p:declare-step type="p:replace">
	     <p:input port="source" primary="true"/>
	     <p:input port="replacement"/>
	     <p:output port="result"/>
	     <p:option name="match" required="true"/>                      <!-- XSLTMatchPattern -->
	</p:declare-step>
	
	<p:declare-step type="p:set-attributes">
	     <p:input port="source" primary="true"/>
	     <p:input port="attributes"/>
	     <p:output port="result"/>
	     <p:option name="match" required="true"/>                      <!-- XSLTMatchPattern -->
	</p:declare-step>
	
	<p:declare-step type="p:sink">
	     <p:input port="source" sequence="true"/>
	</p:declare-step>
	
	<p:declare-step type="p:split-sequence">
	     <p:input port="source" sequence="true"/>
	     <p:output port="matched" sequence="true" primary="true"/>
	     <p:output port="not-matched" sequence="true"/>
	     <p:option name="initial-only" select="'false'"/>              <!-- boolean -->
	     <p:option name="test" required="true"/>                       <!-- XPathExpression -->
	</p:declare-step>
	
	<p:declare-step type="p:store">
	     <p:input port="source"/>
	     <p:output port="result" primary="false"/>
	     <p:option name="href" required="true"/>                       <!-- anyURI -->
	     <p:option name="byte-order-mark"/>                            <!-- boolean -->
	     <p:option name="cdata-section-elements" select="''"/>         <!-- ListOfQNames -->
	     <p:option name="doctype-public"/>                             <!-- string -->
	     <p:option name="doctype-system"/>                             <!-- anyURI -->
	     <p:option name="encoding"/>                                   <!-- string -->
	     <p:option name="escape-uri-attributes" select="'false'"/>     <!-- boolean -->
	     <p:option name="include-content-type" select="'true'"/>       <!-- boolean -->
	     <p:option name="indent" select="'false'"/>                    <!-- boolean -->
	     <p:option name="media-type"/>                                 <!-- string -->
	     <p:option name="method" select="'xml'"/>                      <!-- QName -->
	     <p:option name="normalization-form" select="'none'"/>         <!-- NormalizationForm -->
	     <p:option name="omit-xml-declaration" select="'true'"/>       <!-- boolean -->
	     <p:option name="standalone" select="'omit'"/>                 <!-- "true" | "false" | "omit" -->
	     <p:option name="undeclare-prefixes"/>                         <!-- boolean -->
	     <p:option name="version" select="'1.0'"/>                     <!-- string -->
	</p:declare-step>
	
	<p:declare-step type="p:string-replace">
	     <p:input port="source"/>
	     <p:output port="result"/>
	     <p:option name="match" required="true"/>                      <!-- XSLTMatchPattern -->
	     <p:option name="replace" required="true"/>                    <!-- XPathExpression -->
	</p:declare-step>
	
	<p:declare-step type="p:unescape-markup">
	     <p:input port="source"/>
	     <p:output port="result"/>
	     <p:option name="namespace"/>                                  <!-- anyURI -->
	     <p:option name="content-type" select="'application/xml'"/>    <!-- string -->
	     <p:option name="encoding"/>                                   <!-- string -->
	     <p:option name="charset"/>                                    <!-- string -->
	</p:declare-step>
	
	<p:declare-step type="p:unwrap">
	     <p:input port="source"/>
	     <p:output port="result"/>
	     <p:option name="match" required="true"/>                      <!-- XSLTMatchPattern -->
	</p:declare-step>
	
	<p:declare-step type="p:wrap">
	     <p:input port="source"/>
	     <p:output port="result"/>
	     <p:option name="wrapper" required="true"/>                    <!-- QName -->
	     <p:option name="wrapper-prefix"/>                             <!-- NCName -->
	     <p:option name="wrapper-namespace"/>                          <!-- anyURI -->
	     <p:option name="match" required="true"/>                      <!-- XSLTMatchPattern -->
	     <p:option name="group-adjacent"/>                             <!-- XPathExpression -->
	</p:declare-step>
	
	<p:declare-step type="p:wrap-sequence">
	     <p:input port="source" sequence="true"/>
	     <p:output port="result" sequence="true"/>
	     <p:option name="wrapper" required="true"/>                    <!-- QName -->
	     <p:option name="wrapper-prefix"/>                             <!-- NCName -->
	     <p:option name="wrapper-namespace"/>                          <!-- anyURI -->
	     <p:option name="group-adjacent"/>                             <!-- XPathExpression -->
	</p:declare-step>
	
	<p:declare-step type="p:xinclude">
	     <p:input port="source"/>
	     <p:output port="result"/>
	     <p:option name="fixup-xml-base" select="'false'"/>            <!-- boolean -->
	     <p:option name="fixup-xml-lang" select="'false'"/>            <!-- boolean -->
	</p:declare-step>
	
	<p:declare-step type="p:xslt">
	     <p:input port="source" sequence="true" primary="true"/>
	     <p:input port="stylesheet"/>
	     <p:input port="parameters" kind="parameter"/>
	     <p:output port="result" primary="true"/>
	     <p:output port="secondary" sequence="true"/>
	     <p:option name="initial-mode"/>                               <!-- QName -->
	     <p:option name="template-name"/>                              <!-- QName -->
	     <p:option name="output-base-uri"/>                            <!-- anyURI -->
	     <p:option name="version"/>                                    <!-- string -->
	</p:declare-step>
	
	
	
	<p:declare-step type="p:exec">
	     <p:input port="source" primary="true" sequence="true"/>
	     <p:output port="result" primary="true"/>
	     <p:output port="errors"/>
	     <p:output port="exit-status"/>
	     <p:option name="command" required="true"/>                    <!-- string -->
	     <p:option name="args" select="''"/>                           <!-- string -->
	     <p:option name="cwd"/>                                        <!-- string -->
	     <p:option name="source-is-xml" select="'true'"/>              <!-- boolean -->
	     <p:option name="result-is-xml" select="'true'"/>              <!-- boolean -->
	     <p:option name="wrap-result-lines" select="'false'"/>         <!-- boolean -->
	     <p:option name="errors-is-xml" select="'false'"/>             <!-- boolean -->
	     <p:option name="wrap-error-lines" select="'false'"/>          <!-- boolean -->
	     <p:option name="path-separator"/>                             <!-- string -->
	     <p:option name="failure-threshold"/>                          <!-- integer -->
	     <p:option name="arg-separator" select="' '"/>                 <!-- string -->
	     <p:option name="byte-order-mark"/>                            <!-- boolean -->
	     <p:option name="cdata-section-elements" select="''"/>         <!-- ListOfQNames -->
	     <p:option name="doctype-public"/>                             <!-- string -->
	     <p:option name="doctype-system"/>                             <!-- anyURI -->
	     <p:option name="encoding"/>                                   <!-- string -->
	     <p:option name="escape-uri-attributes" select="'false'"/>     <!-- boolean -->
	     <p:option name="include-content-type" select="'true'"/>       <!-- boolean -->
	     <p:option name="indent" select="'false'"/>                    <!-- boolean -->
	     <p:option name="media-type"/>                                 <!-- string -->
	     <p:option name="method" select="'xml'"/>                      <!-- QName -->
	     <p:option name="normalization-form" select="'none'"/>         <!-- NormalizationForm -->
	     <p:option name="omit-xml-declaration" select="'true'"/>       <!-- boolean -->
	     <p:option name="standalone" select="'omit'"/>                 <!-- "true" | "false" | "omit" -->
	     <p:option name="undeclare-prefixes"/>                         <!-- boolean -->
	     <p:option name="version" select="'1.0'"/>                     <!-- string -->
	</p:declare-step>
	
	<p:declare-step type="p:hash">
	     <p:input port="source" primary="true"/>
	     <p:output port="result"/>
	     <p:input port="parameters" kind="parameter"/>
	     <p:option name="value" required="true"/>                      <!-- string -->
	     <p:option name="algorithm" required="true"/>                  <!-- QName -->
	     <p:option name="match" required="true"/>                      <!-- XSLTMatchPattern -->
	     <p:option name="version"/>                                    <!-- string -->
	</p:declare-step>
	
	<p:declare-step type="p:uuid">
	     <p:input port="source" primary="true"/>
	     <p:output port="result"/>
	     <p:option name="match" required="true"/>                      <!-- XSLTMatchPattern -->
	     <p:option name="version"/>                                    <!-- integer -->
	</p:declare-step>
	
	<p:declare-step type="p:validate-with-relax-ng">
	     <p:input port="source" primary="true"/>
	     <p:input port="schema"/>
	     <p:output port="result"/>
	     <p:option name="dtd-attribute-values" select="'false'"/>      <!-- boolean -->
	     <p:option name="dtd-id-idref-warnings" select="'false'"/>     <!-- boolean -->
	     <p:option name="assert-valid" select="'true'"/>               <!-- boolean -->
	</p:declare-step>
	
	<p:declare-step type="p:validate-with-schematron">
	     <p:input port="parameters" kind="parameter"/>
	     <p:input port="source" primary="true"/>
	     <p:input port="schema"/>
	     <p:output port="result" primary="true"/>
	     <p:output port="report" sequence="true"/>
	     <p:option name="phase" select="'#ALL'"/>                      <!-- string -->
	     <p:option name="assert-valid" select="'true'"/>               <!-- boolean -->
	</p:declare-step>
	
	<p:declare-step type="p:validate-with-xml-schema">
	     <p:input port="source" primary="true"/>
	     <p:input port="schema" sequence="true"/>
	     <p:output port="result"/>
	     <p:option name="use-location-hints" select="'false'"/>        <!-- boolean -->
	     <p:option name="try-namespaces" select="'false'"/>            <!-- boolean -->
	     <p:option name="assert-valid" select="'true'"/>               <!-- boolean -->
	     <p:option name="mode" select="'strict'"/>                     <!-- "strict" | "lax" -->
	</p:declare-step>
	
	<p:declare-step type="p:www-form-urldecode">
	     <p:output port="result"/>
	     <p:option name="value" required="true"/>                      <!-- string -->
	</p:declare-step>
	
	<p:declare-step type="p:www-form-urlencode">
	     <p:input port="source" primary="true"/>
	     <p:output port="result"/>
	     <p:input port="parameters" kind="parameter"/>
	     <p:option name="match" required="true"/>                      <!-- XSLTMatchPattern -->
	</p:declare-step>
	
	<p:declare-step type="p:xquery">
	     <p:input port="source" sequence="true" primary="true"/>
	     <p:input port="query"/>
	     <p:input port="parameters" kind="parameter"/>
	     <p:output port="result" sequence="true"/>
	</p:declare-step>
	
	<p:declare-step type="p:xsl-formatter">
	     <p:input port="source"/>
	     <p:input port="parameters" kind="parameter"/>
	     <p:output port="result" primary="false"/>
	     <p:option name="href" required="true"/>                       <!-- anyURI -->
	     <p:option name="content-type"/>                               <!-- string -->
	</p:declare-step>
	
</p:library>