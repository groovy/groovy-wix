Set fileSystem = CreateObject("Scripting.FileSystemObject")
scriptFolder = fileSystem.GetParentFolderName(WScript.ScriptFullName)
CreateObject("WScript.Shell").Run """" & scriptFolder & "\bin\groovyConsole.bat""", 0, False
