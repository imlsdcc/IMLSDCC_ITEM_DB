'
' Create the required batch files in the current dir
'

Const BASE_URL_REQD     = True   ' NOTE: Change to False IF current run does not require the
                                 '       baseURLs to be specified (in each individual bat file).
Const DB_NAME           = "test_IMLS_Items"
Const DB_SRVR           = "IMLSDCCsql.ad.uiuc.edu"
'Const BASE_DIR          = "D:\harvests\IMLSDCCHarvest\"
Const DATA_DIR          = "D:\harvests\IMLSDCCHarvest\AugmentedData"
Const WORK_DIR          = "D:\harvests\IMLSDCCHarvest\ForIndexingItems"
Const LOG_DIR           = "..\..\LogFiles-Indexreap"
Const SCRIPT_NAME       = "IndexReap_Items"

Const TO_WRITE          = 2


Dim dtNow, dtStamp, i, str, newFile, writeFile, baseUrls, theBaseUrl
Dim fso, dataDir, dataFolders, fldr, fldrName

' Get datestamp for logfile
dtNow = Now()
dtStamp = year(dtNow) & right( "0" & month(dtNow), 2 ) & right( "0" & day(dtNow), 2 )   ' format as YYYYMMDD

' Create Array of base URL's
Set baseUrls = CreateObject("Scripting.Dictionary")

baseUrls.Add "Alabama"                            ,"http://content.lib.auburn.edu/cgi-bin/oai.exe"
baseUrls.Add "azmemory.lib.az.us"                 ,"http://azmemory.lib.az.us/cgi-bin/oai.exe"
baseUrls.Add "banyan.library.unlv.edu"            ,"http://banyan.library.unlv.edu/cgi-bin/oai.exe"
baseUrls.Add "broker10.fcla.edu"                  ,"http://broker10.fcla.edu/cgi/b/broker20/broker20"
baseUrls.Add "cdm.browardlibrary.org"             ,"http://cdm.browardlibrary.org/phpoai/oai2.php"
baseUrls.Add "cdm15018.contentdm.oclc.org"        ,"http://cdm15018.contentdm.oclc.org/cgi-bin/oai.exe"
baseUrls.Add "collections.carli.illinois.edu"     ,"http://collections.carli.illinois.edu/cgi-bin/oai.exe"
baseUrls.Add "content.lib.utah.edu"               ,"http://content.lib.utah.edu/cgi-bin/oai.exe"
baseUrls.Add "content.lib.washington.edu.king"    ,"http://content.lib.washington.edu/cgi-bin/oai.exe"
baseUrls.Add "content.lib.washington.edu.olympic" ,"http://content.lib.washington.edu/cgi-bin/oai.exe"
baseUrls.Add "content.wisconsinhistory.org"       ,"http://content.wisconsinhistory.org/phpoai/oai2.php"
baseUrls.Add "content.wsulibs.wsu.edu"            ,"http://content.wsulibs.wsu.edu/cgi-bin/oai.exe"
baseUrls.Add "contentdm.lib.byu.edu"              ,"http://contentdm.lib.byu.edu/cgi-bin/oai.exe"
baseUrls.Add "contentdm.library.unr.edu"          ,"http://contentdm.library.unr.edu/cgi-bin/oai.exe"
baseUrls.Add "contentdm.mdch.org"                 ,"http://contentdm.mdch.org/cgi-bin/oai.exe"
baseUrls.Add "contentdm.okeeffemuseum.org"        ,"http://contentdm.okeeffemuseum.org/cgi-bin/oai.exe"
baseUrls.Add "contentdm.photohio.org"             ,"http://contentdm.photohio.org/cgi-bin/oai.exe"
baseUrls.Add "contentdm.unl.edu"                  ,"http://contentdm.unl.edu/cgi-bin/oai.exe"
baseUrls.Add "dcbuilder.bcr.org.heritage"         ,"http://dcbuilder.bcr.org:8080/cdp-oai/oai.jsp"
baseUrls.Add "dcbuilder.bcr.org.western"          ,"http://dcbuilder.bcr.org:8080/cdp-oai/oai.jsp"
baseUrls.Add "dembitz.mainlib.brandeis.edu"       ,"http://dembitz.mainlib.brandeis.edu:8882/OAI-script"
baseUrls.Add "digicoll.manoa.hawaii.edu.hwrd"     ,"http://digicoll.manoa.hawaii.edu/hwrd/XML/oai"
baseUrls.Add "digicoll.manoa.hawaii.edu.ttphotos" ,"http://digicoll.manoa.hawaii.edu/ttphotos/XML/oai"
baseUrls.Add "digilib.syr.edu"                    ,"http://digilib.syr.edu/cgi-bin/oai.exe"
baseUrls.Add "digital.lib.umn.edu"                ,"http://snuffy.lib.umn.edu:8080/image/oai/HandleRequest.do"
baseUrls.Add "digital.lib.usu.edu"                ,"http://digital.lib.usu.edu/cgi-bin/oai.exe"
baseUrls.Add "digital.library.pitt.edu"           ,"http://digital.library.pitt.edu/cgi-bin/b/broker20/broker20"
baseUrls.Add "digital.library.unlv.edu"           ,"http://digital.library.unlv.edu/cgi-bin/oai.exe"
baseUrls.Add "digitalmetro.cdmhost.com"           ,"http://digitalmetro.cdmhost.com/cgi-bin/oai.exe"
baseUrls.Add "diglib.lib.utk.edu.snad"            ,"http://diglib.lib.utk.edu/cgi/b/broker20/broker20"
baseUrls.Add "diglib.lib.utk.edu.tdh"             ,"http://diglib.lib.utk.edu/cgi/b/broker20/broker20"
baseUrls.Add "diglib.lib.utk.edu.wpa"             ,"http://diglib.lib.utk.edu/cgi/b/broker20/broker20"
baseUrls.Add "dspace.wrlc.org"                    ,"http://dspace.wrlc.org/doc-oai/request"
baseUrls.Add "econtent.unm.edu"                   ,"http://econtent.unm.edu/cgi-bin/oai.exe"
baseUrls.Add "gwla.westernwater.org"              ,"http://boundless.uoregon.edu/cgi-bin/oai.exe"
baseUrls.Add "idahodocs.cdmhost.com"              ,"http://idahodocs.cdmhost.com/cgi-bin/oai.exe"
baseUrls.Add "idahohistory.cdmhost.com"           ,"http://idahohistory.cdmhost.com/cgi-bin/oai.exe"
baseUrls.Add "lib.uchicago.edu"                   ,"http://oai.lib.uchicago.edu"
baseUrls.Add "lib.umich.edu"                      ,"http://www.hti.umich.edu/cgi/b/broker20/broker20"
baseUrls.Add "library.digitalnc.org"              ,"http://library.digitalnc.org/cgi-bin/oai.exe"
baseUrls.Add "louisdl.louislibraries.org"         ,"http://louisdl.louislibraries.org/cgi-bin/oai.exe"
baseUrls.Add "mainemusicbox.library.umaine.edu"   ,"http://mainemusicbox.library.umaine.edu/ASPOAIDP-DB/oai.asp"
baseUrls.Add "oai.dlib.indiana.edu"               ,"http://oai.dlib.indiana.edu/phpoai/oai2.php"
baseUrls.Add "oai.lib.msu.edu.fap"                ,"http://oai.lib.msu.edu/OAIHandler"
baseUrls.Add "oai.lib.msu.edu.mmm"                ,"http://oai.lib.msu.edu/servlet/OAIHandler"
baseUrls.Add "tempest.lib.ilstu.edu"              ,"http://tempest.lib.ilstu.edu/cgi-bin/oai.exe"
baseUrls.Add "www.cfmemory.org"                   ,"http://www.cfmemory.org/cgi-bin/oai.exe"
baseUrls.Add "www.hrvh.org"                       ,"http://www.hrvh.org/cgi-bin/oai.exe"
baseUrls.Add "www.idaillinois.org"                ,"http://www.idaillinois.org:81/cgi-bin/oai.exe"
baseUrls.Add "www.lib.unc.edu"                    ,"http://www.lib.unc.edu/cgi-bin/oai/das/das/das/oai.pl"
baseUrls.Add "www.perseus.tufts.edu"              ,"http://www.perseus.tufts.edu/cgi-bin/pdataprov"


' Now start creating the individual .bat files
Set fso = CreateObject("Scripting.FileSystemObject")
Set dataDir = fso.GetFolder(DATA_DIR)
Set dataFolders = dataDir.SubFolders

i = 0
wscript.echo "Folder is: " & DATA_DIR
For Each fldr In dataFolders
    fldrName = fldr.name

    if BASE_URL_REQD then
        theBaseUrl = baseUrls.Item(fldrName)      ' if baseURL is required for this run
    else
        theBaseUrl = " "
    end if

    wscript.echo fldrName & "\t\t" & theBaseUrl

    str = ""
    str = str & "cd " & WORK_DIR & VbCrLf         ' cd to working dir
    str = str & SCRIPT_NAME & " "                 ' the .wsf script to call (the file extension is left out)
    str = str & DATA_DIR & "\" & fldrName & " "   ' current folder
    str = str & theBaseUrl & " "                  ' baseURL... (see NOTE at top of this file)
    str = str & "/srv:" & DB_SRVR & " "           ' DB server
    str = str & "/db:" & DB_NAME & " "            ' DB name
    str = str & "/emp /not "                      ' options; ALTERNATIVELY: "/xin /emp /ign /not "
    str = str & "/out:" & LOG_DIR & "\" & dtStamp & "_" & DB_NAME & "_" & fldrName & ".xml" & VbCrLf   ' logfile

    newFile = fldrName & "." & "bat"
    Set writeFile = fso.CreateTextFile(newFile, TO_WRITE)
    writeFile.Write str
    writeFile.Close

    i = i + 1
Next

wscript.echo "Total # of new files created = " & i

