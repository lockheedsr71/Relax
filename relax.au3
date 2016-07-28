
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Res_Comment=By MBK for foxnet group
#AutoIt3Wrapper_Res_Description=auto extractor by MBK
#AutoIt3Wrapper_Res_Fileversion=1.0.0.15
#AutoIt3Wrapper_Res_Fileversion_AutoIncrement=y
#AutoIt3Wrapper_Res_LegalCopyright=(C) 2016. freeware
#AutoIt3Wrapper_Res_Language=1033
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include <MsgBoxConstants.au3>
#include <FileConstants.au3>
#include <MsgBoxConstants.au3>
#include <WinAPIFiles.au3>
#include <Date.au3>

#include <TrayConstants.au3>



;If ProcessExists("relax.com") Then ; Check if the relax process is running.
 ;   MsgBox($MB_SYSTEMMODAL, "", "Relax alrady running.")
;	 ProcessClose("relax.com")
;EndIf


TraySetIcon("shell32.dll", 47) ;

while 1
	main()
	Sleep ( 1000)

WEnd




func main()
Local $Date = _NowDate()
$mytime = _NowTime(4)

while $mytime= "08:00" or $mytime="08:30"       ; check only run in this time slice

	beep(2000,300)

	;msgbox (0,0,$mytime,1)

MsgBox(64, "Welcome to tooshe automation script", "This program will copy and convert media to shared folder on net. Your script dir detected on "& @ScriptDir,3)

 $fpa = "\\192.168.10.253\rec\share_auto\Toosheh TV\*.ts"
 $fpb = @ScriptDir & "\ts\*.ts"
 $fsa = FileGetSize ( $fpa)
 $fsb = FileGetSize ( $fpb)


DirCreate (@ScriptDir & "\ts")
sleep (1000)
if FileExists($fpb ) = 1  then FileDelete ($fpb)
sleep (3000)
_FileCopy($fpa,@ScriptDir & "\ts")

	;filecopy($fpa, $fpb , $FC_OVERWRITE + $FC_CREATEPATH)

 while $fsa <>  $fsb

  $fsa = FileGetSize ( "\\192.168.10.253\rec\share_auto\Toosheh TV\*.ts" )
  $fsb = FileGetSize ( @ScriptDir & "\ts\*.ts" )
;msgbox ( 0,$fsa,$fsb)
if $fsa=$fsb then ExitLoop

sleep (50)
wend

msgbox ( 0, "Copy status ... " , "All file(s) copied. ",2)
;dircopy("d:\tst\", "d:\relax\" , $FC_OVERWRITE + $FC_CREATEPATH)
 $desfile = _DateFormat($Date, "yyyy-MM-dd")
 $CMD = @ScriptDir & "\extract.exe " & @ScriptDir & "\vid\" & $desfile & " /ts  " &  @ScriptDir & "\ts "
; $CMD = "dir " & "e:"

	 RunWait("cmd" & " /c " & $CMD)

;msgbox (0,0, @ScriptDir & "\vid\" & $desfile & "\Toosheh\فیلترشکن",2)
DirRemove (@ScriptDir & "\vid\" & $desfile & "\Toosheh\فیلترشکن",1)
DirRemove (@ScriptDir & "\vid\" & $desfile & "\.lisa",1)
DirRemove (@ScriptDir & "\vid\" & $desfile & "\Updates",1)

$mytime = _NowTime(4)          ; set new system time after do all operations to avoid loop again till clock set next day

	;msgbox (0,0,$mytime,1)



wend

;	msgbox (64,"Inform" ,"Time missed.Program closed.",2)




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
    Local $FOF_RESPOND_YES = 16




    Local $FOF_SIMPLEPROGRESS = 256
    $winShell = ObjCreate("shell.application")
    $winShell.namespace($tofile).CopyHere($fromFile,$FOF_RESPOND_YES)
EndFunc



