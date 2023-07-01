unit DlgParam;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TParamDialog = class(TForm)
    Ok: TBitBtn;
    Cancel: TBitBtn;
    LabelInput: TLabel;
    Param: TEdit;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    procedure ChangeLanguageFile;
  end;

var
  ParamDialog: TParamDialog;

implementation

{$R *.dfm}

uses
  Globals, Language;

{ TParamDialog }

procedure TParamDialog.ChangeLanguageFile;
begin
  if not FileExists(LangPath) then
  begin
    MsgDlg(Format(Msgs[MSG_FILENOTEXISTS], [LangPath]), MB_ICONERROR + MB_OK);
    Exit;
  end;
  with TLanguageFile.Create(LangPath) do
  try
    Section := 'ParametersDialog';
    Self.Caption := LoadItem('DlgParamTitle');
    LabelInput.Caption := LoadItem('DlgParamInput');
    Ok.Caption := LoadItem('DlgParamOk');
    Cancel.Caption := LoadItem('DlgParamCancel');
  finally
    Free;
  end;
end;

procedure TParamDialog.FormCreate(Sender: TObject);
begin
  ChangeLanguageFile;
end;

end.
