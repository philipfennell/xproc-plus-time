<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step 
		xmlns:c="http://www.w3.org/ns/xproc-step"
		xmlns:cx="http://xmlcalabash.com/ns/extensions"
		xmlns:ml="http://xmlcalabash.com/ns/extensions/marklogic"
		xmlns:p="http://www.w3.org/ns/xproc" 
		xml:base="../../../"
		name="load-content"
		version="1.0">
	
	<p:import href="test/resources/xproc/library-1.0.xpl"/>
	
	<p:directory-list name="content" path="test/resources/listings"/>
	
	<p:make-absolute-uris name="directory" match="//c:file/@name">
		<p:with-option name="base-uri" select="/c:directory/@xml:base"/>
	</p:make-absolute-uris>
	
	<p:for-each>
		<p:iteration-source select="/c:directory/c:file"/>
		<p:variable name="uri" select="substring-after(/c:file/@name, 'resources')"/>
		
		<p:load>
			<p:with-option name="href" select="/c:file/@name"/>
		</p:load>
		
		<cx:message>
			<p:with-option name="message" select="$uri"/>
		</cx:message>
		
		<ml:insert-document host="localhost" port="8051" user="admin" 
				password="admin" format="xml" collections="listings"
				content-base="yellcontent">
			<p:with-option name="uri" select="substring-after(p:base-uri(), 'resources')"/>
		</ml:insert-document>
	</p:for-each>
</p:declare-step>
