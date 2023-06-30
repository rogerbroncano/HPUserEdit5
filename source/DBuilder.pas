unit DBuilder;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, JvComponentBase, JvAppStorage, JvAppRegistryStorage, TB2MRU,
  TBXExtItems, SynEditHighlighter, SynHighlighterGeneral, AppEvnts, ActnList,
  XPStyleActnCtrls, ActnMan, ImgList, TB2Item, TBXStatusBars, ExtCtrls,
  DiagramBuilder, JvExForms, JvScrollBox, SynEdit, SynMemo, TBXDkPanels, TBX,
  TB2Dock, TB2Toolbar, TBXGraphics;

type

  TLinkMode = (lmNone, lmBegin, lmNormal, lmBoolean, lmLink, lmNext);

  TDBuilderForm = class(TForm)
    TBXDock1: TTBXDock;
    ToolBar: TTBXToolbar;
    MainMenu: TTBXToolbar;
    TBXDock2: TTBXDock;
    ScrollBox: TJvScrollBox;
    Diagrama: TDiagramControl;
    MenuFile: TTBXSubmenuItem;
    MenuEdit: TTBXSubmenuItem;
    MenuView: TTBXSubmenuItem;
    MenuDiagram: TTBXSubmenuItem;
    TBXItem1: TTBXItem;
    MenuRun: TTBXSubmenuItem;
    TBXItem2: TTBXItem;
    TBXItem3: TTBXItem;
    TBXItem4: TTBXItem;
    TBXSeparatorItem1: TTBXSeparatorItem;
    TBXSeparatorItem2: TTBXSeparatorItem;
    TBXMRUListItem1: TTBXMRUListItem;
    TBXSeparatorItem3: TTBXSeparatorItem;
    TBXItem5: TTBXItem;
    TBXItem6: TTBXItem;
    TBXSeparatorItem4: TTBXSeparatorItem;
    TBXItem7: TTBXItem;
    TBXItem8: TTBXItem;
    TBXItem9: TTBXItem;
    TBXItem10: TTBXItem;
    TBXItem11: TTBXItem;
    TBXItem12: TTBXItem;
    TBXSeparatorItem5: TTBXSeparatorItem;
    TBXItem13: TTBXItem;
    TBXItem14: TTBXItem;
    TBXItem15: TTBXItem;
    TBXItem16: TTBXItem;
    TBXItem17: TTBXItem;
    TBXItem18: TTBXItem;
    TBXItem20: TTBXItem;
    TBXItem21: TTBXItem;
    TBXSeparatorItem6: TTBXSeparatorItem;
    TBXItem22: TTBXItem;
    TBXItem23: TTBXItem;
    TBXItem24: TTBXItem;
    TBXSeparatorItem7: TTBXSeparatorItem;
    TBXItem25: TTBXItem;
    TBXItem29: TTBXItem;
    TBXItem30: TTBXItem;
    TBXItem31: TTBXItem;
    TBXSeparatorItem10: TTBXSeparatorItem;
    TBXItem32: TTBXItem;
    TBXItem33: TTBXItem;
    TBXItem34: TTBXItem;
    TBXItem35: TTBXItem;
    TBXItem36: TTBXItem;
    TBXSeparatorItem11: TTBXSeparatorItem;
    TBXItem37: TTBXItem;
    TBXItem38: TTBXItem;
    TBXItem39: TTBXItem;
    TBXItem40: TTBXItem;
    TBXItem41: TTBXItem;
    TBXItem43: TTBXItem;
    TBXItem44: TTBXItem;
    TBXSeparatorItem12: TTBXSeparatorItem;
    TBXItem45: TTBXItem;
    TBXSeparatorItem13: TTBXSeparatorItem;
    TBXItem46: TTBXItem;
    TBXItem47: TTBXItem;
    TBXItem48: TTBXItem;
    TBXSeparatorItem14: TTBXSeparatorItem;
    TBXSeparatorItem16: TTBXSeparatorItem;
    FileNew: TAction;
    FileOpen: TAction;
    FileSave: TAction;
    FileSaveAs: TAction;
    FileExit: TAction;
    EditChange: TAction;
    EditCut: TAction;
    EditCopy: TAction;
    EditPaste: TAction;
    EditDelete: TAction;
    ViewToolBar: TAction;
    ViewStatusBar: TAction;
    ViewRunWindow: TAction;
    DiagramShape1: TAction;
    DiagramShape2: TAction;
    DiagramShape3: TAction;
    DiagramShape4: TAction;
    DiagramShape5: TAction;
    DiagramShape6: TAction;
    DiagramShape7: TAction;
    DiagramShape8: TAction;
    DiagramConnect: TAction;
    RunRun: TAction;
    RunStep: TAction;
    RunStop: TAction;
    ActionManager: TActionManager;
    ApplicationEvents: TApplicationEvents;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    SynGeneralSyn: TSynGeneralSyn;
    StatusBar: TTBXStatusBar;
    RunPanel: TTBXDockablePanel;
    Memo: TSynMemo;
    MRUList: TTBXMRUList;
    TBXItem26: TTBXItem;
    TBXItem27: TTBXItem;
    FileInsert: TAction;
    Registry: TJvAppRegistryStorage;
    TBXItem28: TTBXItem;
    TBXSeparatorItem8: TTBXSeparatorItem;
    DiagramShape9: TAction;
    TBXItem19: TTBXItem;
    TBXItem42: TTBXItem;
    TBXImageList: TTBXImageList;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FileNewExecute(Sender: TObject);
    procedure FileOpenExecute(Sender: TObject);
    procedure FileSaveExecute(Sender: TObject);
    procedure FileSaveAsExecute(Sender: TObject);
    procedure FileExitExecute(Sender: TObject);
    procedure EditChangeExecute(Sender: TObject);
    procedure EditCutExecute(Sender: TObject);
    procedure EditCopyExecute(Sender: TObject);
    procedure EditPasteExecute(Sender: TObject);
    procedure EditDeleteExecute(Sender: TObject);
    procedure ViewToolBarExecute(Sender: TObject);
    procedure ViewStatusBarExecute(Sender: TObject);
    procedure ViewRunWindowExecute(Sender: TObject);
    procedure DiagramInsertShape(Sender: TObject);
    procedure DiagramConnectExecute(Sender: TObject);
    procedure RunRunExecute(Sender: TObject);
    procedure RunStepExecute(Sender: TObject);
    procedure RunStopExecute(Sender: TObject);
    procedure ApplicationEventsHint(Sender: TObject);
    procedure DiagramaClick(Sender: TObject);
    procedure ShapeClick(Sender: TObject);
    procedure ShapeDblClick(Sender: TObject);
    procedure ShapeEnterState(Sender: TObject);
    procedure ShapeBooleanEnterState(Sender: TShapeBoolean;
      var Result: Boolean);
    procedure ShapeLoopEnterState(Sender: TShapeLoop;
      var Result: Boolean);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure ShapeActionEnterState(Sender: TObject);
    procedure ActionManagerUpdate(Action: TBasicAction;
      var Handled: Boolean);
    procedure MRUListClick(Sender: TObject; const Filename: String);
    procedure ScrollBoxMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DiagramaChangeState(Sender: TDiagramControl; FromState,
      ToState: TShapeCustomControl);
    procedure FileInsertExecute(Sender: TObject);
  private
    ConectMode: TLinkMode;
    FileEdit: string;
    InsertShape: Integer;
    IsRunning: Boolean;
    Modified: Boolean;
    //FxNum: Integer;
    ShapeBegin: TShapeCustomControl;
    procedure Debug(Str: string);
    procedure DebugError(Err: string);
    function DoCloseDiagram: Boolean;
    procedure DoDiagramClear;
    procedure DoInsertShape(sName, sCaption: string; H, L, T, W: Integer);
    function DoOpenFile(FileName: string): Boolean;
    function DoSaveFile(FileName: string): Boolean;
    procedure DoStatusChange;
    function IsPrepareToRun: Boolean;
    function IsShapeBlank(Str: string): Boolean;
    function ShapeSelected: TShapeCustomControl;
    function ShapeType(Shape: TShapeCustomControl): Integer;
    function GenerateNumber: string;
  public
    Param: string;
    procedure ChangeLanguageFile;
  end;

var
  DBuilderForm: TDBuilderForm;

implementation

{$R *.dfm}

uses
  DlgDBEditor, DlgDBInput, CalcExpress, Clipbrd, Registry, Globals, Language,
  HPUtils, StrUtils;

var
  Parser: TCalcExpress;

procedure TDBuilderForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  Diagrama.Stop;
  CanClose := DoCloseDiagram;
end;

procedure TDBuilderForm.FormCreate(Sender: TObject);
var
  Ini: TRegIniFile;
begin
  FileEdit := Caps[LBL_NONAME];
  //FNum := 1;
  Modified := False;
  InsertShape := 0;
  Param := '';
  IsRunning := False;
  ConectMode := lmNone;
  VarNames := TStringList.Create;
  VarNames.CaseSensitive := False;
  Parser := TCalcExpress.Create(Self);
  Registry.Root := REG_HPUSER_ROOT;
  with Registry do
  begin
    Path := REG_BUILDER;
    Height := ReadInteger('WindowHeight', 580);
    Width := ReadInteger('WindowWidth', 700);
    Left := ReadInteger('WindowLeft', 0);
    Top := ReadInteger('WindowTop', 0);
    WindowState := TWindowState(ReadInteger('WindowState', 0));
  end;
  //Diagrama.Color := BackgroundColor;
  Ini := TRegIniFile.Create('Software\HPUserEdit');
  try
    MRUList.LoadFromRegIni(Ini, 'Builder');
  finally
    Ini.Free;
  end;
  DoStatusChange;
  ChangeLanguageFile;
end;

procedure TDBuilderForm.FormDestroy(Sender: TObject);
var
  Ini: TRegIniFile;
begin
  Registry.Root := REG_HPUSER_ROOT;
  with Registry do
  begin
    Path := REG_BUILDER;
    WriteInteger('WindowHeight', Height);
    WriteInteger('WindowWidth', Width);
    WriteInteger('WindowLeft', Left);
    WriteInteger('WindowTop', Top);
    WriteInteger('WindowState', Ord(WindowState));
  end;
  Ini := TRegIniFile.Create('Software\HPUserEdit');
  try
    MRUList.SaveToRegIni(Ini, 'Builder');
  finally
    Ini.Free;
  end;
  FreeAndNil(Parser);
  FreeAndNil(VarNames);
end;

procedure TDBuilderForm.FormShow(Sender: TObject);
begin
  Diagrama.Show;
end;

function TDBuilderForm.GenerateNumber: string;
begin
  Randomize;
  Result := IntToStr(Random(147483647));
end;

procedure TDBuilderForm.FileNewExecute(Sender: TObject);
begin
  if not DoCloseDiagram then Exit;
  Memo.Lines.Clear;
  Diagrama.Refresh;
  DoStatusChange;
  //FNum := 1;
end;

procedure TDBuilderForm.FileOpenExecute(Sender: TObject);
begin
  FileNewExecute(nil);
  if OpenDialog.Execute then
    if not DoOpenFile(OpenDialog.FileName) then
      MsgDlg(Msgs[MSG_NOOPENDIAGRAM], MB_ICONERROR + MB_OK)
end;

procedure TDBuilderForm.FileSaveExecute(Sender: TObject);
begin
  if FileEdit = Caps[LBL_NONAME] then
    FileSaveAsExecute(Sender)
  else
    if not DoSaveFile(FileEdit) then
      MsgDlg(Msgs[MSG_NOSAVEDIAGRAM], MB_ICONERROR + MB_OK);
end;

procedure TDBuilderForm.FileSaveAsExecute(Sender: TObject);
begin
  if SaveDialog.Execute then
    if not DoSaveFile(SaveDialog.FileName) then
      MsgDlg(Msgs[MSG_NOSAVEDIAGRAM], MB_ICONERROR + MB_OK);
end;

procedure TDBuilderForm.FileExitExecute(Sender: TObject);
begin
  Close;
end;

procedure TDBuilderForm.FileInsertExecute(Sender: TObject);

function IsString(const S: string): Boolean;
begin
  Result := False;
  if S= '' then Exit;
  if (S[1] = '"') and (S[Length(S)] = '"') then
    Result := True;
end;

function FindShape(const Name: string): TShapeCustomControl;
var
  C: Integer;
  IsFound: Boolean;
begin
  Result := nil;
  C := 0;
  IsFound := False;
  while (C < Diagrama.ControlCount) and not IsFound do
    if (Diagrama.Controls[C] is TShapeCustomControl) and
       (TShapeCustomControl(Diagrama.Controls[C]).Name = Name) then IsFound := True
    else Inc(C);
  if IsFound then Result := TShapeCustomControl(Diagrama.Controls[C]);
end;

var
  I, J: Integer;
  IsEnd, Failed, ExistStart, ExistEnd, ExistVar: Boolean;
  Actual, Shape: TShapeCustomControl;
  Code, Depth, Vars: TStringList;
  Temp, VarName: string;
  Value: Extended;
  Tabs: Integer;

procedure ProcessLoopBoolean;

procedure LoopNext;
begin
  if (Shape is TShapeLoop) and (Shape.Tag = 1) then
  begin
    Code.Add(DupeString(' ', Tabs) + 'NEXT');
    Dec(Tabs);
    Shape := TShapeLoop(Shape).FalseState;
    if Shape = nil then
      Failed := True
    else LoopNext;
  end
end;

begin
  if Shape = nil then
    Failed := True
  else
    LoopNext;{if (Shape is TShapeLoop) and (Shape.Tag = 1) then
  begin
    Code.Add('NEXT');
    Shape := TShapeLoop(Shape).FalseState;
    if Shape = nil then
      Failed := True;
  end}
  if (Shape is TShapeTrans) and (Shape.Tag = 1) then
  begin
    Shape := TShapeTrans(Shape).DefaultTransition;
    if Shape = nil then
      Failed := True
    else if (Shape is TShapeBoolean) and (Shape.Tag = 1) then
    begin
      Depth.Delete(Depth.IndexOf(Shape.Name));
      I := Code.IndexOf('$$' + Shape.Name + '$$');
      Code[I + 1] := DupeString(' ', Tabs) + 'WHILE' + Code[I + 1];
      Code[I + 2] := DupeString(' ', Tabs) + 'REPEAT';
      Code.Delete(I);
      Code.Add(DupeString(' ', Tabs) + 'END');
      Dec(Tabs);
      Shape := TShapeBoolean(Shape).FalseState;
      if Shape = nil then
        Failed := True;
    end;
  end;
end;

begin
  ExistStart := False;
  ExistEnd := False;
  I := 0;
  while (I < Diagrama.ControlCount) and not ExistStart do
    if Diagrama.Controls[I] is TShapeStart then
    begin
      ExistStart := True;
      Shape := TShapeCustomControl(Diagrama.Controls[I]);
    end
    else Inc(I);
  if not ExistStart then
  begin
    MsgDlg(Msgs[MSG_NOBEGINBLOCK], MB_ICONERROR + MB_OK);
    Exit;
  end;
  I := 0;
  while (I < Diagrama.ControlCount) and not ExistEnd do
    if Diagrama.Controls[I] is TShapeStop then
      ExistEnd := True
    else Inc(I);
  if not ExistEnd then
  begin
    MsgDlg(Msgs[MSG_NOENDBLOCK], MB_ICONERROR + MB_OK);
    Exit;
  end;
  Code := TStringList.Create;
  Depth := TStringList.Create;
  Vars := TStringList.Create;
  try
    IsEnd := False;
    Failed := False;
    ExistVar := False;
    Temp := '';
    Code.Add('«');
    Code.Add(#141);
    Code.Add(' «');
    Tabs := 1;
    Shape.Tag := 1;
    Shape := TShapeStart(Shape).DefaultTransition;
    if Shape = nil then
    begin
      IsEnd := True;
      Failed := True;
    end;
    while not IsEnd or Failed do
    begin
      Shape.Tag := Shape.Tag + 1;
      if Shape.Tag > 1 then
      begin
        Failed := True;
        Break;
      end;
      if Shape is TShapeStop then // TShapeStop
      begin
        IsEnd := True;
      end
      else if Shape is TShapeRead then // TShapeRead
      begin
        ExistVar := True;
        I := Code.IndexOf(#141);
        Vars.Clear;
        Vars.CommaText := Shape.Caption;
        if Code[I + 1] = ' «' then
          Code.Insert(I + 1, '');
        Code[I + 1] := Code[I + 1] + ' ' + StringReplace(Shape.Caption, ',', ' ', [rfReplaceAll]);
        for J := Vars.Count - 1 downto 0 do
          if Trim(Vars[J]) = '' then
            Failed := True
          else
            Code.Insert(I, '"' + Trim(Vars[J]) + '" "" INPUT OBJ'#141);
        Shape := TShapeRead(Shape).DefaultTransition;
        ProcessLoopBoolean;
      end
      else if Shape is TShapeWrite then // TShapeWrite
      begin
        if IsString(Shape.Caption) then
            Code.Add(DupeString(' ', Tabs + 1) + Shape.Caption + ' MSGBOX')
        else begin
          Vars.Clear;
          Vars.CommaText := Shape.Caption;
          for J := 0 to Vars.Count - 1 do
            if Trim(Vars[J]) = '' then
              Failed := True
            else
              Code.Add(DupeString(' ', Tabs + 1) + Trim(Vars[J]) + ' "' + Trim(Vars[J]) + '" '#141'TAG');
        end;
        Shape := TShapeWrite(Shape).DefaultTransition;
        ProcessLoopBoolean;
      end
      else if Shape is TShapeTrans then // TShapeTrans
      begin
        if (Depth.Count > 0) and (Shape.Hint <> 'ELSE') then
        begin
          Actual := Shape;
          Shape := FindShape(Depth[Depth.Count - 1]);
          Depth.Delete(Depth.Count - 1);
          if Shape = nil then
            Failed := True
          else begin
            I := Code.IndexOf('$$' + Shape.Name + '$$');
            Code[I + 1] := DupeString(' ', Tabs) + 'IF' + Code[I + 1];
            Code[I + 2] := DupeString(' ', Tabs) + 'THEN';
            Code.Delete(I);
            Shape := TShapeBoolean(Shape).FalseState;
            if Shape.Name = Actual.Name then
            begin
              Code.Add(DupeString(' ', Tabs) + 'END');
              Dec(Tabs);
              Code.Add('$$' + Shape.Name + '$$');
              Shape := TShapeTrans(Shape).DefaultTransition;
            end
            else begin
              Code.Add(DupeString(' ', Tabs) + 'ELSE');
              Actual.Tag := Actual.Tag - 1;
              Actual.Hint := 'ELSE';
            end;
          end;
        end
        else if Shape.Hint = 'ELSE' then
        begin
          Shape.Hint := '';
          Code.Add(DupeString(' ', Tabs) + 'END');
          Dec(I);
          Code.Add('$$' + Shape.Name + '$$');
          Shape := TShapeTrans(Shape).DefaultTransition;
        end
        else begin
          Code.Add('$$' + Shape.Name + '$$');
          Shape := TShapeTrans(Shape).DefaultTransition;
        end;
      end
      else if Shape is TShapeNode then // TShapeNode
      begin
        Temp := Shape.Caption;
        if Pos('=', Temp) <> 0 then
        begin
          VarName := Copy(Temp, 1, Pos('=', Temp) - 1);
          Temp := Copy(Temp, Pos('=', Temp) + 1, Length(Temp));
          if TryStrToFloat(Temp, Value) then
          begin
            I := Code.IndexOf(#141);
            if Code[I + 1] = ' «' then
              Code.Insert(I + 1, '');
            Code[I + 1] := Code[I + 1] + ' ' + VarName;
            Code.Insert(I, Temp);
          end
          else begin
            if Pos('Pi', Temp) <> 0 then
            begin
              if Length(Temp) > (Pos('Pi', Temp) + 1) then
                if not (Temp[Pos('Pi', Temp) + 2] in ['a'..'z', 'A'..'Z', '_', '1'..'9', '0']) then
                  Temp := StringReplace(Temp, 'Pi', #135, [rfReplaceAll]);
            end;
            Temp := '''' + Temp + ''' '#141'NUM ''' + VarName + ''' STO';
            Code.Add(DupeString(' ', Tabs + 1) + Temp);
          end;
        end
        else if IsString(Temp) then
          Code.Add(DupeString(' ', Tabs + 1) + Temp + ' MSGBOX')
        else
          Code.Add(DupeString(' ', Tabs + 1) + Temp);
        Shape := TShapeNode(Shape).DefaultTransition;
        ProcessLoopBoolean;
      end
      else if Shape is TShapeBoolean then // TShapeBoolean
      begin
        Inc(Tabs);
        Code.Add('$$' + Shape.Name + '$$');
        Depth.Add(Shape.Name);
        Temp := Shape.Caption;
        Temp := StringReplace(Temp, '>=', #138, [rfReplaceAll]);
        Temp := StringReplace(Temp, '<=', #137, [rfReplaceAll]);
        Temp := StringReplace(Temp, '=', '==', [rfReplaceAll]);
        Code.Add(' ''' + Temp + '''');
        Code.Add('%%');
        Temp := Shape.Name;
        Actual := TShapeBoolean(Shape).FalseState;
        if Actual = nil then
          Failed := True
        else if (Actual is TShapeTrans) and (Actual.Tag = 0) then
          Shape := TShapeBoolean(Shape).TrueState
        else if not (Actual is TShapeTrans) and (Actual.Tag <> 1) then
          Shape := TShapeBoolean(Shape).TrueState
        else if (Actual is TShapeTrans) and (Actual.Tag = 1) then
        begin
          Depth.Delete(Depth.IndexOf(Temp));
          I := Code.IndexOf('$$' + Actual.Name + '$$');
          Code[I] := DupeString(' ', Tabs) + 'DO';
          I := Code.IndexOf('$$' + Temp + '$$');
          Code[I + 1] := DupeString(' ', Tabs) + 'UNTIL' + Code[I + 1];
          Code[I + 2] := DupeString(' ', Tabs) + 'END';
          Dec(Tabs);
          Code.Delete(I);
          Shape := TShapeBoolean(FindShape(Temp)).TrueState;
          if Shape = nil then
            Failed := True;
        end;
      end
      else if Shape is TShapeLoop then // TShapeLoop
      begin
        Inc(Tabs);
        Temp := Shape.Caption;
        if Pos('=', Temp) = 0 then
          Failed := True
        else begin
          VarName := Copy(Temp, 1, Pos('=', Temp) - 1);
          Temp := Copy(Temp, Pos('=', Temp) + 1, Length(Temp));
          if Pos(':', Temp) = 0 then
            Failed := True
          else begin
            Code.Add(DupeString(' ', Tabs) + StringReplace(Temp, ':', ' ', []));
            Code.Add(DupeString(' ', Tabs) + 'FOR ' + VarName);
            Shape := TShapeLoop(Shape).TrueState;
            if Shape = nil then
              Failed := True;
          end;
        end;
      end;
    end;
    I := 0;
    while I < Code.Count do
    begin
      Temp := Code[I];
      if Temp <> '' then
        if Pos('$$', Temp) = 1 then
          Code.Delete(I)
        else
          Inc(I)
      else
        Inc(I);
    end;
    if ExistVar then
    begin
      I := Code.IndexOf(#141);
      Code[I] := #141 + Code[I + 1];
      Code.Delete(I + 1);
      Code.Add(' »');
    end
    else begin
      I := Code.IndexOf(#141);
      Code.Delete(I + 1);
      Code.Delete(I);
    end;
    Code.Add('»|');
    if Failed then
      MsgDlg(Msgs[MSG_CODEERROR], MB_ICONERROR + MB_OK)
    else begin
      Param := Code.Text;
      Close;
    end;
  finally
    I := 0;
    while I < Diagrama.ControlCount do
    begin
      Diagrama.Controls[I].Tag := 0;
      Inc(I);
    end;
    Code.Free;
    Depth.Free;
    Vars.Free;
  end;
end;

procedure TDBuilderForm.EditChangeExecute(Sender: TObject);
var
  Shape: TShapeCustomControl;
begin
  Shape := ShapeSelected;
  if (Shape <> nil) and not (Shape is TShapeTrans) then ShapeDblClick(Shape);
end;

procedure TDBuilderForm.EditCutExecute(Sender: TObject);
begin
  EditCopyExecute(Sender);
  EditDeleteExecute(Sender);
end;

procedure TDBuilderForm.EditCopyExecute(Sender: TObject);
begin
  Clipboard.SetComponent(ShapeSelected);
end;

procedure TDBuilderForm.EditPasteExecute(Sender: TObject);
var
  Shape: TShapeCustomControl;
begin
  Shape := TShapeCustomControl(Clipboard.GetComponent(Self, Diagrama));
  Diagrama.State := nil;
  Shape.Name := Shape.ClassName + GenerateNumber;//IntToStr(FNum);
  Shape.Left := Shape.Left + GridSize;
  Shape.Top := Shape.Top + GridSize;
  TShapeCustomControl.UnselectControl(Diagrama);
  Shape.Selected := True;
  //Inc(FNum);
end;

procedure TDBuilderForm.EditDeleteExecute(Sender: TObject);
begin
  TShapeCustomControl.DeleteSelectedControl(Diagrama);
  Diagrama.Refresh;
end;

procedure TDBuilderForm.ViewToolBarExecute(Sender: TObject);
begin
  ViewToolBar.Checked := not ViewToolBar.Checked;
  ToolBar.Visible := ViewToolBar.Checked;
end;

procedure TDBuilderForm.ViewStatusBarExecute(Sender: TObject);
begin
  ViewStatusBar.Checked := not ViewStatusBar.Checked;
  StatusBar.Visible := ViewStatusBar.Checked;
end;

procedure TDBuilderForm.ViewRunWindowExecute(Sender: TObject);
begin
  ViewRunWindow.Checked := not ViewRunWindow.Checked;
  RunPanel.Visible := ViewRunWindow.Checked;
end;

procedure TDBuilderForm.DiagramInsertShape(Sender: TObject);
begin
  if InsertShape <> 0 then
    TAction(FindComponent('DiagramShape' + IntToStr(InsertShape))).Checked := False;
  InsertShape := TAction(Sender).Tag;
  TAction(Sender).Checked := True;
end;

procedure TDBuilderForm.DiagramConnectExecute(Sender: TObject);
begin
  ConectMode := lmBegin;
  DiagramConnect.Checked := True;
  Diagrama.Cursor := crUpArrow;
  DoStatusChange;
end;

procedure TDBuilderForm.RunRunExecute(Sender: TObject);
begin
  if IsPrepareToRun then
  begin
    RunStep.Enabled := False;
    Diagrama.Execute;
  end;
end;

procedure TDBuilderForm.RunStepExecute(Sender: TObject);
begin
  if Diagrama.State <> nil then
    Diagrama.Execute
  else if IsPrepareToRun then
    Diagrama.Options := Diagrama.Options + [soSingleStep];
end;

procedure TDBuilderForm.RunStopExecute(Sender: TObject);
begin
  Diagrama.Stop;
  Diagrama.Options := Diagrama.Options - [soSingleStep];
  Diagrama.Enabled := True;
  RunStep.Enabled := True;
  Diagrama.State := nil;
  IsRunning := False;
end;

procedure TDBuilderForm.ApplicationEventsHint(Sender: TObject);
begin
  StatusBar.Panels.Items[1].Caption := Utf8ToAnsi(' ' + Application.Hint); // ver5
end;

procedure TDBuilderForm.ChangeLanguageFile;
begin
  if not FileExists(LangPath) then
  begin
    MsgDlg(Format(Msgs[MSG_FILENOTEXISTS], [LangPath]), MB_ICONERROR + MB_OK);
    Exit;
  end;
  with TLanguageFile.Create(LangPath) do
  try
    Section := 'BuilderDialog';
    MainMenu.Caption := LoadItem('MenusBarTitle');
    MainMenu.ChevronHint := LoadItem('ToolBarChevronHint');
    ToolBar.Caption := LoadItem('ToolBarTitle');
    ToolBar.ChevronHint := LoadItem('ToolBarChevronHint');
    MenuFile.Caption := LoadItem('MenuFile');
    FileNew.Caption := LoadItem('MenuFileNew');
    FileNew.Hint := LoadItem('MenuFileNewHint');
    FileOpen.Caption := LoadItem('MenuFileOpen');
    FileOpen.Hint := LoadItem('MenuFileOpenHint');
    FileSave.Caption := LoadItem('MenuFileSave');
    FileSave.Hint := LoadItem('MenuFileSaveHint');
    FileSaveAs.Caption := LoadItem('MenuFileSaveAs');
    FileSaveAs.Hint := LoadItem('MenuFileSaveAsHint');
    FileInsert.Caption := LoadItem('MenuFileInsert');
    FileInsert.Hint := LoadItem('MenuFileInsertHint');
    FileExit.Caption := LoadItem('MenuFileExit');
    FileExit.Hint := LoadItem('MenuFileExitHint');
    MenuEdit.Caption := LoadItem('MenuEdit');
    EditChange.Caption := LoadItem('MenuEditChange');
    EditChange.Hint := LoadItem('MenuEditChangeHint');
    EditCut.Caption := LoadItem('MenuEditCut');
    EditCut.Hint := LoadItem('MenuEditCutHint');
    EditCopy.Caption := LoadItem('MenuEditCopy');
    EditCopy.Hint := LoadItem('MenuEditCopyHint');
    EditPaste.Caption := LoadItem('MenuEditPaste');
    EditPaste.Hint := LoadItem('MenuEditPasteHint');
    EditDelete.Caption := LoadItem('MenuEditDelete');
    EditDelete.Hint := LoadItem('MenuEditDeleteHint');
    MenuView.Caption := LoadItem('MenuView');
    ViewToolBar.Caption := LoadItem('MenuViewToolBar');
    ViewToolBar.Hint := LoadItem('MenuViewToolBarHint');
    ViewStatusBar.Caption := LoadItem('MenuViewStatusBar');
    ViewStatusBar.Hint := LoadItem('MenuViewStatusBarHint');
    ViewRunWindow.Caption := LoadItem('MenuViewRunWindow');
    ViewRunWindow.Hint := LoadItem('MenuViewRunWindowHint');
    MenuDiagram.Caption := LoadItem('MenuDiagram');
    DiagramShape1.Caption := LoadItem('MenuDiagramShapeBegin');
    DiagramShape1.Hint := LoadItem('MenuDiagramShapeBeginHint');
    DiagramShape2.Caption := LoadItem('MenuDiagramShapeRead');
    DiagramShape2.Hint := LoadItem('MenuDiagramShapeReadHint');
    DiagramShape3.Caption := LoadItem('MenuDiagramShapeAction');
    DiagramShape3.Hint := LoadItem('MenuDiagramShapeActionHint');
    DiagramShape4.Caption := LoadItem('MenuDiagramShapeCondition');
    DiagramShape4.Hint := LoadItem('MenuDiagramShapeConditionHint');
    DiagramShape5.Caption := LoadItem('MenuDiagramShapeBucle');
    DiagramShape5.Hint := LoadItem('MenuDiagramShapeBucleHint');
    //DiagramShape6.Caption := LoadItem('MenuDiagramShapeConector');
    //DiagramShape6.Hint := LoadItem('MenuDiagramShapeConectorHint');
    DiagramShape7.Caption := LoadItem('MenuDiagramShapeWrite');
    DiagramShape7.Hint := LoadItem('MenuDiagramShapeWriteHint');
    DiagramShape8.Caption := LoadItem('MenuDiagramShapeEnd');
    DiagramShape8.Hint := LoadItem('MenuDiagramShapeEndHint');
    DiagramConnect.Caption := LoadItem('MenuDiagramConnect');
    DiagramConnect.Hint := LoadItem('MenuDiagramConnectHint');
    MenuRun.Caption := LoadItem('MenuRun');
    RunRun.Caption := LoadItem('MenuRunRun');
    RunRun.Hint := LoadItem('MenuRunRunHint');
    RunStep.Caption := LoadItem('MenuRunStep');
    RunStep.Hint := LoadItem('MenuRunStepHint');
    RunStop.Caption := LoadItem('MenuRunStop');
    RunStop.Hint := LoadItem('MenuRunStopHint');
    RunPanel.Caption := LoadItem('PanelWindowRun');
  finally
    Free;
  end;
end;

procedure TDBuilderForm.DiagramaClick(Sender: TObject);
var
  Point: TPoint;
begin
  if ConectMode <> lmNone then
  begin
    MsgDlg(Msgs[MSG_NOBLOCKCONECT], MB_ICONERROR + MB_OK);
    Exit;
  end;
  TShapeCustomControl.UnselectControl(Diagrama);
  if InsertShape <> 0 then
  begin
    GetCursorPos(Point);
    Point := Diagrama.ScreenToClient(Point);
    DoInsertShape('Control' + GenerateNumber{IntToStr(FNum)}, '', 0, SnapToGrid(Point.X), SnapToGrid(Point.Y), 0);
    Modified := True;
  end;
  DoStatusChange;
end;

procedure TDBuilderForm.ShapeClick(Sender: TObject);
begin
  Modified := True;
  if InsertShape <> 0 then
  begin
    DiagramaClick(Self);
    Exit;
  end;
  if (ConectMode = lmBegin) and (Sender is TShapeStop) then
  begin
    MsgDlg(Msgs[MSG_SELECTOTHERBLOCK], MB_ICONERROR + MB_OK);
    Exit;
  end;
  if (ShapeBegin <> nil) and (ConectMode <> lmBegin) and (ConectMode <> lmNone) then
    if (ShapeBegin.Name = TShapeCustomControl(Sender).Name) then
    begin
      MsgDlg(Msgs[MSG_SELECTOTHERBLOCK], MB_ICONERROR + MB_OK);
      Exit;
    end;
  case ConectMode of
    lmBegin:
      begin
        ShapeBegin := TShapeCustomControl(Sender);
        if Sender is TShapeBoolean or (Sender is TShapeLoop) then
          ConectMode := lmBoolean
        else if Sender is TShapeLink then
          ConectMode := lmLink
        else ConectMode := lmNormal;
      end;
    lmNormal:
      begin
        TShapeNode(ShapeBegin).DefaultTransition := TShapeCustomControl(Sender);
        ConectMode := lmNone;
        DiagramConnect.Checked := False;
        Diagrama.Cursor := crDefault;
      end;
    lmBoolean:
      begin
        if ShapeBegin is TShapeBoolean then
          TShapeBoolean(ShapeBegin).TrueState := TShapeCustomControl(Sender)
        else
          TShapeLoop(ShapeBegin).TrueState := TShapeCustomControl(Sender);
        ConectMode := lmNext;
      end;
    lmNext:
      begin
        if ShapeBegin is TShapeBoolean then
          TShapeBoolean(ShapeBegin).FalseState := TShapeCustomControl(Sender)
        else
          TShapeLoop(ShapeBegin).FalseState := TShapeCustomControl(Sender);
        ConectMode := lmNone;
        DiagramConnect.Checked := False;
        Diagrama.Cursor := crDefault;
      end;
    lmLink:
      begin
        if Sender is TShapeLink then
        begin
          TShapeLink(Sender).Direction := ldIncoming;
          TShapeLink(ShapeBegin).Direction := ldOutgoing;
          TShapeLink(ShapeBegin).Destination := TShapeCustomControl(Sender);
        end
        else begin
          TShapeLink(ShapeBegin).Direction := ldIncoming;
          TShapeLink(ShapeBegin).Destination := TShapeCustomControl(Sender);
        end;
        ConectMode := lmNone;
        DiagramConnect.Checked := False;
        Diagrama.Cursor := crDefault;
      end;
  end;
  DoStatusChange;
end;

procedure TDBuilderForm.ShapeDblClick(Sender: TObject);
begin
  if Sender is TShapeTrans then
    Exit;
  with TEditorForm.Create(Self) do
  try
    Edit.Text := TShapeCustomControl(Sender).Caption;
    if ShowModal = mrOk then
    begin
      TShapeCustomControl(Sender).Caption := Edit.Text;
      Modified := True;
    end;
  finally
    Free;
  end;
  Diagrama.Refresh;
  DoStatusChange;
end;

procedure TDBuilderForm.ShapeEnterState(Sender: TObject);
var
  Str, nVar, TempVal: string;
  pos: Integer;
  Index: Integer;
begin
  Str := TShapeCustomControl(Sender).Caption;
  if IsShapeBlank(Str) then Exit;
  if Sender is TShapeStart then
  begin
    Debug(Str);
  end;
  if Sender is TShapeRead then
  begin
    pos := 1;
    nVar := '';
    Trim(Str);
    while pos <= Length(Str) do
    begin
      case Str[pos] of
        ',':
        begin
          if nVar = '' then
          begin
            DebugError(Msgs[MSG_VAREXPECTED]);
            Exit;
          end
          else nVar := '';
        end;
        'a'..'z', 'A'..'Z', '_':
        begin
          while (pos <= Length(Str)) and (Str[pos] in ['a'..'z', 'A'..'Z', '_', '1'..'9', '0']) do
          begin
            nVar := nVar + Str[pos];
            Inc(pos);
          end;
          Dec(pos);
          TempVal := '';
          with TInputForm.Create(Self) do
          try
            VarName := nVar;
            if ShowModal = mrOk then
              TempVal := Edit.Text
          finally
            Free;
          end;
          if TempVal <> '' then
          begin
            Index := VarNames.IndexOf(nVar);
            if Index <> -1 then
            begin
              VarValues[Index] := StrToFloat(TempVal);
              Debug(Format(' %g >> %s', [VarValues[Index], nVar]));
            end
            else begin
              VarNames.Add(nVar);
              VarValues[VarNames.Count - 1] := StrToFloat(TempVal);
              Debug(Format(' %g >> %s', [VarValues[VarNames.Count - 1], nVar]));
            end;
          end
          else begin
            DebugError(Msgs[MSG_NOINPUTDATA]);
            Exit;
          end;
        end
        else begin
          DebugError(Msgs[MSG_VARBADNAME]);
          Exit;
        end;
      end;
      Inc(pos);
    end;
  end;
  if Sender is TShapeWrite then
  begin
    pos := 1;
    nVar := '';
    if Str[1] = '"' then
      if Str[Length(Str)] = '"' then
      begin
        Debug(' >> ' + Str);
        Exit;
      end
      else begin
        DebugError(Msgs[MSG_STRINGEXPECTED]);
        Exit;
      end;
    Trim(Str);
    while pos <= Length(Str) do
    begin
      case Str[pos] of
        ',':
        begin
          if nVar = '' then
          begin
            DebugError(Msgs[MSG_VAREXPECTED]);
            Exit;
          end
          else nVar := '';
        end;
        'a'..'z', 'A'..'Z', '_':
        begin
          while (pos <= Length(Str)) and (Str[pos] in ['a'..'z', 'A'..'Z', '_', '1'..'9', '0']) do
          begin
            nVar := nVar + Str[pos];
            Inc(pos);
          end;
          Dec(pos);
          Index := VarNames.IndexOf(nVar);
          if Index <> -1 then
            Debug(Format(' %s = %g', [nVar, VarValues[Index]]))
          else begin
            DebugError(Msgs[MSG_NOEXISTSVAR]);
            Exit;
          end;
        end
        else begin
          DebugError(Msgs[MSG_INCORRECTVARNAME]);
          Exit;
        end;
      end;
      Inc(pos);
    end;
  end;
  if Sender is TShapeStop then
  begin
    Debug(Str);
    RunStopExecute(Self);
  end;
end;

procedure TDBuilderForm.ShapeBooleanEnterState(Sender: TShapeBoolean;
  var Result: Boolean);
var
  Str: string;
  Value: Extended;
  //Res: Integer;
begin
  Str := Sender.Caption;
  if IsShapeBlank(Str) then Exit;
  try
    Parser.Formula := Str;
    Parser.Variables := VarNames;
    Value := Parser.calc(VarValues);
    if Value = 0 then
      Debug(' ''' + Str + ''' >> ' + Caps[LBL_FALSE])
    else
      Debug(' ''' + Str + ''' >> ' + Caps[LBL_TRUE]);
  except
    DebugError(Msgs[MSG_NOEVALFORMULA]);
    Exit;
  end;
  Result := Trunc(Value) = 1;
end;

procedure TDBuilderForm.ShapeLoopEnterState(Sender: TShapeLoop;
  var Result: Boolean);
var
  Str, nVar, sInicio, sFin: string;
  Indice: Integer;
  vInicio, vFin: Extended;
begin
  Str := Sender.Caption;
  if IsShapeBlank(Str) then Exit;
  Trim(Str);
  Indice := Pos('=', Str);
  if Indice <> 0 then
  begin
    nVar := Copy(Str, 1, Indice - 1);
    Trim(nVar);
    if nVar = '' then
    begin
      DebugError(Msgs[MSG_VARBADNAME]);
      Exit;
    end;
    Str := Copy(Str, Indice + 1, Length(Str));
    Indice := Pos(':', Str);
    if Indice <> 0 then
    begin
      sInicio := Copy(Str, 1, Indice - 1);
      sFin := Copy(Str, Indice + 1, Length(Str));
      Trim(sInicio);
      if sInicio = '' then
      begin
        DebugError(Msgs[MSG_NOINITVALUE]);
        Exit;
      end
      else begin
        try
          Parser.Formula := sInicio;
          Parser.Variables := VarNames;
          vInicio := Parser.calc(VarValues);
        except
          DebugError(Msgs[MSG_NOEVALFORMULA]);
          Exit;
        end;
      end;
      if sFin = '' then
      begin
        DebugError(Msgs[MSG_NOENDVALUE]);
        Exit;
      end
      else begin
        try
          Parser.Formula := sFin;
          Parser.Variables := VarNames;
          vFin := Parser.calc(VarValues);
        except
          DebugError(Msgs[MSG_NOEVALFORMULA]);
          Exit;
        end;
      end;
      Indice := VarNames.IndexOf(nVar);
      if Indice <> -1 then
        if Sender.Tag = 1 then
          VarValues[Indice] := VarValues[Indice] + 1
        else begin
          VarValues[Indice] := vInicio;
          Sender.Tag := 1;
        end
      else begin
        VarNames.Add(nVar);
        Indice := VarNames.Count - 1;
        VarValues[Indice] := vInicio;
        Sender.Tag := 1;
      end;
    end  
    else begin
      DebugError(Msgs[MSG_BUCLESYNERROR]);
      Exit;
    end;
  end
  else begin
    DebugError(Msgs[MSG_BUCLESYNERROR]);
    Exit;
  end;
  Debug(Format(' %s << %g', [nVar, VarValues[Indice]]));
  Result := Trunc(VarValues[Indice]) <= Trunc(vFin);
  if not Result then Sender.Tag := 0;
end;

procedure TDBuilderForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #27) and (ConectMode <> lmNone) then
  begin
    ConectMode := lmNone;
    DiagramConnect.Checked := False;
    Diagrama.Cursor := crDefault;
  end;
  if (Key = #27) and (InsertShape <> 0) then
  begin
    TAction(FindComponent('DiagramShape' + IntToStr(InsertShape))).Checked := False;
    InsertShape := 0;
  end;
end;

procedure TDBuilderForm.Debug(Str: string);
begin
  //if (Str[1] = '<') or (Str[1] = '-') or (soSingleStep in Diagrama.Options) then
    Memo.Lines.Add(Str);
end;

function TDBuilderForm.IsShapeBlank(Str: string): Boolean;
begin
  Result := False;
  if Str = '' then
  begin
    DebugError(Msgs[MSG_BLANKBLOCK]);
    Result := True;
  end;
end;

procedure TDBuilderForm.ShapeActionEnterState(Sender: TObject);
var
  Str, nVar, Expr: string;
  Indice: Integer;
  Value: Extended;
begin
  Str := TShapeCustomControl(Sender).Caption;
  if IsShapeBlank(Str) then Exit;
  Indice := Pos('=', Str);
  if Indice <> 0 then
  begin
    nVar := Copy(Str, 1, Indice - 1);
    Expr := Copy(Str, Indice + 1, Length(Str));
    Trim(nVar);
    if nVar = '' then
    begin
      DebugError(Msgs[MSG_VAREXPECTED]);
      Exit;
    end;
    try
      Parser.Formula := Expr;
      Parser.Variables := VarNames;
      Value := Parser.calc(VarValues);
    except
      DebugError(Msgs[MSG_NOEVALFORMULA]);
      Exit;
    end;
    Indice := VarNames.IndexOf(nVar);
    if Indice <> -1 then
      VarValues[Indice] := Value
    else begin
      VarNames.Add(nVar);
      VarValues[VarNames.Count - 1] := Value;
    end;
    Debug(Format(' %s << %g', [nVar, Value]));
  end
  else begin
    Debug(' ' + Str);
  end;
end;

procedure TDBuilderForm.DebugError(Err: string);
begin
  MessageBeep(MB_ICONHAND);
  Memo.Lines.Add(Format('{' + Caps[LBL_ERROR] + ': %s}', [Err]));
  Diagrama.Stop;
  Diagrama.Enabled := True;
end;

function TDBuilderForm.DoSaveFile(FileName: string): Boolean;
var
  BinStream: TStream;
  w: TWriter;
  I, T: Integer;

procedure WriteDestination(Shape: TShapeCustomControl);
begin
  if Shape <> nil then
    w.WriteString(Shape.Name)
  else
    w.WriteString('None');
end;

begin
  try
    BinStream := TFileStream.Create(FileName, fmCreate);
    try
      w := TWriter.Create(BinStream, 1024);
      try
        w.WriteString('ADB%RGB_2007');
        with Diagrama do
        begin
          w.WriteInteger(ControlCount);
          For I := 0 to ControlCount - 1 do
          begin
            w.WriteInteger(ShapeType(TShapeCustomControl(Controls[I])));
            w.WriteString(TShapeCustomControl(Controls[I]).Name);
            w.WriteString(TShapeCustomControl(Controls[I]).Caption);
            w.WriteInteger(TShapeCustomControl(Controls[I]).Height);
            w.WriteInteger(TShapeCustomControl(Controls[I]).Left);
            w.WriteInteger(TShapeCustomControl(Controls[I]).Top);
            w.WriteInteger(TShapeCustomControl(Controls[I]).Width);
          end;
          For I := 0 to ControlCount - 1 do
          begin
            T := ShapeType(TShapeCustomControl(Controls[I]));
            w.WriteInteger(T);
            case T of
              1, 2, 3, 7, 8, 9:
                WriteDestination(TShapeNode(Controls[I]).DefaultTransition);
              4:
                begin
                  WriteDestination(TShapeBoolean(Controls[I]).TrueState);
                  WriteDestination(TShapeBoolean(Controls[I]).FalseState);
                end;
              5:
                begin
                  WriteDestination(TShapeLoop(Controls[I]).TrueState);
                  WriteDestination(TShapeLoop(Controls[I]).FalseState);
                end;
              6:
                begin
                  w.WriteInteger(Ord(TShapeLink(Controls[I]).Direction));
                  WriteDestination(TShapeLink(Controls[I]).Destination);
                end;
            end;
          end;
        end;
        FileEdit := FileName;
        Modified := False;
        DoStatusChange;
        Result := True;
      finally
        w.Free;
      end;
    finally
      BinStream.Free;
    end;
  except
    Result := False;
  end;
end;

procedure TDBuilderForm.DoDiagramClear;
begin
  while Diagrama.ControlCount > 0 do
    Diagrama.Controls[0].Free;
  FileEdit := Caps[LBL_NONAME];
  Modified := False;
end;

procedure TDBuilderForm.DoStatusChange;
begin
  Caption := 'Constructor - [' + FileEdit + ']';
  StatusBar.Panels.Items[0].Caption := '';
  if Modified then
  begin
    StatusBar.Panels.Items[0].Caption := Caps[LBL_MODIFIED];
    Caption := Caption + '*';
  end;
end;

procedure TDBuilderForm.DoInsertShape(sName, sCaption: string; H, L, T,
  W: Integer);
var
  Shape: TShapeCustomControl;
begin
  Shape := nil;
  case InsertShape of
    1: begin
         Shape := TShapeStart.Create(Self);
         TShapeStart(Shape).OnEnterState := ShapeEnterState;
       end;
    2: begin
         Shape := TShapeRead.Create(Self);
         TShapeRead(Shape).OnEnterState := ShapeEnterState;
       end;
    3: begin
         Shape := TShapeNode.Create(Self);
         TShapeNode(Shape).OnEnterState := ShapeActionEnterState;
       end;
    4: begin
         Shape := TShapeBoolean.Create(Self);
         TShapeBoolean(Shape).OnEnterState := ShapeBooleanEnterState;
       end;
    5: begin
         Shape := TShapeLoop.Create(Self);
         TShapeLoop(Shape).OnEnterState := ShapeLoopEnterState;
       end;
    6: begin
         Shape := TShapeLink.Create(Self);
       end;
    7: begin
         Shape := TShapeWrite.Create(Self);
         TShapeWrite(Shape).OnEnterState := ShapeEnterState;
       end;
    8: begin
         Shape := TShapeStop.Create(Self);
         TShapeStop(Shape).OnEnterState := ShapeEnterState;
       end;
    9: begin
         Shape := TShapeTrans.Create(Self);
         //TShapeTrans(Shape).OnEnterState := ShapeEnterState;
       end;
  end;
  Shape.Caption := sCaption;
  if H <> 0 then Shape.Height := H;
  Shape.Left := L;
  if sName = '' then sName := Shape.ClassName + GenerateNumber;//IntToStr(FNum);
  Shape.Name := sName;
  Shape.Parent := Diagrama;
  Shape.Top := T;
  if W <> 0 then Shape.Width := W;
  Shape.OnClick := ShapeClick;
  Shape.OnDblClick := ShapeDblClick;
  TAction(FindComponent('DiagramShape' + IntToStr(InsertShape))).Checked := False;
  Diagrama.State := nil;
  InsertShape := 0;
  //Inc(FNum);
end;

function TDBuilderForm.ShapeSelected: TShapeCustomControl;
var
  I: Integer;
  IsSelected: Boolean;
begin
  Result := nil;
  I := 0;
  IsSelected := False;
  while (I < Diagrama.ControlCount) and not IsSelected do
    if (Diagrama.Controls[I] is TShapeCustomControl) and
       TShapeCustomControl(Diagrama.Controls[I]).Selected then IsSelected := True
    else Inc(I);
  if IsSelected then Result := TShapeCustomControl(Diagrama.Controls[I]);
end;

function TDBuilderForm.ShapeType(Shape: TShapeCustomControl): Integer;
begin
  if Shape is TShapeStart then Result := 1
  else if Shape is TShapeRead then Result := 2
  else if Shape is TShapeBoolean then Result := 4
  else if Shape is TShapeLoop then Result := 5
  else if Shape is TShapeLink then Result := 6
  else if Shape is TShapeWrite then Result := 7
  else if Shape is TShapeStop then Result := 8
  else if Shape is TShapeTrans then Result := 9
  else Result := 3;
end;

procedure TDBuilderForm.ActionManagerUpdate(Action: TBasicAction;
  var Handled: Boolean);
begin
  FileSave.Enabled := Modified;
  EditChange.Enabled := ShapeSelected <> nil;
  EditCut.Enabled := EditChange.Enabled;
  EditCopy.Enabled := EditChange.Enabled;
  EditPaste.Enabled := not IsRunning and Clipboard.HasFormat(CF_COMPONENT);
  EditDelete.Enabled := EditChange.Enabled;
  DiagramShape1.Enabled := not IsRunning;
  DiagramShape2.Enabled := not IsRunning;
  DiagramShape3.Enabled := not IsRunning;
  DiagramShape4.Enabled := not IsRunning;
  DiagramShape5.Enabled := not IsRunning;
  DiagramShape6.Enabled := not IsRunning;
  DiagramShape7.Enabled := not IsRunning;
  DiagramShape8.Enabled := not IsRunning;
  DiagramShape9.Enabled := not IsRunning;
  DiagramConnect.Enabled := (Diagrama.ControlCount > 1) and not IsRunning;
  RunRun.Enabled := not IsRunning;
  RunStop.Enabled := IsRunning;
end;

function TDBuilderForm.DoCloseDiagram: Boolean;
begin
  Result := False;
  if IsRunning then
    if MsgDlg(Msgs[MSG_RUNNINGDIAGRAM], MB_ICONQUESTION + MB_YESNO) = IDYES then
      RunStopExecute(Self)
    else
      Exit;
  if Modified then
  begin
    case MsgDlg(Msgs[MSG_DIAGRAMMODIFIED], MB_ICONQUESTION + MB_YESNOCANCEL) of
      IDYES:
        begin
          FileSaveExecute(Self);
          DoDiagramClear;
          Result := True;
        end;
      IDNO:
        begin
          DoDiagramClear;
          Result := True;
        end;
    end;
  end
  else begin
    DoDiagramClear;
    Result := True;
  end;
  Diagrama.Refresh;  
end;

function TDBuilderForm.DoOpenFile(FileName: string): Boolean;
var
  BinStream: TStream;
  r: TReader;
  I, N, H, L, T, W: Integer;
  sCaption, sName: string;

function FindShape: TShapeCustomControl;
var
  C: Integer;
  IsFound: Boolean;
  Str: string;
begin
  Result := nil;
  C := 0;
  IsFound := False;
  Str := r.ReadString;
  while (C < Diagrama.ControlCount) and not IsFound do
    if (Diagrama.Controls[C] is TShapeCustomControl) and
       (TShapeCustomControl(Diagrama.Controls[C]).Name = Str) then IsFound := True
    else Inc(C);
  if IsFound then Result := TShapeCustomControl(Diagrama.Controls[C]);
end;

begin
  ScrollBox.HorzScrollBar.Position := 0;
  ScrollBox.VertScrollBar.Position := 0;
  try
    BinStream := TFileStream.Create(FileName, fmOpenRead);
    try
      r := TReader.Create(BinStream, 1024);
      try
        if r.ReadString <> 'ADB%RGB_2007' then
        begin
          MsgDlg(Msgs[MSG_NOVALIDFORMAT], MB_ICONSTOP + MB_OK);
          Result := False;
          Exit;
        end;
        with Diagrama do
        begin
          N := r.ReadInteger;
          For I := 0 to N - 1 do
          begin
            InsertShape := r.ReadInteger;
            sName := r.ReadString;
            sCaption := r.ReadString;
            H := r.ReadInteger;
            L := r.ReadInteger;
            T := r.ReadInteger;
            W := r.ReadInteger;
            DoInsertShape(sName, sCaption, H, L, T, W);
          end;
          For I := 0 to N - 1 do
          begin
            T := r.ReadInteger;
            case T of
              1, 2, 3, 7, 8, 9:
                begin
                  TShapeNode(Controls[I]).DefaultTransition := FindShape;
                end;
              4:
                begin
                  TShapeBoolean(Controls[I]).TrueState := FindShape;
                  TShapeBoolean(Controls[I]).FalseState := FindShape;
                end;
              5:
                begin
                  TShapeLoop(Controls[I]).TrueState := FindShape;
                  TShapeLoop(Controls[I]).FalseState := FindShape;
                end;
              6:
                begin
                  TShapeLink(Controls[I]).Direction := TLinkDirection(r.ReadInteger);
                  TShapeLink(Controls[I]).Destination := FindShape;
                end;
            end;
          end;
        end;
        FileEdit := FileName;
        MRUList.Add(FileEdit);
        DoStatusChange;
        Result := True;
      finally
        r.Free;
      end;
    finally
      BinStream.Free;
    end;
  except
    Result := False;
  end;
end;

procedure TDBuilderForm.MRUListClick(Sender: TObject; const Filename: String);
begin
  if not DoOpenFile(FileName) then
    MsgDlg(Msgs[MSG_NOACCESSDIAGRAM], MB_ICONERROR + MB_OK)
end;

function TDBuilderForm.IsPrepareToRun: Boolean;
var
  I: Integer;
  ExistStart: Boolean;
  ExistEnd: Boolean;
begin
  I := 0;
  ExistStart := False;
  ExistEnd := False;
  while (I < Diagrama.ControlCount) and not ExistStart do
    if Diagrama.Controls[I] is TShapeStart then
      ExistStart := True
    else Inc(I);
  if ExistStart then
  begin
    IsRunning := True;
    VarNames.Clear;
    VarNames.Add('Pi');
    VarValues[VarNames.Count - 1] := Pi;
    Memo.Lines.Clear;
    TShapeCustomControl.UnselectControl(Diagrama);
    Diagrama.Enabled := False;
    Diagrama.State := TShapeCustomControl(Diagrama.Controls[I]);
    ActionManagerUpdate(RunRun, ExistStart);
    Result := True;
  end
  else begin
    MsgDlg(Msgs[MSG_NOBEGINBLOCK], MB_ICONERROR + MB_OK);
    Result := False;
    Exit;
  end;
  I := 0;
  while (I < Diagrama.ControlCount) and not ExistEnd do
    if Diagrama.Controls[I] is TShapeStop then
      ExistEnd := True
    else Inc(I);
  if not ExistEnd then
  begin
    MsgDlg(Msgs[MSG_NOENDBLOCK], MB_ICONERROR + MB_OK);
    Result := False;
  end;
end;

procedure TDBuilderForm.ScrollBoxMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Diagrama.Refresh;
end;

procedure TDBuilderForm.DiagramaChangeState(Sender: TDiagramControl; FromState,
  ToState: TShapeCustomControl);
begin
  Application.ProcessMessages;
  Sleep(100);
end;

initialization
  RegisterClasses([TShapeStart, TShapeRead, TShapeNode, TShapeBoolean,
                   TShapeLoop, TShapeLink, TShapeWrite, TShapeStop,
                   TShapeTrans]);

end.
