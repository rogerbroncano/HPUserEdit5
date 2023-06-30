unit DlgPrintPreview;

interface

uses
  Windows, SysUtils, Classes, Graphics, Forms, Controls, ActnList,
  AppEvnts, ImgList, TBXStatusBars, TBX, TB2Item, TB2Dock, TB2Toolbar,
  SynEditPrintPreview, TBXGraphics;

type
  TPreviewDialog = class(TForm)
    ApplicationEvents: TApplicationEvents;
    SynEditPrintPreview: TSynEditPrintPreview;
    TBXDock: TTBXDock;
    Toolbar: TTBXToolbar;
    TBXItem1: TTBXItem;
    TBXItem2: TTBXItem;
    TBXItem3: TTBXItem;
    TBXItem4: TTBXItem;
    TBXSeparatorItem1: TTBXSeparatorItem;
    TBXItem6: TTBXItem;
    TBXSeparatorItem2: TTBXSeparatorItem;
    TBXSeparatorItem3: TTBXSeparatorItem;
    TBXItem7: TTBXItem;
    TBXSubmenuItem1: TTBXSubmenuItem;
    TBXItem5: TTBXItem;
    TBXItem8: TTBXItem;
    TBXItem9: TTBXItem;
    TBXItem10: TTBXItem;
    TBXSeparatorItem4: TTBXSeparatorItem;
    TBXItem11: TTBXItem;
    TBXItem12: TTBXItem;
    TBXItem13: TTBXItem;
    StatusBar: TTBXStatusBar;
    ActionList: TActionList;
    FirstCmd: TAction;
    PrevCmd: TAction;
    NextCmd: TAction;
    LastCmd: TAction;
    ZoomCmd: TAction;
    PrintCmd: TAction;
    CloseCmd: TAction;
    ZoomWholePage: TAction;
    ZoomPageWidth: TAction;
    Zoom25: TAction;
    Zoom50: TAction;
    Zoom100: TAction;
    Zoom200: TAction;
    Zoom400: TAction;
    TBXImageList: TTBXImageList;
    procedure FirstCmdExecute(Sender: TObject);
    procedure PrevCmdExecute(Sender: TObject);
    procedure NextCmdExecute(Sender: TObject);
    procedure LastCmdExecute(Sender: TObject);
    procedure ZoomCmdExecute(Sender: TObject);
    procedure PrintCmdExecute(Sender: TObject);
    procedure CloseCmdExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ApplicationEventsHint(Sender: TObject);
    procedure SynEditPrintPreviewMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure SynEditPrintPreviewPreviewPage(Sender: TObject;
      PageNumber: Integer);
    procedure ZoomExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SynEditPrintPreviewMouseUp(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
  public
    procedure ChangeLanguageFile;
  end;

var
  PreviewDialog: TPreviewDialog;

implementation

{$R *.DFM}

uses
  Globals, Language;

procedure TPreviewDialog.FormShow(Sender: TObject);
begin
  SynEditPrintPreview.UpdatePreview;
  SynEditPrintPreview.FirstPage;
end;

procedure TPreviewDialog.FirstCmdExecute(Sender: TObject);
begin
  SynEditPrintPreview.FirstPage;
end;

procedure TPreviewDialog.PrevCmdExecute(Sender: TObject);
begin
  SynEditPrintPreview.PreviousPage;
end;

procedure TPreviewDialog.NextCmdExecute(Sender: TObject);
begin
  SynEditPrintPreview.NextPage;
end;

procedure TPreviewDialog.LastCmdExecute(Sender: TObject);
begin
  SynEditPrintPreview.LastPage;
end;

procedure TPreviewDialog.ZoomCmdExecute(Sender: TObject);
begin
  SynEditPrintPreview.ScaleMode := pscWholePage;
end;

procedure TPreviewDialog.PrintCmdExecute(Sender: TObject);
begin
  SynEditPrintPreview.Print;
end;

procedure TPreviewDialog.CloseCmdExecute(Sender: TObject);
begin
  Close;
end;

procedure TPreviewDialog.ApplicationEventsHint(Sender: TObject);
begin
  StatusBar.Panels.Items[0].Caption := Utf8ToAnsi(' ' + Application.Hint);
end;

procedure TPreviewDialog.SynEditPrintPreviewMouseDown(
  Sender: TObject; Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
var
  FScale: Integer;
begin
  FScale := SynEditPrintPreview.ScalePercent;
  if Button = mbLeft then
  begin
    if SynEditPrintPreview.ScaleMode = pscWholePage then
      SynEditPrintPreview.ScalePercent := 100
    else
    begin
      FScale := FScale * 2;
      if FScale > 400 then FScale := 400;
      SynEditPrintPreview.ScalePercent := FScale;
    end;
  end
  else
  begin
    FScale := FScale div 2;
    if FScale < 25 then FScale := 25;
    SynEditPrintPreview.ScalePercent := FScale;
  end;
end;

procedure TPreviewDialog.SynEditPrintPreviewPreviewPage(
  Sender: TObject; PageNumber: Integer);
begin
  StatusBar.Panels[1].Caption := Format(' %s: %d', [Caps[LBL_PAGE], PageNumber]);
end;

procedure TPreviewDialog.ZoomExecute(Sender: TObject);
begin
  case (Sender as TAction).Tag of
    -1: SynEditPrintPreview.ScaleMode := pscWholePage;
    -2: SynEditPrintPreview.ScaleMode := pscPageWidth;
  else
    SynEditPrintPreview.ScalePercent := (Sender as TAction).Tag;
  end;
end;

procedure TPreviewDialog.FormCreate(Sender: TObject);
begin
  ChangeLanguageFile;
end;

procedure TPreviewDialog.ChangeLanguageFile;
begin
  if not FileExists(LangPath) then
  begin
    MsgDlg(Format(Msgs[MSG_FILENOTEXISTS], [LangPath]), MB_ICONERROR + MB_OK);
    Exit;
  end;
  with TLanguageFile.Create(LangPath) do
  try
    Section := 'PreviewDialog';
    Self.Caption := LoadItem('DlgPreviewTitle');
    FirstCmd.Caption := LoadItem('DlgPreviewFirst');
    FirstCmd.Hint := LoadItem('DlgPreviewFirstHint');
    PrevCmd.Caption := LoadItem('DlgPreviewPrev');
    PrevCmd.Hint := LoadItem('DlgPreviewPrevHint');
    NextCmd.Caption := LoadItem('DlgPreviewNext');
    NextCmd.Hint := LoadItem('DlgPreviewNextHint');
    LastCmd.Caption := LoadItem('DlgPreviewLast');
    LastCmd.Hint := LoadItem('DlgPreviewLastHint');
    ZoomCmd.Caption := LoadItem('DlgPreviewZoom');
    ZoomCmd.Hint := LoadItem('DlgPreviewZoomHint');
    ZoomWholePage.Caption := LoadItem('DlgPreviewZoomWholePage');
    ZoomWholePage.Hint := LoadItem('DlgPreviewZoomWholePageHint');
    ZoomPageWidth.Caption := LoadItem('DlgPreviewZoomPageWidth');
    ZoomPageWidth.Hint := LoadItem('DlgPreviewZoomPageWidthHint');
    Zoom25.Caption := LoadItem('DlgPreviewZoom25');
    Zoom25.Hint := LoadItem('DlgPreviewZoom25Hint');
    Zoom50.Caption := LoadItem('DlgPreviewZoom50');
    Zoom50.Hint := LoadItem('DlgPreviewZomm50Hint');
    Zoom100.Caption := LoadItem('DlgPreviewZoom100');
    Zoom100.Hint := LoadItem('DlgPreviewZomm100Hint');
    Zoom200.Caption := LoadItem('DlgPreviewZoom200');
    Zoom200.Hint := LoadItem('DlgPreviewZomm200Hint');
    Zoom400.Caption := LoadItem('DlgPreviewZoom400');
    Zoom400.Hint := LoadItem('DlgPreviewZomm400Hint');
    PrintCmd.Caption := LoadItem('DlgPreviewPrint');
    PrintCmd.Hint := LoadItem('DlgPreviewPrintHint');
    CloseCmd.Caption := LoadItem('DlgPreviewClose');
    CloseCmd.Hint := LoadItem('DlgPreviewCloseHint');
    Toolbar.Caption := LoadItem('DlgPreviewToolBarTitle');
    Toolbar.ChevronHint := LoadItem('DlgPreviewToolBarChevronHint');
  finally
    Free;
  end;
end;

procedure TPreviewDialog.SynEditPrintPreviewMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  DummyHwnd: THandle;
begin
  if Button = mbRight then
  begin
    DummyHwnd := Classes.AllocateHwnd(nil);
    if DummyHwnd <> 0 then
    begin
      Windows.SetFocus(DummyHwnd);
      Classes.DeallocateHwnd(DummyHwnd);
    end;
  end;
end;

end.

