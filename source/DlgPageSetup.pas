unit DlgPageSetup;

{$I SynEdit.inc}

interface

uses
  Windows, SysUtils, Classes, Graphics, Forms, Controls, Dialogs, ActnList,
  ImgList, StdCtrls, Buttons, TB2Item, TBX, TB2Dock, TB2Toolbar, JvExControls,
  JvComponent, JvColorBox, JvColorButton, ComCtrls, ExtCtrls, Mask, JvExMask,
  JvSpin, SynEditPrintTypes, SynEditPrint, SynEditPrintMargins,
  SynEditPrintHeaderFooter, TBXGraphics;

type
  TPageDialog = class(TForm)
    PageControl: TPageControl;
    Margins: TTabSheet;
    HeaderFooter: TTabSheet;
    LabelLeft: TLabel;
    LabelRight: TLabel;
    LabelTop: TLabel;
    LabelBottom: TLabel;
    LabelUnits: TLabel;
    LabelHeader: TLabel;
    LabelFooter: TLabel;
    LabelInternalMargin: TLabel;
    LabelLeftIndent: TLabel;
    LabelRightIndent: TLabel;
    LabelGutter: TLabel;
    MirrorMargin: TCheckBox;
    Units: TComboBox;
    GroupHeader: TGroupBox;
    HeaderLeft: TRichEdit;
    HeaderCenter: TRichEdit;
    HeaderRight: TRichEdit;
    HeaderMirror: TCheckBox;
    LabelLeftHeader: TLabel;
    LabelCenterHeader: TLabel;
    LabelRightHeader: TLabel;
    GroupHeaderView: TGroupBox;
    HeaderLine: TCheckBox;
    HeaderBox: TCheckBox;
    HeaderShadow: TCheckBox;
    GroupFooter: TGroupBox;
    LabelLeftFooter: TLabel;
    LabelCenterFooter: TLabel;
    LabelRightFooter: TLabel;
    FooterLeft: TRichEdit;
    FooterCenter: TRichEdit;
    FooterRight: TRichEdit;
    FooterMirror: TCheckBox;
    GroupFooterView: TGroupBox;
    FooterLine: TCheckBox;
    FooterBox: TCheckBox;
    FooterShadow: TCheckBox;
    ActionList: TActionList;
    PageNumCmd: TAction;
    PagesCmd: TAction;
    TimeCmd: TAction;
    DateCmd: TAction;
    FontCmd: TAction;
    BoldCmd: TAction;
    ItalicCmd: TAction;
    UnderlineCmd: TAction;
    LineNumbers: TCheckBox;
    LineNumbersInMargin: TCheckBox;
    PrintHighlight: TCheckBox;
    PrintColors: TCheckBox;
    PrintWrap: TCheckBox;
    FontDialog: TFontDialog;
    TitleCmd: TAction;
    Ok: TBitBtn;
    Cancel: TBitBtn;
    TBXDock: TTBXDock;
    Toolbar: TTBXToolbar;
    TBXItem1: TTBXItem;
    TBXItem2: TTBXItem;
    TBXItem3: TTBXItem;
    TBXItem4: TTBXItem;
    TBXItem5: TTBXItem;
    TBXSeparatorItem1: TTBXSeparatorItem;
    TBXItem6: TTBXItem;
    TBXSeparatorItem2: TTBXSeparatorItem;
    TBXItem7: TTBXItem;
    TBXItem8: TTBXItem;
    TBXItem9: TTBXItem;
    LeftMargin: TJvSpinEdit;
    RightMargin: TJvSpinEdit;
    TopMargin: TJvSpinEdit;
    BottomMargin: TJvSpinEdit;
    GutterSize: TJvSpinEdit;
    HeaderMargin: TJvSpinEdit;
    FooterMargin: TJvSpinEdit;
    InternalMargin: TJvSpinEdit;
    LeftTextIndent: TJvSpinEdit;
    RightTextIndent: TJvSpinEdit;
    Panel: TPanel;
    Image: TImage;
    HeaderLineColor: TJvColorButton;
    LabelHeaderLineColor: TLabel;
    HeaderShadowColor: TJvColorButton;
    LabelHeaderShadowColor: TLabel;
    LabelFooterLineColor: TLabel;
    FooterLineColor: TJvColorButton;
    LabelFooterShadowColor: TLabel;
    FooterShadowColor: TJvColorButton;
    Printer: TButton;
    PrinterSetupDialog: TPrinterSetupDialog;
    TBXImageList: TTBXImageList;
    procedure PageNumCmdExecute(Sender: TObject);
    procedure PagesCmdExecute(Sender: TObject);
    procedure TimeCmdExecute(Sender: TObject);
    procedure DateCmdExecute(Sender: TObject);
    procedure FontCmdExecute(Sender: TObject);
    procedure BoldCmdExecute(Sender: TObject);
    procedure ItalicCmdExecute(Sender: TObject);
    procedure UnderlineCmdExecute(Sender: TObject);
    procedure HeaderLeftEnter(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure HeaderLeftSelectionChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure UnitsChange(Sender: TObject);
    procedure TitleCmdExecute(Sender: TObject);
    procedure ActionListUpdate(Action: TBasicAction; var Handled: Boolean);
    procedure PrinterClick(Sender: TObject);
  private
    Editor: TRichEdit;
    CharPos: TPoint;
    OldStart: Integer;
    FMargins: TSynEditPrintMargins;
    FInternalCall: Boolean;
    procedure UpdateCursorPos;
    procedure SelectLine(LineNum: Integer);
    function CurrText: TTextAttributes;
    procedure SetMargins(SynEditMargins: TSynEditPrintMargins);
    procedure GetMargins(SynEditMargins: TSynEditPrintMargins);
    procedure AddLines(HeadFoot: THeaderFooter; AEdit: TRichEdit;
      Al: TALignment);
    procedure SelectNone;
  public
    procedure ChangeLanguageFile;
    procedure SetValues(SynEditPrint: TSynEditPrint);
    procedure GetValues(SynEditPrint: TSynEditPrint);
  end;

var
  PageDialog: TPageDialog;

implementation

uses
  RichEdit, Messages, Globals, Language;

{$R *.DFM}

procedure TPageDialog.FormCreate(Sender: TObject);
begin
  FMargins := TSynEditPrintMargins.Create;
  FInternalCall := False;
  Editor := HeaderLeft;
  ChangeLanguageFile;
end;

procedure TPageDialog.FormDestroy(Sender: TObject);
begin
  FMargins.Free;
end;

procedure TPageDialog.FormShow(Sender: TObject);
begin
  UpdateCursorPos;
end;

procedure TPageDialog.HeaderLeftEnter(Sender: TObject);
begin
  Editor := Sender as TRichEdit;
end;

procedure TPageDialog.HeaderLeftSelectionChange(Sender: TObject);
begin
  UpdateCursorPos;
end;

procedure TPageDialog.UpdateCursorPos;
begin
  CharPos.Y := SendMessage(Editor.Handle, EM_EXLINEFROMCHAR, 0, Editor.SelStart);
  CharPos.X := (Editor.SelStart - SendMessage(Editor.Handle, EM_LINEINDEX, CharPos.Y, 0));
end;

procedure TPageDialog.SelectLine(LineNum: Integer);
begin
  OldStart := Editor.SelStart;
  Editor.SelStart := SendMessage(Editor.Handle, EM_LINEINDEX, LineNum, 0);
  Editor.SelLength := Length(Editor.Lines[LineNum]);
end;

procedure TPageDialog.SelectNone;
begin
  Editor.SelStart := OldStart;
  Editor.SelLength := 0;
end;

function TPageDialog.CurrText: TTextAttributes;
begin
  Result := Editor.SelAttributes;
end;

procedure TPageDialog.PageNumCmdExecute(Sender: TObject);
begin
  Editor.SelText := '$PAGENUM$';
end;

procedure TPageDialog.PagesCmdExecute(Sender: TObject);
begin
  Editor.SelText := '$PAGECOUNT$';
end;

procedure TPageDialog.TimeCmdExecute(Sender: TObject);
begin
  Editor.SelText := '$TIME$';
end;

procedure TPageDialog.DateCmdExecute(Sender: TObject);
begin
  Editor.SelText := '$DATE$';
end;

procedure TPageDialog.TitleCmdExecute(Sender: TObject);
begin
  Editor.SelText := '$TITLE$';
end;

procedure TPageDialog.FontCmdExecute(Sender: TObject);
begin
  SelectLine(CharPos.y);
  FontDialog.Font.Assign(CurrText);
  if FontDialog.Execute then
    CurrText.Assign(FontDialog.Font);
  SelectNone;
end;

procedure TPageDialog.BoldCmdExecute(Sender: TObject);
begin
  SelectLine(CharPos.y);
  if fsBold in CurrText.Style then
    CurrText.Style := CurrText.Style - [fsBold]
  else
    CurrText.Style := CurrText.Style + [fsBold];
  SelectNone;
end;

procedure TPageDialog.ItalicCmdExecute(Sender: TObject);
begin
  SelectLine(CharPos.y);
  if fsItalic in CurrText.Style then
    CurrText.Style := CurrText.Style - [fsItalic]
  else
    CurrText.Style := CurrText.Style + [fsItalic];
  SelectNone;
end;

procedure TPageDialog.UnderlineCmdExecute(Sender: TObject);
begin
  SelectLine(CharPos.y);
  if fsUnderLine in CurrText.Style then
    CurrText.Style := CurrText.Style - [fsUnderLine]
  else
    CurrText.Style := CurrText.Style + [fsUnderLine];
  SelectNone;
end;

procedure TPageDialog.GetMargins(SynEditMargins: TSynEditPrintMargins);
begin
  with SynEditMargins do
  begin
    if not FInternalCall then UnitSystem := TUnitSystem(Units.ItemIndex);
    Left := LeftMargin.Value;
    Right := RightMargin.Value;
    Top := TopMargin.Value;
    Bottom := BottomMargin.Value;
    Gutter := GutterSize.Value;
    Header := HeaderMargin.Value;
    Footer := FooterMargin.Value;
    LeftHFTextIndent := LeftTextIndent.Value;
    RightHFTextIndent := RightTextIndent.Value;
    HFInternalMargin := InternalMargin.Value;
    MirrorMargins := MirrorMargin.Checked;
  end;
end;

procedure TPageDialog.SetMargins(SynEditMargins: TSynEditPrintMargins);
begin
  with SynEditMargins do
  begin
    Units.ItemIndex := Ord(UnitSystem);
    LeftMargin.Value := Left;
    RightMargin.Value := Right;
    TopMargin.Value := Top;
    BottomMargin.Value := Bottom;
    GutterSize.Value := Gutter;
    HeaderMargin.Value := Header;
    FooterMargin.Value := Footer;
    LeftTextIndent.Value := LeftHFTextIndent;
    RightTextIndent.Value := RightHFTextIndent;
    InternalMargin.Value := HFInternalMargin;
    MirrorMargin.Checked := MirrorMargins;
  end;
end;

procedure TPageDialog.UnitsChange(Sender: TObject);
begin
  FInternalCall := True;
  GetMargins(FMargins);
  FInternalCall := False;
  FMargins.UnitSystem := TUnitSystem(Units.ItemIndex);
  SetMargins(FMargins);
end;

procedure TPageDialog.AddLines(HeadFoot: THeaderFooter; AEdit: TRichEdit;
  Al: TALignment);
var
  I: Integer;
  AFont: TFont;
begin
  Editor := AEdit;
  AFont := TFont.Create;
  for I := 0 to Editor.Lines.Count - 1 do
  begin
    SelectLine(I);
    AFont.Assign(CurrText);
    HeadFoot.Add(Editor.Lines[I], AFont, Al, I + 1);
  end;
  AFont.Free;
end;

procedure TPageDialog.GetValues(SynEditPrint: TSynEditPrint);
begin
  GetMargins(SynEditPrint.Margins);
  SynEditPrint.LineNumbers := LineNumbers.Checked;
  SynEditPrint.LineNumbersInMargin := LineNumbersInMargin.Checked;
  SynEditPrint.Highlight := PrintHighlight.Checked;
  SynEditPrint.Colors := PrintColors.Checked;
  SynEditPrint.Wrap := PrintWrap.Checked;

  SynEditPrint.Header.FrameTypes := [];
  if HeaderLine.Checked then
    SynEditPrint.Header.FrameTypes := SynEditPrint.Header.FrameTypes + [ftLine];
  if HeaderBox.Checked then
    SynEditPrint.Header.FrameTypes := SynEditPrint.Header.FrameTypes + [ftBox];
  if HeaderShadow.Checked then
    SynEditPrint.Header.FrameTypes := SynEditPrint.Header.FrameTypes + [ftShaded];
  SynEditPrint.Header.LineColor := HeaderLineColor.Color;
  SynEditPrint.Header.ShadedColor := HeaderShadowColor.Color;
  SynEditPrint.Header.MirrorPosition := HeaderMirror.Checked;

  SynEditPrint.Footer.FrameTypes := [];
  if FooterLine.Checked then
    SynEditPrint.Footer.FrameTypes := SynEditPrint.Footer.FrameTypes + [ftLine];
  if FooterBox.Checked then
    SynEditPrint.Footer.FrameTypes := SynEditPrint.Footer.FrameTypes + [ftBox];
  if FooterShadow.Checked then
    SynEditPrint.Footer.FrameTypes := SynEditPrint.Footer.FrameTypes + [ftShaded];
  SynEditPrint.Footer.LineColor := FooterLineColor.Color;
  SynEditPrint.Footer.ShadedColor := FooterShadowColor.Color;
  SynEditPrint.Footer.MirrorPosition := FooterMirror.Checked;

  SynEditPrint.Header.Clear;
  AddLines(SynEditPrint.Header, HeaderLeft, taLeftJustify);
  AddLines(SynEditPrint.Header, HeaderCenter, taCenter);
  AddLines(SynEditPrint.Header, HeaderRight, taRightJustify);

  SynEditPrint.Footer.Clear;
  AddLines(SynEditPrint.Footer, FooterLeft, taLeftJustify);
  AddLines(SynEditPrint.Footer, FooterCenter, taCenter);
  AddLines(SynEditPrint.Footer, FooterRight, taRightJustify);
end;

procedure TPageDialog.SetValues(SynEditPrint: TSynEditPrint);
var
  I: Integer;
  AItem: THeaderFooterItem;
  LNum: Integer;
begin
  HeaderLeft.Lines.Clear;
  HeaderCenter.Lines.Clear;
  HeaderRight.Lines.Clear;
  FooterLeft.Lines.Clear;
  FooterCenter.Lines.Clear;
  FooterRight.Lines.Clear;
  SetMargins(SynEditPrint.Margins);
  LineNumbers.Checked := SynEditPrint.LineNumbers;
  LineNumbersInMargin.Checked := SynEditPrint.LineNumbersInMargin;
  PrintHighlight.Checked := SynEditPrint.Highlight;
  PrintColors.Checked := SynEditPrint.Colors;
  PrintWrap.Checked := SynEditPrint.Wrap;

  HeaderLeft.Font := SynEditPrint.Header.DefaultFont;
  HeaderCenter.Font := SynEditPrint.Header.DefaultFont;
  HeaderRight.Font := SynEditPrint.Header.DefaultFont;
  FooterLeft.Font := SynEditPrint.Footer.DefaultFont;
  FooterCenter.Font := SynEditPrint.Footer.DefaultFont;
  FooterRight.Font := SynEditPrint.Footer.DefaultFont;

  HeaderLine.Checked := ftLine in SynEditPrint.Header.FrameTypes;
  HeaderBox.Checked := ftBox in SynEditPrint.Header.FrameTypes;
  HeaderShadow.Checked := ftShaded in SynEditPrint.Header.FrameTypes;
  HeaderLineColor.Color := SynEditPrint.Header.LineColor;
  HeaderShadowColor.Color := SynEditPrint.Header.ShadedColor;
  HeaderMirror.Checked := SynEditPrint.Header.MirrorPosition;

  FooterLine.Checked := ftLine in SynEditPrint.Footer.FrameTypes;
  FooterBox.Checked := ftBox in SynEditPrint.Footer.FrameTypes;
  FooterShadow.Checked := ftShaded in SynEditPrint.Footer.FrameTypes;
  FooterLineColor.Color := SynEditPrint.Footer.LineColor;
  FooterShadowColor.Color := SynEditPrint.Footer.ShadedColor;
  FooterMirror.Checked := SynEditPrint.Footer.MirrorPosition;

  SynEditPrint.Header.FixLines;
  for I := 0 to SynEditPrint.Header.Count - 1 do
  begin
    AItem := SynEditPrint.Header.Get(I);
    case AItem.Alignment of
      taLeftJustify: Editor := HeaderLeft;
      taCenter: Editor := HeaderCenter;
      taRightJustify: Editor := HeaderRight;
    end;
    LNum := Editor.Lines.Add(AItem.Text);
    SelectLine(LNum);
    CurrText.Assign(AItem.Font);
    SelectNone;
  end;

  SynEditPrint.Footer.FixLines;
  for I := 0 to SynEditPrint.Footer.Count - 1 do
  begin
    AItem := SynEditPrint.Footer.Get(I);
    case AItem.Alignment of
      taLeftJustify: Editor := FooterLeft;
      taCenter: Editor := FooterCenter;
      taRightJustify: Editor := FooterRight;
    end;
    LNum := Editor.Lines.Add(AItem.Text);
    SelectLine(LNum);
    CurrText.Assign(AItem.Font);
    SelectNone;
  end;
end;

procedure TPageDialog.ActionListUpdate(Action: TBasicAction;
  var Handled: Boolean);
begin
  PageNumCmd.Enabled := Editor.Focused;
  PagesCmd.Enabled := Editor.Focused;
  TimeCmd.Enabled := Editor.Focused;
  DateCmd.Enabled := Editor.Focused;
  TitleCmd.Enabled := Editor.Focused;
  FontCmd.Enabled := Editor.Focused;
  BoldCmd.Enabled := Editor.Focused;
  ItalicCmd.Enabled := Editor.Focused;
  UnderlineCmd.Enabled := Editor.Focused;
end;

procedure TPageDialog.ChangeLanguageFile;
begin
  if not FileExists(LangPath) then
  begin
    MsgDlg(Format(Msgs[MSG_FILENOTEXISTS], [LangPath]), MB_ICONERROR + MB_OK);
    Exit;
  end;
  with TLanguageFile.Create(LangPath) do
  try
    Section := 'PageSetupDialog';
    Self.Caption := LoadItem('DlgPageSetupTitle');
    Margins.Caption := LoadItem('DlgPageSetupMargins');
    LabelUnits.Caption := LoadItem('DlgPageSetupMarginUnits');
    Units.Items[0] := LoadItem('DlgPageSetupUnitsMillimeters');
    Units.Items[1] := LoadItem('DlgPageSetupUnitsCentimeters');
    Units.Items[2] := LoadItem('DlgPageSetupUnitsInches');
    Units.Items[3] := LoadItem('DlgPageSetupUnitsThousandthsOfInches');
    LabelLeft.Caption := LoadItem('DlgPageSetupLeftMargin');
    LabelRight.Caption := LoadItem('DlgPageSetupRightMargin');
    LabelTop.Caption := LoadItem('DlgPageSetupTopMargin');
    LabelBottom.Caption := LoadItem('DlgPageSetupBottomMargin');
    LabelGutter.Caption := LoadItem('DlgPageSetupGutterMargin');
    LabelHeader.Caption := LoadItem('DlgPageSetupHeaderMargin');
    LabelFooter.Caption := LoadItem('DlgPageSetupFooterMargin');
    LabelInternalMargin.Caption := LoadItem('DlgPageSetupInternalMargin');
    LabelLeftIndent.Caption := LoadItem('DlgPageSetupLeftHFTextIndent');
    LabelRightIndent.Caption := LoadItem('DlgPageSetupRightHFTextIndent');
    MirrorMargin.Caption := LoadItem('DlgPageSetupPrintMirrorMargins');
    LineNumbers.Caption := LoadItem('DlgPageSetupPrintLineNumbers');
    LineNumbersInMargin.Caption := LoadItem('DlgPageSetupPrintLineNumbersInMargin');
    PrintHighlight.Caption := LoadItem('DlgPageSetupPrintHighlight');
    PrintColors.Caption := LoadItem('DlgPageSetupPrintColors');
    PrintWrap.Caption := LoadItem('DlgPageSetupPrintWrap');
    HeaderFooter.Caption := LoadItem('DlgPageSetupHeaderFooter');
    PageNumCmd.Hint := LoadItem('DlgPageSetupPageNumberHint');
    PagesCmd.Hint := LoadItem('DlgPageSetupPagesHint');
    TimeCmd.Hint := LoadItem('DlgPageSetupTimeHint');
    DateCmd.Hint := LoadItem('DlgPageSetupDateHint');
    TitleCmd.Hint := LoadItem('DlgPageSetupTitleHint');
    FontCmd.Hint := LoadItem('DlgPageSetupFontHint');
    BoldCmd.Hint := LoadItem('DlgPageSetupBoldHint');
    ItalicCmd.Hint := LoadItem('DlgPageSetupItalicHint');
    UnderlineCmd.Hint := LoadItem('DlgPageSetupUnderlineHint');
    GroupHeader.Caption := LoadItem('DlgPageSetupHeaderTitle');
    LabelLeftHeader.Caption := LoadItem('DlgPageSetupHeaderLeft');
    LabelCenterHeader.Caption := LoadItem('DlgPageSetupHeaderCenter');
    LabelRightHeader.Caption := LoadItem('DlgPageSetupHeaderRight');
    GroupHeaderView.Caption := LoadItem('DlgPageSetupHeaderAppearance');
    HeaderLine.Caption := LoadItem('DlgPageSetupHeaderLine');
    LabelHeaderLineColor.Caption := LoadItem('DlgPageSetupHeaderLineColor');
    HeaderBox.Caption := LoadItem('DlgPageSetupHeaderBox');
    HeaderShadow.Caption := LoadItem('DlgPageSetupHeaderShadow');
    LabelHeaderShadowColor.Caption := LoadItem('DlgPageSetupHeaderShadowColor');
    HeaderMirror.Caption := LoadItem('DlgPageSetupHeaderMirror');
    GroupFooter.Caption := LoadItem('DlgPageSetupFooterTitle');
    LabelLeftFooter.Caption := LoadItem('DlgPageSetupFooterLeft');
    LabelCenterFooter.Caption := LoadItem('DlgPageSetupFooterCenter');
    LabelRightFooter.Caption := LoadItem('DlgPageSetupFooterRight');
    GroupFooterView.Caption := LoadItem('DlgPageSetupFooterAppearance');
    FooterLine.Caption := LoadItem('DlgPageSetupFooterLine');
    LabelFooterLineColor.Caption := LoadItem('DlgPageSetupFooterLineColor');
    FooterBox.Caption := LoadItem('DlgPageSetupFooterBox');
    FooterShadow.Caption := LoadItem('DlgPageSetupFooterShadow');
    LabelFooterShadowColor.Caption := LoadItem('DlgPageSetupFooterShadowColor');
    FooterMirror.Caption := LoadItem('DlgPageSetupFooterMirror');
    Printer.Caption := LoadItem('DlgPageSetupPrinter');
    Ok.Caption := LoadItem('DlgPageSetupOk');
    Cancel.Caption := LoadItem('DlgPageSetupCancel');
  finally
    Free;
  End;
end;

procedure TPageDialog.PrinterClick(Sender: TObject);
begin
  PrinterSetupDialog.Execute;
end;

end.

