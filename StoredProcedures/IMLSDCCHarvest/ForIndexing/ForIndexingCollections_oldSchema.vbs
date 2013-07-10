' Cycles through directory of harvested collections records And
'	adds them to the Collections table on IMLSHarvest-History @ LIBGRANU
' 
'  modified based on Bill Ingram's dc version by Hong Zhang
' You will need to adjust the directory settings to match your directory structure in order to use this code.

	'set up xslt template for the make_collections_xml stylesheet
	Set xslDocProv = wscript.createobject("MSXML2.FreeThreadedDOMDocument.4.0")
	xslDocProv.async = False
	xslDocProv.resolveExternals = False
	xslDocProv.validateOnParse = False
	ToOpen = "D:\harvests\IMLSDCCHarvest\ForIndexing\make_collections_xml_imlsdcc.xsl"
	xslDocProv.load ToOpen

	Set xslTemplateProv = wscript.CreateObject("MSXML2.XSLTemplate.4.0")
	xslTemplateProv.Stylesheet = xslDocProv		

	'set up the template for the make_parent_collection_xml stylesheet
	Set xslDocProv2 = wscript.createobject("MSXML2.FreeThreadedDOMDocument.4.0")
	xslDocProv2.async = False
	xslDocProv2.resolveExternals = False
	xslDocProv2.validateOnParse = False
	ToOpen2 = "D:\harvests\IMLSDCCHarvest\ForIndexing\make_parent_collection_xml_imlsdcc.xsl"
	xslDocProv2.load ToOpen2

	Set xslTemplateProv2 = wscript.CreateObject("MSXML2.XSLTemplate.4.0")
	xslTemplateProv2.Stylesheet = xslDocProv2	
	
	'added by mtang. set up xslt template for the make_collections_xml stylesheet for display blobs
	Set xslDocProv3 = wscript.createobject("MSXML2.FreeThreadedDOMDocument.4.0")
	xslDocProv3.async = False
	xslDocProv3.resolveExternals = False
	xslDocProv3.validateOnParse = False
	ToOpen3 = "D:\harvests\IMLSDCCHarvest\ForIndexing\make_collections_xml_imlsdcc_TR.xsl"
	xslDocProv3.load ToOpen3

	Set xslTemplateProv3 = wscript.CreateObject("MSXML2.XSLTemplate.4.0")
	xslTemplateProv3.Stylesheet = xslDocProv3		

	'added by mtang. set up the template for the make_parent_collection_xml stylesheet for display blobs
	Set xslDocProv4 = wscript.createobject("MSXML2.FreeThreadedDOMDocument.4.0")
	xslDocProv4.async = False
	xslDocProv4.resolveExternals = False
	xslDocProv4.validateOnParse = False
	ToOpen4 = "D:\harvests\IMLSDCCHarvest\ForIndexing\make_parent_collection_xml_imlsdcc_TR.xsl"
	xslDocProv4.load ToOpen4

	Set xslTemplateProv4 = wscript.CreateObject("MSXML2.XSLTemplate.4.0")
	xslTemplateProv4.Stylesheet = xslDocProv4	
	
	
	'assign folder for processing collections
	Set fso = CreateObject("Scripting.FileSystemObject")
	set folder = fso.GetFolder("D:\harvests\IMLSDCCHarvest\OriginalCollectionData\imlsdcc.grainger.uiuc.edu\")

	
	'create xml object
	set xml = CreateObject("MSXML2.DomDocument.4.0")
	xml.setProperty "SelectionLanguage", "XPath"
	xml.async = False
	xml.validateOnParse = False
	xml.resolveExternals = False
	xml.setProperty "SelectionNamespaces", "xmlns:oai='http://www.openarchives.org/OAI/2.0/' xmlns:dc='http://purl.org/dc/elements/1.1/' xmlns:oai_dc='http://www.openarchives.org/OAI/2.0/oai_dc/' xmlns:imlsdccProf='http://imlsdcc.grainger.uiuc.edu/profile#' xmlns:dcterms='http://purl.org/dc/terms/' xmlns:cld='http://purl.org/cld/terms/' xmlns:imlsdcc='http://imlsdcc.grainger.uiuc.edu/types#' xmlns:vcard='http://www.w3.org/2001/vcard-rdf/3.0#' xmlns:gen='http://example.org/gen/terms#'"
  	
		
	set MyConn = WScript.CreateObject("ADODB.Connection")
	MyConn.ConnectionTimeout = 10
	MyConn.CommandTimeout = 60
    MyConn.open "Provider=SQLOLEDB;DATABASE=delphi_IMLS_Items;SERVER=imlsdccsql.ad.uiuc.edu;Trusted_Connection=yes;"
				
	deleteQuery = "DELETE FROM Collections"
	MyConn.Execute deleteQuery 
	
	Set files = folder.files
	Set parentFiles = folder.Files
	
	'wscript.echo "Here2."
	'wscript.quit
	
	folderName = ""
	i = 0		
	For Each file In files
		'If(i > 4) Then Exit For ' only want the first five records for testing 
		WScript.Echo "Processing file: " & file.name
		folderName = file.ParentFolder
		If(file.type = "XML Document") Then 
			On Error Resume Next
				xml.load file.path
				errnum = err.number
				errdes = err.description
			On Error GoTo 0
			
			If(errnum <> 0) Then
				Set fso = wscript.createobject("Scripting.FileSystemObject")
				Set ts = fso.opentextfile("log.txt",8,true)
				ts.write Now & " ERROR: " & errnum & " " & errdes & VbCrLf
				WScript.StdErr.WriteLine "ERROR: " & errnum & " " & errdes & VbCrLf
				ts.close
				wscript.quit
			end if															 
			Set identifier = xml.selectNodes("//imlsdccProf:collectionDescription/dc:identifier")
				If(identifier.length > 0) Then
					s1 = identifier.item(0).text
					collID = Replace(s1, "http://imlsdcc2.grainger.uiuc.edu/Registry/Collection/?", "")
					collID = Replace(collID, "http://imlsdcc2.grainger.illinois.edu/Registry/Collection/?", "")
					collID = Trim(collID)
				Else 
					Set fso = wscript.createobject("Scripting.FileSystemObject")
					Set ts = fso.opentextfile("log.txt",8,true)
					ts.write Now & " Warning: dc identifier not found for file " & file.name & VbCrLf
					ts.close
					collID = i 
					i = i + 1
				End If 
				
				thumbshot = ""
				Set dcthumbnail = xml.selectNodes("//dc:thumbnail")
				If(dcthumbnail.length > 0) Then 
					thumbshot = dcthumbnail.item(0).text
				End If 
				
				titleName = ""
				Set title = xml.selectNodes("//imlsdccProf:collectionDescription/dc:title")
				If(title.length > 0) Then
					titleName = title.item(0).text
					titleName = Replace(titleName, "'", "''")
					titleName = Trim(titleName)
' 				Else
' 					Set fso = wscript.createobject("Scripting.FileSystemObject")
' 					Set ts = fso.opentextfile("log.txt",8,true)
' 					ts.write Now & " Warning: dc title not found for file " & file.name & VbCrLf
' 					ts.close
				End If 
			
				colldesc = ""
				Set description = xml.selectNodes("//dcterms:abstract")
				If(description.length > 0) Then
					colldesc = description.item(0).text
					'If(Len(colldesc) >= 250) Then colldesc = Left(colldesc, 250)
					colldesc = Replace(colldesc, "'", "''")
					colldesc = Trim(colldesc)
				End If 
				
				
				'Duke University. Rare Book, Manuscript, and Special Collections Library. [Academic library], North Carolina, 27708, United States
				'Oberlin College. Allen Memorial Art Museum. [Art museum], Ohio, 44074, United States
				pubName = ""
				Set publisher = xml.selectNodes("//dc:publisher")
				if publisher.length > 0 then
				  pubText = publisher.item(0).text
				  If (instr(pubText, "http://imlsdcc2.grainger.uiuc.edu/Registry/Institution/?") > 0 or instr(pubText, "http://imlsdcc2.grainger.illinois.edu/Registry/Institution/?") > 0) Then				     
					 tmpStr = "//vcard:VCARD[@xml:base='" & pubText & "']/vcard:FN"					 
				     set pubObj = xml.selectNodes(tmpStr)
					 if pubObj.length > 0 then
				       pubName = pubObj.item(0).text
					   tmpStr = "//vcard:VCARD[@xml:base='" & pubText & "']/vcard:ADR"
					   set pubObj = xml.selectNodes(tmpStr)
					   if pubObj.length > 0 then
					     pubName = pubName & " " & pubObj.item(0).text
					   end if
					   pubName = Replace(pubName, ".,", ",")
					   pubName = Replace(pubName, "'", "''")
					   pubName = Trim(pubName)
					   
					  end if
				  else
				     pubName = pubText
				  End If 
				End If 
				
				isAvailableAt_URL = ""
				Set dcrelation = xml.selectNodes("//imlsdccProf:collectionDescription/cld:isLocatedAt")
				if (dcrelation.length > 0) then
				    isAvailableAt_URL = dcrelation.item(0).text
				end if 	
				 		
				
				'abstract -- does this ever exist?
				collabstract = ""
				'Set dcabstract = xml.selectNodes("//dc:abstract")
				'If(dcabstract.length > 0) Then
				'	If Len(dcabstract.item(0).text) > 250 Then
				'		collabstract = Mid(dcabstract.item(0).text, 1, Len(dcabstract.item(0).text) - InstrRev(Len(dcabstract.item(0).text)," ",1))
				'	Else
				'		collabstract = dcabstract.item(0).text
				'	End If
				'End If 				
				
				'check if the resource is in restricted access
				'accessRights -- TODO: check to see if accessRights is even a valid tag
				access = "unrestricted"
				Set dcaccess = xml.selectNodes("//imlsdccProf:collectionDescription/dcterms:accessRights")
				If(dcaccess.length > 0) Then
					If(StrComp(dcaccess.item(0).text, "restricted", 0) = 0) Then
						access = "restricted"
					End If
				End If 
				
				'before working on the parent collection record, transfer the current record:
				Set xslProc = xslTemplateProv.CreateProcessor
				
				Set xmly = WScript.CreateObject("MSXML2.DOMDocument.4.0")
				xmly.async = False
				xmly.validateOnParse = False
				xmly.resolveExternals = False
				
				xslProc.input = xml
				xslProc.output = xmly
				If (xslProc.Transform = False) Then
							MsgBox "XSLT PROCESSOR1: failed"
							WScript.Quit
				End If
				
				'added by mtang. same but for display blob
				Set xslProc3 = xslTemplateProv3.CreateProcessor
				
				Set xmlyDisplay = WScript.CreateObject("MSXML2.DOMDocument.4.0")
				xmlyDisplay.async = False
				xmlyDisplay.validateOnParse = False
				xmlyDisplay.resolveExternals = False
				
				xslProc3.input = xml
				xslProc3.output = xmlyDisplay
				If (xslProc3.Transform = False) Then
							MsgBox "XSLT PROCESSOR3: failed"
							WScript.Quit
				End If
				'end display blob
				
				parentID=""
				parentName = ""
				parentFileName = ""
				Set parent = xml.selectNodes("//imlsdccProf:collectionDescription/dcterms:isPartOf")				
				If(parent.length > 0) Then
				    s1 = parent.item(0).text
					parentName = getElementName(s1, "//dc:title")
					 'wscript.echo "Parent Coll title is: " & parentName
					s1 = Replace(s1, "http://imlsdcc2.grainger.uiuc.edu/Registry/Collection/?", "")
					s1 = Replace(s1, "http://imlsdcc2.grainger.illinois.edu/Registry/Collection/?", "")
					parentID = clng(Trim(s1))	
					parentFileName = folderName & "\" & s1 & ".xml"					
					 'wscript.echo "parent file is: " & parentFileName
					' load the parent xml file and run the stylesheet
					set parentxml = CreateObject("MSXML2.DomDocument.4.0")
					parentxml.setProperty "SelectionLanguage", "XPath"
					parentxml.async = False
					parentxml.validateOnParse = False
					parentxml.resolveExternals = False
					parentxml.setProperty "SelectionNamespaces", "xmlns:oai='http://www.openarchives.org/OAI/2.0/' xmlns:dc='http://purl.org/dc/elements/1.1/' xmlns:oai_dc='http://www.openarchives.org/OAI/2.0/oai_dc/' xmlns:imlsdccProf='http://imlsdcc.grainger.uiuc.edu/profile#' xmlns:dcterms='http://purl.org/dc/terms/' xmlns:cld='http://purl.org/cld/terms/' xmlns:imlsdcc='http://imlsdcc.grainger.uiuc.edu/types#' xmlns:vcard='http://www.w3.org/2001/vcard-rdf/3.0#' xmlns:gen='http://example.org/gen/terms#'"
					
					parentxml.load parentFileName
					If (parentxml.parseError.errorCode <> 0) Then					    
						Set fso = wscript.createobject("Scripting.FileSystemObject")
						Set ts = fso.opentextfile("log.txt",8,true)
						ts.write Now & " ERROR: " & errnum & " " & errdes & VbCrLf
						ts.close
					else			
					
						' transfer the parent record:
					    Set xslProc2 = xslTemplateProv2.CreateProcessor
											
						Set parentxmly = WScript.CreateObject("MSXML2.DOMDocument.4.0")
						parentxmly.async = False
						parentxmly.validateOnParse = False
						parentxmly.resolveExternals = False
						parentxmly.setProperty "SelectionNamespaces", "xmlns:oai='http://www.openarchives.org/OAI/2.0/' xmlns:dc='http://purl.org/dc/elements/1.1/' xmlns:oai_dc='http://www.openarchives.org/OAI/2.0/oai_dc/' xmlns:imlsdccProf='http://imlsdcc.grainger.uiuc.edu/profile#' xmlns:dcterms='http://purl.org/dc/terms/' xmlns:cld='http://purl.org/cld/terms/' xmlns:imlsdcc='http://imlsdcc.grainger.uiuc.edu/types#' xmlns:vcard='http://www.w3.org/2001/vcard-rdf/3.0#' xmlns:gen='http://example.org/gen/terms#'"
					
						xslProc2.input = parentxml
						xslProc2.output = parentxmly
						If (xslProc2.Transform = False) Then
									MsgBox "XSLT PROCESSOR2: failed"
									WScript.Quit
						End If
						
						'added by mtang. same but for display blob
						Set xslProc4 = xslTemplateProv4.CreateProcessor
											
						Set parentxmlyDisplay = WScript.CreateObject("MSXML2.DOMDocument.4.0")
						parentxmlyDisplay.async = False
						parentxmlyDisplay.validateOnParse = False
						parentxmlyDisplay.resolveExternals = False
						parentxmlyDisplay.setProperty "SelectionNamespaces", "xmlns:oai='http://www.openarchives.org/OAI/2.0/' xmlns:dc='http://purl.org/dc/elements/1.1/' xmlns:oai_dc='http://www.openarchives.org/OAI/2.0/oai_dc/' xmlns:imlsdccProf='http://imlsdcc.grainger.uiuc.edu/profile#' xmlns:dcterms='http://purl.org/dc/terms/' xmlns:cld='http://purl.org/cld/terms/' xmlns:imlsdcc='http://imlsdcc.grainger.uiuc.edu/types#' xmlns:vcard='http://www.w3.org/2001/vcard-rdf/3.0#' xmlns:gen='http://example.org/gen/terms#'"
					
						xslProc4.input = parentxml
						xslProc4.output = parentxmlyDisplay
						If (xslProc4.Transform = False) Then
									MsgBox "XSLT PROCESSOR4: failed"
									WScript.Quit
						End If
						'end display blob
						
						'append the parentBlob onto the childBlob
						Set parentDC = parentxmly.selectSingleNode("//dc")
						Set parent_metadata = xmly.createNode(1, "metadata", "")
						parent_metadata.setAttribute "type", "parent"
						parent_metadata.appendChild(parentDC)
						Set parentDC = Nothing 
									
						Set record = xmly.selectSingleNode("//record")
						record.appendChild(parent_metadata)
						Set record = Nothing 											
						Set parentxmly = Nothing
						set parent_metadata = nothing
						
						'added by mtang. same but for display blob
						Set parentDCDisplay = parentxmlyDisplay.selectSingleNode("//dc")
						Set parent_metadataDisplay = xmlyDisplay.createNode(1, "metadata", "")
						parent_metadataDisplay.setAttribute "type", "parent"
						parent_metadataDisplay.appendChild(parentDCDisplay)
						Set parentDCDisplay = Nothing 
									
						Set recordDisplay = xmlyDisplay.selectSingleNode("//record")
						recordDisplay.appendChild(parent_metadataDisplay)
						Set recordDisplay = Nothing 											
						Set parentxmlyDisplay = Nothing
						set parent_metadataDisplay = nothing
						'end display blob
						
						
					end if				
					set parentxml = nothing				
				
				End If			
				
				
				blob = Trim(xmly.xml)
				blob = Replace(blob, "'", "''")
				
				blobDisplay = Trim(xmlyDisplay.xml)
				blobDisplay = Replace(blobDisplay, "'", "''")
				
                ' And initialize
				portal = 0
				items = 0

				'If parentName <> "" Then WScript.Echo parentblob 
				'WScript.Echo parentblob 
				
				insertQuery = "SET IDENTITY_INSERT Collections ON; "
				insertQuery = insertQuery + "INSERT INTO Collections (" &_
								"collID, " &_
								"title, " &_
								"institution, " &_
								"description, " &_
								"isAvailableAt_URL, " &_
								"abstract, " &_
								"access, " &_
								"thumbnail, " &_
								"parentName, " &_
								"parentID, " &_
								"XMLBlob, " &_
								"XMLBlob_Display, " &_
								"portalCode, " &_
								"itemCount) " &_
					"VALUES (" & collID & ", '" &_
								titleName & "', '" &_
								 pubName & "', '" &_
								 colldesc & "', '" &_
								 isAvailableAt_URL & "', '" &_
								 collabstract & "', '" &_
								 access & "', '" &_
								 thumbshot & "', '" &_
								 parentName & "', '" &_
								 parentID & "', '" &_
								 blob & "', '" &_
								 blobDisplay & "', " &_
								 portal & ", " &_
								 items & ")"
								 
				
				'WScript.Echo insertQuery
				'WScript.Quit 
				MyConn.Execute insertQuery
				set xmly=nothing			
			
		End If 
		'i = i + 1
	Next 
	
	Set xml = Nothing
	
	MyConn.close
	Set MyConn = Nothing
	Set fso = Nothing
	Set folder = Nothing
	
function getElementName(theLink, theElement)
	dim theXML, nodeCollTitle, collTitle
	dim fso, ts
	
	'wscript.echo "Now to getElementName, theLink is: " & theLink
	collTitle = ""
	set theXML= CreateObject("MSXML2.DomDocument.4.0")
	theXML.setProperty "SelectionLanguage", "XPath"
	theXML.async = False
	theXML.validateOnParse = False
	theXML.resolveExternals = False
	theXML.setProperty "SelectionNamespaces", "xmlns:oai='http://www.openarchives.org/OAI/2.0/' xmlns:dc='http://purl.org/dc/elements/1.1/' xmlns:oai_dc='http://www.openarchives.org/OAI/2.0/oai_dc/' xmlns:imlsdccProf='http://imlsdcc.grainger.uiuc.edu/profile#' xmlns:dcterms='http://purl.org/dc/terms/' xmlns:cld='http://purl.org/cld/terms/' xmlns:imlsdcc='http://imlsdcc.grainger.uiuc.edu/types#' xmlns:vcard='http://www.w3.org/2001/vcard-rdf/3.0#' xmlns:gen='http://example.org/gen/terms#'"
					
	theXML.load(theLink)
	If (theXML.parseError.errorCode <> 0) Then	     
		   Set fso = wscript.createobject("Scripting.FileSystemObject")
		   Set ts = fso.opentextfile("log.txt",8,true)
		   ts.write Now & " ERROR: " & errnum & " " & errdes & VbCrLf
		   ts.close
	else
		   set nodeCollTitle = theXML.selectNodes(theElement)
           If nodeCollTitle.length > 0 Then            
             collTitle = Trim(nodeCollTitle.item(0).text)
			 'wscript.echo " --- collTitle is: " & collTitle
		   end if
	end if

	getElementName = collTitle
		
end function	
   
	
