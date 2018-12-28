#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=icon.ico
#AutoIt3Wrapper_Outfile=AutoPull_i386.Exe
#AutoIt3Wrapper_Outfile_x64=AutoPull_AMD64.Exe
#AutoIt3Wrapper_Compile_Both=y
#AutoIt3Wrapper_UseX64=y
#AutoIt3Wrapper_Res_Fileversion=0.1.0.1
#AutoIt3Wrapper_Res_Fileversion_AutoIncrement=y
#AutoIt3Wrapper_Res_ProductName=AutoPull
#AutoIt3Wrapper_Res_ProductVersion=0.1
#AutoIt3Wrapper_Res_CompanyName=Liveployers
#AutoIt3Wrapper_Res_LegalCopyright=BorjaLive (B0vE)
#AutoIt3Wrapper_Run_Tidy=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include <_ArrayUtils.au3>

Const $file = "repos.txt"
Const $url = "https://github.com/"


$raw = FileRead($file)
If StringInStr($raw, @CRLF) <= 0 Then $raw = StringReplace($raw, @LF, @CRLF)
$lines = StringSplit($raw, @CRLF, 1 + 2)

$repos = __getArray()
$folders = __getArray()
$user = ""
For $line In $lines
	If StringMid($line, 1, 1) = "-" Or StringMid($line, 2, 1) = "-" Then ContinueLoop
	If StringMid($line, 1, 1) = @TAB Then
		$repos = __add($repos, $url & $user & "/" & StringTrimLeft($line, 1))
		$folders = __add($folders, StringTrimLeft($line, 1))
	Else
		$user = $line
	EndIf
Next


For $i = 1 To $repos[0]
	If FileExists($folders[$i]) Then
		ConsoleWrite("PULL: " & $repos[$i] & @CRLF)
		RunWait("git pull", @ScriptDir & "\" & $folders[$i])
	Else
		ConsoleWrite("CLONE: " & $repos[$i] & @CRLF)
		RunWait("git clone " & $repos[$i], @ScriptDir)
	EndIf
Next

