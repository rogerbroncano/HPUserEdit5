unit DlgGotoLine;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Mask, JvMaskEdit, JvSpin, JvExMask;

type
  TGoToDialog = class(TForm)
    LabelGotoLine: TLabel;
    Ok: TBitBtn;
    Cancel: TBitBtn;
    LineNumber: TJvSpinEdit;
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    procedure ChangeLanguageFile;
  end;

var
  GoToDialog: TGoToDialog;

implementation

{$R *.DFM}

uses
  Globals, Language;

procedure TGoToDialog.ChangeLanguageFile;
begin
  if not FileExists(LangPath) then
  begin
    MsgDlg(Format(Msgs[MSG_FILENOTEXISTS], [LangPath]), MB_ICONERROR + MB_OK);
    Exit;
  end;
  with TLanguageFile.Create(LangPath) do
  try
    Section := 'GotoDialog';
    Self.Caption := LoadItem('DlgGotoTitle');
    LabelGotoLine.Caption := LoadItem('DlgGotoLine');
    Ok.Caption := LoadItem('DlgGotoOk');
    Cancel.Caption := LoadItem('DlgGotoCancel');
  finally
    Free;
  end;
end;

procedure TGoToDialog.FormActivate(Sender: TObject);
begin
  ActiveControl := LineNumber;
  LineNumber.SelectAll;
end;

end.
