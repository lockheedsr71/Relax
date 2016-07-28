
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Res_Comment=By MBK for foxnet group
#AutoIt3Wrapper_Res_Description=auto extractor by MBK
#AutoIt3Wrapper_Res_Fileversion=1.0.0.18
#AutoIt3Wrapper_Res_Fileversion_AutoIncrement=y
#AutoIt3Wrapper_Res_LegalCopyright=(C) 2016. freeware
#AutoIt3Wrapper_Res_Language=1033
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include <MsgBoxConstants.au3>
#include <FileConstants.au3>
#include <MsgBoxConstants.au3>
#include <WinAPIFiles.au3>
#include <Date.au3>
#include <WinAPIFiles.au3>
#include <TrayConstants.au3>
#include <Debug.au3>


;-----------debg---------------
_DebugSetup("Relax project Debug log :")


;If ProcessExists("relax.com") Then ; Check if the relax process is running.
 ;   MsgBox($MB_SYSTEMMODAL, "", "Relax alrady running.")
;	 ProcessClose("relax.com")
;EndIf
TraySetIcon("shell32.dll", 47) ;
getini()


dim $startin1,$startin2,$startin3,$FilePathUbix,$FilePathClient
		;msgbox (0,$FilePathClient,$FilePathUbix,5)



while 1
		main()
		Sleep ( 1000)

WEnd




func main()
	getini()
			Local $Date = _NowDate()
			$mytime = _NowTime(4)

						while $mytime= $startin1 or $mytime=$startin2 or $mytime=$startin3       ; check only run in this time slice

							beep(2000,300)

							;msgbox (0,0,$mytime,1)

						MsgBox(64, "Welcome to tooshe automation script", "This program will copy and convert media to shared folder on net. Your script dir detected on "& @ScriptDir,3)

						 ;$FilePathUbix = "\\192.168.10.253\rec\share_auto\Toosheh TV\*.ts"
						 ; $FilePathClient = @ScriptDir & "\ts\"
						 $FileSizeUbix = FileGetSize ( $FilePathUbix)
						 $FileSizeClient = FileGetSize ( $FilePathClient & "*.ts")


						DirCreate (@ScriptDir & "\ts")
						sleep (1000)

					;	_DebugOut ($FilePathUbix)
					;	_DebugOut($FilePathClient)


						if FileExists($FilePathClient  & "*.ts" ) = 0  then  _FileCopy($FilePathUbix,@ScriptDir & $FilePathClient)
							;;;;;;;;;sleep (3000)
							;filecopy($FilePathUbix, $FilePathClient , $FC_OVERWRITE + $FC_CREATEPATH)
							;;while $FileSizeUbix <>  $FileSizeClient

						  $FileSizeUbix = FileGetSize ( $FilePathUbix )
						  $FileSizeClient = FileGetSize ( $FilePathClient & "*.ts" )

								;;;;if $FileSizeUbix=$FileSizeClient then ExitLoop
								;;;;sleep (50)
								;;;;wend

						msgbox ( 0, "Copy status ... " , "All file(s) copied. ",2)
						;dircopy("d:\tst\", "d:\relax\" , $FC_OVERWRITE + $FC_CREATEPATH)
						 $desfile = _DateFormat($Date, "yyyy-MM-dd")
						 $CMD = @ScriptDir & "\extract.exe " & @ScriptDir & "\vid\" & $desfile & " /ts  " &  @ScriptDir & "\ts "
						; $CMD = "dir " & "e:"

							 RunWait("cmd" & " /c " & $CMD)

						;msgbox (0,0, @ScriptDir & "\vid\" & $desfile & "\Toosheh\فیلترشکن",2)
								DirRemove (@ScriptDir & "\vid\" & $desfile & "\Toosheh\فیلترشکن",1)
								DirRemove (@ScriptDir & "\vid\" & $desfile & "\Toosheh\نرم افزار\فیلترشکن",1)

								DirRemove (@ScriptDir & "\vid\" & $desfile & "\.lisa",1)
								DirRemove (@ScriptDir & "\vid\" & $desfile & "\Updates",1)

						FileDelete (@ScriptDir & $FilePathClient & "*.ts" )
						msgbox ( 64,"Inform",".TS file deleting ...,Operational successfuly completed.",3)

						$mytime = _NowTime(4)          ; set new system time after do all operations to avoid loop again till clock set next day

						wend



		TrayTip("Relax Inform", "Time missed.Program run at background.wait for proper time...", 0, $TIP_ICONASTERISK)
		sleep (10000)

EndFunc





Func _DateFormat($Date, $style)
    Local $hGui = GUICreate("My GUI get date", 200, 200, 800, 200)
    Local $idDate = GUICtrlCreateDate($Date, 10, 10, 185, 20)
    GUICtrlSendMsg($idDate, 0x1032, 0, $style)
    Local $sReturn = GUICtrlRead($idDate)
    GUIDelete($hGui)
    Return $sReturn
 EndFunc ;==>_DateFormat

Func _FileCopy($fromFile,$tofile)
    Local $FOF_RESPOND_YES = 8
    Local $FOF_SIMPLEPROGRESS = 256
    $winShell = ObjCreate("shell.application")
    $winShell.namespace($tofile).CopyHere($fromFile,$FOF_RESPOND_YES)
EndFunc


Func getini()
    ; Create a constant variable in Local scope of the filepath that will be read/written to.
    Local Const $sFilePath = @ScriptDir & "\vars.ini"

    ; Read the INI file for the value of 'Title' in the section labelled 'General'.
		 global $startin1,$startin2,$startin3,$FilePathUbix,$FilePathClient
			;read start times
		  $startin1 = IniRead($sFilePath, "time", "startin1",0)
		  $startin2 = IniRead($sFilePath, "time", "startin2",0)
		  $startin3 = IniRead($sFilePath, "time", "startin3",0)

		   ; Read paths
		   $FilePathUbix = IniRead($sFilePath, "path", "FilePathUbix",0)
		   $FilePathClient = IniRead($sFilePath, "path", "FilePathClient",0)




		; Display the value returned by IniRead.
		; IniWrite($sFilePath, "mytest", "var3", "meghdar30000")
		; Delete the key labelled 'Title'.
	   ; IniDelete($sFilePath, "General", "Title")

EndFunc



