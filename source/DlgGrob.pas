unit DlgGrob;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, AppEvnts, ActnList, ImgList, TBXStatusBars, Grids, TBXExtItems,
  TB2ExtItems, TB2Item, TBX, TB2Dock, TB2Toolbar, JvExControls, JvgWizardHeader,
  HPUtils, TBXGraphics;

type
  TGrobDialog = class(TForm)
    TBXDock: TTBXDock;
    ImageList: TImageList;
    ActionList: TActionList;
    Header: TJvgWizardHeader;
    Toolbar: TTBXToolbar;
    Grob: TDrawGrid;
    TBXItem1: TTBXItem;
    TBXItem2: TTBXItem;
    ApplicationEvents: TApplicationEvents;
    GrobNew: TAction;
    GrobOpen: TAction;
    GrobSave: TAction;
    TBXItem3: TTBXItem;
    TBXSeparatorItem1: TTBXSeparatorItem;
    TBXItem4: TTBXItem;
    TBXItem5: TTBXItem;
    GrobInsert: TAction;
    GrobCancel: TAction;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    StatusBar: TTBXStatusBar;
    spnWidth: TTBXSpinEditItem;
    spnHeight: TTBXSpinEditItem;
    GrobWidth: TAction;
    GrobHeight: TAction;
    TBXSeparatorItem3: TTBXSeparatorItem;
    GrobZoom: TAction;
    cmbZoom: TTBXComboBoxItem;
    chkGrid: TTBXItem;
    GrobGrid: TAction;
    TBXItem6: TTBXItem;
    TBXItem7: TTBXItem;
    TBXItem8: TTBXItem;
    TBXSeparatorItem2: TTBXSeparatorItem;
    GrobLine: TAction;
    GrobRect: TAction;
    GrobCircle: TAction;
    TBXImageList: TTBXImageList;
    procedure FormCreate(Sender: TObject);
    procedure ApplicationEventsHint(Sender: TObject);
    procedure GrobMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure GrobDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect;
      State: TGridDrawState);
    procedure GrobMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure GrobKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure GrobNewExecute(Sender: TObject);
    procedure GrobOpenExecute(Sender: TObject);
    procedure GrobSaveExecute(Sender: TObject);
    procedure GrobInsertExecute(Sender: TObject);
    procedure GrobCancelExecute(Sender: TObject);
    procedure GrobHeightExecute(Sender: TObject);
    procedure GrobZoomExecute(Sender: TObject);
    procedure GrobGridExecute(Sender: TObject);
    procedure spnWidthStep(Sender: TTBXCustomSpinEditItem; Step: Integer;
      const OldValue: Extended; var NewValue: Extended);
    procedure GrobWidthExecute(Sender: TObject);
    procedure spnHeightStep(Sender: TTBXCustomSpinEditItem; Step: Integer;
      const OldValue: Extended; var NewValue: Extended);
    procedure spnWidthConvert(Sender: TTBXCustomSpinEditItem; const APrefix,
      APostfix: WideString; var AValue: Extended; var CanConvert: Boolean);
    procedure spnHeightConvert(Sender: TTBXCustomSpinEditItem; const APrefix,
      APostfix: WideString; var AValue: Extended; var CanConvert: Boolean);
    procedure GrobEnter(Sender: TObject);
    procedure GrobSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure GrobMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure GrobLineExecute(Sender: TObject);
    procedure GrobRectExecute(Sender: TObject);
    procedure GrobCircleExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    FileName: TFileName;
    IsModified: Boolean;
    IsDrawObj: Boolean;
    ObjType: Integer;
    FIsDrag: Boolean;
    FCol: Integer;
    FRow: Integer;
    FX1: Integer;
    FY1: Integer;
    FX2: Integer;
    FY2: Integer;
    Display: array of array of Boolean;
    Shadow: array of TPoint;
    function BinaToHexa(B: string): string;
    function HexaToBina(H: string): string;
    procedure DoSaveFile(F: TFileName);
    function DisplayToGrob: TGrob;
    procedure DrawGrobLine(X1, Y1, X2, Y2: Integer);
    procedure DrawGrobRect(X1, Y1, X2, Y2: Integer);
    procedure DrawGrobCircle(X2, Y2, X1, Y1: Integer);
    procedure InsertPoint(X, Y: Integer);
    function FindPoint(X, Y: Integer): Boolean;
    function DoCloseGrob: Boolean;
  public
    Param: string;
    procedure ChangeLanguageFile;
  end;

var
  GrobDialog: TGrobDialog;

implementation

{$R *.dfm}

uses
  Globals, Language, Math;

const
  BinTable: array [1..16] of string[4] = ('0000', '1000', '0100', '1100',
                                          '0010', '1010', '0110', '1110',
                                          '0001', '1001', '0101', '1101',
                                          '0011', '1011', '0111', '1111');

  HexTable: string[16] = '0123456789ABCDEF';

function TGrobDialog.FindPoint(X, Y: Integer): Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := Low(Shadow) to High(Shadow) do
    if (Shadow[I].X = X) and (Shadow[I].Y = Y) then
    begin
      Result := True;
      Break;
    end;
end;

procedure TGrobDialog.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := DoCloseGrob;
end;

procedure TGrobDialog.FormCreate(Sender: TObject);
begin
  Grob.RowCount := DEF_GROB_HEIGHT; // ver5
  Grob.ColCount := DEF_GROB_WITH; // ver5
  SetLength(Display, Grob.RowCount, Grob.ColCount); // ver5
  spnWidth.Value := DEF_GROB_WITH; // ver5
  spnHeight.Value := DEF_GROB_HEIGHT; // ver5
  cmbZoom.ItemIndex := 2; // ver5
  IsModified := False; // ver5
  IsDrawObj := False; // ver5
  ObjType := 0;
  FIsDrag := False; // ver5
  //FileName := 'Sin nombre'; // ver5
  ChangeLanguageFile; // ver5
  SetLength(Shadow, 0);
  GrobNewExecute(nil);
end;

procedure TGrobDialog.GrobCancelExecute(Sender: TObject);
begin
  Close; //ver5
end;

procedure TGrobDialog.GrobCircleExecute(Sender: TObject);
begin
  GrobCircle.Checked := not GrobCircle.Checked; // ver5
  IsDrawObj := not IsDrawObj; // ver5
  ObjType := 3; // ver5
end;

procedure TGrobDialog.GrobDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
begin
  if FindPoint(ACol, ARow) then
  begin
    Grob.Canvas.Brush.Color := RGB(128, 255, 0); // ver5
    Grob.Canvas.FillRect(Rect); // ver5
  end
  else if Display[ARow, ACol] then
  begin
    Grob.Canvas.Brush.Color := RGB(0, 0, 0); // ver5
    Grob.Canvas.FillRect(Rect); // ver5
  end
  else begin
    Grob.Canvas.Brush.Color := RGB(104, 145, 106); // ver5
    Grob.Canvas.FillRect(Rect); // ver5
  end;
end;

procedure TGrobDialog.GrobEnter(Sender: TObject);
begin
  StatusBar.Panels.Items[0].Caption := 'X: ' + IntToStr(Grob.Col) + '   Y: ' + IntToStr(Grob.Row); // ver5
end;

procedure TGrobDialog.GrobGridExecute(Sender: TObject);
begin
  chkGrid.Checked := not chkGrid.Checked; // ver5
  Grob.GridLineWidth := Integer(chkGrid.Checked); // ver5
end;

procedure TGrobDialog.GrobHeightExecute(Sender: TObject);
begin
  //
end;

procedure TGrobDialog.GrobInsertExecute(Sender: TObject);
var
  Temp: TGrob;
begin
  Temp := DisplayToGrob; // ver5
  Param := 'GROB ' + IntToStr(Temp.Width) + ' ' + IntToStr(Temp.Height) + ' ' + Temp.Pixels + NewLine + '|';  // ver5
  //ModalResult := mrOk;  // ver5
  Close;  // ver5
end;

procedure TGrobDialog.GrobKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  Col, Row: LongInt;
  MyRect: TRect;
begin
  if Key = 32 then
  begin
    Col := Grob.Col; // ver5
    Row := Grob.Row; // ver5
    Display[Col, Row] := not Display[Col, Row]; // ver5
    MyRect := Grob.CellRect(Col, Row); // ver5
    InvalidateRect(Grob.Handle, @MyRect, False); // ver5
    IsModified := True; // ver5
  end
  else if Key = 27 then
    IsDrawObj := False; // ver5
end;

procedure TGrobDialog.GrobLineExecute(Sender: TObject);
begin
  GrobLine.Checked := not GrobLine.Checked; // ver5
  IsDrawObj := not IsDrawObj; // ver5
  ObjType := 1; // ver5
end;

procedure TGrobDialog.GrobMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  MyRect: TRect;
  Col, Row: LongInt;
begin
  Grob.MouseToCell(X, Y, Col, Row); // ver5
  if Button = mbLeft then
  begin
    if (Col <> -1) and (Row <> -1) then
    begin
      FCol := Col; // ver5
      FRow := Row; // ver5
      FIsDrag := True; // ver5
      if IsDrawObj then
      begin
        FX1 := Col; // ver5
        FY1 := Row; // ver5
      end
      else begin
        Display[Row, Col] := not Display[Row, Col]; // ver5
        MyRect := Grob.CellRect(Col, Row); // ver5
        InvalidateRect(Grob.Handle, @MyRect, False); // ver5
        IsModified := True; // ver5
      end;
    end;
  end;
end;

procedure TGrobDialog.GrobMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
  MyRect: TRect;
  Col, Row: LongInt;
begin
  Grob.MouseToCell(X, Y, Col, Row); // ver5
  if (Col <> -1) and (Row <> -1) then
  begin
    StatusBar.Panels.Items[0].Caption := 'X: ' + IntToStr(Col) + '   Y: ' + IntToStr(Row); // ver5
    if FIsDrag then
    begin
      if IsDrawObj then
      begin
        FX2 := Col; // ver5
        FY2 := Row; // ver5
        if ObjType = 1 then
          DrawGrobLine(FX1, FY1, FX2, FY2) // ver5
        else if ObjType = 2 then
          DrawGrobRect(FX1, FY1, FX2, FY2) // ver5
        else if ObjType = 3 then
          DrawGrobCircle(FX1, FY1, FX2, FY2); // ver5
      end
      else if (FCol <> Col) or (FRow <> Row) then
      begin
        Display[Row, Col] := not Display[Row, Col]; // ver5
        MyRect := Grob.CellRect(Col, Row); // ver5
        InvalidateRect(Grob.Handle, @MyRect, False); // ver5
        IsModified := True; // ver5
        FCol := Col; // ver5
        FRow := Row; // ver5
      end;
    end;
  end;
end;

procedure TGrobDialog.GrobMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  I: Integer;
  MyRect: TRect;
begin
  FIsDrag := False; // ver5
  case ObjType of
    1: GrobLine.Checked := False; // ver5
    2: GrobRect.Checked := False; // ver5
    3: GrobCircle.Checked := False; // ver5
  end;
  if IsDrawObj then
  begin
    IsDrawObj := False; // ver5
    if Button = mbLeft then
    begin
      for I := Low(Shadow) to High(Shadow) do
        Display[Shadow[I].Y, Shadow[I].X] := True; // ver5
      IsModified := True;  // ver5
    end;
  end;
  SetLength(Shadow, 0);
  MyRect := Rect(0, 0, Grob.Width, Grob.Height); // ver5
  InvalidateRect(Grob.Handle, @MyRect, False); // ver5
  ObjType := 0; // ver5
end;

procedure TGrobDialog.GrobNewExecute(Sender: TObject);
var
  MyRect: TRect;
  I, J: Integer;
begin
  if DoCloseGrob then
  begin
    Grob.RowCount := DEF_GROB_HEIGHT; // ver5
    Grob.ColCount := DEF_GROB_WITH; // ver5
    spnWidth.Value := Grob.ColCount; // ver5
    spnHeight.Value := Grob.RowCount; // ver5
    SetLength(Display, Grob.RowCount, Grob.ColCount); // ver5
    for I := Low(Display) to High(Display) do
      for J := Low(Display[I]) to High(Display[I]) do
        Display[I, J] := False; // ver5
    MyRect := Rect(0, 0, Grob.Width, Grob.Height); // ver5
    InvalidateRect(Grob.Handle, @MyRect, False); // ver5
    Grob.Col := 0; // ver5
    Grob.Row := 0; // ver5
    FileName := 'Sin nombre'; // ver5
    IsModified := False; // ver5
  end;
end;

procedure TGrobDialog.GrobOpenExecute(Sender: TObject);
var
  Data: TGrob;
  I, J, P: Integer;
  Pix: string;
  MyRect: TRect;
begin
  OpenDialog.DefaultExt := '*.grb'; // ver5
  OpenDialog.FileName := ''; // ver5
  OpenDialog.Filter := Caps[LBL_GRBFILTER]; // ver5
  OpenDialog.Title := Caps[LBL_OPEN]; // ver5
  if OpenDialog.Execute then
  begin
    Data := PictureFileToGrob(OpenDialog.FileName); // ver5
    if Data.Pixels <> '' then
    begin
      GrobNewExecute(nil); // ver5
      Grob.ColCount := Data.Width; // ver5
      Grob.RowCount := Data.Height; // ver5
      spnWidth.Value := Grob.ColCount;
      spnHeight.Value := Grob.RowCount;
      SetLength(Display, Grob.RowCount, Grob.ColCount); // ver5
      Pix := HexaToBina(Data.Pixels); // ver5
      P := 1; // ver5
      for I := 0 to Data.Height - 1 do
      begin
        for J := 0 to Data.Width - 1 do
        begin
          if Pix[P] = '1' then
            Display[I, J] := True; // ver5
          Inc(P); // ver5
        end;
        P := (Length(Data.Pixels) div Data.Height) * 4 * I + 1; // ver5
      end;
      MyRect := Rect(0, 0, Grob.Width, Grob.Height); // ver5
      InvalidateRect(Grob.Handle, @MyRect, False); // ver5
      FileName := OpenDialog.FileName; // ver5
    end
    else
      MsgDlg(Msgs[MSG_NOIMPORTGRAPH], MB_ICONERROR + MB_OK); // ver5
  end;
end;

procedure TGrobDialog.GrobRectExecute(Sender: TObject);
begin
  GrobRect.Checked := not GrobRect.Checked; // ver5
  IsDrawObj := not IsDrawObj; // ver5
  ObjType := 2; // ver5
end;

procedure TGrobDialog.GrobSaveExecute(Sender: TObject);
begin
  if FileName = 'Sin nombre' then
  begin
    SaveDialog.Title := Caps[LBL_SAVEAS]; // ver5
    SaveDialog.Filter := Caps[LBL_GRBFILTER]; // ver5
    SaveDialog.FileName := FileName; // ver5
    if SaveDialog.Execute then
    begin
      DoSaveFile(SaveDialog.FileName); // ver5
      FileName := SaveDialog.FileName; // ver5
      IsModified := False; // ver5
    end;
  end
  else begin
    DoSaveFile(FileName); // ver5
    IsModified := False; // ver5
  end;
end;

procedure TGrobDialog.GrobSelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
begin
  StatusBar.Panels.Items[0].Caption := 'X: ' + IntToStr(ACol) + '   Y: ' + IntToStr(ARow); // ver5
end;

procedure TGrobDialog.GrobWidthExecute(Sender: TObject);
begin
  //
end;

procedure TGrobDialog.GrobZoomExecute(Sender: TObject);
var
  T: Integer;
begin
  T := 4; // ver5
  case cmbZoom.ItemIndex of
    0: T := 1; // ver5
    1: T := 2; // ver5
    2: T := 4; // ver5
    3: T := 8; // ver5
    4: T := 16; // ver5
    5: T := 32; // ver5
  end;
  Grob.DefaultColWidth := T; // ver5
  Grob.DefaultRowHeight := T; // ver5
end;

function TGrobDialog.HexaToBina(H: string): string;
var
  Temp: string;
  I: Integer;
begin
  Temp := ''; // ver5
  for I := 1 to Length(H) do // ver5
    Temp := Temp + BinTable[Pos(H[I], HexTable)]; // ver5
  Result := Temp; // ver5
end;

procedure TGrobDialog.InsertPoint(X, Y: Integer);
var
  L: Integer;
begin
  L := Length(Shadow); // ver5
  SetLength(Shadow, L + 1); // ver5
  Shadow[L].X := X; // ver5
  Shadow[L].Y := Y; // ver5
end;

procedure TGrobDialog.spnHeightConvert(Sender: TTBXCustomSpinEditItem;
  const APrefix, APostfix: WideString; var AValue: Extended;
  var CanConvert: Boolean);
begin
  Grob.RowCount := Trunc(AValue); // ver5
  SetLength(Display, Grob.RowCount, Grob.ColCount); // ver5
end;

procedure TGrobDialog.spnHeightStep(Sender: TTBXCustomSpinEditItem;
  Step: Integer; const OldValue: Extended; var NewValue: Extended);
begin
  Grob.RowCount := Trunc(NewValue); // ver5
  SetLength(Display, Grob.RowCount, Grob.ColCount); // ver5
end;

procedure TGrobDialog.spnWidthConvert(Sender: TTBXCustomSpinEditItem;
  const APrefix, APostfix: WideString; var AValue: Extended;
  var CanConvert: Boolean);
begin
  Grob.ColCount := Trunc(AValue); // ver5
  SetLength(Display, Grob.RowCount, Grob.ColCount); // ver5
end;

procedure TGrobDialog.spnWidthStep(Sender: TTBXCustomSpinEditItem;
  Step: Integer; const OldValue: Extended; var NewValue: Extended);
begin
  Grob.ColCount := Trunc(NewValue); // ver5
  SetLength(Display, Grob.RowCount, Grob.ColCount); // ver5
end;

procedure TGrobDialog.ApplicationEventsHint(Sender: TObject);
begin
  StatusBar.Panels.Items[1].Caption := Utf8ToAnsi(' ' + Application.Hint); // ver5
end;

function TGrobDialog.BinaToHexa(B: string): string;
var
  H: string[4];
  Temp: string;
  T, I, J: Integer;
begin
  Temp := ''; // ver5
  T := Length(B); // ver5
  I := 1; // ver5
  while I < T do
  begin
    H := Copy(B, I, 4); // ver5
    for J := 1 to 16 do
      if BinTable[J] = H then
        Break; // ver5
    Temp := Temp + HexTable[J]; // ver5
    Inc(I, 4); // ver5
  end;
  Result := Temp; // ver5
end;

procedure TGrobDialog.ChangeLanguageFile;
begin
  if not FileExists(LangPath) then
  begin
    MsgDlg(Format(Msgs[MSG_FILENOTEXISTS], [LangPath]), MB_ICONERROR + MB_OK);
    Exit;
  end;
  with TLanguageFile.Create(LangPath) do
  try
    Section := 'PictureDialog'; // ver5
    Self.Caption := LoadItem('DlgGrobTitle'); // ver5
    Header.Captions.Text := LoadItem('DlgGrobHeaderTitle'); // ver5
    Header.Comments.Text := LoadItem('DlgGrobHeaderDescription'); // ver5
    GrobNew.Caption := LoadItem('DlgGrobNew'); // ver5
    GrobNew.Hint := LoadItem('DlgGrobNewHint'); // ver5
    GrobOpen.Caption := LoadItem('DlgGrobOpen'); // ver5
    GrobOpen.Hint := LoadItem('DlgGrobOpenHint'); // ver5
    GrobSave.Caption := LoadItem('DlgGrobSave'); // ver5
    GrobSave.Hint := LoadItem('DlgGrobSaveHint'); // ver5
    GrobWidth.Caption := LoadItem('DlgGrobWidth'); // ver5
    GrobWidth.Hint := LoadItem('DlgGrobWidthHint'); // ver5
    GrobHeight.Caption := LoadItem('DlgGrobHeight'); // ver5
    GrobHeight.Hint := LoadItem('DlgGrobHeightHint'); // ver5
    GrobZoom.Caption := LoadItem('DlgGrobZoom'); // ver5
    GrobZoom.Hint := LoadItem('DlgGrobZoomHint'); // ver5
    GrobGrid.Caption := LoadItem('DlgGrobGrid'); // ver5
    GrobGrid.Hint := LoadItem('DlgGrobGridHint'); // ver5
    GrobInsert.Caption := LoadItem('DlgGrobInsert'); // ver5
    GrobInsert.Hint := LoadItem('DlgGrobInsertHint'); // ver5
    GrobCancel.Caption := LoadItem('DlgGrobCancel'); // ver5
    GrobCancel.Hint := LoadItem('DlgGrobCancelHint'); // ver5
  finally
    Free; // ver5
  end;
end;

function TGrobDialog.DisplayToGrob: TGrob;
var
  Pix: string;
  I, J, P: Integer;
begin
  Result.Width := Grob.ColCount; // ver5
  Result.Height := Grob.RowCount; // ver5
  Pix := ''; // ver5
  P := 8 * (Grob.ColCount div 8) - Grob.ColCount; // ver5
  if (Grob.ColCount mod 8) <> 0 then
    P := P + 8; // ver5
  for I := 0 to Grob.RowCount - 1 do
  begin
    for J := 0 to Grob.ColCount - 1 do
    begin
      if Display[I, J] = True then
        Pix := Pix + '1' // ver5
      else
        Pix := Pix + '0'; // ver5
    end;
    for J := 1 to P do
      Pix := Pix + '0'; // ver5
  end;
  Result.Pixels := BinaToHexa(Pix); // ver5
end;

function TGrobDialog.DoCloseGrob: Boolean;
begin
  Result := False;
  if IsModified then
    case MsgDlg(Format(Msgs[MSG_CHANGEGROB], [FileName]), MB_ICONEXCLAMATION + MB_YESNOCANCEL) of // ver5
      IDYes: GrobSaveExecute(nil); // ver5
      IDNo: // ver5
    else
      Exit; // ver5
    end;
  Result := True;
end;

procedure TGrobDialog.DoSaveFile(F: TFileName);
begin
  GrobToPictureFile(DisplayToGrob, F); // ver5
end;

procedure TGrobDialog.DrawGrobCircle(X2, Y2, X1, Y1: Integer);
var
  theta, theta0, s, r: Double;
  TX1, TY1: Integer;
  MyRect: TRect;
begin
  SetLength(Shadow, 0); // ver5
  r := sqrt((X1-X2) * (X1-X2) + (Y1-Y2) * (Y1-Y2)); // ver5
  if r=0 then
    InsertPoint(X1, Y1) // ver5
  else begin
    if abs(Y1 - Y2) = r then
      theta0 := pi / 2 // ver5
    else
      theta0 := arcsin((Y2 - Y1) * sign(X1 - X2) / r); // ver5
    if X1 < X2 then
      theta0 := theta0 + pi; // ver5
    theta := theta0; // ver5
    s := arcsin(1 / (2 * r)) / 2; // ver5
    while theta < 2 * pi + theta0 do
    begin
      TX1 := X2 + round(r * cos(theta)); // ver5
      TY1 := Y2 - round(r * sin(theta)); // ver5
      if (TX1 >= 0) and (TY1 >= 0) then
        InsertPoint(TX1, TY1); // ver5
      theta:=theta+s; // ver5
    end;
  end;
  MyRect := Rect(0, 0, Grob.Width, Grob.Height); // ver5
  InvalidateRect(Grob.Handle, @MyRect, False); // ver5
end;

procedure TGrobDialog.DrawGrobLine(X1, Y1, X2, Y2: Integer);
var
  a, b: Double;
  TX1, TY1, TY2: Integer;
  MyRect: TRect;
begin
  SetLength(Shadow, 0); // ver5
  if X1 = X2 then
    for TY1 := Min(Y1, Y2) to Max(Y1, Y2) do
      InsertPoint(X1, TY1) // ver5
  else
  begin
    a := (Y1 - Y2) / (X1 - X2); // ver5
    b := Y2 - a * X2; // ver5
    TY2 := Max(round(a * Min(X1, X2) + b), 0); // ver5
    for TX1 := Min(X1, X2) to Max(X1, X2) do
    begin
      TY1 := Max(Round(a * TX1 + b), 0); // ver5
      if Abs(TY1 - TY2) > 1 then
        for TY2 := Min(TY1, TY2) + 1 to Max(TY1, TY2) - 1 do
          InsertPoint(TX1, TY2); // ver5
      InsertPoint(TX1, TY1); // ver5
      TY2 := TY1; // ver5
    end;
  end;
  MyRect := Rect(0, 0, Grob.Width, Grob.Height); // ver5
  InvalidateRect(Grob.Handle, @MyRect, False); // ver5
end;

procedure TGrobDialog.DrawGrobRect(X1, Y1, X2, Y2: Integer);
var
  I, TX1, TY1, TX2, TY2:  Integer;
  MyRect: TRect;
begin
  TX1 :=min(X1, X2); // ver5
  TY1 :=min(Y1, Y2); // ver5
  TX2 :=max(X1, X2); // ver5
  TY2 :=max(Y1, Y2); // ver5
  SetLength(Shadow, 0); // ver5
  for I := TX1 to TX2 do
  begin
    InsertPoint(I, TY1); // ver5
    InsertPoint(I, TY2); // ver5
  end;
  for I := TY1 to TY2 do
  begin
    InsertPoint(TX1, I); // ver5
    InsertPoint(TX2, I); // ver5
  end;
  MyRect := Rect(0, 0, Grob.Width, Grob.Height); // ver5
  InvalidateRect(Grob.Handle, @MyRect, False); // ver5
end;

end.
