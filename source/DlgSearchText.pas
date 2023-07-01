unit DlgSearchText;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons;

type
  TSearchDialog = class(TForm)
    LabelSearch: TLabel;
    TextToSearch: TComboBox;
    GroupOptions: TGroupBox;
    GroupDirection: TGroupBox;
    Ok: TBitBtn;
    Cancel: TBitBtn;
    DirectionUp: TRadioButton;
    DirectionDown: TRadioButton;
    CaseSensitive: TCheckBox;
    WholeWords: TCheckBox;
    FromCursor: TCheckBox;
    SelectedOnly: TCheckBox;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    function GetSearchBackwards: boolean;
    function GetSearchCaseSensitive: boolean;
    function GetSearchFromCursor: boolean;
    function GetSearchInSelection: boolean;
    function GetSearchText: string;
    function GetSearchTextHistory: string;
    function GetSearchWholeWords: boolean;
    procedure SetSearchBackwards(Value: boolean);
    procedure SetSearchCaseSensitive(Value: boolean);
    procedure SetSearchFromCursor(Value: boolean);
    procedure SetSearchInSelection(Value: boolean);
    procedure SetSearchText(Value: string);
    procedure SetSearchTextHistory(Value: string);
    procedure SetSearchWholeWords(Value: boolean);
  public
    constructor Create(AOwner: TComponent); override;
    property SearchBackwards: boolean read GetSearchBackwards
      write SetSearchBackwards;
    property SearchCaseSensitive: Boolean read GetSearchCaseSensitive
      write SetSearchCaseSensitive;
    property SearchFromCursor: Boolean read GetSearchFromCursor
      write SetSearchFromCursor;
    property SearchInSelectionOnly: Boolean read GetSearchInSelection
      write SetSearchInSelection;
    property SearchText: string read GetSearchText write SetSearchText;
    property SearchTextHistory: string read GetSearchTextHistory
      write SetSearchTextHistory;
    property SearchWholeWords: boolean read GetSearchWholeWords
      write SetSearchWholeWords;
    procedure ChangeLanguageFile; virtual;
  end;

var
  SearchDialog: TSearchDialog;

implementation

{$R *.DFM}

uses
  Globals, Language;

{ TSearchDialog }

function TSearchDialog.GetSearchBackwards: boolean;
begin
  Result := DirectionUp.Checked;
end;

function TSearchDialog.GetSearchCaseSensitive: boolean;
begin
  Result := CaseSensitive.Checked;
end;

function TSearchDialog.GetSearchFromCursor: boolean;
begin
  Result := FromCursor.Checked;
end;

function TSearchDialog.GetSearchInSelection: boolean;
begin
  Result := SelectedOnly.Checked;
end;

function TSearchDialog.GetSearchText: string;
begin
  Result := TextToSearch.Text;
end;

function TSearchDialog.GetSearchTextHistory: string;
var
  I: Integer;
begin
  Result := '';
  for I := 0 to TextToSearch.Items.Count - 1 do
  begin
    if I >= 10 then Break;
    if I > 0 then
      Result := Result + #13#10;
    Result := Result + TextToSearch.Items[I];
  end;
end;

function TSearchDialog.GetSearchWholeWords: boolean;
begin
  Result := WholeWords.Checked;
end;

procedure TSearchDialog.SetSearchBackwards(Value: boolean);
begin
  DirectionUp.Checked := Value;
end;

procedure TSearchDialog.SetSearchCaseSensitive(Value: boolean);
begin
  CaseSensitive.Checked := Value;
end;

procedure TSearchDialog.SetSearchFromCursor(Value: boolean);
begin
  FromCursor.Checked := Value;
end;

procedure TSearchDialog.SetSearchInSelection(Value: boolean);
begin
  SelectedOnly.Checked := Value;
end;

procedure TSearchDialog.SetSearchText(Value: string);
begin
  TextToSearch.Text := Value;
end;

procedure TSearchDialog.SetSearchTextHistory(Value: string);
begin
  TextToSearch.Items.Text := Value;
end;

procedure TSearchDialog.SetSearchWholeWords(Value: boolean);
begin
  WholeWords.Checked := Value;
end;

procedure TSearchDialog.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
var
  s: string;
  I: Integer;
begin
  if ModalResult = mrOK then
  begin
    s := TextToSearch.Text;
    if s <> '' then
    begin
      I := TextToSearch.Items.IndexOf(s);
      if I > -1 then
      begin
        TextToSearch.Items.Delete(I);
        TextToSearch.Items.Insert(0, s);
        TextToSearch.Text := s;
      end else
        TextToSearch.Items.Insert(0, s);
    end;
  end;
end;

procedure TSearchDialog.ChangeLanguageFile;
begin
  if not FileExists(LangPath) then
  begin
    MsgDlg(Format(Msgs[MSG_FILENOTEXISTS], [LangPath]), MB_ICONERROR + MB_OK);
    Exit;
  end;
  with TLanguageFile.Create(LangPath) do
  try
    Section := 'SearchReplaceDialog';
    Self.Caption := LoadItem('DlgSearchTitle');
    LabelSearch.Caption := LoadItem('DlgSearchReplaceSearch');
    GroupOptions.Caption := LoadItem('DlgSearchReplaceOptions');
    CaseSensitive.Caption := LoadItem('DlgSearchReplaceCaseSensitive');
    WholeWords.Caption := LoadItem('DlgSearchReplaceWholeWords');
    FromCursor.Caption := LoadItem('DlgSearchReplaceFromCursor');
    SelectedOnly.Caption := LoadItem('DlgSearchReplaceSelectedOnly');
    GroupDirection.Caption := LoadItem('DlgSearchReplaceDirection');
    DirectionDown.Caption := LoadItem('DlgSearchReplaceDirectionDown');
    DirectionUp.Caption := LoadItem('DlgSearchReplaceDirectionUp');
    Ok.Caption := LoadItem('DlgSearchReplaceOk');
    Cancel.Caption := LoadItem('DlgSearchReplaceCancel');
  finally
    Free;
  end;
end;

constructor TSearchDialog.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ChangeLanguageFile;
end;

end.
