unit DlgInput;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, GR32_Image, ExtCtrls, Mask, JvMaskEdit, JvSpin, Buttons, JvExMask,
  JvExControls, JvComponent, JvgWizardHeader;

type
  TInputDialog = class(TForm)
    LabelMessage: TLabel;
    LabelIntro: TLabel;
    Ok: TBitBtn;
    Cancel: TBitBtn;
    GroupFormat: TGroupBox;
    LabelRow: TLabel;
    LabelCol: TLabel;
    LabelMode: TLabel;
    Mode: TComboBox;
    Panel: TPanel;
    Title: TMemo;
    Intro: TMemo;
    FormatCheck: TCheckBox;
    Row: TJvSpinEdit;
    Col: TJvSpinEdit;
    PaintBox: TPaintBox32;
    Header: TJvgWizardHeader;
    procedure FormatCheckClick(Sender: TObject);
    procedure OkClick(Sender: TObject);
    procedure EditChange(Sender: TObject);
    procedure PaintBoxPaintBuffer(Sender: TObject);
    procedure IntroChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    Param: string;
    procedure ChangeLanguageFile;
  end;

var
  InputDialog: TInputDialog;

implementation

{$R *.DFM}

uses
  Globals, Language;

procedure TInputDialog.FormatCheckClick(Sender: TObject);
begin
  GroupFormat.Enabled := FormatCheck.Checked;
  PaintBoxPaintBuffer(Sender);
end;

procedure TInputDialog.OkClick(Sender: TObject);
const
  Modes: array [0..3] of string[3] = ('', 'Œ', 'ALG', 'V');
begin
  Param := '"' + Title.Text + '"' + NewLine;
  if FormatCheck.Checked then
    Param := Param + '{ "' + Intro.Text + '" { ' + Row.Text + ' ' +
             Col.Text + ' } ' + Modes[Mode.ItemIndex] + ' }' + NewLine
  else
    Param := Param + '"' + Intro.Text + '"' + NewLine;
  Param := Param + 'INPUT|';
end;

procedure TInputDialog.EditChange(Sender: TObject);
begin
  PaintBox.Invalidate;
end;

procedure TInputDialog.PaintBoxPaintBuffer(Sender: TObject);
var
  ARect: TRect;
  Flags, I, Max: Integer;
begin
  with PaintBox.Buffer.Canvas do
  begin
    Brush.Color := RGB(104, 145, 106);
    Rectangle(ClipRect);
    Brush.Style := bsClear;
    Font.Name := 'Small Fonts';
    Font.Size := 11;
    Flags := DT_LEFT + DT_NOCLIP + DT_SINGLELINE;
    ARect := Rect(1, 19, 200, 29);
    DrawText(Handle, 'DEG  XYZ  HEX    R         ''X''', -1, ARect, Flags);
    ARect := Rect(235, 19, 265, 29);
    DrawText(Handle, 'PRG', -1, ARect, Flags);
    ARect := Rect(1, 31, 264, 41);
    DrawText(Handle, '{HOME}', -1, ARect, Flags);
    Rectangle(3, 47, 265, 49);
    Font.Size := 12;
    ARect := Rect(107, 17, 117, 27);
    DrawText(Handle, '=', 1, ARect, Flags);
    Font.Size := 14;
    Flags := DT_LEFT + DT_NOCLIP + DT_END_ELLIPSIS + DT_NOPREFIX;
    Max := Title.Lines.Count;
    if Max > 5 then Max := 5;
    for I := 0 to Max - 1 do
    begin
      ARect := Rect(2, (I + 3) * 16 - 1, 264, (I + 3) * 16 + 8);
      DrawText(Handle, PChar(Title.Lines.Strings[I]), -1, ARect, Flags);
    end;
    Max := Intro.Lines.Count;
    if Max > 5 then Max := 5;
    Brush.Color := RGB(104, 145, 106);
    FillRect(Rect(2, 161 - (Max + 2) * 16, 264, 132));
    Brush.Style := bsClear;
    for I := 0 to Max - 1 do
    begin
      ARect := Rect(2, 159 - (I + 3) * 16, 264, 163 - (I + 3) * 16);
      DrawText(Handle, PChar(Intro.Lines.Strings[Max - 1 - I]), -1, ARect, Flags);
    end;
    Font.Size := 11;
    Flags := DT_LEFT + DT_NOCLIP + DT_SINGLELINE;
    if FormatCheck.Checked then
      case Mode.ItemIndex of
        1: begin
             Font.Name := 'Symbol';
             Font.Size := 16;
             ARect := Rect(109, -8, 121, 20);
             DrawText(Handle, 'a', 1, ARect, Flags);
           end;
        2: begin
             ARect := Rect(200, 19, 230, 29);
             DrawText(Handle, 'ALG', 3, ARect, Flags);
           end;
      end;
    Brush.Color := clBlack;
    for I := 0 to 5 do
      FillRect(Rect(44 * I + 3, 133, 44 * (I + 1) + 1, 147));
  end;
end;

procedure TInputDialog.IntroChange(Sender: TObject);
var
  Max, I: Integer;
begin
  Row.MaxValue := Intro.Lines.Count;
  Max := 0;
  for I := 0 to Intro.Lines.Count - 1 do
    if Length(Intro.Lines.Strings[I]) > Max then
      Max := Length(Intro.Lines.Strings[I]);
  Col.MaxValue := Max;
  PaintBox.Invalidate;
end;

procedure TInputDialog.ChangeLanguageFile;
begin
  if not FileExists(LangPath) then
  begin
    MsgDlg(Format(Msgs[MSG_FILENOTEXISTS], [LangPath]), MB_ICONERROR + MB_OK);
    Exit;
  end;
  with TLanguageFile.Create(LangPath) do
  try
    Section := 'InputDialog';
    Self.Caption := LoadItem('DlgInputTitle');
    Header.Captions.Text := LoadItem('DlgInputHeaderTitle');
    Header.Comments.Text := LoadItem('DlgInputHeaderDescription');
    LabelMessage.Caption := LoadItem('DlgInputMessage');
    LabelIntro.Caption := LoadItem('DlgInputCommandLine');
    FormatCheck.Caption := LoadItem('DlgInputFormat');
    LabelRow.Caption := LoadItem('DlgInputRow');
    LabelCol.Caption := LoadItem('DlgInputCol');
    LabelMode.Caption := LoadItem('DlgInputMode');
    Mode.Items[0] := LoadItem('DlgInputModeDefault');
    Mode.Items[1] := LoadItem('DlgInputModeAlphabetical');
    Mode.Items[2] := LoadItem('DlgInputModeAlgebraic');
    Mode.Items[3] := LoadItem('DlgInputModeCheckSyntax');
    Mode.ItemIndex := 0;
    Ok.Caption := LoadItem('DlgInputOk');
    Cancel.Caption := LoadItem('DlgInputCancel');
  finally
    Free;
  end;
end;

procedure TInputDialog.FormCreate(Sender: TObject);
begin
  ChangeLanguageFile;
end;

end.
