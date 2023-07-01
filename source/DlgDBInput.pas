unit DlgDBInput;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, JvLinkLabel, JvExControls;

type
  TInputForm = class(TForm)
    LinkLabel: TJvLinkLabel;
    Edit: TEdit;
    btnOk: TBitBtn;
    btnCancel: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    VarName: string;
    procedure ChangeLanguageFile;
  end;

var
  InputForm: TInputForm;

implementation

{$R *.dfm}

uses
  Language, Globals;

procedure TInputForm.ChangeLanguageFile;
begin
  if not FileExists(LangPath) then
  begin
    MsgDlg(Format(Msgs[MSG_FILENOTEXISTS], [LangPath]), MB_ICONERROR + MB_OK);
    Exit;
  end;
  with TLanguageFile.Create(LangPath) do
  try
    Section := 'BuilderInputDialog';
    Self.Caption := LoadItem('DlgBuilderInputTitle');
    btnOk.Caption := LoadItem('DlgBuilderInputOk');
    btnCancel.Caption := LoadItem('DlgBuilderInputCancel');
  finally
    Free;
  end;
end;

procedure TInputForm.FormCreate(Sender: TObject);
begin
  ChangeLanguageFile;
end;

procedure TInputForm.FormShow(Sender: TObject);
begin
  LinkLabel.Caption := Caps[LBL_INPUTVAR] + ' "<B>' + VarName + '</B>":';
end;

end.
