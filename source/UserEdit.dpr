program UserEdit;

uses
  Forms,
  Windows,
  Messages,
  SysUtils,
  Registry,
  Main in 'Main.pas' {MainProgram},
  DlgSearchText in 'DlgSearchText.pas' {SearchDialog},
  DlgReplaceText in 'DlgReplaceText.pas' {ReplaceDialog},
  DlgConfirm in 'DlgConfirm.pas' {ConfirmDialog},
  DlgPageSetup in 'DlgPageSetup.pas' {PageDialog},
  DlgGotoLine in 'DlgGotoLine.pas' {GoToDialog},
  DlgAbout in 'DlgAbout.pas' {AboutDialog},
  DlgInput in 'DlgInput.pas' {InputDialog},
  DlgChoose in 'DlgChoose.pas' {ChooseDialog},
  DlgInform in 'DlgInform.pas' {InformDialog},
  DlgTipDay in 'DlgTipDay.pas' {TipDialog},
  DlgConfigEditor in 'DlgConfigEditor.pas' {EditorDialog},
  DlgEnvironment in 'DlgEnvironment.pas' {EnvironmentDialog},
  SynHighlighterUserEdit in 'SynHighlighterUserEdit.pas',
  Language in 'Language.pas',
  DlgPrintPreview in 'DlgPrintPreview.pas' {PreviewDialog},
  Emu48Proc in 'Emu48Proc.pas',
  DlgGrob in 'DlgGrob.pas' {GrobDialog},
  DlgTransfer in 'DlgTransfer.pas' {TransferDialog},
  DlgStatus in 'DlgStatus.pas' {StatusDialog},
  Globals in 'Globals.pas',
  DlgParam in 'DlgParam.pas' {ParamDialog},
  HPUtils in 'HPUtils.pas',
  Emu48Dll in 'Emu48Dll.pas',
  DlgMatrix in 'DlgMatrix.pas' {MatrixDialog},
  YModem in 'YModem.pas',
  DBuilder in 'DBuilder.pas' {DBuilderForm},
  DlgDBEditor in 'DlgDBEditor.pas' {EditorForm},
  DlgDBInput in 'DlgDBInput.pas' {InputForm},
  CalcExpress in 'CalcExpress.pas',
  DiagramBuilder in 'DiagramBuilder.pas';

{$R *.RES}
{$R Iconos.res}

var
  EditHandle: hWnd;
  cds: CopyDataStruct;
  FileName: String;
  Reg: TRegistry;
begin
  oMultiplesInstances := False; // ver5
  Reg := TRegistry.Create; // ver5
  try // ver5
    Reg.RootKey := HKEY_CURRENT_USER; // ver5
    if Reg.OpenKey('SOFTWARE\HPUserEdit\Environment', False) then // ver5
    begin // ver5
      oMultiplesInstances := Reg.ReadBool('MultiplesInstances'); // ver5
      Reg.CloseKey; // ver5
    end; // ver5
  finally // ver5
    Reg.Free; // ver5
  end; // ver5
  if not oMultiplesInstances then
  begin
    EditHandle := FindWindow(APP_CLASSNAME, nil);
    if EditHandle > 0 then
    begin
      FileName := ParamStr(1);
      cds.dwData := 0;
      cds.cbData := Length(FileName);
      cds.lpData := PChar(FileName);
      SetForegroundWindow(EditHandle);
      SendMessage(EditHandle, WM_COPYDATA, 0, Integer(@cds));
      Exit;
    end;
  end;
  Application.Initialize;
  Application.Title := 'HPUserEdit 5';
  Application.CreateForm(TMainProgram, MainProgram);
  Application.CreateForm(TPageDialog, PageDialog);
  Application.CreateForm(TEditorDialog, EditorDialog);
  Application.CreateForm(TEnvironmentDialog, EnvironmentDialog);
  Application.CreateForm(TTransferDialog, TransferDialog);
  Application.Run;
end.
