; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!
#include "environment.iss"
#define MyAppName "Cominnek"
#define MyAppVersion "4.0.0"
#define MyAppPublisher "Minnek Digital Studio"
#define MyAppURL "https://github.com/Minnek-Digital-Studio/cominnek"
#define MyAppExeName "cominnek.exe"

[Setup]
AppId=com.minnekdigitalstudio.cominnek
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={autopf}\{#MyAppName}
DefaultGroupName={#MyAppName}
DisableProgramGroupPage=yes
LicenseFile={#SourcePath}..\..\..\LICENSE
OutputDir={#SourcePath}..\..\..\dist
OutputBaseFilename=cominnek-{#MyAppVersion}
Compression=lzma
SolidCompression=yes
WizardStyle=modern
ChangesEnvironment=true

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Files]
Source: "{#SourcePath}..\..\..\build\{#MyAppExeName}"; DestDir: "{app}"; Flags: ignoreversion

[Icons]
Name: "{group}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"

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
