unit DlgChoose;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Grids, ValEdit, GR32_Image, ExtCtrls, Mask, JvMaskEdit, JvSpin,
  Buttons, JvExMask, JvExControls, JvComponent, JvgWizardHeader;

type
  TChooseDialog = class(TForm)
    LabelTitle: TLabel;
    Title: TEdit;
    LabelList: TLabel;
    Ok: TBitBtn;
    Cancel: TBitBtn;
    LabelPosition: TLabel;
    Position: TJvSpinEdit;
    Panel: TPanel;
    Objects: TValueListEditor;
    PaintBox: TPaintBox32;
    Header: TJvgWizardHeader;
    btnAdd: TBitBtn;
    btnDelete: TBitBtn;
    chkCondition: TCheckBox;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure PaintBoxPaintBuffer(Sender: TObject);
    procedure EditChange(Sender: TObject);
    procedure ObjectsStringsChange(Sender: TObject);
    procedure OkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
  private
    { Private declarations }
  public
    Param: string;
    procedure ChangeLanguageFile;
  end;

var
  ChooseDialog: TChooseDialog;

implementation

{$R *.DFM}

uses
  Globals, Language;

procedure TChooseDialog.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL, 0, 0);
  end
end;

procedure TChooseDialog.PaintBoxPaintBuffer(Sender: TObject);
var
  ARect: TRect;
  Flags, I, J, K, Max, MaxL: Integer;
  Text: string;
begin
  with PaintBox.Buffer.Canvas do
  begin
    Brush.Color := RGB(104, 145, 106);
    Rectangle(ClipRect);
    Brush.Style := bsClear;
    Font.Color := clBlack;
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
    for I := 0 to 4 do
    begin
      ARect := Rect(2, (I + 3) * 16 - 1, 264, (I + 3) * 16 + 8);
      DrawText(Handle, PChar(IntToStr(5 - I) + ':'), -1, ARect, Flags);
    end;
    Max := Objects.Strings.Count;
    if Title.Text <> '' then Inc(Max);
    if Max > 5 then
    begin
      Max := 5;
      MaxL := 212;
    end
    else MaxL := 220;
    Pen.Width := 2;
    J := (110 - Max * 18) div 2;
    Rectangle(37, 20 + J, 226, 27 + J + Max * 18);
    Brush.Color := RGB(104, 145, 106);
    Rectangle(35, 18 + J, 224, 25 + J + Max * 18);
    Brush.Style := bsClear;
    K := 0;
    if Title.Text <> '' then
    begin
      Font.Size := 11;
      ARect := Rect(36, 17 + J + K * 18, 221, 17 + J + (K + 1) * 18);
      DrawText(Handle, PChar(Title.Text), -1, ARect, Flags);
      Rectangle(38, 34 + J + K * 18, 221, 35 + J + K * 18);
      Font.Size := 14;
      Dec(Max);
      Inc(K);
    end;
    for I := 1 to Max do
    begin
      Font.Color := clBlack;
      if I = Position.AsInteger then
      begin
        Brush.Color := clBlack;
        FillRect(Rect(39, 21 + J + K * 18, MaxL, 21 + J + (K + 1) * 18));
        Brush.Style := bsClear;
        Font.Color := RGB(104, 145, 106);
      end;
      ARect := Rect(38, 19 + J + K * 18, MaxL, 19 + J + (K + 1) * 18);
      Text := Objects.Cells[0,I];
      if Length(Text) > 0 then
        if Text[1] = '"' then Delete(Text, 1, 1);
      if Length(Text) > 0 then
        if Text[Length(Text)] = '"' then Delete(Text, Length(Text), 1);
      DrawText(Handle, PChar(Text), -1, ARect, Flags);
      Inc(K);
    end;
    if Objects.Strings.Count > Max then
      if Title.Text <> '' then
      begin
        Rectangle(215, 50, 220, 121);
        Rectangle(217, 51, 218, 51 + 70 div Objects.Strings.Count * 4);
      end
      else begin
        Rectangle(215, 32, 220, 121);
        Rectangle(217, 33, 218, 33 + 90 div Objects.Strings.Count * 5);
      end;
    Brush.Color := clBlack;
    for I := 0 to 5 do
      FillRect(Rect(44 * I + 3, 133, 44 * (I + 1) + 1, 147));
    Brush.Style := bsClear;
    Font.Color := RGB(104, 145, 106);
    Font.Size := 11;
    Flags := DT_CENTER + DT_SINGLELINE + DT_NOCLIP;
    ARect := Rect(179, 131, 221, 145);
    DrawText(Handle, '(AN(L', -1, ARect, Flags);
    ARect := Rect(223, 131, 265, 145);
    DrawText(Handle, 'OK', -1, ARect, Flags);
  end;
end;

procedure TChooseDialog.EditChange(Sender: TObject);
begin
  PaintBox.Invalidate;
end;

procedure TChooseDialog.ObjectsStringsChange(Sender: TObject);
begin
  Position.MaxValue := Objects.Strings.Count;
  PaintBox.Invalidate;
end;

procedure TChooseDialog.OkClick(Sender: TObject);
var
  I: Integer;
begin
  Param := '"' + Title.Text + '"' + NewLine + '{' + NewLine;
  For I := 1 to Objects.Strings.Count do
    if Objects.Cells[1,I] = '' then
      Param := Param + Objects.Cells[0,I] + NewLine
    else
      Param := Param + '{ "' + Objects.Cells[0,I] + '" «' +  Objects.Cells[1,I] + '» }' + NewLine;
  Param := Param + '}' + NewLine + Position.Text + NewLine + 'CHOOSE';
  if chkCondition.Checked then
    Param := Param + NewLine + 'IF' + NewLine + 'THEN' + NewLine + '  EVAL|' + NewLine + 'END'
  else
    Param := Param + '|';
end;

procedure TChooseDialog.FormCreate(Sender: TObject);
begin
  ChangeLanguageFile;
end;

procedure TChooseDialog.btnAddClick(Sender: TObject);
begin
  Objects.InsertRow('', '', True); // ver5
end;

procedure TChooseDialog.btnDeleteClick(Sender: TObject);
begin
  Objects.DeleteRow(Objects.Row); // ver5
end;

procedure TChooseDialog.ChangeLanguageFile;
begin
  if not FileExists(LangPath) then
  begin
    MsgDlg(Format(Msgs[MSG_FILENOTEXISTS], [LangPath]), MB_ICONERROR + MB_OK);
    Exit;
  end;
  with TLanguageFile.Create(LangPath) do
  try
    Section := 'ChooseDialog';
    Self.Caption := LoadItem('DlgChooseTitle');
    Header.Captions.Text := LoadItem('DlgChooseHeaderTitle');
    Header.Comments.Text := LoadItem('DlgChooseHeaderDescription');
    LabelTitle.Caption := LoadItem('DlgChooseLabelTitle');
    LabelPosition.Caption := LoadItem('DlgChooseLabelPosition');
    LabelList.Caption := LoadItem('DlgChooseLabelList');
    Objects.TitleCaptions[0] := LoadItem('DlgChooseObjectsShow');
    Objects.TitleCaptions[1] := LoadItem('DlgChooseObjectsReturn');
    btnAdd.Caption := LoadItem('DlgChooseAdd'); // ver5
    btnDelete.Caption := LoadItem('DlgChooseDelete'); // ver5
    chkCondition.Caption := LoadItem('DlgChooseConditional'); // ver5
    Ok.Caption := LoadItem('DlgChooseOk');
    Cancel.Caption := LoadItem('DlgChooseCancel');
  finally
    Free;
  end;
end;

end.
