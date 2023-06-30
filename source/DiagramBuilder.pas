unit DiagramBuilder;
// -----------------------------------------------------------------------------
// Project: Diagram Builder
// Module: DiagramBuild
// Description: Constructor de Diagramas
// Version: 2.0
// Release: 4
// Date: 6-OCT-2003
// Target: Delphi 2 ~ 7.
// Author: Roger Broncano Reyes, rgbinnet@hotmail.com
//         Basado en State Machine by Anders Melander, anders@melander.dk
//         Copyright (c) 2003 by Anders Melander & Roger Broncano
// Formatting: 2 space indent, 8 space tabs, 80 columns.
// -----------------------------------------------------------------------------

interface

uses
  ExtCtrls,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs;

// Windows message used to initiate state transitions
const
  SM_STATE_TRANSITION = WM_USER;

type
  TDiagramControl = class;
  TShapeCustomControl = class;
  TShapeConnector = class;

  // Type of the OnChangeState event
  TChangeStateEvent = procedure(Sender: TDiagramControl;
    FromState, ToState: TShapeCustomControl) of object;

  // Type of the OnException event
  TStateExceptionEvent = procedure(Sender: TDiagramControl; Node: TShapeCustomControl;
    Error: Exception) of object;

  // Run-time options:
  //
  //   soInteractive
  //			If set, the TDiagramControl will be visible at run-time.
  //			The current state will be painted in red and bold.
  //
  //   soSingleStep
  //			If set, the execution will stop after each transition.
  //			Use the Execute method to resume execution.
  //
  //   soVerifyTransitions
  //			If set, transitions (TShapeTransition) will verify their
  //			source states when executed.
  //			An attempt to move through a transition from a state
  //			other than the one specified as the "FromState" will
  //			cause an exception to be raised.
  //			If the transition does not specify a "FromState", the
  //			transition will not be validated.
  //
  TDiagramControlOption = (soInteractive, soSingleStep, soVerifyTransitions);
  TDiagramControlOptions = set of TDiagramControlOption;

  TDesignMove = (dmSource, dmFirstHandle, dmOffset, dmLastHandle, dmDestination, dmNone);
  TConnectorLines = array[dmSource..dmDestination] of TPoint;

  TDiagramControl = class(TCustomPanel)
  private
    FState: TShapeCustomControl;
    FOnChangeState: TChangeStateEvent;
    FOnException: TStateExceptionEvent;
    FActive: Boolean;
    StateChanged: Boolean;
    FConnector: TShapeConnector;
    FDesignMoving: TDesignMove;
    Lines: TConnectorLines;
    FStopSignalled: Boolean;
    FOptions: TDiagramControlOptions;
  protected
    procedure SetState(Value :TShapeCustomControl);
    procedure DoSetState(Value :TShapeCustomControl);
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure Paint; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure DoOnChangeState(FromState, ToState: TShapeCustomControl); dynamic;
    procedure DoOnException(Node: TShapeCustomControl; E: Exception); dynamic;
    procedure SMShapeTransition(var Message: TMessage); message SM_STATE_TRANSITION;
    procedure CMDesignHitTest(var Msg: TWMMouse); message CM_DESIGNHITTEST;
  public
    procedure Execute;
    procedure Stop;
    procedure ChangeState(Transition: TShapeCustomControl);
    procedure PostStateChange(State: TShapeCustomControl);
    property StopSignalled: Boolean read FStopSignalled;
  published
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Active: boolean read FActive write FActive default False;
    property State: TShapeCustomControl read FState write SetState;
    property Options: TDiagramControlOptions read FOptions write FOptions;
    property OnChangeState: TChangeStateEvent read FOnChangeState write FOnChangeState;
    property OnException: TStateExceptionEvent read FOnException write FOnException;
    property Align;
    property Color;
    property Enabled;
    property Font;
    property OnClick;
  end;

  TTransitionDirection = (tdFrom, tdTo);
  TVisualElement = (veShadow, veFrame, vePanel, veText, veConnector);
  TStatePathOwner = (poOwnedBySource, poOwnedByDestination);

  TShapeCustomControl = class(TGraphicControl)
  private
    FCanProcessMouseMsg: Boolean;
    FCaption: string;
    FConnectors: TList;
    FSelected: Boolean;
    FDiagramControl: TDiagramControl;
    FWasCovered: Boolean;
    procedure ReadConnectors(Reader: TReader);
    procedure WriteConnectors(Writer: TWriter);
    procedure SetSelected(Value: Boolean); virtual;
  protected
    procedure DefineProperties(Filer: TFiler); override;
    procedure SetCaption(Value: string);
    procedure SetActive(Value: boolean); virtual;
    function GetActive: boolean; virtual;
    procedure SetParent(AParent: TWinControl); override;
    function GetCheckDiagramControl: TDiagramControl;
    property CheckDiagramControl: TDiagramControl read GetCheckDiagramControl;
    procedure Paint; override;
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
    procedure DoOnEnter; virtual;
    procedure DoOnExit; virtual;
    function DoDefault: Boolean; virtual;
    procedure PrepareCanvas(Element: TVisualElement; Canvas: TCanvas); virtual;
    procedure DrawText(TextRect: TRect); virtual;
    procedure DoPaint; virtual;
    function AddConnector(OwnerRole: TStatePathOwner): TShapeConnector;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    function GetCustomShapeAtPos(X, Y: Integer): TShapeCustomControl;
    property CanProcessMouseMsg: Boolean read FCanProcessMouseMsg
      write FCanProcessMouseMsg;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property DiagramControl: TDiagramControl read FDiagramControl;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
    procedure PaintConnector; virtual;
    function HitTest(Mouse: TPoint): TShapeConnector; virtual;
    procedure CheckTransition(Transition: TShapeCustomControl; Direction: TTransitionDirection); virtual;
    class procedure UnselectControl(ParentControl: TWinControl);
    class procedure DeleteSelectedControl(ParentControl: TWinControl);
    property Active: boolean read GetActive write SetActive default False;
    property Connectors: TList read FConnectors;
    property Selected: Boolean read FSelected write SetSelected;
  published
    property Caption: string read FCaption write SetCaption;
    property OnClick;
    property OnDblClick;
  end;

  TShapeMoveableControl = class(TShapeCustomControl)
  private
    FOrigin: TPoint;
    FMoving: Boolean;
    FDelta: TPoint;
    PenModeSave: TPenMode;
    PenColorSave: TColor;
    PenStyleSave: TPenStyle;
    PenWidthSave: Integer;
    BrushStyleSave: TBrushStyle;
    procedure SaveAttributes;
    procedure RestoreAttributes;
  protected
    procedure StartMove(X, Y: Integer);
    procedure Move(DeltaX, DeltaY: Integer);
    procedure EndMove;
    function ValidMove(DeltaX, DeltaY: Integer): Boolean;
    procedure MoveShapes(DeltaX, DeltaY: Integer);
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    property Moving: Boolean read FMoving write FMoving;
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TSizingMode = (smTopLeft, smTop, smTopRight, smLeft, smRight,
    smBottomLeft, smBottom, smBottomRight, smNone);

  TShapeSizeableControl = class(TShapeMoveableControl)
  private
    FSizingMode: TSizingMode;
    FSizeOrigin: TPoint;
    FSizeRectHeight: Integer;
    FSizeRectWidth: Integer;
    FMinHeight: Integer;
    FMinWidth: Integer;
    FSizeRect: TRect;
  protected
    procedure SetSelected(Value: Boolean); override;
    procedure Paint; override;
    procedure DrawSizingRects;
    function GetSizeRect(SizeRectType: TSizingMode): TRect;
    procedure CheckForSizeRects(X, Y: Integer);
    procedure ResizeControl(X, Y: Integer);
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    property SizingMode: TSizingMode read FSizingMode write FSizingMode;
    property SizeRectHeight: Integer read FSizeRectHeight write FSizeRectHeight;
    property SizeRectWidth: Integer read FSizeRectWidth write FSizeRectWidth;
    property MinHeight: Integer read FMinHeight write FMinHeight;
    property MinWidth: Integer read FMinWidth write FMinWidth;
  public
    constructor Create(AOwner: TComponent); override;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
  end;

  TShapeNodeBase = class(TShapeSizeableControl)
  protected
    procedure SetParent(AParent: TWinControl); override;
  end;

  TStatePath = (spAuto, spDirect, spLeftRight, spTopBottom, spTopLeft,
                spRightBottom, spTopTop, spBottomBottom);

  TShapeConnector = class(TObject)
  private
    FSelected: Boolean;
    FOffset: integer;
    FPath: TStatePath;
    FActualPath: TStatePath;
    FOwner: TStatePathOwner;
    FSource: TShapeCustomControl;
    FDestination: TShapeCustomControl;
    BoundsRect: TRect;
  protected
    procedure SetPeer(Index: integer; Value: TShapeCustomControl);
    function GetPeer(Index: integer): TShapeCustomControl;
  public
    constructor Create(AOwner: TShapeCustomControl; OwnerRole: TStatePathOwner);
    procedure Paint;
    procedure PaintFlipLine;
    function HitTest(Mouse: TPoint): Boolean;
    function GetLines(var Lines: TConnectorLines): Boolean;
    class function MakeRect(pa, pb: TPoint): TRect;
    class function RectCenter(r: TRect): TPoint;
    property Source: TShapeCustomControl index 1 read FSource write SetPeer;
    property Destination: TShapeCustomControl index 2 read FDestination write SetPeer;
    property PeerNode: TShapeCustomControl index 0 read GetPeer write SetPeer;
    property ActualPath: TStatePath read FActualPath;
    property Selected: Boolean read FSelected write FSelected;
  published
    property Path: TStatePath read FPath write FPath;
    property Offset: integer read FOffset write FOffset;
  end;

  TShapeBoolean = class;
  TBooleanStateEvent = procedure(Sender: TShapeBoolean; var Result: Boolean) of object;

  TShapeBoolean = class(TShapeNodeBase)
  private
    FOnEnterState: TBooleanStateEvent;
    FOnExitState: TNotifyEvent;
    FTrueState: TShapeCustomControl;
    FFalseState: TShapeCustomControl;
    FTrueConnector: TShapeConnector;
    FFalseConnector: TShapeConnector;
    FResult: Boolean;
    FDefault: Boolean;
  protected
    procedure DoPaint; override;
    procedure PrepareCanvas(Element: TVisualElement; Canvas: TCanvas); override;
    procedure SetTrueState(Value :TShapeCustomControl);
    procedure SetFalseState(Value :TShapeCustomControl);
    procedure SetDefault(Value :Boolean);
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
    procedure DoOnEnter; override;
    procedure DoOnExit; override;
    function DoDefault: Boolean; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
    procedure PaintConnector; override;
    function HitTest(Mouse: TPoint): TShapeConnector; override;
  published
    property OnEnterState: TBooleanStateEvent read FOnEnterState write FOnEnterState;
    property OnExitState: TNotifyEvent read FOnExitState write FOnExitState;
    property TrueState: TShapeCustomControl read FTrueState write SetTrueState;
    property FalseState: TShapeCustomControl read FFalseState write SetFalseState;
    property DefaultState: Boolean read FDefault write SetDefault default True;
  end;

  TShapeNode = class(TShapeNodeBase)
  private
    FOnEnterState: TNotifyEvent;
    FOnExitState: TNotifyEvent;
    FDefaultTransition: TShapeCustomControl;
    FToConnector: TShapeConnector;
  protected
    procedure PrepareCanvas(Element: TVisualElement; Canvas: TCanvas); override;
    procedure SetDefaultTransition(Value: TShapeCustomControl);
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
    procedure DoOnEnter; override;
    procedure DoOnExit; override;
    function DoDefault: Boolean; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
    procedure PaintConnector; override;
    function HitTest(Mouse: TPoint): TShapeConnector; override;
  published
    property OnEnterState: TNotifyEvent read FOnEnterState write FOnEnterState;
    property OnExitState: TNotifyEvent read FOnExitState write FOnExitState;
    property DefaultTransition: TShapeCustomControl read FDefaultTransition write SetDefaultTransition;
  end;

  TShapeStart = class(TShapeNode)
  protected
    procedure DoPaint; override;
    procedure PrepareCanvas(Element: TVisualElement; Canvas: TCanvas); override;
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TShapeStop = class(TShapeNode)
  protected
    procedure DoPaint; override;
    procedure PrepareCanvas(Element: TVisualElement; Canvas: TCanvas); override;
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TShapeRead = class(TShapeNode)
  protected
    procedure DoPaint; override;
    procedure PrepareCanvas(Element: TVisualElement; Canvas: TCanvas); override;
  end;

  TShapeWrite = class(TShapeNode)
  protected
    procedure DoPaint; override;
    procedure PrepareCanvas(Element: TVisualElement; Canvas: TCanvas); override;
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TShapeTrans = class(TShapeNode)
  protected
    procedure DoPaint; override;
    procedure PrepareCanvas(Element: TVisualElement; Canvas: TCanvas); override;
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TShapeLoop = class;
  TLoopStateEvent = procedure(Sender: TShapeLoop; var Result: Boolean) of object;

  TShapeLoop = class(TShapeNodeBase)
  private
    FOnEnterState: TLoopStateEvent;
    FOnExitState: TNotifyEvent;
    FTrueState: TShapeCustomControl;
    FFalseState: TShapeCustomControl;
    FTrueConnector: TShapeConnector;
    FFalseConnector: TShapeConnector;
    FResult: Boolean;
    FDefault: Boolean;
  protected
    procedure DoPaint; override;
    procedure PrepareCanvas(Element: TVisualElement; Canvas: TCanvas); override;
    procedure SetTrueState(Value :TShapeCustomControl);
    procedure SetFalseState(Value :TShapeCustomControl);
    procedure SetDefault(Value :Boolean);
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
    procedure DoOnEnter; override;
    procedure DoOnExit; override;
    function DoDefault: Boolean; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
    procedure PaintConnector; override;
    function HitTest(Mouse: TPoint): TShapeConnector; override;
  published
    property OnEnterState: TLoopStateEvent read FOnEnterState write FOnEnterState;
    property OnExitState: TNotifyEvent read FOnExitState write FOnExitState;
    property TrueState: TShapeCustomControl read FTrueState write SetTrueState;
    property FalseState: TShapeCustomControl read FFalseState write SetFalseState;
    property DefaultState: Boolean read FDefault write SetDefault default True;
  end;

  TShapeTransition = class(TShapeSizeableControl)
  private
    FFromState: TShapeCustomControl;
    FToState: TShapeCustomControl;
    FOnTransition: TNotifyEvent;
    FToConnector: TShapeConnector;
    FFromConnector: TShapeConnector;
  protected
    procedure DoPaint; override;
    procedure PrepareCanvas(Element: TVisualElement; Canvas: TCanvas); override;
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
    procedure SetParent(AParent: TWinControl); override;
    procedure SetFromState(Value :TShapeCustomControl);
    procedure SetToState(Value :TShapeCustomControl);
    procedure DoOnEnter; override;
    function DoDefault: Boolean; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure CheckTransition(Transition: TShapeCustomControl; Direction: TTransitionDirection); override;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
    procedure PaintConnector; override;
    function HitTest(Mouse: TPoint): TShapeConnector; override;
  published
    property FromState: TShapeCustomControl read FFromState write SetFromState;
    property ToState: TShapeCustomControl read FToState write SetToState;
    property OnTransition: TNotifyEvent read FOnTransition write FOnTransition;
  end;

  TLinkDirection = (ldIncoming, ldOutgoing);

  TShapeLinkBase = class(TShapeSizeableControl)
  end;

  TShapeLink = class(TShapeLinkBase)
  private
    FDestination: TShapeCustomControl;
    FConnector: TShapeConnector;
    FDirection: TLinkDirection;
  protected
    procedure PrepareCanvas(Element: TVisualElement; Canvas: TCanvas); override;
    procedure DoPaint; override;
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
    procedure SetParent(AParent: TWinControl); override;
    procedure SetDestination(Value :TShapeCustomControl);
    procedure SetDirection(Value :TLinkDirection);
    function DoDefault: Boolean; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure CheckTransition(Transition: TShapeCustomControl; Direction: TTransitionDirection); override;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
    procedure PaintConnector; override;
    function HitTest(Mouse: TPoint): TShapeConnector; override;
  published
    property Destination: TShapeCustomControl read FDestination write SetDestination;
    property Direction: TLinkDirection read FDirection write SetDirection;
  end;

procedure Register;

implementation

{$DEBUGINFO ON}

uses
{$IFDEF DEBUG}
  debugit,
{$ENDIF}
  TypInfo, Types;

{$IFNDEF DEBUG}
procedure DebugStr(s: string);
begin
end;
{$ENDIF}

const
  ShadowHeight = 2;
  OverlapXMargin = 10;
  OverlapYMargin = 10;
  SelectMarginX = 4;
  SelectMarginY = 4;
  GridSize = 8;

procedure NoLessThan(var Value: Integer; Limit: Integer);
begin
  if Value < Limit then
    Value := Limit;
end;

function InRect(X, Y: Integer; ARect: TRect): Boolean;
begin
  Result := (X >= ARect.Left) and (X <= ARect.Right) and
    (Y >= ARect.Top) and (Y <= ARect.Bottom);
end;

function SnapToGrid(const Value: Integer): Integer;
begin
  SnapToGrid := Round(Value / GridSize) * GridSize;
end;

//******************************************************************************
//**
//**			Component Registration
//**
//******************************************************************************

procedure Register;
begin
  RegisterComponents('Diagram',
    [TDiagramControl, TShapeStart, TShapeNode, TShapeTransition, TShapeBoolean,
     TShapeLink, TShapeRead, TShapeWrite, TShapeLoop, TShapeStop, TShapeTrans]);
end;

//******************************************************************************
//**
//**			TDiagramControl
//**
//******************************************************************************

constructor TDiagramControl.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle - [csSetCaption, csReplicatable] + [csDesignInteractive];
  FDesignMoving := dmNone;
  BevelInner := bvNone;
  BevelOuter := bvNone;
  BorderStyle := bsNone;
  FOptions := [soVerifyTransitions];
  Visible := (soInteractive in FOptions);
  FActive := False;
end;

destructor TDiagramControl.Destroy;
begin
  inherited Destroy;
end;

procedure TDiagramControl.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (AComponent is TShapeCustomControl) and (TShapeCustomControl(AComponent).DiagramControl = self) then
    case Operation of
      opRemove:
        begin
          Invalidate;
        end;
    end;
end;

procedure TDiagramControl.Execute;
var
  InitialState: TShapeCustomControl;
begin
  if (State = nil) then
    raise Exception.Create('No se ha especificado el control inicial');
  InitialState := FState;
  FState := nil;
  FActive := True;
  FStopSignalled := False;
  SetState(InitialState);
end;

procedure TDiagramControl.Stop;
begin
  FStopSignalled := True;
//  Active := False;
  Application.ProcessMessages;
end;

procedure TDiagramControl.SetState(Value :TShapeCustomControl);
begin
  if (Active) and ([csLoading, csDesigning] * ComponentState = []) then
    DoOnChangeState(State, Value);
  DoSetState(Value);
//  PostStateChange(Value);
end;

procedure TDiagramControl.DoSetState(Value :TShapeCustomControl);
var
  OldState: TShapeCustomControl;
begin
  if (Value <> nil) and (Value.FDiagramControl <> self) then
    raise Exception.Create('No se puede cambiar el flujo a otro contenedor');

  OldState := FState;
  FState := Value;

  // Repaint old and new state
  if (OldState <> nil) then
  begin
    OldState.Invalidate;
    OldState.Update;
  end;

  if (FState <> nil) then
  begin
    FState.Invalidate;
    FState.Update;
  end;

  if not(Active) then
    exit;

  // State change without transition
  if ([csLoading, csDesigning] * ComponentState = []) then
  begin
    if (OldState <> nil) then
      try
        OldState.DoOnExit;
      except
        on E: Exception do
          DoOnException(OldState, E);
      end;

    if (FStopSignalled) or (State = nil) then
    begin
      Active := False;
      exit;
    end;

    StateChanged := False;
    try
      State.DoOnEnter;
    except
      on E: Exception do
        DoOnException(State, E);
    end;

    if (FStopSignalled) then
    begin
      Active := False;
      exit;
    end;

    if not(StateChanged) then
      if not(State.DoDefault) then
        Active := False;

    if (soSingleStep in FOptions) then
      FStopSignalled := True;

  end;
end;

procedure TDiagramControl.ChangeState(Transition: TShapeCustomControl);
begin
  // State change with transition
  if (Transition = nil) then
    raise Exception.Create('Flujo no válido');
  //if not(Active) then
  //  raise Exception.Create('No se puede ejecutar el flujo en un estado detenido');

  // Check transitions
  if (soVerifyTransitions in FOptions) then
    try
      State.CheckTransition(Transition, tdFrom);
      Transition.CheckTransition(State, tdTo);
    except
      on E: Exception do
        raise Exception.CreateFmt('Flujo no válido de %s a %s:'+#13+'%s',
          [State.Name, Transition.Name, E.Message]);
    end;

  StateChanged := True;

  DoOnChangeState(State, Transition);

  PostStateChange(Transition);
end;

procedure TDiagramControl.PostStateChange(State: TShapeCustomControl);
begin
  PostMessage(Handle, SM_STATE_TRANSITION, 0, LongInt(State));
end;

procedure TDiagramControl.DoOnChangeState(FromState, ToState: TShapeCustomControl);
begin
  if (Assigned(FOnChangeState)) then
    try
      FOnChangeState(self, FromState, ToState);
    except
      on E: Exception do
        DoOnException(nil, E);
    end;
end;

procedure TDiagramControl.DoOnException(Node: TShapeCustomControl; E: Exception);
begin
  if (Assigned(FOnException)) then
    FOnException(self, Node, E)
  else
    raise E;
end;

procedure TDiagramControl.SMShapeTransition(var Message: TMessage);
begin
  if (Message.LParam <> 0) then
    DoSetState(TShapeNode(Message.LParam));
end;

procedure TDiagramControl.Paint;
begin
  if (soInteractive in FOptions) or (csDesigning in ComponentState) then
  begin
    inherited Paint;
    if (FDesignMoving in [dmFirstHandle, dmLastHandle]) then
      FConnector.PaintFlipLine;
  end;
end;

procedure TDiagramControl.CMDesignHitTest(var Msg: TWMMouse);
var
  NewPnt: TPoint;
  i: integer;
  Connector: TShapeConnector;

  function TestConnector(Connector: TShapeConnector; p: TPoint): boolean;
  var
    HandleRect: TRect;
    j: TDesignMove;
  begin
    Result := False;
    if (Connector = nil) or not(Connector.GetLines(Lines)) then
      exit;

    for j := Low(Lines) to Pred(High(Lines)) do
    begin
      HandleRect := TShapeConnector.MakeRect(Lines[j], Lines[Succ(j)]);
      InflateRect(HandleRect, SelectMarginX, SelectMarginY);
      if (PtInRect(HandleRect, p)) then
      begin
        Result := True;
        exit;
      end;
    end;
  end;

begin
{$IFDEF WIN32}
  NewPnt := SmallPointToPoint(Msg.Pos);
{$ELSE}
  NewPnt := Msg.Pos;
{$ENDIF}
  if (FDesignMoving <> dmNone) then
  begin
    Msg.Result := 1;
    exit;
  end;

  Msg.Result := 0;

  if not(ssLeft in KeysToShiftState(Msg.Keys)) then
    exit;

  if (TestConnector(FConnector, NewPnt)) then
  begin
    Msg.Result := 1;
    exit;
  end;

  for i := 0 to ControlCount-1 do
    if (Controls[i] is TShapeCustomControl) then
    begin
      Connector := (TShapeCustomControl(Controls[i]).HitTest(NewPnt));

      if not(TestConnector(Connector, NewPnt)) then
        continue;

      if (FConnector <> nil) and (FConnector <> Connector) then
      begin
        FConnector.Selected := False;
        Invalidate;
      end;

      FConnector := Connector;
      Connector.Selected := True;
      Connector.Paint;
      Msg.Result := 1;
      exit;
    end;

  if (FConnector <> nil) then
  begin
    FConnector.Selected := False;
    FConnector := nil;
    invalidate;
  end;
end;

procedure TDiagramControl.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  I: TDesignMove;
  HandleRect: TRect;
  R: TRect;
begin
  if (csDesigning in ComponentState) and (FConnector <> nil) and
    (FConnector.GetLines(Lines)) then
    for I := dmFirstHandle to dmLastHandle do
    begin
      if (I = dmOffset) and (FConnector.ActualPath in [spTopLeft, spRightBottom]) then
        continue;
      HandleRect.TopLeft := Lines[I];
      HandleRect.BottomRight := HandleRect.TopLeft;
      InflateRect(HandleRect, SelectMarginX, SelectMarginY);
      if (PtInRect(HandleRect, Point(X, Y))) then
      begin
        FDesignMoving := I;
        MouseCapture := True;
        Canvas.Pen.Width := 3;
        Canvas.Pen.Mode := pmNotXor;
        FConnector.Paint;
        if (FDesignMoving in [dmFirstHandle, dmLastHandle]) then
        begin
          if (Lines[dmDestination].Y > Lines[dmSource].Y) then
          begin
            if (Lines[dmDestination].X > Lines[dmSource].X) then
              Screen.Cursor := crSizeNESW
            else
              Screen.Cursor := crSizeNWSE;
          end else
          begin
            if (Lines[dmDestination].X > Lines[dmSource].X) then
              Screen.Cursor := crSizeNWSE
            else
              Screen.Cursor := crSizeNESW;
          end;
          FConnector.PaintFlipLine;
        end else
        begin
          { Confine cursor }
          R := FConnector.MakeRect(ClientToScreen(Lines[dmSource]),
            ClientToScreen(Lines[dmDestination]));
          ClipCursor(@R);

          if (FConnector.ActualPath = spLeftRight) then
            Screen.Cursor := crHSplit
          else if (FConnector.ActualPath = spTopBottom) then
            Screen.Cursor := crVSplit;
        end;
        Canvas.Pen.Width := 1;
        Canvas.Pen.Mode := pmCopy;
        Canvas.Pen.Style := psSolid;
        Canvas.Pen.Color := clBlack;
        exit;
      end;
    end;
  inherited MouseDown(Button, Shift, X, Y);
end;

procedure TDiagramControl.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  Vector: TRect;
  NewOffset: integer;
  NewPath: TStatePath;
  DoPaint: Boolean;

  // Function to determine on which side of the vector c1->c2 the point a lies
  function cross(a: TPoint; c: TRect): integer;
  var
    b: TPoint;
  begin
    a := Point(a.x-c.Left, a.y-c.Top);
    b := Point(c.Right-c.Left, c.Bottom-c.Top);
    Result := (a.x*b.y)-(a.y*b.x);
  end;

  function NewState(OldState: TStatePath; Handle: TDesignMove; Diagonal: TRect;
    OldHandle, NewHandle: TPoint): TStatePath;
  const
    Paths: array[dmFirstHandle..dmLastHandle, spLeftRight..spRightBottom] of TStatePath =
      ((spTopLeft,spRightBottom,spLeftRight,spTopBottom),
       (spTopLeft,spRightBottom,spLeftRight,spTopBottom),//Dummy not used
       (spRightBottom, spTopLeft, spTopBottom, spLeftRight));
  begin
    if (cross(NewHandle, Diagonal)*cross(OldHandle, Diagonal) < 0) then
      Result := Paths[Handle, OldState]
    else
      Result := OldState;
  end;

begin
  if (csDesigning in ComponentState) and (FDesignMoving <> dmNone) and
    (FConnector <> nil) then
  begin
    DoPaint := False;
    NewOffset := FConnector.Offset;
    NewPath := FConnector.Path;
    if (FDesignMoving in [dmFirstHandle, dmLastHandle]) then
    begin
      Vector.TopLeft :=  TShapeConnector.RectCenter(FConnector.Source.BoundsRect);
      Vector.BottomRight :=  TShapeConnector.RectCenter(FConnector.Destination.BoundsRect);
      NewPath := NewState(FConnector.ActualPath, FDesignMoving, Vector,
        Lines[FDesignMoving], Point(X, Y));
      if (NewPath <> FConnector.ActualPath) then
      begin
        DebugStr('Vuelta:' + IntToStr(Ord(NewPath)));
        DoPaint := True;
      end else
        DebugStr('Atrás:' + IntToStr(Ord(FConnector.ActualPath)));
    end else
    begin
      case (FConnector.ActualPath) of
        spLeftRight:
          NewOffset := FConnector.Offset + X - Lines[dmOffset].X;
        spTopBottom:
          NewOffset := FConnector.Offset + Y - Lines[dmOffset].Y;
      end;
      DebugStr('Cambiar desplazamiento:' + IntToStr(NewOffset));
      if (NewOffset <> FConnector.Offset) then
      begin
        DoPaint := True;
      end;
    end;
    if (DoPaint) then
    begin
      Canvas.Pen.Width := 3;
      Canvas.Pen.Mode := pmNotXor;
      FConnector.Paint;  // Erase previous

      FConnector.Offset := NewOffset;
      FConnector.Path := NewPath;
      FConnector.GetLines(Lines);

      FConnector.Paint; // Paint new
      Canvas.Pen.Width := 1;
      Canvas.Pen.Mode := pmCopy;
    end;
  end;
  inherited MouseMove(Shift, X, Y);
end;

procedure TDiagramControl.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
{$IFNDEF VER90}
  Form: TCustomForm;
{$ELSE}
  Form: TForm;
{$ENDIF}
begin
  if (csDesigning in ComponentState) and (FDesignMoving <> dmNone) then
  begin
    DebugStr('Contenedor.MouseUp');
    Canvas.Pen.Mode := pmCopy;
    Form := GetParentForm(self);
    if (Form <> nil) and (Form.Designer <> nil) then
      Form.Designer.Modified;
    FDesignMoving := dmNone;
    Screen.Cursor := crDefault;
    ClipCursor(nil);
    MouseCapture := false;
    Invalidate;
  end;
  inherited MouseUp(Button, Shift, X, Y);
  //Repaint;
end;

//******************************************************************************
//**
//**			TShapeConnector
//**
//******************************************************************************

constructor TShapeConnector.Create(AOwner: TShapeCustomControl; OwnerRole: TStatePathOwner);
begin
  inherited Create;
  FOwner := OwnerRole;
  if (FOwner = poOwnedBySource) then
    FSource := AOwner
  else
    FDestination := AOwner;
  FPath := spAuto;
  FActualPath := FPath;
end;

procedure TShapeConnector.SetPeer(Index: integer; Value: TShapeCustomControl);
begin
  if ((Index = 1) and (FOwner = poOwnedBySource)) or
    ((Index = 2) and (FOwner = poOwnedByDestination)) then
    raise Exception.Create('No se puede modificar el propietario del conector');
  case (Index) of
    0: if (FOwner = poOwnedBySource) then
         FDestination := Value
       else
         FSource := Value;
    1: FSource := Value;
    2: FDestination := Value;
  end;
end;

function TShapeConnector.GetPeer(Index: integer): TShapeCustomControl;
begin
  if (FOwner = poOwnedBySource) then
    Result := FDestination
  else
    Result := FSource;
end;

function TShapeConnector.GetLines(var Lines: TConnectorLines): Boolean;
var
//  OverlapX,
  OverlapY: Boolean;
  p1,
  p2: TPoint;
  r1,
  r2: TRect;
  dx,
  dy: integer;
  d2x,
  d2y: integer;
  DirectionX,
  DirectionY: integer;
//                   +--------+
//                   |  Dest  |
//                d1 |   p2   | ^
//                   |        | |
//                   +--------+ |
//          ^            d2     |
//          |                   |
//         d2y                  |
//          |                   dy
//     s2   v                   |
// +--------+<--d2x->           |
// | Source |                   |
// |   p1   | s1                v
// |        |
// +--------+
//      <------- dx ----->

begin
  if (Source = nil) or (Destination = nil) then
  begin
    Result := False;
    exit;
  end;
  Result := True;


  r1 := Source.BoundsRect;
  r2 := Destination.BoundsRect;
  p1 := Point(r1.Left + Source.Width div 2, r1.Top + Source.Height div 2);
  p2 := Point(r2.Left + Destination.Width div 2, r2.Top + Destination.Height div 2);

  dx := p2.x - p1.x;
  dy := p2.y - p1.y;
  if (dx = 0) then
    DirectionX := 0
  else
    DirectionX := dx div Abs(dx);
  if (dy = 0) then
    DirectionY := 0
  else
    DirectionY := dy div Abs(dy);
  d2x := Abs(dx) - (Source.Width + Destination.Width) div 2;
  d2y := Abs(dy) - (Source.Height + Destination.Height) div 2;

  //OverlapX := (d2x <= OverlapXMargin);
  OverlapY := (d2y <= OverlapYMargin);

  FActualPath := Path;
  // Switch to auto if position makes path impossible
  if ((ActualPath = spRightBottom) and
      ((Abs(dx) - (Source.Width div 2) < OverlapXMargin) or
       (d2y + (Source.Height div 2) < OverlapYMargin)) or
     ((ActualPath = spTopLeft) and
      ((Abs(dy) - (Source.Height div 2) < OverlapYMargin) or
       (d2x + (Source.Width div 2) < OverlapXMargin)))) then
    FActualPath := spAuto;

  if (ActualPath in [spAuto, spDirect]) then
  begin
    if (d2x > 0) and (d2y > 0) then
      FActualPath := spTopTop
    else if dy < 0 then
      FActualPath := spBottomBottom
    else if (OverlapY) or (d2x > d2y) then
      FActualPath := spLeftRight
    else
      FActualPath := spTopBottom;
  end else
    FActualPath := Path;

  case ActualPath of
    spTopTop:
      if (DirectionX > 0) then
        Lines[dmSource] := Point(r1.Right + 1, p1.y)
      else if (DirectionX < 0) then
        Lines[dmSource] := Point(r1.Left - 1, p1.y)
      else
        Lines[dmSource] := p1;
    spBottomBottom:
      Lines[dmSource] := Point(p1.x, r1.Bottom + 1);
    spLeftRight,
    spRightBottom:
      if (DirectionX > 0) then
        Lines[dmSource] := Point(r1.Right + 1, p1.y)
      else if (DirectionX < 0) then
        Lines[dmSource] := Point(r1.Left - 1, p1.y)
      else
        Lines[dmSource] := p1;
    spTopBottom,
    spTopLeft:
      if (DirectionY > 0) then
        Lines[dmSource] := Point(p1.x, r1.Bottom + 1)
      else if (DirectionY < 0) then
        Lines[dmSource] := Point(p1.x, r1.Top - 1)
      else
        Lines[dmSource] := p1;
  end;
  case ActualPath of
    spTopTop:
      if (DirectionX > 0) then
        Lines[dmDestination] := Point(p2.x, r2.Top - 1)
      else if (DirectionX < 0) then
        Lines[dmDestination] := Point(p2.x, r2.Top - 1)
      else
        Lines[dmDestination] := p2;
    spBottomBottom:
        Lines[dmDestination] := Point(r2.Left - 1, p2.y);
    spLeftRight,
    spTopLeft:
      if (DirectionX > 0) then
        Lines[dmDestination] := Point(r2.Left - 1, p2.y)
      else if (DirectionX < 0) then
        Lines[dmDestination] := Point(r2.Right + 1, p2.y)
      else
        Lines[dmDestination] := p2;
    spTopBottom,
    spRightBottom:
      if (DirectionY > 0) then
        Lines[dmDestination] := Point(p2.x, r2.Top - 1)
      else if (DirectionY < 0) then
        Lines[dmDestination] := Point(p2.x, r2.Bottom + 1)
      else
        Lines[dmDestination] := p2;
  end;
  if (Path = spDirect) then
    FActualPath := spDirect;

  case ActualPath of
    spDirect:
      begin
        dx := (Lines[dmDestination].x-Lines[dmSource].x) DIV 4;
        dy := (Lines[dmDestination].y-Lines[dmSource].y) DIV 4;
        Lines[dmFirstHandle] := Point(Lines[dmSource].x + dx, Lines[dmSource].y + dy);
        Lines[dmOffset] := Point(Lines[dmSource].x + dx*2, Lines[dmSource].y + dy*2);
        Lines[dmLastHandle] := Point(Lines[dmSource].x + dx*3, Lines[dmSource].y + dy*3);
      end;
    spTopTop:
      begin
        Lines[dmFirstHandle] := Point(Lines[dmSource].x + DirectionX * d2x DIV 2, p1.y);
        Lines[dmLastHandle] := Point(Lines[dmDestination].x, p1.y);
      end;
    spBottomBottom:
      begin
        Lines[dmFirstHandle] := Point(Lines[dmSource].x, Lines[dmSource].y + 25);
        Lines[dmLastHandle] := Point(Lines[dmDestination].x - 81, p2.y);
      end;
    spLeftRight:
      begin
        Lines[dmFirstHandle] := Point(Lines[dmSource].x + DirectionX * d2x DIV 2, p1.y);
        Lines[dmLastHandle] := Point(Lines[dmSource].x + DirectionX * d2x DIV 2, p2.y);
      end;
    spTopBottom:
      begin
        Lines[dmFirstHandle] := Point(p1.x, Lines[dmSource].y + DirectionY * d2y DIV 2);
        Lines[dmLastHandle] := Point(p2.x, Lines[dmSource].y + DirectionY * d2y DIV 2);
      end;
    spRightBottom:
      begin
        Lines[dmFirstHandle] := Point(Lines[dmSource].x + (p2.x-Lines[dmSource].x) DIV 2, p1.y);
        Lines[dmLastHandle] := Point(p2.x, Lines[dmDestination].y - (Lines[dmDestination].y - p1.y) DIV 2);
      end;
    spTopLeft:
      begin
        Lines[dmFirstHandle] := Point(p1.x, Lines[dmSource].y + (p2.y-Lines[dmSource].y) DIV 2);
        Lines[dmLastHandle] := Point(Lines[dmDestination].x - (Lines[dmDestination].x - p1.x) DIV 2, p2.y);
      end;
  end;
  case ActualPath of
    spTopTop:
        Lines[dmOffset] := Point(Lines[dmLastHandle].x, Lines[dmLastHandle].y);
    spBottomBottom:
        Lines[dmOffset] := Point(Lines[dmLastHandle].x, Lines[dmFirstHandle].y);
    spLeftRight:
      begin
        Lines[dmFirstHandle].x := Lines[dmFirstHandle].x + Offset;
        Lines[dmLastHandle].x := Lines[dmFirstHandle].x;
        Lines[dmOffset] := Point(Lines[dmFirstHandle].x,
          Lines[dmFirstHandle].y+(Lines[dmLastHandle].y-Lines[dmFirstHandle].y) DIV 2);
      end;
    spTopLeft:
      Lines[dmOffset] := Point(Lines[dmFirstHandle].x, Lines[dmLastHandle].y);
    spTopBottom:
      begin
        Lines[dmFirstHandle].y := Lines[dmFirstHandle].y + Offset;
        Lines[dmLastHandle].y := Lines[dmFirstHandle].y;
        Lines[dmOffset] := Point(Lines[dmFirstHandle].x+(Lines[dmLastHandle].x-Lines[dmFirstHandle].x) DIV 2,
          Lines[dmFirstHandle].y);
      end;
    spRightBottom:
      Lines[dmOffset] := Point(Lines[dmLastHandle].x, Lines[dmFirstHandle].y);
  end;
end;

class function TShapeConnector.MakeRect(pa, pb: TPoint): TRect;
  function Min(a,b: integer): integer;
  begin
    if (a <= b) then
      Result := a
    else
      Result := b;
  end;

  function Max(a,b: integer): integer;
  begin
    if (a >= b) then
      Result := a
    else
      Result := b;
  end;
begin
  Result.TopLeft := Point(Min(pa.x, pb.x), Min(pa.y, pb.y));
  Result.BottomRight := Point(Max(pa.x, pb.x), Max(pa.y, pb.y));
end;

class function TShapeConnector.RectCenter(r: TRect): TPoint;
begin
  Result.x := r.Left+(r.Right-r.Left) DIV 2;
  Result.y := r.Top+(r.Bottom-r.Top) DIV 2;
end;

procedure TShapeConnector.Paint;
var
  Lines: TConnectorLines;
  Arrow: array[0..2] of TPoint;
  i: TDesignMove;
  Direction: integer;
  Size: integer;
  SaveWidth: integer;
  WorkPath: TStatePath;
begin
  if not(GetLines(Lines)) then exit;

  Source.DiagramControl.Canvas.Pen.Style := psSolid;

  Source.DiagramControl.Canvas.Brush.Style := bsSolid;
  Source.DiagramControl.Canvas.Brush.Color := Source.DiagramControl.Canvas.Pen.Color;

  Size := Source.DiagramControl.Canvas.Pen.Width DIV 2;
  Arrow[0] := Lines[dmDestination];
  if (ActualPath = spDirect) then
  begin
    if (Abs(Lines[dmDestination].x-Lines[dmSource].x) > 0) and
       (Abs(Lines[dmDestination].y-Lines[dmSource].y) > 0) then
      WorkPath := spTopTop
    else if (Abs(Lines[dmDestination].x-Lines[dmSource].x) >
      Abs(Lines[dmDestination].y-Lines[dmSource].y)) then
      WorkPath := spLeftRight
    else
      WorkPath := spTopBottom;
  end else
    WorkPath := ActualPath;

  case WorkPath of
    spTopTop:
      begin
        Direction := Lines[dmDestination].y-Lines[dmLastHandle].y;
        if (Direction <> 0) then
          Direction := Direction div Abs(Direction);

        Lines[dmDestination].y :=
          Lines[dmDestination].y-Source.DiagramControl.Canvas.Pen.Width*Direction;
        Arrow[1] := Point(Arrow[0].x-(3+Size), Arrow[0].y-(3+Size)*Direction);
        Arrow[2] := Point(Arrow[0].x+(3+Size), Arrow[0].y-(3+Size)*Direction);
      end;
    spBottomBottom:
      begin
        Lines[dmDestination].x :=
          Lines[dmDestination].x-Source.DiagramControl.Canvas.Pen.Width;
        Arrow[1] := Point(Arrow[0].x-(3+Size), Arrow[0].y-(3+Size));
        Arrow[2] := Point(Arrow[0].x-(3+Size), Arrow[0].y+(3+Size));
      end;
    spLeftRight,
    spTopLeft:
      begin
        Direction := Lines[dmDestination].x-Lines[dmLastHandle].x;
        if (Direction <> 0) then
          Direction := Direction div Abs(Direction);

        Lines[dmDestination].x :=
          Lines[dmDestination].x-Source.DiagramControl.Canvas.Pen.Width*Direction;
        Arrow[1] := Point(Arrow[0].x-(3+Size)*Direction, Arrow[0].y-(3+Size));
        Arrow[2] := Point(Arrow[0].x-(3+Size)*Direction, Arrow[0].y+(3+Size));
      end;
    spTopBottom,
    spRightBottom:
      begin
        Direction := Lines[dmDestination].y-Lines[dmLastHandle].y;
        if (Direction <> 0) then
          Direction := Direction DIV ABS(Direction);

        Lines[dmDestination].y :=
          Lines[dmDestination].y-Source.DiagramControl.Canvas.Pen.Width*Direction;
        Arrow[1] := Point(Arrow[0].x-(3+Size), Arrow[0].y-(3+Size)*Direction);
        Arrow[2] := Point(Arrow[0].x+(3+Size), Arrow[0].y-(3+Size)*Direction);
      end;
  end;

  Source.DiagramControl.Canvas.PolyLine(Lines);

  SaveWidth := Source.DiagramControl.Canvas.Pen.Width;
  Source.DiagramControl.Canvas.Pen.Width := 1;
  Source.DiagramControl.Canvas.Polygon(Arrow);
  Source.DiagramControl.Canvas.Pen.Width := SaveWidth;

  if (csDesigning in Source.DiagramControl.ComponentState) then
  begin
    if (Selected) and (Source.DiagramControl.FConnector = self) then
      for i := dmFirstHandle to dmLastHandle do
      begin
        if (i <> dmOffset) or not(ActualPath in [spTopLeft, spRightBottom]) then
          Source.DiagramControl.Canvas.Rectangle(Lines[i].x-2, Lines[i].y-2, Lines[i].x+2, Lines[i].y+2);
      end;
    BoundsRect := MakeRect(Lines[dmSource], Lines[dmDestination]);
    InflateRect(BoundsRect, SelectMarginX, SelectMarginY);
  end;
end;

procedure TShapeConnector.PaintFlipLine;
var
  p: TPoint;
begin
  if (Source <> nil) and (Destination <> nil) then
  begin
    Source.DiagramControl.Canvas.Pen.Width := 1;
    Source.DiagramControl.Canvas.Pen.Mode := pmXor;
    Source.DiagramControl.Canvas.Pen.Style := psDot;
    Source.DiagramControl.Canvas.Pen.Color := clWhite;
    p := TShapeConnector.RectCenter(Source.BoundsRect);
    Source.DiagramControl.Canvas.MoveTo(p.x, p.y);
    p := TShapeConnector.RectCenter(Destination.BoundsRect);
    Source.DiagramControl.Canvas.LineTo(p.x, p.y);
    Source.DiagramControl.Canvas.Pen.Width := 1;
    Source.DiagramControl.Canvas.Pen.Mode := pmCopy;
    Source.DiagramControl.Canvas.Pen.Style := psSolid;
    Source.DiagramControl.Canvas.Pen.Color := clBlack;
  end;
end;

function TShapeConnector.HitTest(Mouse: TPoint): Boolean;
begin
  Result := PtInRect(BoundsRect, Mouse);
end;

//******************************************************************************
//**
//**			TShapeCustomControl
//**
//******************************************************************************

constructor TShapeCustomControl.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  inherited SetBounds(0, 0, 81, 33);
  FConnectors := TList.Create;
  FCanProcessMouseMsg := True;
  FSelected := False;
  FWasCovered := False;
  Canvas.Font.Name := 'Courier New';
  Canvas.Font.Size := 10;
end;

destructor TShapeCustomControl.Destroy;
begin
  FConnectors.Free;
  inherited Destroy;
end;

function TShapeCustomControl.AddConnector(OwnerRole: TStatePathOwner): TShapeConnector;
begin
  Result := TShapeConnector.Create(self, OwnerRole);
  Connectors.Add(Result);
end;

procedure TShapeCustomControl.DefineProperties(Filer: TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineProperty('Connectors', ReadConnectors, WriteConnectors,
    (Connectors.Count > 0));
end;

procedure TShapeCustomControl.WriteConnectors(Writer: TWriter);
var
  I: integer;
begin
  Writer.WriteListBegin;
  try
    for I := 0 to Connectors.Count-1 do
    begin
      Writer.WriteInteger(ord(TShapeConnector(Connectors[I]).Path));
      Writer.WriteInteger(TShapeConnector(Connectors[I]).Offset);
    end;
  finally
    Writer.WriteListEnd;
  end;
end;

procedure TShapeCustomControl.ReadConnectors(Reader: TReader);
var
  I: integer;
begin
  Reader.ReadListBegin;
  try
    I := 0;
    while not(Reader.EndOfList) do
    begin
      if (I < Connectors.Count) then
      begin
        TShapeConnector(Connectors[I]).Path := TStatePath(Reader.ReadInteger);
        TShapeConnector(Connectors[I]).Offset := Reader.ReadInteger;
      end else
        Reader.ReadInteger;
      inc(I);
    end;
  finally
    Reader.ReadListEnd;
  end;
end;

procedure TShapeCustomControl.SetParent(AParent: TWinControl);
begin
  inherited SetParent(AParent);
  if (AParent <> nil) and not(AParent is TDiagramControl) then
    raise Exception.Create(ClassName + ' Debe tener un propietario TDiagramControl');
  FDiagramControl := TDiagramControl(AParent);
end;

procedure TShapeCustomControl.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  inherited SetBounds(ALeft, ATop, AWidth, AHeight);
  if (FDiagramControl <> nil) then
    FDiagramControl.Invalidate;
end;

function TShapeCustomControl.GetCheckDiagramControl: TDiagramControl;
begin
  if (FDiagramControl = nil) then
    raise Exception.Create(ClassName + ' no está conectado al flujo');
  Result := FDiagramControl;
end;

procedure TShapeCustomControl.SetCaption(Value: string);
begin
  if FCaption <> Value then
  begin
    FCaption := Value;
    Invalidate;
  end;
end;

procedure TShapeCustomControl.SetActive(Value: boolean);
begin
  if not Value then
    CheckDiagramControl.State := nil
  else
    CheckDiagramControl.State := Self;
end;

function TShapeCustomControl.GetActive: boolean;
begin
  Result := (CheckDiagramControl.State = Self);
end;

procedure TShapeCustomControl.PrepareCanvas(Element: TVisualElement; Canvas: TCanvas);
begin
  case (Element) of
    veShadow:
      begin
        Canvas.Pen.Width := 1;
        Canvas.Pen.Color := clGray;
        Canvas.Pen.Style := psSolid;
        Canvas.Pen.Mode := pmCopy;
        Canvas.Brush.Style := bsSolid;
        Canvas.Brush.Color := clGray;
      end;
    veFrame:
      begin
        Canvas.Pen.Color := clBlack;
        Canvas.Pen.Style := psInsideFrame;
        Canvas.Pen.Mode := pmCopy;
        if (Active) then
          Canvas.Pen.Width := 2
        else
          Canvas.Pen.Width := 1;
      end;
    vePanel:
      begin
        Canvas.Brush.Style := bsSolid;
        if (Active) then
          Canvas.Brush.Color := $003DE6A1
        else
          Canvas.Brush.Color := clWhite;
      end;
    veText:
      begin
        Canvas.Brush.Style := bsClear;
        if (Active) then
          Canvas.Font.Color := clGreen
        else
          Canvas.Font.Color := clBlack;
      end;
    veConnector:
      begin
        Canvas.Pen.Width := 1;
        Canvas.Pen.Color := clBlack;
      end;
  end;
end;

procedure TShapeCustomControl.DrawText(TextRect: TRect);
var
  Opt: integer;
begin
  Opt := DT_CENTER or DT_NOPREFIX or DT_END_ELLIPSIS or DT_VCENTER or DT_SINGLELINE;
  windows.DrawText(Canvas.Handle, PChar(FCaption), -1, TextRect, Opt);
end;

procedure TShapeCustomControl.DoPaint;
var
  R: TRect;
begin
  // Draw shadow
  PrepareCanvas(veShadow, Canvas);
  R.TopLeft :=  Point(ShadowHeight, ShadowHeight);
  R.BottomRight := Point(Width, Height);
  Canvas.FillRect(R);
  // Draw rectangle
  PrepareCanvas(veFrame, Canvas);
  PrepareCanvas(vePanel, Canvas);
  OffsetRect(R, -ShadowHeight, -ShadowHeight);
  Canvas.Rectangle(R.Left, R.Top, R.Right, R.Bottom);
  // Draw name
  PrepareCanvas(veText, Canvas);
  // Margin for text
  InflateRect(R, -(ShadowHeight + 2), -(ShadowHeight + 2));
  DrawText(R);
end;

procedure TShapeCustomControl.PaintConnector;
begin
  PrepareCanvas(veConnector, DiagramControl.Canvas);
end;

procedure TShapeCustomControl.Paint;
const
  Painting: Boolean = False;	// To avoide recursion by accidentally calling
  				// inherited Paint in overloaded DoPaint
begin
  if (Painting) then
    raise Exception.Create('Se ha detectado recursividad en TShapeCustomControl.Paint');
  Painting := True;
  try
    inherited Paint;
    DoPaint;
    PaintConnector;
    // DiagramControl.Canvas.Pen.Width := 1;
  finally
    Painting := False;
  end;
end;

procedure TShapeCustomControl.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = self) and (FDiagramControl <> nil) then
    DiagramControl.Invalidate;
end;

procedure TShapeCustomControl.DoOnEnter;
begin
  // Nothing to do here
end;

procedure TShapeCustomControl.DoOnExit;
begin
  // Nothing to do here
end;

function TShapeCustomControl.DoDefault: Boolean;
begin
  Result := False;
end;

procedure TShapeCustomControl.CheckTransition(Transition: TShapeCustomControl; Direction: TTransitionDirection);
begin
  if (self = nil) then
    raise Exception.Create('No hay flujo');
end;

function TShapeCustomControl.HitTest(Mouse: TPoint): TShapeConnector;
begin
  Result := nil;
end;

procedure TShapeCustomControl.MouseDown(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
var
  TempPt: TPoint;
  CoveredShape: TShapeCustomControl;
begin
  if CanProcessMouseMsg then
  begin
    if ssShift in Shift then UnselectControl(Parent);
    BringToFront;
    MouseCapture := True;
    inherited MouseDown(Button, Shift, X, Y);
    Exit;
  end;

  // Pass message on to any covered control capable of handling it
  CoveredShape := GetCustomShapeAtPos(X, Y);
  TempPt := Point(X, Y);
  MouseCapture := False;

  if CoveredShape <> nil then
  begin
    SendToBack;
    // Convert coordinates to covered shape's coordinates
    TempPt := CoveredShape.ScreenToClient(ClientToScreen(TempPt));
    // Send the mouse down message to the covered shape
    CoveredShape.MouseDown(Button, Shift, TempPt.X, TempPt.Y);
    // Flag the control as having been covered because we lose a mouse click
    CoveredShape.FWasCovered := True;
  end
  else
  if Assigned(Parent) then
  begin
    // Send mouse down message to Parent. The typecast is purely to gain access
    // to the Parent.MouseDown method. Need to convert coordinates to parent's
    // coordinates
    TempPt := Parent.ScreenToClient(ClientToScreen(TempPt));
    DiagramControl.MouseDown(Button, Shift, TempPt.X, TempPt.Y);
  end;
end;

procedure TShapeCustomControl.MouseUp(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
  if FWasCovered then
  begin
    // We will lose a mouse click, so replace it
    Click;
    FWasCovered := False;
  end;
end;

class procedure TShapeCustomControl.UnselectControl(ParentControl: TWinControl);
var
  I: Integer;
begin
  // (rom) added Assigned for security
  if Assigned(ParentControl) then
    for I := 0 to ParentControl.ControlCount - 1 do
      if ParentControl.Controls[I] is TShapeCustomControl then
        TShapeCustomControl(ParentControl.Controls[I]).Selected := False;
end;

procedure TShapeCustomControl.SetSelected(Value: Boolean);
begin
  FSelected := Value;
end;

class procedure TShapeCustomControl.DeleteSelectedControl(
  ParentControl: TWinControl);
var
  I: Integer;
begin
  // Delete controls from ParentControl if they are flagged as selected
  I := 0;
  // (rom) added Assigned for security
  if Assigned(ParentControl) then
    while I < ParentControl.ControlCount do
      if (ParentControl.Controls[I] is TShapeCustomControl) and
        (TShapeCustomControl(ParentControl.Controls[I]).Selected) then
        ParentControl.Controls[I].Free
        // Note that there is no need to increment the counter, because the
        // next component (if any) will now be at the same position in Controls[]
      else
        Inc(I);
end;

function TShapeCustomControl.GetCustomShapeAtPos(X,
  Y: Integer): TShapeCustomControl;
var
  I: Integer;
  Pt: TPoint;
begin
  Result := nil;
  if not Assigned(FDiagramControl) then Exit;

  Pt := Parent.ScreenToClient(ClientToScreen(Point(X, Y)));

  for I := 0 to Parent.ControlCount - 1 do
    if (Parent.Controls[I] <> Self) and
      (Parent.Controls[I] is TShapeCustomControl) and
      TShapeCustomControl(Parent.Controls[I]).CanProcessMouseMsg and
      InRect(Pt.X, Pt.Y, Parent.Controls[I].BoundsRect) then
    begin
      Result := TShapeCustomControl(Parent.Controls[I]);
      Exit;
    end;
end;

//******************************************************************************
//**
//**			TShapeMoveableControl
//**
//******************************************************************************

constructor TShapeMoveableControl.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Selected := False;
  Moving := False;
  FOrigin := Point(0, 0);
  FDelta := Point(0, 0);
end;

procedure TShapeMoveableControl.StartMove(X, Y: Integer);
begin
  Selected := True;
  Moving := True;
  FOrigin := Point(X, Y);
end;

procedure TShapeMoveableControl.Move(DeltaX, DeltaY: Integer);
begin
  SetBounds(Left + DeltaX, Top + DeltaY, Width, Height);
end;

procedure TShapeMoveableControl.EndMove;
begin
  Moving := False;
  FOrigin := Point(0, 0);
  FDelta := Point(0, 0);
end;

function TShapeMoveableControl.ValidMove(DeltaX, DeltaY: Integer): Boolean;
begin
  Result := True;
  if not Assigned(Parent) then Exit;
  if Selected then
    Result := (Left + DeltaX >= 0) and
      (Top + DeltaY >= 0) and
      (Left + DeltaX + Width - 1 <
      Parent.ClientRect.Right - Parent.ClientRect.Left) and
      (Top + DeltaY + Height - 1 <
      Parent.ClientRect.Bottom - Parent.ClientRect.Top);
end;

procedure TShapeMoveableControl.MoveShapes(DeltaX, DeltaY: Integer);
var
  I, Pass: Integer;
  TempControl: TControl;
begin
  if not Assigned(Parent) then
    Exit;
  // Do 2 passes through controls. The first one is to check that all
  // movements are valid
  for Pass := 1 to 2 do
  begin
    for I := 0 to Parent.ControlCount - 1 do
    begin
      TempControl := Parent.Controls[I];
      if TempControl is TShapeMoveableControl then
      begin
        if (Pass = 1) and
          (not TShapeMoveableControl(TempControl).ValidMove(DeltaX, DeltaY)) then
          Exit
        else
        if (Pass = 2) and TShapeMoveableControl(TempControl).Selected then
          TShapeMoveableControl(TempControl).Move(DeltaX, DeltaY);
      end;
    end;
  end;
end;

procedure TShapeMoveableControl.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var
  TempPt: TPoint;
begin
  inherited MouseDown(Button, Shift, X, Y);
  // Only respond to left mouse button events
  if Button <> mbLeft then
    Exit;
  // If not holding down the shift key then not doing multiple selection
  if not (ssShift in Shift) then
    UnselectControl(Parent);
  // Start moving the component
  TempPt := Point(X, Y);
  TempPt := Parent.ScreenToClient(ClientToScreen(TempPt));
  FDelta := Point(X, Y);
  StartMove(TempPt.X - FDelta.X, TempPt.Y - FDelta.Y);
end;

procedure TShapeMoveableControl.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  ptNew: TPoint;
  rc: TRect;
begin
  inherited MouseMove(Shift, X, Y);
  // Only need to move the component if the left mouse button is being held down
  if not (ssLeft in Shift) then
  begin
    Moving := False;
    Exit;
  end;

  if Moving then
    // Move all the selected shapes
  begin
    SaveAttributes;
    rc := Rect(0, 0, Width, Height);
    OffsetRect(rc, SnapToGrid(FOrigin.X), SnapToGrid(FOrigin.Y));
    DiagramControl.Canvas.Rectangle(rc);
    rc := Rect(0, 0, Width, Height);
    ptNew := Point(X, Y);
    ptNew := Parent.ScreenToClient(ClientToScreen(ptNew));
    OffsetRect(rc, SnapToGrid(ptNew.X - FDelta.X), SnapToGrid(ptNew.Y - FDelta.Y));
    DiagramControl.Canvas.Rectangle(rc);
    FOrigin := Point(ptNew.X - FDelta.X, ptNew.Y - FDelta.Y);
    RestoreAttributes;
  end;
end;

procedure TShapeMoveableControl.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var
  I: Integer;
  TempControl: TControl;
begin
  inherited MouseUp(Button, Shift, X, Y);
  // Only interested in left mouse button events
  if Button <> mbLeft then Exit;

  if Moving then MoveShapes(SnapToGrid(X - FDelta.X), SnapToGrid(Y - FDelta.Y));

  EndMove;

  // If this shape is covering any smaller shapes then send it to the back,
  // so that we can get at the smaller ones
  if not Assigned(Parent) then
    Exit;
  for I := 0 to Parent.ControlCount - 1 do
  begin
    TempControl := Parent.Controls[I];
    if (TempControl <> Self) and
      (TempControl is TShapeCustomControl) and
      TShapeCustomControl(TempControl).CanProcessMouseMsg and
      InRect(TempControl.Left, TempControl.Top, BoundsRect) and
      InRect(TempControl.Left + TempControl.Width,
      TempControl.Top + TempControl.Height, BoundsRect) then
    begin
      // TempControl is not this one, it is a custom shape, that can process
      // mouse messages (eg not a connector), and is completely covered by
      // this control. So bring the convered control to the top of the z-order
      // so that we can access it.
      TempControl.BringToFront;
      Exit;
    end;
  end;
end;

procedure TShapeMoveableControl.RestoreAttributes;
begin
  with DiagramControl.Canvas do
  begin
    Pen.Mode := PenModeSave;
    Pen.Color := PenColorSave;
    Pen.Style := PenStyleSave;
    Pen.Width := PenWidthSave;
    Brush.Style := BrushStyleSave;
  end;
end;

procedure TShapeMoveableControl.SaveAttributes;
begin
  with DiagramControl.Canvas do
  begin
    PenColorSave := Pen.Color;
    PenModeSave := Pen.Mode;
    PenStyleSave := Pen.Style;
    PenWidthSave := Pen.Width;
    Pen.Color := clGray;
    Pen.Mode := pmNotXor;
    Pen.Style := psDot;
    Pen.Width := 1;
    BrushStyleSave := Brush.Style;
    Brush.Style := bsClear;
  end;
end;

//******************************************************************************
//**
//**			TShapeSizeableControl
//**
//******************************************************************************

constructor TShapeSizeableControl.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FSizingMode := smNone;
  FSizeOrigin := Point(0, 0);
  FSizeRectHeight := 5;
  FSizeRectWidth := 5;
  FMinHeight := FSizeRectHeight;
  FMinWidth := FSizeRectWidth;
end;

procedure TShapeSizeableControl.SetSelected(Value: Boolean);
begin
  if Value <> FSelected then
  begin
    inherited SetSelected(Value);
    // Force redraw to show sizing rectangles
    Invalidate;
  end;
end;

procedure TShapeSizeableControl.Paint;
begin
  inherited Paint;
  if not Assigned(Parent) then Exit;
  DrawSizingRects;
end;

function TShapeSizeableControl.GetSizeRect(SizeRectType: TSizingMode): TRect;
begin
  case SizeRectType of
    smTopLeft:
      Result := Bounds(0, 0, SizeRectWidth, SizeRectHeight);
    smTop:
      Result := Bounds(((ClientRect.Right - ClientRect.Left) div 2) -
        (SizeRectWidth div 2), 0, SizeRectWidth, SizeRectHeight);
    smTopRight:
      Result := Bounds(ClientRect.Right - SizeRectWidth, 0,
        SizeRectWidth, SizeRectHeight);
    smLeft:
      Result := Bounds(0, ((ClientRect.Bottom - ClientRect.Top) div 2) -
        (SizeRectHeight div 2), SizeRectWidth, SizeRectHeight);
    smRight:
      Result := Bounds(ClientRect.Right - SizeRectWidth,
        ((ClientRect.Bottom - ClientRect.Top) div 2) -
        (SizeRectHeight div 2), SizeRectWidth, SizeRectHeight);
    smBottomLeft:
      Result := Bounds(0, ClientRect.Bottom - SizeRectHeight,
        SizeRectWidth, SizeRectHeight);
    smBottom:
      Result := Bounds(((ClientRect.Right - ClientRect.Left) div 2) -
        (SizeRectWidth div 2), ClientRect.Bottom - SizeRectHeight,
        SizeRectWidth, SizeRectHeight);
    smBottomRight:
      Result := Bounds(ClientRect.Right - SizeRectWidth,
        ClientRect.Bottom - SizeRectHeight, SizeRectWidth, SizeRectHeight);
    smNone:
      Result := Bounds(0, 0, 0, 0);
  end;
end;

procedure TShapeSizeableControl.DrawSizingRects;
var
  OldBrush: TBrush;
  SMode: TSizingMode;
begin
  if not FSelected or not CanProcessMouseMsg then Exit;
  with Canvas do
  begin
    // Draw the sizing rectangles
    OldBrush := TBrush.Create;
    try
      OldBrush.Assign(Brush);
      Brush.Style := bsSolid;
      Brush.Color := clBlack;
      Pen.Color := clBlack;
      for SMode := smTopLeft to smBottomRight do
        FillRect(GetSizeRect(SMode));
    finally
      Brush.Assign(OldBrush);
      OldBrush.Free;
    end;
  end;
end;

procedure TShapeSizeableControl.CheckForSizeRects(X, Y: Integer);
const
  cCursors: array [TSizingMode] of TCursor =
    (crSizeNWSE, crSizeNS, crSizeNESW, crSizeWE, crSizeWE,
     crSizeNESW, crSizeNS, crSizeNWSE, crDefault);
var
  SMode: TSizingMode;
begin
  Cursor := crDefault;
  FSizingMode := smNone;
  if not Selected then Exit;

  for SMode := smTopLeft to smBottomRight do
    if InRect(X, Y, GetSizeRect(SMode)) then
    begin
      SizingMode := SMode;
      Break;
    end;
  Cursor := cCursors[SizingMode];
end;

procedure TShapeSizeableControl.ResizeControl(X, Y: Integer);

function SnapToGridRect(Const Rect: TRect): TRect;
begin
  SnapToGridRect.Left := SnapToGrid(Rect.Left);
  SnapToGridRect.Top := SnapToGrid(Rect.Top);
  SnapToGridRect.Right := SnapToGrid(Rect.Right) + 1;
  SnapToGridRect.Bottom := SnapToGrid(Rect.Bottom) + 1;
end;

var
  L, T, W, H, DeltaX, DeltaY: Integer;
begin
  L := Left;
  T := Top;
  W := Width;
  H := Height;
  DeltaX := X - FSizeOrigin.X;
  DeltaY := Y - FSizeOrigin.Y;
  // Calculate the new boundaries on the control. Also change FSizeOrigin to
  // reflect change in boundaries if necessary.
  case FSizingMode of
    smTopLeft:
      begin
        // Ensure that don't move the left edge if this would make the
        // control too narrow
        if (L + DeltaX >= 0) and (W - DeltaX > MinWidth) then
        begin
          L := L + DeltaX;
          W := W - DeltaX;
        end;
        // Ensure that don't move the top edge if this would make the
        // control too short
        if (T + DeltaY >= 0) and (H - DeltaY > MinHeight) then
        begin
          T := T + DeltaY;
          H := H - DeltaY;
        end;
      end;
    smTop:
      begin
        if (T + DeltaY >= 0) and (H - DeltaY > MinHeight) then
        begin
          T := T + DeltaY;
          H := H - DeltaY;
        end;
      end;
    smTopRight:
      begin
        W := W + DeltaX;
        if (T + DeltaY >= 0) and (H - DeltaY > MinHeight) then
        begin
          T := T + DeltaY;
          H := H - DeltaY;
        end;
        //FSizeOrigin.X := X;
      end;
    smLeft:
      begin
        if (L + DeltaX >= 0) and (W - DeltaX > MinWidth) then
        begin
          L := L + DeltaX;
          W := W - DeltaX;
        end;
      end;
    smRight:
      begin
        W := W + DeltaX;
        //FSizeOrigin.X := X;
      end;
    smBottomLeft:
      begin
        if (L + DeltaX >= 0) and (W - DeltaX > MinWidth) then
        begin
          L := L + DeltaX;
          W := W - DeltaX;
        end;
        H := H + DeltaY;
        //FSizeOrigin.Y := Y;
      end;
    smBottom:
      begin
        H := H + DeltaY;
        //FSizeOrigin.X := X;
        //FSizeOrigin.Y := Y;
      end;
    smBottomRight:
      begin
        W := W + DeltaX;
        H := H + DeltaY;
        //FSizeOrigin.X := X;
        //FSizeOrigin.Y := Y;
      end;
    smNone: ;
  end;
  SaveAttributes;
  DiagramControl.Canvas.Rectangle(SnapToGridRect(FSizeRect));
  FSizeRect := SnapToGridRect(Bounds(L, T, W, H));
  DiagramControl.Canvas.Rectangle(FSizeRect);
  RestoreAttributes;
end;

procedure TShapeSizeableControl.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  if ssDouble in Shift then Exit;
  FSizeRect := BoundsRect;
  if (FSizingMode = smNone) or (Button <> mbLeft) or (ssShift in Shift) then
  begin
    // Do moving instead of sizing
    FSizingMode := smNone;
    inherited MouseDown(Button, Shift, X, Y);
    Exit;
  end;
  // If sizing then make this the only selected control
  // UnselectControl(Parent);
  BringToFront;
  { TODO : check on all Shapes selected }
  //  FSelected   := True;
  FSizeOrigin := Point(X, Y);
end;

procedure TShapeSizeableControl.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  if Moving then
    inherited MouseMove(Shift, X, Y)
  else
  if (FSizingMode <> smNone) and (ssLeft in Shift) then
    ResizeControl(X, Y)
  else
    // Check if over a sizing rectangle
    CheckForSizeRects(X, Y);
end;

procedure TShapeSizeableControl.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  if Button = mbLeft then
  begin
    FSizingMode := smNone;
    Cursor := crDefault;
  end;
  SetBounds(FSizeRect.Left, FSizeRect.Top, FSizeRect.Right - FSizeRect.Left, FSizeRect.Bottom - FSizeRect.Top);
  inherited MouseUp(Button, Shift, X, Y);
end;

procedure TShapeSizeableControl.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  // Check that the control bounds are sensible. The control must be at least
  // as large as a sizing rectangle
  NoLessThan(ALeft, 0);
  NoLessThan(ATop, 0);
  NoLessThan(AWidth, FMinWidth);
  NoLessThan(AHeight, FMinHeight);
  inherited SetBounds(ALeft, ATop, AWidth, AHeight);
end;

//******************************************************************************
//**
//**			TShapeNodeBase
//**
//******************************************************************************

procedure TShapeNodeBase.SetParent(AParent: TWinControl);
begin
  inherited SetParent(AParent);
  // First state will be used as default
  if (DiagramControl <> nil) and (DiagramControl.State = nil) then
    DiagramControl.State := self;
end;

//******************************************************************************
//**
//**			TShapeNode
//**
//******************************************************************************

constructor TShapeNode.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FToConnector := AddConnector(poOwnedBySource);
//  ControlStyle := [csCaptureMouse, { csOpaque, } csDoubleClicks];
end;

destructor TShapeNode.Destroy;
begin
  FToConnector.Free;
  inherited Destroy;
end;

procedure TShapeNode.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  inherited SetBounds(ALeft, ATop, AWidth, AHeight);
  FToConnector.Offset := 0;
end;

procedure TShapeNode.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) then
  begin
    if (AComponent = FDefaultTransition) then
    begin
      FDefaultTransition := nil;
      FToConnector.Destination := nil;
    end;
  end;
end;

procedure TShapeNode.PaintConnector;
begin
  inherited PaintConnector;
  DiagramControl.Canvas.Pen.Width := 2;
  FToConnector.Paint;
end;

function TShapeNode.HitTest(Mouse: TPoint): TShapeConnector;
begin
  Result := nil;
  if (FToConnector.HitTest(Mouse)) then
    Result := FToConnector;
end;

procedure TShapeNode.PrepareCanvas(Element: TVisualElement; Canvas: TCanvas);
begin
  inherited PrepareCanvas(Element, Canvas);
  if (Element = veText) and
    not(Assigned(OnEnterState) or (csDesigning in ComponentState)) then
    Canvas.Font.Color := clGray;
end;

procedure TShapeNode.SetDefaultTransition(Value: TShapeCustomControl);
begin
  FDefaultTransition := Value;
  FToConnector.Destination := Value;
  if (FDiagramControl <> nil) then
    DiagramControl.Invalidate;
end;

procedure TShapeNode.DoOnEnter;
begin
  if (Assigned(FOnEnterState)) then
    FOnEnterState(self);
end;

procedure TShapeNode.DoOnExit;
begin
  if (Assigned(FOnExitState)) then
    FOnExitState(self);
end;

function TShapeNode.DoDefault: Boolean;
begin
  Result := True;
  if Assigned(DefaultTransition) then
    DiagramControl.ChangeState(DefaultTransition)
  else
    Result := False;
end;

//******************************************************************************
//**
//**			TShapeStart
//**
//******************************************************************************

constructor TShapeStart.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  SetBounds(0, 0, 65, 33);
end;

procedure TShapeStart.DoPaint;
var
  RoundSize: integer;
  r: TRect;
begin
  RoundSize := Height - (2 * ShadowHeight);
  // Draw shadow
  PrepareCanvas(veShadow, Canvas);
  Canvas.RoundRect(ShadowHeight, ShadowHeight, Width, Height, RoundSize, RoundSize);
  // Draw rectangle
  PrepareCanvas(veFrame, Canvas);
  PrepareCanvas(vePanel, Canvas);
  Canvas.RoundRect(0,0, Width - ShadowHeight, Height - ShadowHeight, RoundSize, RoundSize);
  // Draw name
  PrepareCanvas(veText, Canvas);
  r := Rect(0, 0, Width, Height);
  InflateRect(r, -(ShadowHeight + 2), -(ShadowHeight + 2));
  DrawText(r);
end;

procedure TShapeStart.PrepareCanvas(Element: TVisualElement; Canvas: TCanvas);
begin
  inherited PrepareCanvas(Element, Canvas);
  case (Element) of
    veText:
      Canvas.Font.Style := [fsBold];
    veFrame:
      Canvas.Pen.Color := clGreen;
  end;
end;

//******************************************************************************
//**
//**			TShapeStop
//**
//******************************************************************************

constructor TShapeStop.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  SetBounds(0, 0, 65, 33);
end;

procedure TShapeStop.DoPaint;
var
  RoundSize: integer;
  r: TRect;
begin
  RoundSize := Height - (2 * ShadowHeight);
  // Draw shadow
  PrepareCanvas(veShadow, Canvas);
  Canvas.RoundRect(ShadowHeight, ShadowHeight, Width, Height, RoundSize, RoundSize);
  // Draw rectangle
  PrepareCanvas(veFrame, Canvas);
  PrepareCanvas(vePanel, Canvas);
  Canvas.RoundRect(0,0, Width - ShadowHeight, Height - ShadowHeight, RoundSize, RoundSize);
  // Draw name
  PrepareCanvas(veText, Canvas);
  r := Rect(0, 0, Width, Height);
  InflateRect(r, -(ShadowHeight + 2), -(ShadowHeight + 2));
  DrawText(r);
end;

procedure TShapeStop.PrepareCanvas(Element: TVisualElement; Canvas: TCanvas);
begin
  inherited PrepareCanvas(Element, Canvas);
  case (Element) of
    veText:
      Canvas.Font.Style := [fsBold];
    veFrame:
      Canvas.Pen.Color := $000099FF;
  end;
end;

//******************************************************************************
//**
//**			TShapeBoolean
//**
//******************************************************************************

constructor TShapeBoolean.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FDefault := True;
  FTrueConnector := AddConnector(poOwnedBySource);
  FFalseConnector := AddConnector(poOwnedBySource);
  SetBounds(0, 0, 81, 41);
end;

destructor TShapeBoolean.Destroy;
begin
  FTrueConnector.Free;
  FFalseConnector.Free;

  inherited Destroy;
end;

procedure TShapeBoolean.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  inherited SetBounds(ALeft, ATop, AWidth, AHeight);
  FTrueConnector.Offset := 0;
  FFalseConnector.Offset := 0;
end;

procedure TShapeBoolean.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) then
  begin
    if (AComponent = FTrueState) then
    begin
      FTrueState := nil;
      FTrueConnector.Destination := nil;
    end;
    if (AComponent = FFalseState) then
    begin
      FFalseState := nil;
      FFalseConnector.Destination := nil;
    end;
  end;
end;

procedure TShapeBoolean.PaintConnector;
begin
  inherited PaintConnector;
  if (DefaultState) then
    DiagramControl.Canvas.Pen.Width := 2
  else
    DiagramControl.Canvas.Pen.Width := 1;
  DiagramControl.Canvas.Pen.Color := clGreen;
  FTrueConnector.Paint;

  if not(DefaultState) then
    DiagramControl.Canvas.Pen.Width := 2
  else
    DiagramControl.Canvas.Pen.Width := 1;
  DiagramControl.Canvas.Pen.Color := clRed;
  FFalseConnector.Paint;
end;

function TShapeBoolean.HitTest(Mouse: TPoint): TShapeConnector;
begin
  Result := nil;
  if (FTrueConnector.HitTest(Mouse)) then
    Result := FTrueConnector
  else if (FFalseConnector.HitTest(Mouse)) then
    Result := FFalseConnector;
end;

procedure TShapeBoolean.PrepareCanvas(Element: TVisualElement; Canvas: TCanvas);
begin
  inherited PrepareCanvas(Element, Canvas);
  case (Element) of
    veText:
      if not(Assigned(OnEnterState) or (csDesigning in ComponentState)) then
        Canvas.Font.Color := clGray;
  end;
end;

procedure TShapeBoolean.DoPaint;
var
  r: TRect;
  Diamond: array[0..3] of TPoint;
begin
  // Draw shadow
  PrepareCanvas(veShadow, Canvas);
  Diamond[0] := Point(ShadowHeight, (Height - ShadowHeight) div 2 + ShadowHeight);
  Diamond[1] := Point((Width - ShadowHeight) div 2 + ShadowHeight, ShadowHeight);
  Diamond[2] := Point(Width - 1, (Height - ShadowHeight) div 2 + ShadowHeight);
  Diamond[3] := Point((Width - ShadowHeight) div 2 + ShadowHeight, Height - 1);
  Canvas.Polygon(Diamond);
  // Draw rectangle
  PrepareCanvas(veFrame, Canvas);
  PrepareCanvas(vePanel, Canvas);
  Diamond[0] := Point(0, (Height - ShadowHeight) div 2);
  Diamond[1] := Point((Width - ShadowHeight) div 2, 0);
  Diamond[2] := Point(Width - (ShadowHeight + 1), (Height - ShadowHeight) div 2);
  Diamond[3] := Point((Width - ShadowHeight) div 2, Height - (ShadowHeight + 1));
  Canvas.Polygon(Diamond);
  // Draw name
  PrepareCanvas(veText, Canvas);
  r := Rect(Width DIV 8, Height DIV 3, Width - (Width DIV 8), Height - (Height DIV 3));
  InflateRect(r, -ShadowHeight, -ShadowHeight);
  DrawText(r);
end;

procedure TShapeBoolean.SetTrueState(Value :TShapeCustomControl);
begin
  FTrueState := Value;
  FTrueConnector.Destination := Value;
  // True and False should not be the same
  if (Value <> nil) and (FFalseState = Value) then
    FFalseState := nil;
  if (FDiagramControl <> nil) then
    DiagramControl.Invalidate;
end;

procedure TShapeBoolean.SetFalseState(Value :TShapeCustomControl);
begin
  FFalseState := Value;
  FFalseConnector.Destination := Value;
  // True and False should not be the same
  if (Value <> nil) and (FtrueState = Value) then
    FTrueState := nil;
  if (FDiagramControl <> nil) then
    DiagramControl.Invalidate;
end;

procedure TShapeBoolean.SetDefault(Value :Boolean);
begin
  if (Value <> FDefault) then
  begin
    FDefault := Value;
    DiagramControl.Invalidate; // To erase previous fat line
    // Invalidate;
  end;
end;

procedure TShapeBoolean.DoOnEnter;
begin
  FResult := FDefault;
  if (Assigned(FOnEnterState)) then
  begin
    FOnEnterState(self, FResult);
    if not(DiagramControl.StateChanged) then
    begin
      if (FResult) and (Assigned(FTrueState)) then
        DiagramControl.ChangeState(FTrueState)
      else if (not FResult) and (Assigned(FFalseState)) then
        DiagramControl.ChangeState(FFalseState);
    end;
  end;
end;

procedure TShapeBoolean.DoOnExit;
begin
  if (Assigned(FOnExitState)) then
    FOnExitState(self);
end;

function TShapeBoolean.DoDefault: Boolean;
begin
  Result := True;
  if (DefaultState) and (Assigned(FTrueState)) then
    DiagramControl.ChangeState(FTrueState)
  else if (not DefaultState) and (Assigned(FFalseState)) then
    DiagramControl.ChangeState(FFalseState)
  else
    Result := False;
end;

//******************************************************************************
//**
//**			TShapeTransition
//**
//******************************************************************************

constructor TShapeTransition.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FToConnector := AddConnector(poOwnedBySource);
  FFromConnector := AddConnector(poOwnedByDestination);
  SetBounds(0, 0, 89, 41);
end;

destructor TShapeTransition.Destroy;
begin
  FFromState := nil;
  FFromConnector.Free;
  FToState := nil;
  FToConnector.Free;
  inherited Destroy;
end;

procedure TShapeTransition.SetParent(AParent: TWinControl);
begin
  inherited SetParent(AParent);
end;

procedure TShapeTransition.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  inherited SetBounds(ALeft, ATop, AWidth, AHeight);
  FToConnector.Offset := 0;
  FFromConnector.Offset := 0;
end;

procedure TShapeTransition.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) then
  begin
    if (FFromState = AComponent) then
    begin
      FFromState := nil;
      FFromConnector.Source := nil;
    end;
    if (FToState = AComponent) then
    begin
      FToState := nil;
      FToConnector.Destination := nil;
    end;
  end;
end;

procedure TShapeTransition.PaintConnector;
begin
  inherited PaintConnector;
  DiagramControl.Canvas.Pen.Width := 1;
  FFromConnector.Paint;
  FToConnector.Paint;
end;

function TShapeTransition.HitTest(Mouse: TPoint): TShapeConnector;
begin
  Result := nil;
  if (FToConnector.HitTest(Mouse)) then
    Result := FToConnector
  else
    if (FFromConnector.HitTest(Mouse)) then
      Result := FFromConnector;
end;

procedure TShapeTransition.PrepareCanvas(Element: TVisualElement; Canvas: TCanvas);
begin
  inherited PrepareCanvas(Element, Canvas);
  case (Element) of
    veText:
      if not((Assigned(FFromState)) and (Assigned(FToState)) or
        (csDesigning in ComponentState)) then
        Canvas.Font.Color := clGray;
  end;
end;

procedure TShapeTransition.DoPaint;
var
  RoundSize: integer;
  r: TRect;
begin
  RoundSize := 16;
  if (Height < RoundSize) then
    RoundSize := Height;
  if (Width < RoundSize) then
    RoundSize := Width;

  // Draw shadow
  PrepareCanvas(veShadow, Canvas);
  Canvas.RoundRect(ShadowHeight,ShadowHeight, Width, Height, RoundSize,RoundSize);
  // Draw rectangle
  PrepareCanvas(veFrame, Canvas);
  PrepareCanvas(vePanel, Canvas);
  Canvas.RoundRect(0,0, Width-ShadowHeight,Height-ShadowHeight, RoundSize,RoundSize);
  // Draw name
  PrepareCanvas(veText, Canvas);
  r := Rect(ShadowHeight+1,ShadowHeight+1,Width-(Canvas.Pen.Width+1), Height-(Canvas.Pen.Width+1));
  DrawText(r);
end;

procedure TShapeTransition.SetFromState(Value :TShapeCustomControl);
begin
  if (Value <>  nil) and (Value.DiagramControl <> CheckDiagramControl) then
    raise Exception.Create('No se puede enlazar este control en otro contenedor');
  FFromState := Value;
  FFromConnector.Source := Value;
  if (FDiagramControl <> nil) then
    DiagramControl.Invalidate;
end;

procedure TShapeTransition.SetToState(Value :TShapeCustomControl);
begin
  if (Value <>  nil) and (Value.DiagramControl <> CheckDiagramControl) then
    raise Exception.Create('No se puede enlazar este control en otro contenedor');
  FToState := Value;
  FToConnector.Destination := Value;
  if (FDiagramControl <> nil) then
    DiagramControl.Invalidate;
end;

procedure TShapeTransition.DoOnEnter;
begin
  if (Assigned(FOnTransition)) then
    FOnTransition(self);
end;

function TShapeTransition.DoDefault: Boolean;
begin
  Result := True;
  if Assigned(ToState) then
    DiagramControl.ChangeState(ToState)
  else
    Result := False;
end;

procedure TShapeTransition.CheckTransition(Transition: TShapeCustomControl; Direction: TTransitionDirection);
begin
  inherited CheckTransition(Transition, Direction);
  if (Direction = tdTo) and Assigned(FFromState) and (Transition <> FFromState) then
    raise Exception.Create('FromState no es el mismo');
  if (Direction = tdFrom) and Assigned(FToState) and (Transition <> FToState) then
    raise Exception.Create('ToState no es el mismo');
end;

//******************************************************************************
//**
//**			TShapeLink
//**
//******************************************************************************

constructor TShapeLink.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FDirection := ldOutgoing;
  FConnector := AddConnector(poOwnedBySource);
  SetBounds(0, 0, 25, 25);
end;

destructor TShapeLink.Destroy;
begin
  FConnector.Free;
  FDestination := nil;
  inherited Destroy;
end;

procedure TShapeLink.SetParent(AParent: TWinControl);
begin
  inherited SetParent(AParent);
end;

procedure TShapeLink.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  if (AWidth <> Width) then
    AHeight := AWidth
  else if (AHeight <> Height) then
    AWidth := AHeight;
  inherited SetBounds(ALeft, ATop, AWidth, AHeight);
  FConnector.Offset := 0;
end;

procedure TShapeLink.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) then
  begin
    if (FDestination = AComponent) then
    begin
      if (Direction = ldOutgoing) then
        FConnector.Destination := nil;
      FDestination := nil;
    end;
  end;
end;

procedure TShapeLink.PaintConnector;
begin
  inherited PaintConnector;
  FConnector.Paint;
end;

function TShapeLink.HitTest(Mouse: TPoint): TShapeConnector;
begin
  Result := nil;
  if (FConnector.HitTest(Mouse)) then
    Result := FConnector;
end;

procedure TShapeLink.PrepareCanvas(Element: TVisualElement; Canvas: TCanvas);
begin
  inherited PrepareCanvas(Element, Canvas);
  case (Element) of
    veText:
      if not(Assigned(FDestination) or (csDesigning in ComponentState)) then
        Canvas.Font.Color := clGray;
  end;
end;

procedure TShapeLink.DoPaint;
var
  r: TRect;
begin
  // Draw shadow
  PrepareCanvas(veShadow, Canvas);
  r.TopLeft :=  Point(ShadowHeight,ShadowHeight);
  r.BottomRight := Point(Width, Height);
  Canvas.Ellipse(r.Left, r.Top, r.Right, r.Bottom);
  // Draw rectangle
  PrepareCanvas(veFrame, Canvas);
  PrepareCanvas(vePanel, Canvas);
  OffsetRect(r, -r.Left, -r.Top);
  Canvas.Ellipse(r.Left, r.Top, r.Right, r.Bottom);
  // Draw name
  PrepareCanvas(veText, Canvas);
  // Margin for text
  InflateRect(r, -(ShadowHeight + 2), -(ShadowHeight + 2));
  DrawText(r);
end;

procedure TShapeLink.SetDestination(Value :TShapeCustomControl);
begin
  if (Value <>  nil) and (Value.DiagramControl <> CheckDiagramControl) then
    raise Exception.Create('No se puede conectar a un nodo en otro contenedor');

  if (Value = Self) then
    raise Exception.Create('No se puede conectar a si mismo');

  FDestination := Value;

  if (Value <>  nil) then
  begin
    if (Value is TShapeLink) then
    begin
      FDirection := ldOutgoing;
      FConnector.Destination := nil;
    end else
    begin
      FDirection := ldIncoming;
      FConnector.Destination := Value;
    end;

    FConnector.Paint;
  end;
  DiagramControl.Invalidate;
end;

procedure TShapeLink.SetDirection(Value :TLinkDirection);
begin
  if (Value <> FDirection) then
  begin
    FDirection := Value;
    Destination := nil;
    DiagramControl.Invalidate;
  end;
end;

procedure TShapeLink.CheckTransition(Transition: TShapeCustomControl; Direction: TTransitionDirection);
begin
  inherited CheckTransition(Transition, Direction);
  if (Direction = tdTo) and
  (((FDirection = ldOutgoing) and (Transition is TShapeLink)) or
   ((FDirection = ldIncoming) and not(Transition is TShapeLink))) then
    raise Exception.Create('La dirección y el tipo de estado previo es ilegal');

  if (Direction = tdFrom) and
  (((FDirection = ldOutgoing) and not(Transition is TShapeLink)) or
   ((FDirection = ldIncoming) and (Transition is TShapeLink))) then
    raise Exception.Create('La dirección y el siguiente tipo de estado es ilegal');
end;

function TShapeLink.DoDefault: Boolean;
begin
  Result := True;
  if Assigned(Destination) then
    DiagramControl.ChangeState(Destination)
  else
    Result := False;
end;

//******************************************************************************
//**
//**			TShapeRead
//**
//******************************************************************************

procedure TShapeRead.DoPaint;
var
  OffsetSize: integer;
  r: TRect;
  Frame: array[0..3] of TPoint;
begin
  OffsetSize := 15;
  // Draw shadow
  PrepareCanvas(veShadow, Canvas);
  Frame[0] := Point(ShadowHeight + OffsetSize, ShadowHeight);
  Frame[1] := Point(Width - 1, ShadowHeight);
  Frame[2] := Point(Width - (OffsetSize + 1), Height - 1);
  Frame[3] := Point(ShadowHeight, Height - 1);
  Canvas.Polygon(Frame);
  // Draw Paralellogram
  PrepareCanvas(veFrame, Canvas);
  PrepareCanvas(vePanel, Canvas);
  Frame[0] := Point(OffsetSize, 0);
  Frame[1] := Point(Width - (ShadowHeight + 1), 0);
  Frame[2] := Point(Width - (ShadowHeight + OffsetSize + 1), Height - (ShadowHeight + 1));
  Frame[3] := Point(0, Height - (ShadowHeight + 1));
  Canvas.Polygon(Frame);
  // Draw name
  PrepareCanvas(veText, Canvas);
  r := Rect(Width DIV 5, 0, Width - (Width DIV 5), Height);
  InflateRect(r, -(ShadowHeight + 2), -(ShadowHeight + 2));
  DrawText(r);
end;

procedure TShapeRead.PrepareCanvas(Element: TVisualElement;
  Canvas: TCanvas);
begin
  inherited PrepareCanvas(Element, Canvas);
  case (Element) of
    veText:
      if not(Assigned(OnEnterState) or (csDesigning in ComponentState)) then
        Canvas.Font.Color := clGray;
  end;
end;

//******************************************************************************
//**
//**			TShapeWrite
//**
//******************************************************************************

constructor TShapeWrite.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  SetBounds(0, 0, 81, 41);
end;

procedure TShapeWrite.DoPaint;
var
  r: TRect;
  Frame: array[0..3] of TPoint;
begin
  // Draw shadow
  PrepareCanvas(veShadow, Canvas);
  Frame[0] := Point(ShadowHeight, ShadowHeight);
  Frame[1] := Point(Width - 1, ShadowHeight);
  Frame[2] := Point(Width - 1, Height - (Height div 3) + ShadowHeight);
  Frame[3] := Point(ShadowHeight, Height - 1);
  Canvas.Polygon(Frame);
  // Draw Paralellogram
  PrepareCanvas(veFrame, Canvas);
  PrepareCanvas(vePanel, Canvas);
  Frame[0] := Point(0, 0);
  Frame[1] := Point(Width - (ShadowHeight + 1), 0);
  Frame[2] := Point(Width - (ShadowHeight + 1), Height - (Height div 3));
  Frame[3] := Point(0, Height - (ShadowHeight + 1));
  Canvas.Polygon(Frame);
  // Draw name
  PrepareCanvas(veText, Canvas);
  r := Rect(0, 0, Width, Height - (Height div 3));
  InflateRect(r, -(ShadowHeight + 2), -(ShadowHeight + 2));
  DrawText(r);
end;

procedure TShapeWrite.PrepareCanvas(Element: TVisualElement;
  Canvas: TCanvas);
begin
  inherited PrepareCanvas(Element, Canvas);
  case (Element) of
    veText:
      if not(Assigned(OnEnterState) or (csDesigning in ComponentState)) then
        Canvas.Font.Color := clGray;
  end;
end;

//******************************************************************************
//**
//**			TShapeLoop
//**
//******************************************************************************

constructor TShapeLoop.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FDefault := True;
  FTrueConnector := AddConnector(poOwnedBySource);
  FFalseConnector := AddConnector(poOwnedBySource);
end;

destructor TShapeLoop.Destroy;
begin
  FTrueConnector.Free;
  FFalseConnector.Free;

  inherited Destroy;
end;

procedure TShapeLoop.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  inherited SetBounds(ALeft, ATop, AWidth, AHeight);
  FTrueConnector.Offset := 0;
  FFalseConnector.Offset := 0;
end;

procedure TShapeLoop.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) then
  begin
    if (AComponent = FTrueState) then
    begin
      FTrueState := nil;
      FTrueConnector.Destination := nil;
    end;
    if (AComponent = FFalseState) then
    begin
      FFalseState := nil;
      FFalseConnector.Destination := nil;
    end;
  end;
end;

procedure TShapeLoop.PaintConnector;
begin
  inherited PaintConnector;
  if (DefaultState) then
    DiagramControl.Canvas.Pen.Width := 2
  else
    DiagramControl.Canvas.Pen.Width := 1;
  DiagramControl.Canvas.Pen.Color := clGreen;
  FTrueConnector.Paint;

  if not(DefaultState) then
    DiagramControl.Canvas.Pen.Width := 2
  else
    DiagramControl.Canvas.Pen.Width := 1;
  DiagramControl.Canvas.Pen.Color := clRed;
  FFalseConnector.Paint;
end;

function TShapeLoop.HitTest(Mouse: TPoint): TShapeConnector;
begin
  Result := nil;
  if (FTrueConnector.HitTest(Mouse)) then
    Result := FTrueConnector
  else if (FFalseConnector.HitTest(Mouse)) then
    Result := FFalseConnector;
end;

procedure TShapeLoop.PrepareCanvas(Element: TVisualElement; Canvas: TCanvas);
begin
  inherited PrepareCanvas(Element, Canvas);
  case (Element) of
    veText:
      if not(Assigned(OnEnterState) or (csDesigning in ComponentState)) then
        Canvas.Font.Color := clGray;
  end;
end;

procedure TShapeLoop.DoPaint;
var
  r: TRect;
  Frame: array[0..5] of TPoint;
begin
  // Draw shadow
  PrepareCanvas(veShadow, Canvas);
  Frame[0] := Point(ShadowHeight, (Height - ShadowHeight) div 2 + ShadowHeight);
  Frame[1] := Point(ShadowHeight + Height div 2, ShadowHeight);
  Frame[2] := Point(Width - Height div 2, ShadowHeight);
  Frame[3] := Point(Width - 1, (Height - ShadowHeight) div 2 + ShadowHeight);
  Frame[4] := Point(Width - Height div 2, Height - 1);
  Frame[5] := Point(ShadowHeight + Height div 2, Height - 1);
  Canvas.Polygon(Frame);
  // Draw Poligon
  PrepareCanvas(veFrame, Canvas);
  PrepareCanvas(vePanel, Canvas);
  Frame[0] := Point(0, (Height - ShadowHeight) div 2);
  Frame[1] := Point((Height - ShadowHeight) div 2, 0);
  Frame[2] := Point(Width - ShadowHeight - Height div 2, 0);
  Frame[3] := Point(Width - (ShadowHeight + 1), (Height - ShadowHeight) div 2);
  Frame[4] := Point(Width - ShadowHeight - Height div 2, Height - (ShadowHeight + 1));
  Frame[5] := Point((Height - ShadowHeight) div 2, Height - (ShadowHeight + 1));
  Canvas.Polygon(Frame);
  // Draw name
  PrepareCanvas(veText, Canvas);
  r := Rect(Width DIV 8, Height DIV 3, Width - (Width DIV 8), Height - (Height DIV 3));
  InflateRect(r, -(ShadowHeight + 2), -(ShadowHeight + 2));
  DrawText(r);
end;

procedure TShapeLoop.SetTrueState(Value :TShapeCustomControl);
begin
  FTrueState := Value;
  FTrueConnector.Destination := Value;
  // True and False should not be the same
  if (Value <> nil) and (FFalseState = Value) then
    FFalseState := nil;
  if (FDiagramControl <> nil) then
    DiagramControl.Invalidate;
end;

procedure TShapeLoop.SetFalseState(Value :TShapeCustomControl);
begin
  FFalseState := Value;
  FFalseConnector.Destination := Value;
  // True and False should not be the same
  if (Value <> nil) and (FtrueState = Value) then
    FTrueState := nil;
  if (FDiagramControl <> nil) then
    DiagramControl.Invalidate;
end;

procedure TShapeLoop.SetDefault(Value :Boolean);
begin
  if (Value <> FDefault) then
  begin
    FDefault := Value;
    DiagramControl.Invalidate; // To erase previous fat line
    // Invalidate;
  end;
end;

procedure TShapeLoop.DoOnEnter;
begin
  FResult := FDefault;
  if (Assigned(FOnEnterState)) then
  begin
    FOnEnterState(self, FResult);
    if not(DiagramControl.StateChanged) then
    begin
      if (FResult) and (Assigned(FTrueState)) then
        DiagramControl.ChangeState(FTrueState)
      else if (not FResult) and (Assigned(FFalseState)) then
        DiagramControl.ChangeState(FFalseState);
    end;
  end;
end;

procedure TShapeLoop.DoOnExit;
begin
  if (Assigned(FOnExitState)) then
    FOnExitState(self);
end;

function TShapeLoop.DoDefault: Boolean;
begin
  Result := True;
  if (DefaultState) and (Assigned(FTrueState)) then
    DiagramControl.ChangeState(FTrueState)
  else if (not DefaultState) and (Assigned(FFalseState)) then
    DiagramControl.ChangeState(FFalseState)
  else
    Result := False;
end;

//******************************************************************************
//**
//**			TShapeTrans
//**
//******************************************************************************

constructor TShapeTrans.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  SetBounds(0, 0, 17, 17);
end;

procedure TShapeTrans.DoPaint;
var
  r: TRect;
begin
  // Draw shadow
  PrepareCanvas(veShadow, Canvas);
  r.TopLeft :=  Point(ShadowHeight,ShadowHeight);
  r.BottomRight := Point(Width, Height);
  Canvas.Ellipse(r.Left, r.Top, r.Right, r.Bottom);
  // Draw rectangle
  PrepareCanvas(veFrame, Canvas);
  PrepareCanvas(vePanel, Canvas);
  OffsetRect(r, -r.Left, -r.Top);
  Canvas.Ellipse(r.Left, r.Top, r.Right, r.Bottom);
end;

procedure TShapeTrans.PrepareCanvas(Element: TVisualElement; Canvas: TCanvas);
begin
  inherited PrepareCanvas(Element, Canvas);
  case (Element) of
    veText:
      Canvas.Font.Style := [fsBold];
    veFrame:
      Canvas.Pen.Color := $00FFFF80;
  end;
end;

end.
