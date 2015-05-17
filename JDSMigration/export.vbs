Wscript.StdOut.Write("Please enter the folder path of the .DBF files: ")
datafolder_in = WScript.StdIn.ReadLine
wscript.echo("Will convert .DBF files from " & datafolder_in )
if datafolder_in = undefined then
    wscript.quit()
end if

datafolder_out = datafolder_in & "\out"
set fso = CreateObject("Scripting.FileSystemObject")

If Not fso.FolderExists(datafolder_in) Then
    wscript.echo("The folder does not exist at: " & datafolder_in)
    wscript.quit()
end if

set excel = createobject("excel.application")

If Not fso.FolderExists(datafolder_out) Then
   Set newfolder = fso.CreateFolder(datafolder_out)
   wscript.echo("A new folder has been created at: " & datafolder_out)
End If
excel.DefaultFilePath = datafolder_out
files = Array("AS", _
			  "CLIFESUB", _
              "CORR", _
              "CORRF", _
              "CURREB", _
              "CURRFEX", _
              "CURRGRAN", _
              "CURRIEX", _
              "CURRMEM", _
              "CURRWC", _
              "CURTWAS", _
              "EBALL", _
              "EXCHANGE", _
			  "feljm", _
              "HON", _
              "HONFEL", _
              "JGRANT", _
              "JNLS", _
              "MEMBER", _
              "RESOCOMP", _
			  "RESOEB", _
              "TEMP", _
              "INDTEMP", _
              "NEWINW", _
              "LIFE_MEM", _
              "HON_MEM2", _
              "PATRO")
for each file in files
    wscript.echo("Exporting file " & file)
    if fso.FileExists(datafolder_in & "\" & file & ".DBF") then
        Set objWB = excel.WorkBooks.Open(datafolder_in & "\" & file & ".DBF")
        objWB.SaveAs datafolder_out &  "\" & file & ".xls", 56
    else
        wscript.echo("Cannot find the file " & file)
    end if
next
excel.Quit()
