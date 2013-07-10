'
' Creates a batch file that, when run, will call each batch file in the directory
'

Const DIR_NAME   = "D:\harvests\IMLSDCCHarvest\ForIndexingItems\IndexReap_CCYYMMDD"
Const FILE_NAME  = "_runBatchFiles.bat"

Const TO_WRITE   = 2
Const BAT_FILE   = "Windows Batch File"


Dim fileName, fso, theDir, theFiles, fl, batFile

fileName = DIR_NAME & "\" & FILE_NAME

Set fso = CreateObject("Scripting.FileSystemObject")
Set theDir = fso.GetFolder(DIR_NAME)
Set theFiles = theDir.Files
Set batFile = fso.opentextfile(fileName, TO_WRITE, true)

For Each fl In theFiles
    If fl.type = BAT_FILE And fl.name <> FILE_NAME Then 
        batFile.Write "cd " & DIR_NAME & VbCrLf 
        batFile.write "Call " & fl.name & VbCrLf
    End If 
Next

batFile.Close 

