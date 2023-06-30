unit DlgConfirm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls;

type
  TConfirmDialog = class(TForm)
    Image: TImage;
    LabelConfirmation: TLabel;
    Replace: TBitBtn;
    Skip: TBitBtn;
    Cancel: TBitBtn;
    ReplaceAll: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    procedure ChangeLanguageFile;
    procedure PrepareShow(AEditorRect: TRect; X, Y1, Y2: integer;
      AReplaceText: string);
  end;

var
  ConfirmDialog: TConfirmDialog;

implementation

uses
  Globals, Language;

{$R *.DFM}

procedure TConfirmDialog.ChangeLanguageFile;
begin
  if not FileExists(LangPath) then
  begin
    MsgDlg(Format(Msgs[MSG_FILENOTEXISTS], [LangPath]), MB_ICONERROR + MB_OK);
    Exit;
  end;
  with TLanguageFile.Create(LangPath) do
  try
    Section := 'ConfirmDialog';
    Self.Caption := LoadItem('DlgConfirmTitle');
    Replace.Caption := LoadItem('DlgConfirmReplac');
    Skip.Caption := LoadItem('DlgConfirmSkip');
    Cancel.Caption := LoadItem('DlgConfirmCancel');
    ReplaceAll.Caption := LoadItem('DlgConfirmReplaceAll');
  finally
    Free;
  end;
end;

procedure TConfirmDialog.FormCreate(Sender: TObject);
begin
  Image.Picture.Icon.Handle := LoadIcon(0, IDI_QUESTION);
  ChangeLanguageFile;
end;

procedure TConfirmDialog.FormDestroy(Sender: TObject);
begin
  ConfirmDialog := nil;
end;

procedure TConfirmDialog.PrepareShow(AEditorRect: TRect; X, Y1,
  Y2: integer; AReplaceText: string);
var
  nW, nH: integer;
begin
  LabelConfirmation.Caption := Format(Msgs[MSG_REPLACETEXT], [AReplaceText]);
  nW := AEditorRect.Right - AEditorRect.Left;
  nH := AEditorRect.Bottom - AEditorRect.Top;
  if nW <= Width then
    X := AEditorRect.Left - (Width - nW) div 2
  else begin
    if X + Width > AEditorRect.Right then
      X := AEditorRect.Right - Width;
  end;
  if Y2 > AEditorRect.Top + MulDiv(nH, 2, 3) then
    Y2 := Y1 - Height - 4
  else
    Inc(Y2, 4);
  SetBounds(X, Y2, Width, Height);
end;

end.
