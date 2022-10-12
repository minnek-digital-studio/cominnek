; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!
#include "environment.iss"
#define MyAppName "Cominnek"
#define MyAppVersion "2.0.1"
#define MyAppPublisher "Minnek Digital Studio"
#define MyAppURL "https://github.com/Minnek-Digital-Studio/cominnek"
#define MyAppExeName "cominnek.exe"

[Setup]
; NOTE: The value of AppId uniquely identifies this application. Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{8C704EC9-0C93-4AF5-BEDD-6B90152B76E0}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
;AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={autopf}\{#MyAppName}
DefaultGroupName={#MyAppName}
DisableProgramGroupPage=yes
LicenseFile=C:\Users\isaac\Minnek-Projects\cominnek\LICENSE
; Uncomment the following line to run in non administrative install mode (install for current user only.)
;PrivilegesRequired=lowest
OutputDir=C:\Users\isaac\Minnek-Projects\cominnek\dist
OutputBaseFilename=cominnek-2.0.1
Compression=lzma
SolidCompression=yes
WizardStyle=modern
ChangesEnvironment=true

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Files]
Source: "C:\Users\isaac\Minnek-Projects\cominnek\build\{#MyAppExeName}"; DestDir: "{app}"; Flags: ignoreversion
; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[Icons]
Name: "{group}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"

[Run]
Filename: "{app}\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent

[Code]
procedure CurStepChanged(CurStep: TSetupStep);
begin
    if CurStep = ssPostInstall 
     then EnvAddPath(ExpandConstant('{app}'));
    
    if CurStep = ssPostInstall 
     then EnvAddVariable('COMINNEK_PAHT', ExpandConstant('{app}'));
end;

procedure CurUninstallStepChanged(CurUninstallStep: TUninstallStep);
begin
    if CurUninstallStep = usPostUninstall
     then EnvRemovePath(ExpandConstant('{app}'));

    if CurUninstallStep = usPostUninstall 
    then EnvRemoveVariable('COMINNEK_PAHT');
end;