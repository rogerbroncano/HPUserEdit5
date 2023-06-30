unit DlgReplaceText;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DlgSearchText, StdCtrls, Buttons;

type
  TReplaceDialog = class(TSearchDialog)
    TextToReplace: TComboBox;
    LabelReplace: TLabel;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    function GetReplaceText: string;
    function GetReplaceTextHistory: string;
    procedure SetReplaceText(Value: string);
    procedure SetReplaceTextHistory(Value: string);
  public
    constructor Create(AOwner: Tcomponent); override;
    property ReplaceText: string read GetReplaceText write SetReplaceText;
    property ReplaceTextHistory: string read GetReplaceTextHistory
      write SetReplaceTextHistory;
    procedure ChangeLanguageFile; override;
  end;

var
  ReplaceDialog: TReplaceDialog;

implementation

{$R *.DFM}

uses
  Globals, Language;

{ TReplaceDialog }

function TReplaceDialog.GetReplaceText: string;
begin
  Result := TextToReplace.Text;
end;

function TReplaceDialog.GetReplaceTextHistory: string;
var
  I: Integer;
begin
  Result := '';
  for I := 0 to TextToReplace.Items.Count - 1 do
  begin
    if I >= 10 then Break;
    if I > 0 then
      Result := Result + #13#10;
    Result := Result + TextToReplace.Items[I];
  end;
end;

procedure TReplaceDialog.SetReplaceText(Value: string);
begin
  TextToReplace.Text := Value;
end;

procedure TReplaceDialog.SetReplaceTextHistory(Value: string);
begin
  TextToReplace.Items.Text := Value;
end;

procedure TReplaceDialog.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
var
  s: string;
  I: Integer;
begin
  inherited;
  if ModalResult = mrOK then
  begin
    s := TextToReplace.Text;
    if s <> '' then
    begin
      I := TextToReplace.Items.IndexOf(s);
      if I > -1 then
      begin
        TextToReplace.Items.Delete(I);
        TextToReplace.Items.Insert(0, s);
        TextToReplace.Text := s;
      end
      else
        TextToReplace.Items.Insert(0, s);
    end;
  end;
end;

procedure TReplaceDialog.ChangeLanguageFile;
begin
  inherited ChangeLanguageFile;
  with TLanguageFile.Create(LangPath) do
  try
    Section := 'SearchReplaceDialog';
    Self.Caption := LoadItem('DlgReplaceTitle');
    LabelReplace.Caption := LoadItem('DlgReplaceReplaceWith');
  finally
    Free;
  end;
end;

constructor TReplaceDialog.Create(AOwner: Tcomponent);
begin
  inherited Create(Owner);
end;

end.
