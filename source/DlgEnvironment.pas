unit DlgEnvironment;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, JvComponentBase, JvComputerInfoEx, JvSpin, Mask, JvExMask,
  JvToolEdit, ExtCtrls, ComCtrls, Buttons;

type
  TEnvironmentDialog = class(TForm)
    Ok: TBitBtn;
    Cancel: TBitBtn;
    PageControl: TPageControl;
    General: TTabSheet;
    GroupShortCut: TGroupBox;
    OnDesktop: TCheckBox;
    OnSendTo: TCheckBox;
    OnContextMenu: TCheckBox;
    OnQuickLaunch: TCheckBox;
    Emu48: TTabSheet;
    Comunication: TTabSheet;
    Associate: TButton;
    DefaultEmu: TRadioGroup;
    GroupEnvironment: TGroupBox;
    MultiplesInstances: TCheckBox;
    LogoOnStartup: TCheckBox;
    StayOnTop: TCheckBox;
    GroupFiles: TGroupBox;
    LabelEmu48Filename: TLabel;
    Emu48Filename: TJvFilenameEdit;
    LabelEmu48PortFilename: TLabel;
    Emu48PortFilename: TJvFilenameEdit;
    LabelEmu49Filename: TLabel;
    Emu49Filename: TJvFilenameEdit;
    GroupXModem: TGroupBox;
    LabelPort: TLabel;
    SendPort: TComboBox;
    GroupObjects: TGroupBox;
    ObjectNameExt: TCheckBox;
    ObjectNameCap: TCheckBox;
    ComputerInfo: TJvComputerInfoEx;
    GroupTemplates: TGroupBox;
    CmdsFileName: TJvFilenameEdit;
    TreeFileName: TJvFilenameEdit;
    LabelCmdsFileName: TLabel;
    LabelTreeFileName: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    chkSaveIntoEMU: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure AssociateClick(Sender: TObject);
    procedure OkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    procedure ChangeLanguageFile;
  end;

procedure RegisterFileType(cMyExt, cMyFileType, cMyDescription, ExeName: string; IcoIndex: integer; DoUpdate: boolean = false);

var
  EnvironmentDialog: TEnvironmentDialog;

implementation

{$R *.DFM}

uses
  Globals, Registry, ComObj, ActiveX, ShlObj, YModem, Language;

procedure RegisterFileType(cMyExt, cMyFileType, cMyDescription, ExeName: string; IcoIndex: Integer; DoUpdate: Boolean = false);
var
  Reg: TRegistry;
begin
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CLASSES_ROOT;
    Reg.OpenKey(cMyExt, True);
    Reg.WriteString('', cMyFileType);
    Reg.CloseKey;
    Reg.OpenKey(cMyFileType, True);
    Reg.WriteString('', cMyDescription);
    Reg.CloseKey;
    Reg.OpenKey(cMyFileType + '\DefaultIcon', True);
    Reg.WriteString('', ExeName + ',' + IntToStr(IcoIndex));
    Reg.CloseKey;
    Reg.OpenKey(cMyFileType + '\Shell\Open', True);
    Reg.WriteString('', '&Open');
    Reg.CloseKey;
    Reg.OpenKey(cMyFileType + '\Shell\Open\Command', True);
    Reg.WriteString('', '"' + ExeName + '" "%1"');
    Reg.CloseKey;
    if DoUpdate then SHChangeNotify(SHCNE_ASSOCCHANGED, SHCNF_IDLIST, nil, nil);
  finally
    Reg.Free;
  end;
end;

procedure TEnvironmentDialog.FormShow(Sender: TObject);
begin
  MultiplesInstances.Checked := oMultiplesInstances;
  LogoOnStartup.Checked := oLogoOnStartup;
  StayOnTop.Checked := oStayOnTop;
  //NewOnStartup.Checked := oNewOnStartup;
  OnDesktop.Checked := oShortCutDesktop;
  OnSendTo.Checked := oShortCutSendTo;
  OnContextMenu.Checked := oShortCutContext;
  OnQuickLaunch.Checked := oShortCutLaunchBar;
  CmdsFileName.FileName := oCmdsFile; // ver5
  TreeFileName.FileName := oTreeFile; // ver5
  Emu48Filename.FileName := oEmu48Filename;
  Emu48PortFilename.FileName := oEmu48PortFilename;
  Emu49Filename.FileName := oEmu49Filename;
  chkSaveIntoEMU.Checked := oSaveIntoEMU; // ver5
  if oIsCalc48 then DefaultEmu.ItemIndex := 0 else DefaultEmu.ItemIndex := 1;
  ObjectNameCap.Checked := oObjectNameCap;
  ObjectNameExt.Checked := oObjectNameExt;
  SendPort.ItemIndex := oComPort; // ver5
  oComPortName := SendPort.Text;
  //SendSpeed.ItemIndex := oSendSpeed;
  //SendChecksum.ItemIndex := oSendChecksum;
  //SendRetry.Value := oSendRetry;
  //EnableBeep.Checked := oEnableBeep;
end;

procedure TEnvironmentDialog.AssociateClick(Sender: TObject);
begin
  RegisterFileType('.hpe', 'HpUserEditFile', ' HPUserEdit', Application.ExeName, 1, True);
  RegisterFileType('.hpprj', 'HPUserEditProject', 'Archivo de Proyecto de HPUserEdit 5', Application.ExeName, 2, True);
  RegisterFileType('.hpprg', 'HPUserEditProgram', 'Archivo de Programa de HPUserEdit 5', Application.ExeName, 3, True);
  RegisterFileType('.hpdir', 'HPUserEditDirectory', 'Archivo de Directorio de HPUserEdit 5', Application.ExeName, 4, True);
  RegisterFileType('.hplst', 'HPUserEditList', 'Archivo de Lista de HPUserEdit 5', Application.ExeName, 5, True);
  RegisterFileType('.hpstr', 'HPUserEditString', 'Archivo de Texto de HPUserEdit 5', Application.ExeName, 6, True);
  RegisterFileType('.hparr', 'HPUserEditArray', 'Archivo de Arreglo de HPUserEdit 5', Application.ExeName, 7, True);
  RegisterFileType('.hpalg', 'HPUserEditAlgebraic', 'Archivo de Ecuación de HPUserEdit 5', Application.ExeName, 8, True);
  RegisterFileType('.hpgrb', 'HPUserEditGraphic', 'Archivo de gráfico de HPUserEdit 5', Application.ExeName, 9, True);
  RegisterFileType('.hpobj', 'HPUserEditObject', 'Archivo de Objeto de HPUserEdit 5', Application.ExeName, 10, True);
  MsgDlg(Msgs[MSG_ASSOCIATION], MB_ICONINFORMATION + MB_OK);
end;

procedure TEnvironmentDialog.OkClick(Sender: TObject);
var
  ShLink: IShellLink;
  PFile: IPersistFile;
  wFileName: WideString;
begin
  oMultiplesInstances := MultiplesInstances.Checked;
  oLogoOnStartup := LogoOnStartup.Checked;
  oStayOnTop := StayOnTop.Checked;
  //oNewOnStartup := NewOnStartup.Checked;
  oShortCutDesktop := OnDesktop.Checked;
  oShortCutSendTo := OnSendTo.Checked;
  oShortCutContext := OnContextMenu.Checked;
  oShortCutLaunchBar := OnQuickLaunch.Checked;
  oCmdsFile := CmdsFileName.FileName; // ver5
  oTreeFile := TreeFileName.FileName; // ver5
  oEmu48Filename := Emu48Filename.FileName;
  oEmu48PortFilename := Emu48PortFilename.FileName;
  oEmu49Filename := Emu49Filename.FileName;
  oSaveIntoEMU := chkSaveIntoEMU.Checked; // ver5
  oIsCalc48 := DefaultEmu.ItemIndex = 0;
  oObjectNameCap := ObjectNameCap.Checked;
  oObjectNameExt := ObjectNameExt.Checked;
  oComPort := SendPort.ItemIndex; // ver5
  oComPortName := SendPort.Text;
  //oSendSpeed := SendSpeed.ItemIndex;
  //oSendChecksum := SendChecksum.ItemIndex;
  //oSendRetry := SendRetry.AsInteger;
  //oEnableBeep := EnableBeep.Checked;

  ShLink := CreateComObject(CLSID_ShellLink) as IShellLink;
  PFile := ShLink as IPersistFile;
  ShLink.SetPath(PChar(Application.ExeName));
  ShLink.SetWorkingDirectory(PChar(AppPath));
  wFileName := ComputerInfo.Folders.Desktop + '\' + APP_LNK;
  if oShortCutDesktop and not FileExists(wFileName) then
    PFile.Save(PwChar(wFileName), False)
  else
    DeleteFile(wFileName);
  wFileName := ComputerInfo.Folders.SendTo + '\' + APP_LNK;
  if oShortCutSendTo and not FileExists(wFileName) then
    PFile.Save(PwChar(wFileName), False)
  else
    DeleteFile(wFileName);
  wFileName := ComputerInfo.Folders.AppData + '\Microsoft\Internet Explorer\Quick Launch\' + APP_LNK;
  if oShortCutLaunchBar and not FileExists(wFileName) then
    PFile.Save(PwChar(wFileName), False)
  else
    DeleteFile(wFileName);
end;

procedure TEnvironmentDialog.ChangeLanguageFile;
begin
  if not FileExists(LangPath) then
  begin
    MsgDlg(Format(Msgs[MSG_FILENOTEXISTS], [LangPath]), MB_ICONERROR + MB_OK);
    Exit;
  end;
  with TLanguageFile.Create(LangPath) do
  try
    Section := 'ConfigEnvironmentDialog';
    Self.Caption := LoadItem('DlgEnvironmentTitle');
    General.Caption := LoadItem('DlgEnvironmentGeneral');
    GroupEnvironment.Caption := LoadItem('DlgEnvironmentEnvironment');
    MultiplesInstances.Caption := LoadItem('DlgEnvironmentMultiInstances');
    LogoOnStartup.Caption := LoadItem('DlgEnvironmentLogoAtStartup');
    StayOnTop.Caption := LoadItem('DlgEnvironmentStayOnTop');
    //NewOnStartup.Caption := LoadItem('DlgEnvironmentNewOnStartup');
    GroupShortCut.Caption := LoadItem('DlgEnvironmentShortCut');
    OnDesktop.Caption := LoadItem('DlgEnvironmentShortCutDesktop');
    OnSendTo.Caption := LoadItem('DlgEnvironmentShortCutSendTo');
    OnContextMenu.Caption := LoadItem('DlgEnvironmentShortCutContextMenu');
    OnQuickLaunch.Caption := LoadItem('DlgEnvironmentShortCutQuickLaunch');
    Associate.Caption := LoadItem('DlgEnvironmentAssociateFile');
    GroupTemplates.Caption := LoadItem('DlgEnvironmentTemplates');
    LabelCmdsFileName.Caption := LoadItem('DlgEnvironmentCommandsFileName');
    CmdsFileName.DialogTitle := LoadItem('DlgEnvironmentCommandsFileNameDialogTitle');
    CmdsFileName.Filter := LoadItem('DlgEnvironmentCommandsFileNameDialogFilter');
    LabelTreeFileName.Caption := LoadItem('DlgEnvironmentMenusFileName');
    TreeFileName.DialogTitle := LoadItem('DlgEnvironmentMenusFileNameDialogTitle');
    TreeFileName.Filter := LoadItem('DlgEnvironmentMenusFileNameDialogFilter');
    Emu48.Caption := LoadItem('DlgEnvironmentEmulator');
    GroupFiles.Caption := LoadItem('DlgEnvironmentEmulatorFiles');
    LabelEmu48FileName.Caption := LoadItem('DlgEnvironmentEmu48FileName');
    Emu48FileName.DialogTitle := LoadItem('DlgEnvironmentEmu48FileNameDialogTitle');
    Emu48FileName.Filter := LoadItem('DlgEnvironmentEmu48FileNameDialogFilter');
    LabelEmu48PortFileName.Caption := LoadItem('DlgEnvironmentEmu48PortFileName');
    Emu48PortFileName.DialogTitle := LoadItem('DlgEnvironmentEmu48PortFileNameDialogTitle');
    Emu48PortFileName.Filter := LoadItem('DlgEnvironmentEmu48PortFileNameDialogFilter');
    LabelEmu49FileName.Caption := LoadItem('DlgEnvironmentEmu49FileName');
    Emu49FileName.DialogTitle := LoadItem('DlgEnvironmentEmu49FileNameDialogTitle');
    Emu49FileName.Filter := LoadItem('DlgEnvironmentEmu49FileNameDialogFilter');
    chkSaveIntoEMU.Caption := LoadItem('DlgEnvironmentSaveIntoEMU'); // ver5
    DefaultEmu.Caption := LoadItem('DlgEnvironmentDefaultEmu');
    DefaultEmu.Items[0] := LoadItem('DlgEnvironmentDefaultEmuHP48');
    DefaultEmu.Items[1] := LoadItem('DlgEnvironmentDefaultEmuHP49');
    Comunication.Caption := LoadItem('DlgEnvironmentComunication');
    GroupObjects.Caption := LoadItem('DlgEnvironmentObjects');
    ObjectNameCap.Caption := LoadItem('DlgEnvironmentObjectNameCapital');
    ObjectNameExt.Caption := LoadItem('DlgEnvironmentObjectNameExtension');
    //SendPort.Caption := LoadItem('DlgEnvironmentSendPort');
    //GroupKermit.Caption := LoadItem('DlgEnvironmentKermit');
    LabelPort.Caption := LoadItem('DlgEnvironmentSendPort');
    //LabelSendChecksum.Caption := LoadItem('DlgEnvironmentSendChecksum');
    //SendChecksum.Items[0] := LoadItem('DlgEnvironmentSendChecksumType1');
    //SendChecksum.Items[1] := LoadItem('DlgEnvironmentSendChecksumType2');
    //SendChecksum.Items[2] := LoadItem('DlgEnvironmentSendChecksumType3');
    //LabelSendRetry.Caption := LoadItem('DlgEnvironmentSendRetry');
    //EnableBeep.Caption := LoadItem('DlgEnvironmentEnableBeep');
    Ok.Caption := LoadItem('DlgEnvironmentOk');
    Cancel.Caption := LoadItem('DlgEnvironmentCancel');
  finally
    Free;
  end;
end;

procedure TEnvironmentDialog.FormCreate(Sender: TObject);
var
  L: TStringList;
begin
  L:= TStringList.Create;
  try
    L.text:= ListComm;
    L.Sorted:= True;
    SendPort.Items.text:= 'Auto'#10+L.Text;         // wgg removed +disconnect;
  finally
    L.free;
  end;
  ChangeLanguageFile;
end;

end.
