unit DlgTransfer;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls, YModem, Buttons;

type
  TTransferDialog = class(TForm)
    LabelFileName: TLabel;
    FileName: TPanel;
    ObjectName: TPanel;
    StatusPanel: TPanel;
    LabelStatus: TLabel;
    LabelObjectName: TLabel;
    GroupTransfer: TGroupBox;
    LabelPacket: TLabel;
    Packets: TPanel;
    ProgressBar: TProgressBar;
    Percent: TPanel;
    Cancel: TBitBtn;
    procedure FormPaint(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    Fconnected: boolean;
    FCalcTypeString: string;                   // wgg received as part of version string from calc
    FCalcVersion: string;                      // wgg ROM version id
    XModemServer: TXModemServer;
    procedure Status(sender: TObject; Messages: string; operation, v1, v2, v3: integer);
    procedure ShowBusy(state: boolean);                                       // wgg
    procedure SetComPort;                                                     // wgg
    procedure LoadToReal(server: TXModemServer);                                // wgg
    procedure SetCalcTypeString(s: string);                                   // wgg
  public
    TargetFile: string;
    property CalcTypeString: string read FCalcTypeString write SetCalcTypeString; // wgg
    property CalcVersion: string read FCalcVersion write FCalcVersion;            // wgg
    procedure Setconnected(const Value: boolean);                                 // wgg made public
    property Connected: Boolean read Fconnected write Setconnected;               // wgg made public
    Procedure Action(m: string; o, v1, v2, v3: integer);
    procedure TransferFile;
    procedure ChangeLanguageFile;
  end;

var
  TransferDialog: TTransferDialog;

implementation

{$R *.dfm}

uses
  Globals, Language;

procedure TTransferDialog.TransferFile;
var
  FName: TFileName;
begin
  FName := TargetFile; // ver5
  FileName.Caption := FName; // ver5
  FName := ExtractFileName(FName); // ver5
  if oObjectNameCap then
    FName := UpperCase(FName); // ver5
  if oObjectNameExt then
    ObjectName.Caption := ChangeFileExt(FName, '') // ver5
  else
    ObjectName.Caption := FName; // ver5
  if Not connected then
    SetComPort; // ver5
  ShowBusy(true);   // wgg
  LoadToReal(XModemServer);                         // FProject sets this callback
  // Setconnected(false);                     // warmstart kills the server
  XModemServer.Kill;   // if a lib and a 48, it is already dead due to warmstart!
  ShowBusy(false); // ver5
end;

procedure TTransferDialog.SetCalcTypeString(s: string);
begin
  FCalcTypeString:= s; // ver5
end;

procedure TTransferDialog.SetComPort;
begin
  ShowBusy(true);   // wgg
  try
    if oComPortName <> Disconnect then
      try
        connected:= false;         // wgg was before first try
        XModemServer.com:= oComPortName; // ver5
      finally
        Connected:= XModemServer.connected; // ver5
        if connected then Refresh;              // wgg
      end
    else
    begin
      XModemServer.Kill;                       // wgg kill the calc server
 //     XModemServer.com:= Disconnect;
    end;
  finally
  ShowBusy(false);   // wgg
  end;
end;

procedure TTransferDialog.Setconnected(const Value: boolean);
begin
  if Fconnected <> Value then Fconnected:= Value; // ver5
end;

procedure TTransferDialog.ShowBusy(state: boolean);
begin
  if state then
    Screen.Cursor:= crHourGlass // ver5
  else
    Screen.Cursor:= crDefault; // ver5
  Application.ProcessMessages; // ver5
end;

procedure TTransferDialog.Status(sender: TObject; Messages: string; operation,
  v1, v2, v3: integer);
begin
  StatusPanel.Caption := Messages; // ver5
  Application.ProcessMessages; // ver5
end;

procedure TTransferDialog.FormPaint(Sender: TObject);
var
  R: TRect;
begin
  R := ClientRect;
  DrawEdge(canvas.handle, R, EDGE_RAISED, BF_RECT or BF_ADJUST);
  R.Bottom := R.Top + GetSystemMetrics(SM_CYCAPTION);
  DrawCaption(Self.Handle, Canvas.Handle, R, DC_ACTIVE or DC_TEXT or DC_GRADIENT);
end;

procedure TTransferDialog.LoadToReal(server: TXModemServer);
const
  tname: string = '$$$t';
begin
  with server do
  begin
    Put(tname, TargetFile);                                // load the project .hp file
    DoCommand('''' + tname + ''' DUP RCL SWAP PURGE');         // and put on stack
  end;
end;

procedure TTransferDialog.Action(m: string; o, v1, v2, v3: integer);
begin
  if not visible then exit;
  if o = opEnd then
  begin
    Close; // ver5
    ModalResult:= mrOk; // ver5
    Exit; // ver5
  end;
  StatusPanel.Caption := m; // ver5
  if o = opPercent then
  begin
    ProgressBar.Max:= v2; // ver5
    ProgressBar.Position:= v1; // ver5
    Percent.Caption := IntToStr(v1) + '%'; // ver5
  end;
  if o = opCancelState then
    Cancel.Enabled:= m = '1'; // ver5
end;

procedure TTransferDialog.ChangeLanguageFile;
begin
  if not FileExists(LangPath) then
  begin
    MsgDlg(Format(Msgs[MSG_FILENOTEXISTS], [LangPath]), MB_ICONERROR + MB_OK);
    Exit;
  end;
  with TLanguageFile.Create(LangPath) do
  try
    Section := 'TransferDialog';
    Self.Caption := LoadItem('DlgTransferTitle');
    LabelFileName.Caption := LoadItem('DlgTransferFileName');
    LabelObjectName.Caption := LoadItem('DlgTransferObjectName');
    LabelStatus.Caption := LoadItem('DlgTransferStatus');
    GroupTransfer.Caption := LoadItem('DlgTransferTransferStatus');
    LabelPacket.Caption := LoadItem('DlgTransferSendPackets');
  finally
    Free;
  end;
end;

procedure TTransferDialog.FormCreate(Sender: TObject);
begin
  Connected := False; // ver5
  XModemServer:= TXModemServer.Create; // ver5
  XModemServer.StatusReport := Status; // ver5
  ChangeLanguageFile;
end;

end.
