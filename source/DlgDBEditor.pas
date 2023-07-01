unit DlgDBEditor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TEditorForm = class(TForm)
    Title: TLabel;
    Edit: TEdit;
    btnOk: TBitBtn;
    btnCancel: TBitBtn;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    procedure ChangeLanguageFile;
  end;

var
  EditorForm: TEditorForm;

implementation

{$R *.dfm}

uses
  Language, Globals;

{ TEditorForm }

procedure TEditorForm.ChangeLanguageFile;
begin
  if not FileExists(LangPath) then
  begin
    MsgDlg(Format(Msgs[MSG_FILENOTEXISTS], [LangPath]), MB_ICONERROR + MB_OK);
    Exit;
  end;
  with TLanguageFile.Create(LangPath) do
  try
    Section := 'BuilderEditDialog';
    Self.Caption := LoadItem('DlgBuilderEditTitle');
    Title.Caption := LoadItem('DlgBuilderEditLabel');
    btnOk.Caption := LoadItem('DlgBuilderEditOk');
    btnCancel.Caption := LoadItem('DlgBuilderEditCancel');
  finally
    Free;
  end;
end;

procedure TEditorForm.FormCreate(Sender: TObject);
begin
  ChangeLanguageFile;
end;

end.
