unit DlgConfigEditor;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, JvColorCombo, SynEdit, JvCombobox, ExtCtrls, Mask,
  JvMaskEdit, JvSpin, ComCtrls, SynHighlighterUserEdit, JvExStdCtrls, JvExMask;

type
  TEditorDialog = class(TForm)
    Ok: TBitBtn;
    Cancel: TBitBtn;
    PageControl: TPageControl;
    General: TTabSheet;
    Display: TTabSheet;
    Colors: TTabSheet;
    GroupEditorOptions: TGroupBox;
    AutoIndent: TCheckBox;
    InsertMode: TCheckBox;
    TabsToSpaces: TCheckBox;
    SmallTabs: TCheckBox;
    HideSelection: TCheckBox;
    LabelExtraLineSpacing: TLabel;
    LabelUndoLimits: TLabel;
    LabelTabSize: TLabel;
    UndoAfterSave: TCheckBox;
    TrimSpaces: TCheckBox;
    DragDropEditing: TCheckBox;
    AltSetsColumn: TCheckBox;
    UseHighLight: TCheckBox;
    GroupFileOptions: TGroupBox;
    CreateBackup: TCheckBox;
    GroupMargins: TGroupBox;
    Margin: TCheckBox;
    Gutter: TCheckBox;
    LabelMarginSize: TLabel;
    LabelGutterSize: TLabel;
    LabelFontName: TLabel;
    SamplePanel: TPanel;
    LabelFontSize: TLabel;
    GroupAttributes: TGroupBox;
    BoldText: TCheckBox;
    ItalicText: TCheckBox;
    UnderlineText: TCheckBox;
    EditorItems: TListBox;
    LabelEditorItems: TLabel;
    LabelForeground: TLabel;
    LabelBackground: TLabel;
    EditSample: TSynEdit;
    LabelFontSample: TLabel;
    FontSize: TComboBox;
    ExtraLineSpacing: TJvSpinEdit;
    UndoLimits: TJvSpinEdit;
    TabSize: TJvSpinEdit;
    MarginSize: TJvSpinEdit;
    GutterSize: TJvSpinEdit;
    FontName: TJvFontComboBox;
    Foreground: TJvColorComboBox;
    Background: TJvColorComboBox;
    EndLineFormat: TCheckBox;
    procedure EditorItemsClick(Sender: TObject);
    procedure ForegroundChange(Sender: TObject);
    procedure BackgroundChange(Sender: TObject);
    procedure BoldTextClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FontNameChange(Sender: TObject);
    procedure FontSizeChange(Sender: TObject);
    procedure OkClick(Sender: TObject);
  private
    FHighlighter: TSynUserEditSyn;
  public
    procedure ChangeLanguageFile;
    procedure SetValues(Highlighter: TSynUserEditSyn);
    procedure GetValues(Highlighter: TSynUserEditSyn);
  end;

var
  EditorDialog: TEditorDialog;

implementation

{$R *.DFM}

uses
  Globals, Language;

procedure TEditorDialog.EditorItemsClick(Sender: TObject);
begin
  with FHighlighter do
    case EditorItems.ItemIndex of
      0: begin
           Foreground.ColorValue := SpaceAttri.Foreground;
           Background.ColorValue := SpaceAttri.Background;
           BoldText.Checked := fsBold in SpaceAttri.Style;
           ItalicText.Checked := fsItalic in SpaceAttri.Style;
           UnderlineText.Checked := fsUnderline in SpaceAttri.Style;
         end;
      1: begin
           Foreground.ColorValue := KeyAttri.Foreground;
           Background.ColorValue := KeyAttri.Background;
           BoldText.Checked := fsBold in KeyAttri.Style;
           ItalicText.Checked := fsItalic in KeyAttri.Style;
           UnderlineText.Checked := fsUnderline in KeyAttri.Style;
         end;
      2: begin
           Foreground.ColorValue := ReservedAttri.Foreground; // ver5
           Background.ColorValue := ReservedAttri.Background; // ver5
           BoldText.Checked := fsBold in ReservedAttri.Style; // ver5
           ItalicText.Checked := fsItalic in ReservedAttri.Style; // ver5
           UnderlineText.Checked := fsUnderline in ReservedAttri.Style; // ver5
         end;
      3: begin
           Foreground.ColorValue := SymbolAttri.Foreground;
           Background.ColorValue := SymbolAttri.Background;
           BoldText.Checked := fsBold in SymbolAttri.Style;
           ItalicText.Checked := fsItalic in SymbolAttri.Style;
           UnderlineText.Checked := fsUnderline in SymbolAttri.Style;
         end;
      4: begin
           Foreground.ColorValue := StringAttri.Foreground;
           Background.ColorValue := StringAttri.Background;
           BoldText.Checked := fsBold in StringAttri.Style;
           ItalicText.Checked := fsItalic in StringAttri.Style;
           UnderlineText.Checked := fsUnderline in StringAttri.Style;
         end;
      5: begin
           Foreground.ColorValue := NumberAttri.Foreground;
           Background.ColorValue := NumberAttri.Background;
           BoldText.Checked := fsBold in NumberAttri.Style;
           ItalicText.Checked := fsItalic in NumberAttri.Style;
           UnderlineText.Checked := fsUnderline in NumberAttri.Style;
         end;
      6: begin
           Foreground.ColorValue := IdentifierAttri.Foreground;
           Background.ColorValue := IdentifierAttri.Background;
           BoldText.Checked := fsBold in IdentifierAttri.Style;
           ItalicText.Checked := fsItalic in IdentifierAttri.Style;
           UnderlineText.Checked := fsUnderline in IdentifierAttri.Style;
         end;
      7: begin
           Foreground.ColorValue := CommentAttri.Foreground; // ver5
           Background.ColorValue := CommentAttri.Background; // ver5
           BoldText.Checked := fsBold in CommentAttri.Style; // ver5
           ItalicText.Checked := fsItalic in CommentAttri.Style; // ver5
           UnderlineText.Checked := fsUnderline in CommentAttri.Style; // ver5
         end;
    end;
end;

procedure TEditorDialog.ForegroundChange(Sender: TObject);
begin
  with FHighlighter do
    case EditorItems.ItemIndex of
      0: SpaceAttri.Foreground := Foreground.ColorValue;
      1: KeyAttri.Foreground := Foreground.ColorValue;
      2: ReservedAttri.Foreground := Foreground.ColorValue; // ver5
      3: SymbolAttri.Foreground := Foreground.ColorValue;
      4: StringAttri.Foreground := Foreground.ColorValue;
      5: NumberAttri.Foreground := Foreground.ColorValue;
      6: IdentifierAttri.Foreground := Foreground.ColorValue;
      7: CommentAttri.Foreground := Foreground.ColorValue;
    end;
end;

procedure TEditorDialog.BackgroundChange(Sender: TObject);
begin
  with FHighlighter do
    case EditorItems.ItemIndex of
      0: SpaceAttri.Background := Background.ColorValue;
      1: KeyAttri.Background := Background.ColorValue;
      2: ReservedAttri.Background := Background.ColorValue; // ver5
      3: SymbolAttri.Background := Background.ColorValue;
      4: StringAttri.Background := Background.ColorValue;
      5: NumberAttri.Background := Background.ColorValue;
      6: IdentifierAttri.Background := Background.ColorValue;
      7: IdentifierAttri.Background := Background.ColorValue;
    end;
end;

procedure TEditorDialog.BoldTextClick(Sender: TObject);
var
  Style: TFontStyles;
begin
  Style := [];
  if BoldText.Checked then Include(Style, fsBold);
  if ItalicText.Checked then Include(Style, fsItalic);
  if UnderlineText.Checked then Include(Style, fsUnderline);
  with FHighlighter do
    case EditorItems.ItemIndex of
      0: SpaceAttri.Style := Style;
      1: KeyAttri.Style := Style;
      2: ReservedAttri.Style := Style; // ver5
      3: SymbolAttri.Style := Style;
      4: StringAttri.Style := Style;
      5: NumberAttri.Style := Style;
      6: IdentifierAttri.Style := Style;
      7: CommentAttri.Style := Style;
    end;
end;

procedure TEditorDialog.FormShow(Sender: TObject);
begin
  AutoIndent.Checked := eAutoIndent;
  InsertMode.Checked := eInsertMode;
  TabsToSpaces.Checked := eTabsToSpaces;
  SmallTabs.Checked := eSmallTabs;
  HideSelection.Checked := eHideSelection;
  UndoAfterSave.Checked := eUndoAfterSave;
  TrimSpaces.Checked := eTrimSpaces;
  DragDropEditing.Checked := eDragDropEditing;
  AltSetsColumn.Checked := eAltSetsColumn;
  UseHighLight.Checked := eUseHighlight;
  ExtraLineSpacing.Value := eExtraLineSpacing;
  UndoLimits.Value := eMaxUndos;
  TabSize.Value := eTabSize;
  CreateBackup.Checked := eCreateBackup;
  EndLineFormat.Checked := eEndLineFormat;
  Margin.Checked := eMarginVisible;
  Gutter.Checked := eGutterVisible;
  MarginSize.Value := eMarginSize;
  GutterSize.Value := eGutterSize;
  FontName.FontName := eFontEditor;
  FontSize.Text := IntToStr(eFontEditorSize);
  SamplePanel.Font.Name := FontName.FontName;
  SamplePanel.Font.Size := StrToInt(FontSize.Text);
end;

procedure TEditorDialog.FormCreate(Sender: TObject);
begin
  FHighlighter := TSynUserEditSyn.Create(nil);
  EditSample.Highlighter := FHighlighter;
  ChangeLanguageFile;
end;

procedure TEditorDialog.FontNameChange(Sender: TObject);
begin
  SamplePanel.Font.Name := FontName.FontName;
end;

procedure TEditorDialog.FontSizeChange(Sender: TObject);
begin
  SamplePanel.Font.Size := StrToInt(FontSize.Text);
end;

procedure TEditorDialog.OkClick(Sender: TObject);
begin
    eAutoIndent := AutoIndent.Checked;
    eInsertMode := InsertMode.Checked;
    eTabsToSpaces := TabsToSpaces.Checked;
    eSmallTabs := SmallTabs.Checked;
    eHideSelection := HideSelection.Checked;
    eUndoAfterSave := UndoAfterSave.Checked;
    eTrimSpaces := TrimSpaces.Checked;
    eDragDropEditing := DragDropEditing.Checked;
    eAltSetsColumn := AltSetsColumn.Checked;
    eUseHighlight := UseHighLight.Checked;
    eExtraLineSpacing := ExtraLineSpacing.AsInteger;
    eMaxUndos := UndoLimits.AsInteger;
    eTabSize := TabSize.AsInteger;
    eCreateBackup := CreateBackup.Checked;
    eEndLineFormat := EndLineFormat.Checked;
    eMarginVisible := Margin.Checked;
    eGutterVisible := Gutter.Checked;
    eMarginSize := MarginSize.AsInteger;
    eGutterSize := GutterSize.AsInteger;
    eFontEditor := FontName.FontName;
    eFontEditorSize := StrToInt(FontSize.Text);
end;

procedure TEditorDialog.GetValues(Highlighter: TSynUserEditSyn);
begin
  Highlighter.Assign(FHighlighter);
end;

procedure TEditorDialog.SetValues(Highlighter: TSynUserEditSyn);
begin
  FHighlighter.Assign(Highlighter);
  FHighlighter.KeyWords.Assign(Highlighter.KeyWords);
end;

procedure TEditorDialog.ChangeLanguageFile;
begin
  if not FileExists(LangPath) then
  begin
    MsgDlg(Format(Msgs[MSG_FILENOTEXISTS], [LangPath]), MB_ICONERROR + MB_OK);
    Exit;
  end;
  with TLanguageFile.Create(LangPath) do
  try
    Section := 'ConfigEditorDialog';
    Self.Caption := LoadItem('DlgConfigEditorTitle');
    General.Caption := LoadItem('DlgConfigEditorGeneral');
    GroupEditorOptions.Caption := LoadItem('DlgConfigEditorEditorOptions');
    AutoIndent.Caption := LoadItem('DlgConfigEditorAutoIndent');
    InsertMode.Caption := LoadItem('DlgConfigEditorInsertMode');
    TabsToSpaces.Caption := LoadItem('DlgConfigEditorTabsToSpaces');
    SmallTabs.Caption := LoadItem('DlgConfigEditorSmartTabs');
    HideSelection.Caption := LoadItem('DlgConfigEditorHideSelection');
    UndoAfterSave.Caption := LoadItem('DlgConfigEditorUndoAfterSave');
    TrimSpaces.Caption := LoadItem('DlgConfigEditorTrimTrailingSpaces');
    DragDropEditing.Caption := LoadItem('DlgConfigEditorDragDropEditing');
    AltSetsColumn.Caption := LoadItem('DlgConfigEditorAltSetsColumnMode');
    UseHighLight.Caption := LoadItem('DlgConfigEditorUseHighlighter');
    LabelExtraLineSpacing.Caption := LoadItem('DlgConfigEditorExtraLineSpacing');
    LabelUndoLimits.Caption := LoadItem('DlgConfigEditorUndoLimits');
    LabelTabSize.Caption := LoadItem('DlgConfigEditorTabWidth');
    Display.Caption := LoadItem('DlgConfigEditorDisplay');
    GroupFileOptions.Caption := LoadItem('DlgConfigEditorFileOptions');
    CreateBackup.Caption := LoadItem('DlgConfigEditorCreateBackup');
    EndLineFormat.Caption := LoadItem('DlgConfigEditorLineEndFormat');
    GroupMargins.Caption := LoadItem('DlgConfigEditorMagins');
    Margin.Caption := LoadItem('DlgConfigEditorVisibleMargin');
    Gutter.Caption := LoadItem('DlgConfigEditorVisibleGutter');
    LabelMarginSize.Caption := LoadItem('DlgConfigEditorMarginSize');
    LabelGutterSize.Caption := LoadItem('DlgConfigEditorGutterSize');
    LabelFontName.Caption := LoadItem('DlgConfigEditorFontName');
    LabelFontSize.Caption := LoadItem('DlgConfigEditorFontSize');
    LabelFontSample.Caption := LoadItem('DlgConfigEditorFontExample');
    Colors.Caption := LoadItem('DlgConfigEditorColors');
    LabelEditorItems.Caption := LoadItem('DlgConfigEditorElements');
    EditorItems.Items[0] := LoadItem('DlgConfigEditorSpaces');
    EditorItems.Items[1] := LoadItem('DlgConfigEditorCommands');
    EditorItems.Items[2] := LoadItem('DlgConfigEditorReserved'); // ver5
    EditorItems.Items[3] := LoadItem('DlgConfigEditorSymbols');
    EditorItems.Items[4] := LoadItem('DlgConfigEditorAlgebraics');
    EditorItems.Items[5] := LoadItem('DlgConfigEditorNumbers');
    EditorItems.Items[6] := LoadItem('DlgConfigEditorText');
    EditorItems.Items[7] := LoadItem('DlgConfigEditorComment');
    LabelForeground.Caption := LoadItem('DlgConfigEditorForegroundColor');
    LabelBackground.Caption := LoadItem('DlgConfigEditorBackgroundColor');
    GroupAttributes.Caption := LoadItem('DlgConfigEditorTextAttributes');
    BoldText.Caption := LoadItem('DlgConfigEditorTextBold');
    ItalicText.Caption := LoadItem('DlgConfigEditorTextItalic');
    UnderlineText.Caption := LoadItem('DlgConfigEditorTextUnderline');
    Ok.Caption := LoadItem('DlgConfigEditorOk');
    Cancel.Caption := LoadItem('DlgConfigEditorCancel');
  finally
    Free;
  end;
end;

end.
