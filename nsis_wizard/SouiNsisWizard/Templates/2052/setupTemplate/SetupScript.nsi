; �ýű�ʹ�� HM VNISEdit �ű��༭���򵼲���

; ############################ ��ʼ��������� ####################################
;�����ھ��
Var Dialog

SetCompressor lzma

RequestExecutionLevel admin

!AddPluginDir ".\plugins"
;############################# ����nsh�ű� ######################################

!include "MUI.nsh"
!include "WinCore.nsh"
!include "nsWindows.nsh"
!include "nsDialogs.nsh"
!include "FileFunc.nsh"
!include "LogicLib.nsh"
!include "WinMessages.nsh"
!include "MUI2.nsh"
!include "WordFunc.nsh"
!include "Library.nsh"


; ########################### ��װ�����ʼ���峣�� ###############################
!define PRODUCT_NAME "[!output ProductName]"
!define PRODUCT_VERSION "[!output ProductVer]"
!define PRODUCT_PUBLISHER "[!output ProductUser]"
!define PRODUCT_WEB_SITE "[!output ProductWebSite]"
!define PRODUCT_MAIN_EXE "[!output ProductMainExe]"
; ͼ��
!define MUI_ICON	".\logo.ico"
;ж��ͼ��
!define MUI_UNICON	".\logo.ico"
;Ӣ�Ĳ�Ʒ����
!define PRODUCT_NAME_EN  "[!output ProductNameEn]"
;��ʾ��
!define ERROR_MESSAGE           "��װ������ȷ������������"
;Ԥ���������ռ��С(M)��ע�����Ϊ��ʵ��С���������жϿռ��Ƿ��á�
!define REQUIRED_SPACE  "15"
;���廥������
!define MyMutex_Install     "Install_[!output ProductGUID]"
!define MyMutex_UnInstall   "UnInstall_[!output ProductGUID]"

!define Unstall_KeyPath "Software\Microsoft\Windows\CurrentVersion\Uninstall\"

;Languages �����ʹ��MUI���Զ���setupͼ���ʧЧ�ˣ���򵥵�����һ����OK�ˡ�
!insertmacro MUI_LANGUAGE "SimpChinese"


;############################ ��װ�ļ����� ############################
Name "${PRODUCT_NAME} ${PRODUCT_VERSION}"
OutFile "Setup.exe"
InstallDir "$PROGRAMFILES\${PRODUCT_NAME}"
InstallDirRegKey HKLM "${PRODUCT_UNINST_KEY}" "UninstallString"
;
ShowInstDetails show
ShowUnInstDetails show
BrandingText " "

;############################ ��װ���� ################################
;�Զ���ҳ��
Page custom MyPage
;��װ���Ƚ���
Page instfiles "" MyInstallNow
;�Զ���ж��ҳ��
UninstPage   custom     un.MyUninstallPage
;ж�ؽ��Ƚ���
UninstPage   instfiles	""	un.MyUninstallNow

;############################ �ؼ�Section����� #######################
/*�����ļ���������ݷ�ʽ*/
Section "MainSection" SEC01
  SetOutPath "$INSTDIR"
  SetOverwrite ifnewer
  File /r "file\*.*"

	;������ʼ�˵�����
 	CreateDirectory "$SMPROGRAMS\${PRODUCT_NAME}"
  CreateShortCut "$SMPROGRAMS\${PRODUCT_NAME}\${PRODUCT_NAME}.lnk" "$INSTDIR\${PRODUCT_MAIN_EXE}"
	;���������ݷ�ʽ
	CreateShortCut "$DESKTOP\${PRODUCT_NAME}.lnk" "$INSTDIR\${PRODUCT_MAIN_EXE}"
	
	;��������С����д��ע���
	${GetSize} "$INSTDIR" "/S=0K" $0 $1 $2
 	IntFmt $0 "0x%08X" $0
  WriteRegDWORD HKLM "${Unstall_KeyPath}${PRODUCT_NAME_EN}" "EstimatedSize" "$0"

   
SectionEnd

Section -AdditionalIcons
	;��˾��������
  WriteIniStr "$INSTDIR\${PRODUCT_NAME}.url" "InternetShortcut" "URL" "${PRODUCT_WEB_SITE}"
  ;��ʼ�˵�-��˾��������
  CreateShortCut "$SMPROGRAMS\${PRODUCT_NAME}\Website.lnk" "$INSTDIR\${PRODUCT_NAME}.url"
  ;��ʼ�˵�-ж�س����ݷ�ʽ
  CreateShortCut "$SMPROGRAMS\${PRODUCT_NAME}\Uninstall.lnk" "$INSTDIR\uninst.exe"
SectionEnd

Section -Post
	;�����˳�����
  WriteUninstaller "$INSTDIR\uninst.exe"
  
  ;ж����Ϣע���
  WriteRegStr HKLM "${Unstall_KeyPath}${PRODUCT_NAME_EN}" "DisplayName" "${PRODUCT_NAME}"
  WriteRegStr HKLM "${Unstall_KeyPath}${PRODUCT_NAME_EN}" "UninstallString" '"$INSTDIR\uninst.exe"'
  WriteRegStr HKLM "${Unstall_KeyPath}${PRODUCT_NAME_EN}" "DisplayIcon" '"$INSTDIR\${PRODUCT_MAIN_EXE}"'
  WriteRegStr HKLM "${Unstall_KeyPath}${PRODUCT_NAME_EN}" "InstallLocation" "$INSTDIR"
  WriteRegStr HKLM "${Unstall_KeyPath}${PRODUCT_NAME_EN}" "Publisher" "${PRODUCT_PUBLISHER}"
  WriteRegStr HKLM "${Unstall_KeyPath}${PRODUCT_NAME_EN}" "HelpLink" "${PRODUCT_WEB_SITE}"
  WriteRegStr HKLM "${Unstall_KeyPath}${PRODUCT_NAME_EN}" "DisplayVersion" "${PRODUCT_VERSION}"
		/*
  	  ж��ע���-��ѡ����
	  InstallLocation (string) - Installation directory ($INSTDIR)
		DisplayIcon (string) - Path, filename and index of of the icon that will be displayed next to your application name
		Publisher (string) - (Company) name of the publisher
		ModifyPath (string) - Path and filename of the application modify program
		InstallSource (string) - Location where the application was installed from
		ProductID (string) - Product ID of the application
		Readme (string) - Path (File or URL) to readme information
		RegOwner (string) - Registered owner of the application
		RegCompany (string) - Registered company of the application
		HelpLink (string) - Link to the support website
		HelpTelephone (string) - Telephone number for support
		URLUpdateInfo (string) - Link to the website for application updates
		URLInfoAbout (string) - Link to the application home page
		DisplayVersion (string) - Displayed version of the application
		VersionMajor (DWORD) - Major version number of the application
		VersionMinor (DWORD) - Minor version number of the application
		NoModify (DWORD) - 1 if uninstaller has no option to modify the installed application
		NoRepair (DWORD) - 1 if the uninstaller has no option to repair the installation
		SystemComponent (DWORD) - Set 1 to prevents display of the application in the Programs List of the Add/Remove Programs in the Control Panel.
		EstimatedSize (DWORD) - The size of the installed files (in KB)
		Comments (string) - A comment describing the installer package
	*/

SectionEnd



;Uninstaller Section

Section "Uninstall"
  ;ִ��uninstall.exe
  Delete "$SMSTARTUP\${PRODUCT_NAME}.lnk"
  Delete "$DESKTOP\${PRODUCT_NAME}.lnk"
  Delete "$QUICKLAUNCH\${PRODUCT_NAME}.lnk"

  SetShellVarContext all
  RMDir /r /REBOOTOK "$SMPROGRAMS\${PRODUCT_NAME}"

  SetShellVarContext current
  RMDir /r /REBOOTOK "$SMPROGRAMS\${PRODUCT_NAME}"
  
  SetRebootFlag false
  RMDir /r /REBOOTOK "$INSTDIR"
  ;DeleteRegKey ${PRODUCT_ROOT_KEY} "${PRODUCT_SUB_KEY}"

  SetRebootFlag false
  DeleteRegKey HKLM "${Unstall_KeyPath}${PRODUCT_NAME_EN}"

  Delete "$INSTDIR\Uninstall.exe"
  ;RMDir "$INSTDIR"
SectionEnd

;############################ ��װ���̺������� ############################

; Э�����ӵ��������
Function OnLinkAgreementClick
  	[!output PROJECT_NAME]::NSISScriptSendMessage /NOUNLOAD $Dialog "WM_SJONELINKAGREEMENT"
FunctionEnd

;�Զ��尲װ
Function OnCustomInstallClick
 [!output PROJECT_NAME]::NSISScriptSendMessage /NOUNLOAD $Dialog "WM_SJONECUSTOMINSTALL"
FunctionEnd

; ���ٰ�װ��ť���������
Function OnBtnInstallClick
 ;[!output PROJECT_NAME]::NSISScriptSendMessage $Dialog "WM_SJONEINSTALL"
 	;ֹͣ��Ϣѭ��
	[!output PROJECT_NAME]::NSISScriptSendMessage /NOUNLOAD $Dialog "WM_SJMSGLOOPSTOP"
FunctionEnd

; ͬ��Э�鸴ѡ����������
Function OnChkAgreementClick
		[!output PROJECT_NAME]::NSISScriptSendMessage /NOUNLOAD $Dialog "WM_SJONECHECKSTATUS"
FunctionEnd
; Э��ҳ��ȷ����ť���������
Function OnAgreementSureClick
		[!output PROJECT_NAME]::NSISScriptSendMessage /NOUNLOAD $Dialog "WM_SJTWOSURE"
FunctionEnd
;�Զ���ѡ��ҳ�淵����һ��
Function OnPreviousClick
		[!output PROJECT_NAME]::NSISScriptSendMessage /NOUNLOAD $Dialog "WM_SJTHREEPREVIOUS"
FunctionEnd

;���·��
Function OnChangePathClick
		;���ļ��Ի���
		[!output PROJECT_NAME]::NSISOpenFolderDialog /NOUNLOAD "��ѡ��װĿ¼"
		Pop $0
		
		${If} $0 == "-1"
		${Else}
      StrCpy $INSTDIR "$0\${PRODUCT_NAME_EN}"
      ;���ô��̿ռ�
			${GetRoot} $INSTDIR $1
			${DriveSpace} $1 "/D=F /S=M" $2
			[!output PROJECT_NAME]::NSISScriptSendMessage /NOUNLOAD $Dialog "WM_SJTHREEUPDATEFREESPACE" "$2"
			;�������ռ��С
			[!output PROJECT_NAME]::NSISScriptSendMessage /NOUNLOAD $Dialog "WM_SJTHREEUPDATEREQUIREDSPACE" "${REQUIRED_SPACE}"
			;Ĭ�ϰ�װ·��
			[!output PROJECT_NAME]::SetControlProperties /NOUNLOAD "SEdit" "edit_choose_url" "text" $INSTDIR
   ${EndIf}
FunctionEnd


;��ʼ��װ
Function OnInstall

		;ֹͣ��Ϣѭ��
		[!output PROJECT_NAME]::NSISScriptSendMessage /NOUNLOAD $Dialog "WM_SJMSGLOOPSTOP"
FunctionEnd

;�������������",��ɲ���ʼ���г���(��Ϣѭ���Ѿ�ֹͣ��������������ֱ�Ӳ�������)
Function OnFinishRun
	;�򿪳�������
	Exec '"$INSTDIR\${PRODUCT_MAIN_EXE}"'
  [!output PROJECT_NAME]::ClosePage /NOUNLOAD
FunctionEnd

Function OnFinishRunEx
  [!output PROJECT_NAME]::ClosePage /NOUNLOAD
FunctionEnd

;�رճ���
Function OnClose
  [!output PROJECT_NAME]::NSISMessageBox /NOUNLOAD 3 "ȷ��Ҫȡ����װ��" "��ʾ"
  Pop $0
  ${If} $0 == "1"
    ;�رճ���
	  [!output PROJECT_NAME]::ClosePage /NOUNLOAD
	${EndIf}
FunctionEnd


Function MyPage
	;�������
 	;ShowWindow $HWNDPARENT ${SW_HIDE}
	${NSW_SetWindowSize} $HWNDPARENT 0 0 ;�ı��Զ��崰���С
	;/////��ʼ������/////
	[!output PROJECT_NAME]::InitWindow /NOUNLOAD "$PLUGINSDIR"
	Pop $Dialog
	;/////�󶨿ؼ���ű�������Ӧ��ϵ//////
	
	[!output PROJECT_NAME]::FindChildByName /NOUNLOAD "link_agreement"
	Pop $0
	${If} $0 == "-1"
		MessageBox MB_OK ERROR_MESSAGE
	${Else}
		GetFunctionAddress $0 OnLinkAgreementClick
		[!output PROJECT_NAME]::BindControlAndNSISScript /NOUNLOAD  "link_agreement" $0
	${EndIf}

	[!output PROJECT_NAME]::FindChildByName /NOUNLOAD  "btn_custominstall"
	Pop $0
	${If} $0 == "-1"
		MessageBox MB_OK ERROR_MESSAGE
	${Else}
		GetFunctionAddress $0 OnCustomInstallClick
		[!output PROJECT_NAME]::BindControlAndNSISScript /NOUNLOAD  "btn_custominstall" $0
	${EndIf}

	[!output PROJECT_NAME]::FindChildByName /NOUNLOAD "btn_install"
	Pop $0
	${If} $0 == "-1"
		MessageBox MB_OK ERROR_MESSAGE
	${Else}
		GetFunctionAddress $0 OnBtnInstallClick
		[!output PROJECT_NAME]::BindControlAndNSISScript /NOUNLOAD "btn_install" $0
	${EndIf}


	[!output PROJECT_NAME]::FindChildByName /NOUNLOAD "chk_agreement"
	Pop $0
	${If} $0 == "-1"
		MessageBox MB_OK ERROR_MESSAGE
	${Else}
		GetFunctionAddress $0 OnChkAgreementClick
		[!output PROJECT_NAME]::BindControlAndNSISScript /NOUNLOAD "chk_agreement" $0
	${EndIf}
	
	[!output PROJECT_NAME]::FindChildByName /NOUNLOAD "btn_agreement_sure"
	Pop $0
	${If} $0 == "-1"
		MessageBox MB_OK ERROR_MESSAGE
	${Else}
		GetFunctionAddress $0 OnAgreementSureClick
		[!output PROJECT_NAME]::BindControlAndNSISScript /NOUNLOAD "btn_agreement_sure" $0
	${EndIf}
	
	[!output PROJECT_NAME]::FindChildByName /NOUNLOAD "btn_choose_previous"
	Pop $0
	${If} $0 == "-1"
		MessageBox MB_OK ERROR_MESSAGE
	${Else}
		GetFunctionAddress $0 OnPreviousClick
		[!output PROJECT_NAME]::BindControlAndNSISScript /NOUNLOAD "btn_choose_previous" $0
	${EndIf}

  [!output PROJECT_NAME]::FindChildByName /NOUNLOAD "btn_choose_changedir"
	Pop $0
	${If} $0 == "-1"
		MessageBox MB_OK ERROR_MESSAGE
	${Else}
		GetFunctionAddress $0 OnChangePathClick
		[!output PROJECT_NAME]::BindControlAndNSISScript /NOUNLOAD "btn_choose_changedir" $0
	${EndIf}

 [!output PROJECT_NAME]::FindChildByName /NOUNLOAD "btn_choose_install"
	Pop $0
	${If} $0 == "-1"
		MessageBox MB_OK ERROR_MESSAGE
	${Else}
		GetFunctionAddress $0 OnInstall
		[!output PROJECT_NAME]::BindControlAndNSISScript /NOUNLOAD "btn_choose_install" $0
	${EndIf}
	
	[!output PROJECT_NAME]::FindChildByName /NOUNLOAD "btn_finish_feel"
	Pop $0
	${If} $0 == "-1"
		MessageBox MB_OK ERROR_MESSAGE
	${Else}
		GetFunctionAddress $0 OnFinishRun
		[!output PROJECT_NAME]::BindControlAndNSISScript /NOUNLOAD "btn_finish_feel" $0
	${EndIf}
	
		[!output PROJECT_NAME]::FindChildByName /NOUNLOAD "btn_finish_finish"
	Pop $0
	${If} $0 == "-1"
		MessageBox MB_OK ERROR_MESSAGE
	${Else}
		GetFunctionAddress $0 OnFinishRunEx
		[!output PROJECT_NAME]::BindControlAndNSISScript /NOUNLOAD "btn_finish_finish" $0
	${EndIf}
	
	
	[!output PROJECT_NAME]::FindChildByName /NOUNLOAD "btn_close"
	Pop $0
	${If} $0 == "-1"
		MessageBox MB_OK ERROR_MESSAGE
	${Else}
		GetFunctionAddress $0 OnClose
		[!output PROJECT_NAME]::BindControlAndNSISScript /NOUNLOAD "btn_close" $0
	${EndIf}

	;��ʼ����ť״̬
	[!output PROJECT_NAME]::SetControlProperties /NOUNLOAD "STabCtrl" "tab_main" "curSel" "0"
	[!output PROJECT_NAME]::SetControlProperties /NOUNLOAD  "SImageButton" "btn_install" "enable" "false"
	[!output PROJECT_NAME]::SetControlProperties /NOUNLOAD  "SImageButton" "btn_custominstall" "enable" "false"
	[!output PROJECT_NAME]::SetControlProperties /NOUNLOAD  "SCheckBox" "chk_agreement" "checked" "false"
	
	;/////��ʼ������/////

	;���ô��̿ռ�
	${GetRoot} $INSTDIR $0
	${DriveSpace} $0 "/D=F /S=M" $2
	[!output PROJECT_NAME]::NSISScriptSendMessage /NOUNLOAD $Dialog "WM_SJTHREEUPDATEFREESPACE" "$2"
	
	;�������ռ��С
	[!output PROJECT_NAME]::NSISScriptSendMessage /NOUNLOAD $Dialog "WM_SJTHREEUPDATEREQUIREDSPACE" "${REQUIRED_SPACE}"
	
	;Ĭ�ϰ�װ·��
	[!output PROJECT_NAME]::SetControlProperties /NOUNLOAD "SEdit" "edit_choose_url" "text" $INSTDIR
	
	;/////��ʾ����/////
	[!output PROJECT_NAME]::ShowPage /NOUNLOAD
FunctionEnd

Function MyInstallNow

	
	;�������
  ShowWindow $HWNDPARENT ${SW_HIDE}
	${NSW_SetWindowSize} $HWNDPARENT 0 0 ;�ı��Զ��崰���С

	;�л���ͼ
	;[!output PROJECT_NAME]::NSISScriptSendMessage /NOUNLOAD $Dialog "WM_SJTABSETSEL" "3"
	[!output PROJECT_NAME]::SetControlProperties /NOUNLOAD "STabCtrl" "tab_main" "curSel" "3"

   ;�󶨽���
  [!output PROJECT_NAME]::BindingProgress  /NOUNLOAD "pg_installing"
  	
	;[!output PROJECT_NAME]::NSISScriptSendMessage /NOUNLOAD $Dialog "WM_SJMSGLOOPSTOP"
FunctionEnd

Function CreateMutex
	;��鰲װ����
	ReCheck:
	System::Call 'kernel32::CreateMutexA(i 0, i 0, t "${MyMutex_Install}") i .R1 ?e'
	Pop $R0
	System::Call 'kernel32::CloseHandle(i R1) i.s'
	;���ж�ػ��⣺
	System::Call 'kernel32::CreateMutexA(i 0, i 0, t "${MyMutex_UnInstall}") i .R3 ?e'
	Pop $R2
	System::Call 'kernel32::CloseHandle(i R3) i.s'
	;�жϰ�װ����Ĵ���
	${If} $R0 != 0
		MessageBox MB_RetryCancel|MB_ICONEXCLAMATION "��װ�����Ѿ����У�" IdRetry ReCheck
		Quit
	${ElseIf} $R2 != 0
		MessageBox MB_RetryCancel|MB_ICONEXCLAMATION "ж�س����Ѿ����У�" IdRetry ReCheck
		Quit
	${Else}
		;������װ���⣺
		System::Call 'kernel32::CreateMutexA(i 0, i 0, t "${MyMutex_Install}") i .R1 ?e'
		Pop $R0
		StrCmp $R0 0 +2
		Quit
	${EndIf}
FunctionEnd

Function un.CreateMutex
	;���ж�ػ��⣺
	ReCheck:
	System::Call 'kernel32::CreateMutexA(i 0, i 0, t "${MyMutex_UnInstall}") i .R1 ?e'
	Pop $R0
	System::Call 'kernel32::CloseHandle(i R1) i.s'
	;��鰲װ����
	System::Call 'kernel32::CreateMutexA(i 0, i 0, t "${MyMutex_Install}") i .R3 ?e'
	Pop $R2
	System::Call 'kernel32::CloseHandle(i R3) i.s'
	;�ж�ж�ػ���Ĵ���
	${If} $R0 != 0
		MessageBox MB_RetryCancel|MB_ICONEXCLAMATION "ж�س����Ѿ����У�" IdRetry ReCheck
		Quit
	${ElseIf} $R2 != 0
		MessageBox MB_RetryCancel|MB_ICONEXCLAMATION "��װ�����Ѿ����У�" IdRetry ReCheck
		Quit
	${Else}
		;����ж�ػ��⣺
		System::Call 'kernel32::CreateMutexA(i 0, i 0, t "${MyMutex_UnInstall}") i .R1 ?e'
		Pop $R0
		StrCmp $R0 0 +2
		Quit
	${EndIf}
FunctionEnd

Function .onInit

	;����UI������Ҫ����Դ
	InitPluginsDir
	;File `/ONAME=$PLUGINSDIR\[!output ProductName].dll` `plugins\[!output ProductName].dll`
	;File `/ONAME=$PLUGINSDIR\soui-sys-resource.dll` `plugins\soui-sys-resource.dll`
	;File `/ONAME=$PLUGINSDIR\ui.dll` `plugins\ui.dll`
	;File `/ONAME=$PLUGINSDIR\imgdecoder-gdip.dll` `plugins\imgdecoder-gdip.dll`
	;File `/ONAME=$PLUGINSDIR\render-gdi.dll` `plugins\render-gdi.dll`
	;File `/ONAME=$PLUGINSDIR\translator.dll` `plugins\translator.dll`
  ;File `/ONAME=$PLUGINSDIR\utilities.dll` `plugins\utilities.dll`
  ;File `/ONAME=$PLUGINSDIR\soui.dll` `plugins\soui.dll`
  ;File `/ONAME=$PLUGINSDIR\resprovider-zip.dll` `plugins\resprovider-zip.dll`
  SetOutPath $PLUGINSDIR
  File /r `.\plugins\*.*`
	;�����򻥳�
	Call CreateMutex

FunctionEnd

;############################################ж��############################################
Function un.OnClose
  [!output PROJECT_NAME]::NSISMessageBox /NOUNLOAD 3 "ȷ��Ҫȡ��ж����" "��ʾ"
  Pop $0
  ${If} $0 == "1"
    ;�رճ���
	  [!output PROJECT_NAME]::ClosePage /NOUNLOAD
	${EndIf}
FunctionEnd
;ж�ص�һҳ������һҳ
Function un.OnBtnNextClick
	[!output PROJECT_NAME]::NSISScriptSendMessage /NOUNLOAD $Dialog "WM_SJUNSTALLSTARTNEXT"
FunctionEnd

Function un.OnBtnCancellClick
	[!output PROJECT_NAME]::NSISMessageBox /NOUNLOAD 3 "ȷ��Ҫȡ��ж����" "��ʾ"
  Pop $0
  ${If} $0 == "1"
    ;�رճ���
	  [!output PROJECT_NAME]::ClosePage /NOUNLOAD
	${EndIf}
FunctionEnd

Function un.OnUnstallClick
		;ֹͣ��Ϣѭ��
		[!output PROJECT_NAME]::NSISScriptSendMessage /NOUNLOAD $Dialog "WM_SJMSGLOOPSTOP"
FunctionEnd

Function un.OnFinishClick
  [!output PROJECT_NAME]::ClosePage /NOUNLOAD
FunctionEnd

Function un.MyUninstallPage
  ;�������
 	ShowWindow $HWNDPARENT ${SW_HIDE}
	${NSW_SetWindowSize} $HWNDPARENT 0 0 ;�ı��Զ��崰���С

	;/////��ʼ������/////
	[!output PROJECT_NAME]::InitWindow /NOUNLOAD "$PLUGINSDIR"
	Pop $Dialog

	;�л���ж�ؽ���
	[!output PROJECT_NAME]::SetControlProperties /NOUNLOAD "STabCtrl" "tab_main" "curSel" "5"
	;������С����ť
	[!output PROJECT_NAME]::SetControlProperties /NOUNLOAD "SImageButton" "btn_min" "visible" "false"
	;��ʾж�ر���
	[!output PROJECT_NAME]::SetControlProperties /NOUNLOAD "SStatic" "txt_titlename" "text" "Sha Monk MM UnInstall Guide"

	;�󶨹رհ�ť
	[!output PROJECT_NAME]::FindChildByName /NOUNLOAD "btn_close"
	Pop $0
	${If} $0 == "-1"
		MessageBox MB_OK ERROR_MESSAGE
	${Else}
		GetFunctionAddress $0 un.OnClose
		[!output PROJECT_NAME]::BindControlAndNSISScript /NOUNLOAD "btn_close" $0
	${EndIf}
	;/////��һҳ��/////
	;����һҳ
	[!output PROJECT_NAME]::FindChildByName /NOUNLOAD "btn_unstallstart_next"
	Pop $0
	${If} $0 == "-1"
		MessageBox MB_OK ERROR_MESSAGE
	${Else}
		GetFunctionAddress $0 un.OnBtnNextClick
		[!output PROJECT_NAME]::BindControlAndNSISScript /NOUNLOAD "btn_unstallstart_next" $0
	${EndIf}
	;/////�ڶ�ҳ��/////
	;ȡ����ť
	[!output PROJECT_NAME]::FindChildByName /NOUNLOAD "btn_unstallchoose_previous"
	Pop $0
	${If} $0 == "-1"
		MessageBox MB_OK ERROR_MESSAGE
	${Else}
		GetFunctionAddress $0 un.OnBtnCancellClick
		[!output PROJECT_NAME]::BindControlAndNSISScript /NOUNLOAD "btn_unstallchoose_previous" $0
	${EndIf}
	;ж�ذ�ť
		[!output PROJECT_NAME]::FindChildByName /NOUNLOAD "btn_unstallchoose_unnstall"
	Pop $0
	${If} $0 == "-1"
		MessageBox MB_OK ERROR_MESSAGE
	${Else}
		GetFunctionAddress $0 un.OnUnstallClick
		[!output PROJECT_NAME]::BindControlAndNSISScript /NOUNLOAD "btn_unstallchoose_unnstall" $0
	${EndIf}
	;////���һ��ҳ��/////
	;��ɰ�ť
	[!output PROJECT_NAME]::FindChildByName /NOUNLOAD "btn_unstallfinish"
	Pop $0
	${If} $0 == "-1"
		MessageBox MB_OK ERROR_MESSAGE
	${Else}
		GetFunctionAddress $0 un.OnFinishClick
		[!output PROJECT_NAME]::BindControlAndNSISScript /NOUNLOAD "btn_unstallfinish" $0
	${EndIf}
	
	;��ȡҪж�ص�Ŀ¼
	ReadRegStr $0 HKLM "${Unstall_KeyPath}${PRODUCT_NAME_EN}" "InstallLocation"
  ;��ʾж�ص�Ŀ¼
	[!output PROJECT_NAME]::SetControlProperties /NOUNLOAD "SEdit" "edit_unstallchoose_url" "text" "$0"

	;/////��ʾ����/////
	[!output PROJECT_NAME]::ShowPage /NOUNLOAD
FunctionEnd

Function un.MyUninstallNow
	;�������
 	ShowWindow $HWNDPARENT ${SW_HIDE}
	${NSW_SetWindowSize} $HWNDPARENT 0 0 ;�ı��Զ��崰���С

	;[!output PROJECT_NAME]::NSISScriptSendMessage /NOUNLOAD $Dialog "WM_SJTABSETSEL" "7"
  [!output PROJECT_NAME]::SetControlProperties /NOUNLOAD "STabCtrl" "tab_main" "curSel" "7"
  [!output PROJECT_NAME]::BindingProgress  /NOUNLOAD "pg_unstalling"
  
FunctionEnd

Function un.onInit

  ;����UI������Ҫ����Դ
	InitPluginsDir
	;File `/ONAME=$PLUGINSDIR\[!output ProductName].dll` `plugins\[!output ProductName].dll`
	;File `/ONAME=$PLUGINSDIR\ui.dll` `plugins\ui.dll`
	;File `/ONAME=$PLUGINSDIR\soui-sys-resource.dll` `plugins\soui-sys-resource.dll`
	SetOutPath $PLUGINSDIR
  File /r `plugins\*.*`
	;�����򻥳�
	Call un.CreateMutex
FunctionEnd
