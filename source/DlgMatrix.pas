unit DlgMatrix;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, Buttons, ExtCtrls, ActnList, TB2Item, TBX,
  ImgList, TB2Dock, TB2Toolbar, JvExControls, JvComponent, JvgWizardHeader,
  TBXStatusBars, AppEvnts, TBXGraphics;

type
  TMatrixDialog = class(TForm)
    Writer: TStringGrid;
    GroupType: TRadioGroup;
    GroupAdvance: TRadioGroup;
    TBXDock: TTBXDock;
    ActionList: TActionList;
    WidthDec: TAction;
    WidthInc: TAction;
    InsertRow: TAction;
    DeleteRow: TAction;
    InsertCol: TAction;
    DeleteCol: TAction;
    Header: TJvgWizardHeader;
    Toolbar: TTBXToolbar;
    TBXItem1: TTBXItem;
    TBXItem2: TTBXItem;
    TBXSeparatorItem1: TTBXSeparatorItem;
    TBXItem3: TTBXItem;
    TBXItem4: TTBXItem;
    TBXSeparatorItem2: TTBXSeparatorItem;
    TBXItem5: TTBXItem;
    TBXItem6: TTBXItem;
    TBXSeparatorItem3: TTBXSeparatorItem;
    TBXItem7: TTBXItem;
    TBXItem8: TTBXItem;
    InsertMat: TAction;
    CancelDlg: TAction;
    Panel: TPanel;
    ApplicationEvents: TApplicationEvents;
    StatusBar: TTBXStatusBar;
    TBXImageList: TTBXImageList;
    procedure WriterKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure WriterSetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: String);
    procedure WidthDecExecute(Sender: TObject);
    procedure WidthIncExecute(Sender: TObject);
    procedure InsertRowExecute(Sender: TObject);
    procedure DeleteRowExecute(Sender: TObject);
    procedure InsertColExecute(Sender: TObject);
    procedure DeleteColExecute(Sender: TObject);
    procedure InsertMatExecute(Sender: TObject);
    procedure CancelDlgExecute(Sender: TObject);
    procedure ApplicationEventsHint(Sender: TObject);
  private
    procedure UpdateSize;
  public
    MaxCol: Integer;
    MaxRow: Integer;
    Param: string;
    procedure ChangeLanguageFile;
  end;

var
  MatrixDialog: TMatrixDialog;

implementation

{$R *.dfm}

uses
  Globals, Language;

procedure TMatrixDialog.WriterKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) and Writer.EditorMode then
    if GroupAdvance.ItemIndex = 0 then
      Writer.Col := Writer.Col + 1
    else
      Writer.Row := Writer.Row + 1;
end;

procedure TMatrixDialog.FormCreate(Sender: TObject);
var
  I: Integer;
begin
  Param := '';
  MaxCol := 0;
  MaxRow := 0;
  UpdateSize;
  for I := 1 to Writer.RowCount - 1 do
    Writer.Cells[0,I] := IntToStr(I);
  for I := 1 to Writer.ColCount - 1 do
    Writer.Cells[I,0] := IntToStr(I);
  ChangeLanguageFile;
end;

procedure TMatrixDialog.WriterSetEditText(Sender: TObject; ACol,
  ARow: Integer; const Value: String);
var
  I, J: Integer;
begin
  if Value <> '' then
  begin
    if ACol > MaxCol then MaxCol := ACol;
    if ARow > MaxRow then MaxRow := ARow;
    for I := 1 to MaxRow do
      For J := 1 to MaxCol do
        if Writer.Cells[J,I] = '' then
          Writer.Cells[J,I] := '0';
    UpdateSize;
  end;
end;

procedure TMatrixDialog.UpdateSize;
begin
  if MaxCol = 0 then MaxRow := 0;
  if MaxRow = 0 then MaxCol := 0;
  Writer.Cells[0,0] := Format('%d x %d', [MaxRow, MaxCol]);
end;

procedure TMatrixDialog.WidthDecExecute(Sender: TObject);
begin
  Writer.DefaultColWidth := Writer.DefaultColWidth - 1;
end;

procedure TMatrixDialog.WidthIncExecute(Sender: TObject);
begin
  Writer.DefaultColWidth := Writer.DefaultColWidth + 1;
end;

procedure TMatrixDialog.InsertRowExecute(Sender: TObject);
var
  I, J: Integer;
begin
  if MaxRow < Writer.Row then Exit;
  for I := MaxRow + 1 downto Writer.Row + 1 do
    for J := 1 to MaxCol do
      Writer.Cells[J,I] := Writer.Cells[J,I - 1];
  for J := 1 to MaxCol do
    Writer.Cells[J,MaxRow] := '0';
  Inc(MaxRow);
  UpdateSize;
end;

procedure TMatrixDialog.DeleteRowExecute(Sender: TObject);
var
  I, J: Integer;
begin
  if MaxRow < Writer.Row then Exit;
  for I := Writer.Row to MaxRow - 1 do
    for J := 1 to MaxCol do
      Writer.Cells[J,I] := Writer.Cells[J,I + 1];
  for J := 1 to MaxCol do
    Writer.Cells[J,MaxRow] := '';
  Dec(MaxRow);
  UpdateSize;
end;

procedure TMatrixDialog.InsertColExecute(Sender: TObject);
var
  I, J: Integer;
begin
  if MaxCol < Writer.Col then Exit;
  for J := MaxCol + 1 downto Writer.Col + 1 do
    for I := 1 to MaxRow do
      Writer.Cells[J,I] := Writer.Cells[J - 1,I];
  for I := 1 to MaxRow do
    Writer.Cells[MaxCol,I] := '0';
  Inc(MaxCol);
  UpdateSize;
end;

procedure TMatrixDialog.InsertMatExecute(Sender: TObject);
var
  I, J: Integer;
  BegDelim, EndDelim: Char;
begin
  BegDelim := '['; // ver5
  EndDelim := ']'; // ver5
  if GroupType.ItemIndex = 2 then
  begin
    BegDelim := '{'; // ver5
    EndDelim := '}'; // ver5
  end;
  Param := BegDelim + ' ';
  if (GroupType.ItemIndex = 1) and (MaxRow = 1) then
    for J := 1 to MaxCol do
        Param := Param + Writer.Cells[J,1] + ' '
  else begin
    for I := 1 to MaxRow do
    begin
      Param := Param + BegDelim + ' ';
      for J := 1 to MaxCol do
        Param := Param + Writer.Cells[J,I] + ' ';
      Param := Param + EndDelim + ' ' + NewLine;
    end;
    Delete(Param, Length(Param), 1);
  end;
  Param := Param + EndDelim + '|';
  Close;
end;

procedure TMatrixDialog.DeleteColExecute(Sender: TObject);
var
  I, J: Integer;
begin
  if MaxCol < Writer.Col then Exit;
  for J := Writer.Col to MaxCol - 1 do
    for I := 1 to MaxRow do
      Writer.Cells[J,I] := Writer.Cells[J + 1,I];
  for I := 1 to MaxRow do
    Writer.Cells[MaxCol,I] := '';
  Dec(MaxCol);
  UpdateSize;
end;

procedure TMatrixDialog.ApplicationEventsHint(Sender: TObject);
begin
  StatusBar.Panels.Items[0].Caption := Utf8ToAnsi(' ' + Application.Hint); // ver5
end;

procedure TMatrixDialog.CancelDlgExecute(Sender: TObject);
begin
  Close;
end;

procedure TMatrixDialog.ChangeLanguageFile;
begin
  if not FileExists(LangPath) then
  begin
    MsgDlg(Format(Msgs[MSG_FILENOTEXISTS], [LangPath]), MB_ICONERROR + MB_OK);
    Exit;
  end;
  with TLanguageFile.Create(LangPath) do
  try
    Section := 'MatrixDialog';
    Self.Caption := LoadItem('DlgMatrixTitle');
    Header.Captions.Text := LoadItem('DlgMatrixHeaderTitle');
    Header.Comments.Text := LoadItem('DlgMatrixHeaderDescription');
    WidthDec.Caption := LoadItem('DlgMatrixWidthDecrease');
    WidthDec.Hint := LoadItem('DlgMatrixWidthDecreaseHint');
    WidthInc.Caption := LoadItem('DlgMatrixWidthIncrease');
    WidthInc.Hint := LoadItem('DlgMatrixWidthIncreaseHint');
    InsertRow.Caption := LoadItem('DlgMatrixRowInsert');
    InsertRow.Hint := LoadItem('DlgMatrixRowInsertHint');
    DeleteRow.Caption := LoadItem('DlgMatrixRowDelete');
    DeleteRow.Hint := LoadItem('DlgMatrixRowDeleteHint');
    InsertCol.Caption := LoadItem('DlgMatrixColInsert');
    InsertCol.Hint := LoadItem('DlgMatrixColInsertHint');
    DeleteCol.Caption := LoadItem('DlgMatrixColDelete');
    DeleteCol.Hint := LoadItem('DlgMatrixColDeleteHint');
    GroupType.Caption := LoadItem('DlgMatrixType');
    GroupType.Items[0] := LoadItem('DlgMatrixMatrix');
    GroupType.Items[1] := LoadItem('DlgMatrixVector');
    GroupAdvance.Caption := LoadItem('DlgMatrixGo');
    GroupAdvance.Items[0] := LoadItem('DlgMatrixGoToLeft');
    GroupAdvance.Items[1] := LoadItem('DlgMatrixGoToDown');
    InsertMat.Caption := LoadItem('DlgMatrixInsertMatrix'); // ver5
    InsertMat.Hint := LoadItem('DlgMatrixInsertMatrixHint'); // ver5
    CancelDlg.Caption := LoadItem('DlgMatrixCancel');
    CancelDlg.Hint := LoadItem('DlgMatrixCancelHint'); // ver5
  finally
    Free;
  end;
end;

end.
