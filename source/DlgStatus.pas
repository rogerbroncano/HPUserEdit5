unit DlgStatus;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls;

type
  TStatusDialog = class(TForm)
    FileSource: TPanel;
    FileTarget: TPanel;
    LabelAs: TLabel;
    procedure FormPaint(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    procedure SetStatus(Title, FileName, NewName: string);
    procedure ChangeLanguageFile;
  end;

var
  StatusDialog: TStatusDialog;

implementation

{$R *.dfm}

uses
  Globals, Language;

{ TDialogStatus }

procedure TStatusDialog.SetStatus(Title, FileName, NewName: string);
begin
  Caption := Title;
  FileSource.Caption := FileName;
  FileTarget.Caption := NewName;
  Update;
end;

procedure TStatusDialog.FormPaint(Sender: TObject);
var
  R: TRect;
begin
  R := ClientRect;
  DrawEdge(Canvas.Handle, R, EDGE_RAISED, BF_RECT or BF_ADJUST);
  R.Bottom := R.Top + GetSystemMetrics(SM_CYCAPTION);
  DrawCaption(Self.Handle, Canvas.Handle, R, DC_ACTIVE or DC_TEXT or DC_GRADIENT);
end;

procedure TStatusDialog.ChangeLanguageFile;
begin
  if not FileExists(LangPath) then
  begin
    MsgDlg(Format(Msgs[MSG_FILENOTEXISTS], [LangPath]), MB_ICONERROR + MB_OK);
    Exit;
  end;
  with TLanguageFile.Create(LangPath) do
  try
    Section := 'StatusDialog';
    LabelAs.Caption := LoadItem('DlgStatusLabelAs');
  finally
    Free;
  end;
end;

procedure TStatusDialog.FormCreate(Sender: TObject);
begin
  ChangeLanguageFile;
end;

end.
