unit DlgTipDay;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TTipDialog = class(TForm)
    NextTip: TButton;
    CloseTip: TButton;
    ShowCheck: TCheckBox;
    Panel: TPanel;
    Image: TImage;
    Title: TLabel;
    Tip: TLabel;
    Welcome: TLabel;
    PrevTip: TButton;
    procedure FormCreate(Sender: TObject);
    procedure CloseTipClick(Sender: TObject);
    procedure NextTipClick(Sender: TObject);
    procedure ShowCheckClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure PrevTipClick(Sender: TObject);
  private
    { Private declarations }
  public
    FItem: Integer;
    FTips: TStringList;
    procedure ChangeLanguageFile;
  end;

var
  TipDialog: TTipDialog;

implementation

{$R *.DFM}

uses
  Globals, Language;

procedure TTipDialog.FormCreate(Sender: TObject);
begin
  ShowCheck.Checked := oShowTipDay;
  FTips := TStringList.Create;
  if FileExists(AppPath + TIPS_FILE) then
  begin
    FTips.LoadFromFile(AppPath + TIPS_FILE);
    Randomize;
    FItem := Random(FTips.Count);
    Tip.Caption := FTips.Strings[FItem];
  end
  else begin
    MsgDlg(Format(Msgs[MSG_FILENOTEXISTS], [AppPath + TIPS_FILE]), MB_ICONERROR + MB_OK);
    NextTip.Enabled := False;
    PrevTip.Enabled := False;
  end;
  ChangeLanguageFile;
end;

procedure TTipDialog.CloseTipClick(Sender: TObject);
begin
  Close;
end;

procedure TTipDialog.NextTipClick(Sender: TObject);
begin
  if FItem = FTips.Count - 1 then FItem := 0
  else Inc(FItem);
  Tip.Caption := FTips.Strings[FItem];
end;

procedure TTipDialog.ShowCheckClick(Sender: TObject);
begin
  oShowTipDay := ShowCheck.Checked;
end;

procedure TTipDialog.ChangeLanguageFile;
begin
  if not FileExists(LangPath) then
  begin
    MsgDlg(Format(Msgs[MSG_FILENOTEXISTS], [LangPath]), MB_ICONERROR + MB_OK);
    Exit;
  end;
  with TLanguageFile.Create(LangPath) do
  try
    Section := 'TipDayDialog';
    Self.Caption := LoadItem('DlgTipDayTitle');
    Welcome.Caption := LoadItem('DlgTipDayWelcome');
    Title.Caption := LoadItem('DlgTipDayDescription');
    ShowCheck.Caption := LoadItem('DlgTipDayShowTip');
    NextTip.Caption := LoadItem('DlgTipDayNext');
    PrevTip.Caption := LoadItem('DlgTipDayPrevious');
    CloseTip.Caption := LoadItem('DlgTipDayClose');
  finally
    Free;
  end;
end;

procedure TTipDialog.FormDestroy(Sender: TObject);
begin
  FTips.Free;
end;

procedure TTipDialog.PrevTipClick(Sender: TObject);
begin
  if FItem = 0 then FItem := FTips.Count - 1
  else Dec(FItem);
  Tip.Caption := FTips.Strings[FItem];
end;

end.
