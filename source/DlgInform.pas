unit DlgInform;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, JvMaskEdit, JvSpin, Grids, GR32_Image, ExtCtrls, Buttons,
  JvExMask, JvExControls, JvComponent, JvgWizardHeader;

type
  TInformDialog = class(TForm)
    LabelTitle: TLabel;
    Title: TEdit;
    LabelField: TLabel;
    Ok: TBitBtn;
    Cancel: TBitBtn;
    Panel: TPanel;
    PaintBox: TPaintBox32;
    Fields: TStringGrid;
    GroupFormat: TGroupBox;
    LabelCol: TLabel;
    OffsetCheck: TCheckBox;
    Columns: TJvSpinEdit;
    Offset: TJvSpinEdit;
    Header: TJvgWizardHeader;
    btnAdd: TBitBtn;
    btnDelete: TBitBtn;
    chkCondition: TCheckBox;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure EditChange(Sender: TObject);
    procedure PaintBoxPaintBuffer(Sender: TObject);
    procedure OffsetCheckClick(Sender: TObject);
    procedure FieldsSetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: String);
    procedure OkClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
  private
    procedure DeleteRow(Index: Integer);
    procedure InsertRow(Index: Integer);
    function IsEmptyRow(Row: Integer): Boolean;
  public
    Param: string;
    procedure ChangeLanguageFile;
  end;

var
  InformDialog: TInformDialog;

implementation

{$R *.DFM}

uses
  Globals, Language;

procedure TInformDialog.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL, 0, 0);
  end
end;

procedure TInformDialog.InsertRow(Index: Integer);
var
  I, J: Integer;
begin
  Fields.RowCount := Fields.RowCount + 1;
  for I := Fields.RowCount - 1 downto Index + 2 do
    for J := 0 to 4 do
      Fields.Cells[J,I] := Fields.Cells[J,I - 1];
  for J := 0 to 4 do
    Fields.Cells[J,Index + 1] := '';
  Fields.Row := Index + 1;
end;

function TInformDialog.IsEmptyRow(Row: Integer): Boolean;
begin
  Result := (Fields.Cells[0,Row] = '') and (Fields.Cells[1,Row] = '') and
            (Fields.Cells[2,Row] = '') and (Fields.Cells[3,Row] = '') and
            (Fields.Cells[4,Row] = '');
end;

procedure TInformDialog.FormCreate(Sender: TObject);
begin
  ChangeLanguageFile;
end;

procedure TInformDialog.EditChange(Sender: TObject);
begin
  PaintBox.Invalidate;
end;

procedure TInformDialog.PaintBoxPaintBuffer(Sender: TObject);
var
  ARect: TRect;
  Flags, I, J, X, Y, Desp, Max, MaxW: Integer;
  s: string;
begin
  with PaintBox.Buffer.Canvas do
  begin
    Brush.Color := RGB(104, 145, 106);
    Rectangle(ClipRect);
    for I := 0 to 65 do
      for J := 0 to 3 do
        Rectangle(4 * I + 3, 4 * J + 19, 4 * I + 5, 4 * J + 21);
    for I := 0 to 64 do
      for J := 0 to 2 do
        Rectangle(4 * I + 5, 4 * J + 21, 4 * I + 7, 4 * J + 23);
    Font.Color := clBlack;
    Font.Name := 'Small Fonts';
    Font.Size := 11;
    Flags := DT_NOCLIP + DT_SINGLELINE + DT_VCENTER + DT_CENTER + DT_END_ELLIPSIS;
    ARect := Rect(7, 17, 261, 33);
    DrawText(Handle, PChar(Title.Text + ' '), -1, ARect, Flags);
    Font.Size := 11;
    Brush.Style := bsClear;
    Max := Fields.RowCount - 1;
    if Max > 4 * Columns.AsInteger then
      Max := 4 * Columns.AsInteger;
    MaxW := 265 div Columns.AsInteger;
    Desp := 3;
    if OffsetCheck.Checked then Desp := Offset.AsInteger;
    Desp := Desp * 10;
    J := 0;
    for I := 1 to Max do
      if TextWidth(Fields.Cells[0,I]) > J then
        J := TextWidth(Fields.Cells[0,I]);
    Desp := Desp + J;
    if Desp > MaxW - 20 then
      Desp := MaxW - 30;
    X := 1;
    Y := 1;
    Flags := DT_VCENTER + DT_LEFT + DT_NOCLIP + DT_SINGLELINE + DT_END_ELLIPSIS + DT_NOPREFIX;
    for I := 1 to Max do
    begin
      ARect := Rect((X - 1) * MaxW + 3, Y * 20 + 13, (X - 1) * MaxW + 3 + Desp, Y * 20 + 33);
      DrawText(Handle, PChar(Fields.Cells[0,I]), -1, ARect, Flags);
      ARect := Rect((X - 1) * MaxW + Desp + 5, Y * 20 + 13, X * MaxW - 6, Y * 20 + 33);
      if I = Fields.Row then
      begin
        Brush.Color := clBlack;
        FillRect(ARect);
        Brush.Style := bsClear;
        Font.Color := RGB(104, 145, 106);
      end;
      s := Fields.Cells[4,I];
      if (s <> '') and (s <> 'NOVAL') then
      begin
        Font.Size := 14;
        DrawText(Handle, PChar(s), -1, ARect, Flags);
        Font.Size := 11;
      end;
      Font.Color := clBlack;
      if I = Fields.Row then
      begin
        ARect := Rect(2, 120, 265, 128);
        DrawText(Handle, PChar(Fields.Cells[1,I]), -1, ARect, Flags);
      end;
      Inc(X);
      if X > Columns.AsInteger then
      begin
        X := 1;
        Inc(Y);
      end;
    end;
    Font.Color := RGB(104, 145, 106);
    Font.Size := 11;
    Brush.Color := clBlack;
    Flags := DT_CENTER + DT_SINGLELINE + DT_NOCLIP;
    for I := 0 to 5 do
      FillRect(Rect(44 * I + 3, 133, 44 * (I + 1) + 1, 147));
    Brush.Style := bsClear;
    ARect := Rect(3, 131, 45, 145);
    DrawText(Handle, 'EDIT', -1, ARect, Flags);
    ARect := Rect(179, 131, 221, 145);
    DrawText(Handle, '(AN(L', -1, ARect, Flags);
    ARect := Rect(223, 131, 265, 145);
    DrawText(Handle, 'OK', -1, ARect, Flags);
  end;
end;

procedure TInformDialog.OffsetCheckClick(Sender: TObject);
begin
  Offset.Enabled := OffsetCheck.Checked;
  PaintBox.Invalidate;
end;

procedure TInformDialog.FieldsSetEditText(Sender: TObject; ACol,
  ARow: Integer; const Value: String);
begin
  PaintBox.Invalidate;
end;

procedure TInformDialog.OkClick(Sender: TObject);

function IsEmptyCol(Col: Integer): Boolean;
var
  I: Integer;
begin
  Result := True;
  for I := 1 to Fields.RowCount - 1 do
    Result := Result and (Fields.Cells[Col,I] = '');
end;

var
  I: Integer;
begin
  Param := '"' + Title.Text + '"' + NewLine + '{' + NewLine;
  for I := 1 to Fields.RowCount - 1 do
    if Fields.Cells[1,I] <> '' then
      Param := Param + '{ ' + '"' + Fields.Cells[0,I] + '" "' + Fields.Cells[1,I] + '" ' + Fields.Cells[2,I] + ' }' + NewLine
    else
      Param := Param + '"' + Fields.Cells[0,I] + '"' + NewLine;
  Param := Param + '}' + NewLine;
  if OffsetCheck.Checked then
    Param := Param + '{ ' + Columns.Text + ' ' + Offset.Text + ' }' + NewLine
  else
    Param := Param + Columns.Text + NewLine;
  if IsEmptyCol(3) then
    Param := Param + '{ }' + NewLine
  else
    begin
      Param := Param + '{ ';
      for I := 1 to Fields.RowCount - 1 do
        if Fields.Cells[3,I] = '' then
          Param := Param + 'NOVAL '
        else
          Param := Param + Fields.Cells[3,I] + ' ';
      Param := Param + '}' + NewLine;
    end;
  if IsEmptyCol(4) then
    Param := Param + '{ }' + NewLine
  else
    begin
      Param := Param + '{ ';
      for I := 1 to Fields.RowCount - 1 do
        if Fields.Cells[4,I] = '' then
          Param := Param + 'NOVAL '
        else
          Param := Param + Fields.Cells[4,I] + ' ';
      Param := Param + '}' + NewLine;
    end;
  Param := Param + 'INFORM';
  if chkCondition.Checked then
    Param := Param + NewLine + 'IF' + NewLine + 'THEN' + NewLine + '  |' + NewLine + 'ELSE' + NewLine + 'END'
  else
    Param := Param + '|';
end;

procedure TInformDialog.btnAddClick(Sender: TObject);
begin
  if Fields.Row = Fields.RowCount - 1 then // ver5
    (InsertRow(Fields.Row)); // ver5
  PaintBox.Invalidate; // ver5
end;

procedure TInformDialog.btnDeleteClick(Sender: TObject);
begin
  if IsEmptyRow(Fields.Row) and (Fields.Row <> 1) then // ver5
    DeleteRow(Fields.Row); // ver5
  PaintBox.Invalidate; // ver5
end;

procedure TInformDialog.ChangeLanguageFile;
begin
  if not FileExists(LangPath) then
  begin
    MsgDlg(Format(Msgs[MSG_FILENOTEXISTS], [LangPath]), MB_ICONERROR + MB_OK);
    Exit;
  end;
  with TLanguageFile.Create(LangPath) do
  try
    Section := 'InformDialog';
    Self.Caption := LoadItem('DlgInformTitle');
    Header.Captions.Text := LoadItem('DlgInformHeaderTitle');
    Header.Comments.Text := LoadItem('DlgInformHeaderDescription');
    LabelTitle.Caption := LoadItem('DlgInformLabelTitle');
    GroupFormat.Caption := LoadItem('DlgInformFormat');
    LabelCol.Caption := LoadItem('DlgInformLabelColumns');
    OffsetCheck.Caption := LoadItem('DlgInformWidth');
    LabelField.Caption := LoadItem('DlgInformFieldTitle');
    Fields.Cells[0,0] := LoadItem('DlgInformFieldName');
    Fields.Cells[1,0] := LoadItem('DlgInformFieldHelp');
    Fields.Cells[2,0] := LoadItem('DlgInformFieldObject');
    Fields.Cells[3,0] := LoadItem('DlgInformFieldReset');
    Fields.Cells[4,0] := LoadItem('DlgInformFieldDefault');
    btnAdd.Caption := LoadItem('DlgInformAdd'); // ver5
    btnDelete.Caption := LoadItem('DlgInformDelete'); // ver5
    Ok.Caption := LoadItem('DlgInformOk');
    Cancel.Caption := LoadItem('DlgInformCancel');
  finally
    Free;
  end;
end;

procedure TInformDialog.DeleteRow(Index: Integer);
var
  I, J: Integer;
begin
  for I := Index to Fields.RowCount - 2 do
    for J := 0 to 4 do
      Fields.Cells[J,I] := Fields.Cells[J,I + 1];
  Fields.RowCount := Fields.RowCount - 1;
  Fields.Row := Index - 1;
end;

end.
