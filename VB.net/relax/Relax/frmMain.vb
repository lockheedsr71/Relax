
Imports System.IO
Imports System.Media
Imports System.Threading              ' for sleep command



Public Class Form1
    Private myIni As goini
    Public startin1, startin2, startin3, FilePathUbix, FilePathClient, FilePathClientOut, removepath1, removepath2, removepath3, removepath4, removepath5 As String
    Public mydate As String
    Public mytime As String
    Public  projdir As String
      Public FileSizeUbix As String 
    Public FileSizeClient as System.IO.FileInfo


    Sub  tst
    chkini

      

      



        End 
    End Sub


    Private Sub Main()
        
         projdir = My.Application.Info.DirectoryPath & "\"    
      ' tst()
        chkini()
        '  filechk ( "vars.ini")
        'filechk ( "extract.exe")
        '	filechk ( "LisaCore.dll")
        '	filechk ( "LisaExtractor.dll")
        '	filechk ( "LisaExtractorApp.dll")
        '  
        mydate = Now.Date()
        mytime = TimeOfDay.ToString("hh:mm")

      
           
         While mytime <> startin1 Or mytime = startin2 Or mytime = startin3
          
            
              CreateObject("WScript.Shell").Popup("This program will copy and convert TOOSHEH TV DATA and Media to shared folder on network share path.RELAX Running at this location : " & projdir ,  3, "Welcome to RELAX",64)

          
                     
           ''  FileSizeClient = My.Computer.FileSystem.GetFileInfo(FilePathClient & "xx.ts" ) 


            Directory.CreateDirectory (projdir & FilePathClient )         ' create ts folder in project dir 
            Thread.Sleep(1000)

           if chkts ("ts")  = False Then            ' chk if ts folder was empty and then copy ts file from server
                My.Computer.FileSystem.CopyDirectory(FilePathUbix  , projdir & "ts", showUI:=FileIO.UIOption.AllDialogs)

            End If 

          ''  FileSizeUbix = My.Computer.FileSystem.GetFileInfo(FilePathClient & "xx.ts" ) 

           '' FileSizeClient = My.Computer.FileSystem.GetFileInfo(FilePathClient & "*.ts" ) 





















        End While


    End Sub

    Private Sub Form1_Load(sender As Object, e As EventArgs) Handles MyBase.Load
        ContextMenuStrip1.Enabled = False

        While 1
            Thread.Sleep(2000)

            Main()

        End While

    End Sub


    Private Sub Form1_FormClosing(ByVal sender As System.Object, ByVal e As System.Windows.Forms.FormClosingEventArgs) Handles MyBase.FormClosing
        'Cancel Closing:
        e.Cancel = True
        'Minimize the form:
        Me.WindowState = FormWindowState.Minimized
        'Don't show in the task bar
        Me.ShowInTaskbar = False
        'Enable the Context Menu Strip
        ContextMenuStrip1.Enabled = True
    End Sub

    Private Sub ShowToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ShowToolStripMenuItem.Click
        'When Show menu clicks, it will show the form:
        Me.WindowState = FormWindowState.Normal
        'Show in the task bar:
        Me.ShowInTaskbar = True
        'Disable the Context Menu:
        ContextMenuStrip1.Enabled = False
    End Sub

    Private Sub ExitToolStripMenuItem_Click(sender As Object, e As EventArgs) Handles ExitToolStripMenuItem.Click
        End
    End Sub

    Private Sub Form1_SizeChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.SizeChanged
        If Me.WindowState = FormWindowState.Minimized Then
            ShowInTaskbar = False
            ContextMenuStrip1.Enabled = True
        End If
    End Sub

    Private Sub AboutToolStripMenuItem_Click(sender As Object, e As EventArgs) Handles AboutToolStripMenuItem.Click
        frmAboutBox1.Show

    End Sub

    Private Sub chkini()

        'Create ini object.
        myIni = New goini
        'File to process.
        myIni.Filename = My.Application.Info.DirectoryPath & "\vars.ini"         ' current ini path in relax app


        Dim oLst As New List(Of String)
        'Check if ini loaded.
        If myIni.LoadFromFile() Then
            'Read a value name.


            'read start times
            startin1 = myIni.ReadString("time", "startin1")
            startin2 = myIni.ReadString("time", "startin2")
            startin3 = myIni.ReadString("time", "startin3")


            'read paths
            FilePathUbix = myIni.ReadString("path", "FilePathUbix")
            FilePathClient = myIni.ReadString("path", "FilePathClient")
            FilePathClientOut = myIni.ReadString("path", "FilePathClientOut")



            'read removing files

            removepath1 = myIni.ReadString("remove", "path1")
            removepath2 = myIni.ReadString("remove", "path2")
            removepath3 = myIni.ReadString("remove", "path3")
            removepath4 = myIni.ReadString("remove", "path4")
            removepath5 = myIni.ReadString("remove", "path5")



            If removepath1 = "" Then removepath1 = "0"
            If removepath2 = "" Then removepath2 = "0"
            If removepath3 = "" Then removepath3 = "0"
            If removepath4 = "" Then removepath4 = "0"
            If removepath5 = "" Then removepath5 = "0"


        End If

    End Sub

    Private Function filechk(filename As String)
         projdir = My.Application.Info.DirectoryPath & "\" & filename
        If File.Exists(projdir) = False Then
            MsgBox("RELAX need some files to runing correctly but  " & projdir & " not found in current dir.Please copy this file to current project dir and run it again.RELAX terminated by now.", vbCritical, "File not found")
            End
        End If

           End Function


    Private function chkts (ext As string)

       Dim  tspath = projdir &  FilePathClient 
           Dim paths() As String = IO.Directory.GetFiles(tspath  , "*." & ext )
            If paths.Length > 0 Then
                chkts = True            '      MsgBox ("file   fond")

                Else 
                    chkts = False      '    MsgBox ("file nis")
             end if 



    End function

End Class
