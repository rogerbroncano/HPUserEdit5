unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, JvAppStorage, JvAppRegistryStorage, JvComponentBase,
  JvComputerInfoEx, ehsbase, ehswhatsthis, XPMan, Menus, TB2Item, TBX, TB2MRU,
  TBXExtItems, TBXSwitcher, SynEditMiscClasses, SynEditSearch, StdActns,
  ActnList, XPStyleActnCtrls, ActnMan, ehscontextmap, ehshelprouter,
  SynEditPrint, AppEvnts, TFlatHintUnit, ImgList, Grids, ComCtrls, TBXDkPanels,
  JvgPage, TBXStatusBars, TB2Dock, TB2Toolbar, SynEdit, SynHighlighterUserEdit,
  JvSearchFiles, JvExStdCtrls, JvListBox, TBXGraphics, JvPageList, JvExControls,
  JvTabBar, Tabs, JvExGrids, JvStringGrid, ExtCtrls;

type
  TMainProgram = class(TForm)
    FlatHint: TFlatHint;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    ApplicationEvents: TApplicationEvents;
    SynEditPrint: TSynEditPrint;
    PrintDialog: TPrintDialog;
    HelpRouter: THelpRouter;
    HelpContextMap: THelpContextMap;
    ActionManager: TActionManager;
    EditCopy: TEditCopy;
    EditCut: TEditCut;
    EditPaste: TEditPaste;
    EditSelectAll: TEditSelectAll;
    EditUndo: TEditUndo;
    EditRedo: TAction;
    SearchFind: TAction;
    SearchReplace: TAction;
    FileOpen: TAction;
    FileSave: TAction;
    FilePrint: TAction;
    FilePreview: TAction;
    HelpIndex: TAction;
    OptionsEditor: TAction;
    ViewLineNumbers: TAction;
    SearchFindNext: TAction;
    SearchFindPrev: TAction;
    SearchGoTo: TAction;
    EmuSend: TAction;
    HelpAbout: TAction;
    FileClose: TAction;
    FileSaveAs: TAction;
    FileCloseAll: TAction;
    FileExit: TAction;
    HelpTipOfDay: TAction;
    OptionsEnvironment: TAction;
    FilePageSetup: TAction;
    ViewStatusBar: TAction;
    ViewCommandsBar: TAction;
    ViewInsertBar: TAction;
    ViewSymbolsBar: TAction;
    ViewToolBar: TAction;
    InsertProgram: TAction;
    InsertString: TAction;
    InsertEquation: TAction;
    InsertList: TAction;
    ToolsMatrixWriter: TAction;
    InsertComplex: TAction;
    InsertIf: TAction;
    InsertCase: TAction;
    InsertStart: TAction;
    InsertFor: TAction;
    InsertDo: TAction;
    InsertWhile: TAction;
    ToolsInput: TAction;
    ToolsChoose: TAction;
    ToolsInform: TAction;
    ToolsPicture: TAction;
    SynEditSearch: TSynEditSearch;
    FileNew: TAction;
    DockTop: TTBXDock;
    MenuBar: TTBXToolbar;
    ToolBar: TTBXToolbar;
    InsertBar: TTBXToolbar;
    StatusBar: TTBXStatusBar;
    MenuFile: TTBXSubmenuItem;
    MenuEdit: TTBXSubmenuItem;
    MenuSearch: TTBXSubmenuItem;
    MenuView: TTBXSubmenuItem;
    MenuInsert: TTBXSubmenuItem;
    MenuOptions: TTBXSubmenuItem;
    MenuHelp: TTBXSubmenuItem;
    TBXItem3: TTBXItem;
    TBXItem4: TTBXItem;
    TBXItem5: TTBXItem;
    TBXSeparatorItem1: TTBXSeparatorItem;
    TBXItem6: TTBXItem;
    TBXItem7: TTBXItem;
    TBXSeparatorItem2: TTBXSeparatorItem;
    TBXItem8: TTBXItem;
    TBXItem9: TTBXItem;
    TBXSeparatorItem3: TTBXSeparatorItem;
    TBXItem10: TTBXItem;
    TBXItem11: TTBXItem;
    TBXItem12: TTBXItem;
    TBXSeparatorItem4: TTBXSeparatorItem;
    TBXItem13: TTBXItem;
    TBXItem14: TTBXItem;
    TBXItem15: TTBXItem;
    TBXItem16: TTBXItem;
    TBXSeparatorItem5: TTBXSeparatorItem;
    TBXItem17: TTBXItem;
    TBXSeparatorItem6: TTBXSeparatorItem;
    TBXItem18: TTBXItem;
    TBXItem19: TTBXItem;
    TBXSeparatorItem7: TTBXSeparatorItem;
    TBXItem20: TTBXItem;
    TBXItem21: TTBXItem;
    TBXSeparatorItem8: TTBXSeparatorItem;
    TBXItem23: TTBXItem;
    TBXMRUListItem1: TTBXMRUListItem;
    TBXItem24: TTBXItem;
    TBXItem25: TTBXItem;
    TBXItem26: TTBXItem;
    TBXItem27: TTBXItem;
    TBXItem28: TTBXItem;
    TBXSeparatorItem9: TTBXSeparatorItem;
    TBXItem29: TTBXItem;
    TBXItem30: TTBXItem;
    TBXItem31: TTBXItem;
    TBXItem32: TTBXItem;
    TBXItem34: TTBXItem;
    TBXItem35: TTBXItem;
    TBXItem36: TTBXItem;
    TBXItem37: TTBXItem;
    TBXItem38: TTBXItem;
    TBXItem39: TTBXItem;
    TBXItem40: TTBXItem;
    TBXItem41: TTBXItem;
    TBXItem42: TTBXItem;
    TBXItem43: TTBXItem;
    TBXItem44: TTBXItem;
    TBXItem45: TTBXItem;
    TBXItem46: TTBXItem;
    TBXItem47: TTBXItem;
    TBXItem48: TTBXItem;
    TBXItem49: TTBXItem;
    TBXItem50: TTBXItem;
    TBXSeparatorItem11: TTBXSeparatorItem;
    TBXItem51: TTBXItem;
    TBXItem54: TTBXItem;
    TBXItem55: TTBXItem;
    TBXSeparatorItem12: TTBXSeparatorItem;
    TBXSeparatorItem13: TTBXSeparatorItem;
    TBXItem57: TTBXItem;
    TBXItem58: TTBXItem;
    TBXSeparatorItem14: TTBXSeparatorItem;
    TBXItem59: TTBXItem;
    TBXItem60: TTBXItem;
    TBXItem61: TTBXItem;
    TBXSeparatorItem15: TTBXSeparatorItem;
    TBXItem62: TTBXItem;
    TBXItem63: TTBXItem;
    TBXSeparatorItem16: TTBXSeparatorItem;
    TBXItem64: TTBXItem;
    TBXItem65: TTBXItem;
    TBXSeparatorItem17: TTBXSeparatorItem;
    TBXItem66: TTBXItem;
    TBXSeparatorItem18: TTBXSeparatorItem;
    TBXItem67: TTBXItem;
    TBXItem68: TTBXItem;
    TBXItem69: TTBXItem;
    TBXItem70: TTBXItem;
    TBXItem71: TTBXItem;
    TBXItem72: TTBXItem;
    TBXItem73: TTBXItem;
    TBXItem74: TTBXItem;
    TBXSeparatorItem19: TTBXSeparatorItem;
    TBXItem75: TTBXItem;
    TBXItem76: TTBXItem;
    TBXItem77: TTBXItem;
    TBXItem78: TTBXItem;
    TBXItem79: TTBXItem;
    TBXItem80: TTBXItem;
    TBXSeparatorItem20: TTBXSeparatorItem;
    TBXItem81: TTBXItem;
    TBXItem82: TTBXItem;
    TBXItem83: TTBXItem;
    TBXItem84: TTBXItem;
    TBXSwitcher: TTBXSwitcher;
    MRUList: TTBXMRUList;
    PopupMenu: TTBXPopupMenu;
    TBXItem52: TTBXItem;
    TBXItem1: TTBXItem;
    TBXSeparatorItem22: TTBXSeparatorItem;
    TBXItem2: TTBXItem;
    TBXSeparatorItem23: TTBXSeparatorItem;
    TBXItem53: TTBXItem;
    TBXSeparatorItem24: TTBXSeparatorItem;
    TBXItem85: TTBXItem;
    TBXItem86: TTBXItem;
    TBXSeparatorItem25: TTBXSeparatorItem;
    TBXItem87: TTBXItem;
    TBXItem88: TTBXItem;
    TBXItem89: TTBXItem;
    TBXSeparatorItem26: TTBXSeparatorItem;
    TBXItem90: TTBXItem;
    FileImport: TAction;
    FileExport: TAction;
    TBXItem93: TTBXItem;
    TBXItem94: TTBXItem;
    TBXSeparatorItem27: TTBXSeparatorItem;
    FileSendToHP: TAction;
    TBXItem95: TTBXItem;
    TBXItem96: TTBXItem;
    TBXItem97: TTBXItem;
    TBXSeparatorItem28: TTBXSeparatorItem;
    TBXItem98: TTBXItem;
    InsertArray: TAction;
    MenuTools: TTBXSubmenuItem;
    TBXSeparatorItem30: TTBXSeparatorItem;
    TBXItem99: TTBXItem;
    TBXSeparatorItem21: TTBXSeparatorItem;
    TBXSeparatorItem31: TTBXSeparatorItem;
    TBXItem100: TTBXItem;
    HelpWhatThisIs: TAction;
    TBXItem101: TTBXItem;
    TBXSeparatorItem32: TTBXSeparatorItem;
    EmuProgramRun: TAction;
    EmuProgramParam: TAction;
    EmuProgramStep: TAction;
    EmuProgramBreak: TAction;
    TBXItem22: TTBXItem;
    TBXItem102: TTBXItem;
    TBXItem104: TTBXItem;
    MenuEmu: TTBXSubmenuItem;
    TBXItem105: TTBXItem;
    TBXItem106: TTBXItem;
    TBXItem107: TTBXItem;
    TBXItem108: TTBXItem;
    TBXSeparatorItem34: TTBXSeparatorItem;
    TBXSeparatorItem35: TTBXSeparatorItem;
    TBXSeparatorItem36: TTBXSeparatorItem;
    HelpFaq: TAction;
    HelpWeb: TAction;
    TBXItem109: TTBXItem;
    TBXItem110: TTBXItem;
    TBXSeparatorItem38: TTBXSeparatorItem;
    TBXItem111: TTBXItem;
    EmuClearBreak: TAction;
    TBXItem33: TTBXItem;
    GutterGlyphs: TImageList;
    TBXItem103: TTBXItem;
    TBXSeparatorItem29: TTBXSeparatorItem;
    TBXItem112: TTBXItem;
    EmuRun: TAction;
    TBXItem113: TTBXItem;
    TBXSeparatorItem39: TTBXSeparatorItem;
    TBXSeparatorItem40: TTBXSeparatorItem;
    TBXItem56: TTBXItem;
    TBXItem114: TTBXItem;
    MultiDock: TTBXMultiDock;
    CommandsBar: TTBXDockablePanel;
    SymbolsBar: TTBXDockablePanel;
    WhatsThis: TWhatsThis;
    ComputerInfo: TJvComputerInfoEx;
    Registry: TJvAppRegistryStorage;
    MenuLanguage: TTBXSubmenuItem;
    Lang1: TTBXItem;
    Lang2: TTBXItem;
    Lang3: TTBXItem;
    Lang4: TTBXItem;
    Lang5: TTBXItem;
    Lang6: TTBXItem;
    Lang7: TTBXItem;
    Lang8: TTBXItem;
    Lang9: TTBXItem;
    TBXSeparatorItem37: TTBXSeparatorItem;
    SearchFiles: TJvSearchFiles;
    OptionsLanguage: TAction;
    TBXSeparatorItem33: TTBXSeparatorItem;
    TBXItem91: TTBXItem;
    TBXSeparatorItem41: TTBXSeparatorItem;
    ToolsProgram: TAction;
    TBXItem92: TTBXItem;
    TBXSeparatorItem42: TTBXSeparatorItem;
    TBXItem115: TTBXItem;
    InsertIfErr: TAction;
    TBXItem116: TTBXItem;
    TBXImageList: TTBXImageList;
    TBXItem117: TTBXItem;
    TreeImageList: TImageList;
    InsertDirectory: TAction;
    InsertSubprogram: TAction;
    TBXItem118: TTBXItem;
    TBXItem119: TTBXItem;
    Panel: TPanel;
    JvModernTabBarPainter: TJvModernTabBarPainter;
    TabBar: TJvTabBar;
    EditPanel: TPanel;
    PageList: TJvPageList;
    StackBar: TTBXDockablePanel;
    StackPanel: TPanel;
    StackViewIn: TJvStringGrid;
    ShapeLine: TShape;
    StackViewOut: TJvStringGrid;
    TabSet: TTabSet;
    TreeCommands: TTreeView;
    StringGrid: TStringGrid;
    Splitter: TSplitter;
    TBXItem120: TTBXItem;
    TBXItem121: TTBXItem;
    procedure FormCreate(Sender: TObject);
    procedure EditCopyExecute(Sender: TObject);
    procedure EditCutExecute(Sender: TObject);
    procedure EditPasteExecute(Sender: TObject);
    procedure EditSelectAllExecute(Sender: TObject);
    procedure EditUndoExecute(Sender: TObject);
    procedure EditRedoExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SearchSearchExecute(Sender: TObject);
    procedure SearchReplaceExecute(Sender: TObject);
    procedure SearchFindNextClick(Sender: TObject);
    procedure SearchGoToClick(Sender: TObject);
    procedure ApplicationEventsHint(Sender: TObject);
    procedure FileNewExecute(Sender: TObject);
    procedure FileSaveExecute(Sender: TObject);
    procedure FileOpenExecute(Sender: TObject);
    procedure SearchFindPrevClick(Sender: TObject);
    procedure EditorReplaceText(Sender: TObject; const ASearch,
      AReplace: string; Line, Column: Integer;
      var Action: TSynReplaceAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FilePreviewExecute(Sender: TObject);
    procedure FilePrintExecute(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure HelpIndexExecute(Sender: TObject);
    procedure ToolsInputExecute(Sender: TObject);
    procedure ToolsChooseExecute(Sender: TObject);
    procedure ToolsInformExecute(Sender: TObject);
    procedure ToolsPictureExecute(Sender: TObject);
    procedure OptionsEnvironmentExecute(Sender: TObject);
    procedure EmuSendExecute(Sender: TObject);
    procedure ApplicationEventsActivate(Sender: TObject);
    procedure HelpAboutExecute(Sender: TObject);
    procedure FileCloseExecute(Sender: TObject);
    procedure ToolWindowExecute(Sender: TObject);
    procedure EditorDropFiles(Sender: TObject; X, Y: Integer;
      AFiles: TStrings);
    procedure FlatHintShowHint(var HintStr: String; var CanShow: Boolean;
      var HintInfo: THintInfo);
    procedure TreeCommandsClick(Sender: TObject);
    procedure StringGridMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure StringGridMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure EditorStatusChange(Sender: TObject;
      Changes: TSynStatusChanges);
    procedure FileCloseAllExecute(Sender: TObject);
    procedure FileSaveAsExecute(Sender: TObject);
    procedure FileExitExecute(Sender: TObject);
    procedure HelpTipOfDayExecute(Sender: TObject);
    procedure OptionsEditorExecute(Sender: TObject);
    procedure FilePageSetupExecute(Sender: TObject);
    procedure ActionManagerUpdate(Action: TBasicAction;
      var Handled: Boolean);
    procedure ViewLineNumbersExecute(Sender: TObject);
    procedure StringGridDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure ToolsMatrixWriterExecute(Sender: TObject);
    procedure MRUListClick(Sender: TObject; const Filename: String);
    procedure InsertProgramExecute(Sender: TObject);
    procedure InsertStringExecute(Sender: TObject);
    procedure InsertEquationExecute(Sender: TObject);
    procedure InsertListExecute(Sender: TObject);
    procedure InsertArrayExecute(Sender: TObject);
    procedure InsertComplexExecute(Sender: TObject);
    procedure InsertIfExecute(Sender: TObject);
    procedure InsertCaseExecute(Sender: TObject);
    procedure InsertStartExecute(Sender: TObject);
    procedure InsertForExecute(Sender: TObject);
    procedure InsertDoExecute(Sender: TObject);
    procedure InsertWhileExecute(Sender: TObject);
    procedure FileImportExecute(Sender: TObject);
    procedure FileExportExecute(Sender: TObject);
    procedure FileSendToHPExecute(Sender: TObject);
    procedure HelpWhatThisIsExecute(Sender: TObject);
    procedure EmuProgramRunExecute(Sender: TObject);
    procedure EmuProgramParamExecute(Sender: TObject);
    procedure EmuProgramStepExecute(Sender: TObject);
    procedure EmuProgramBreakExecute(Sender: TObject);
    procedure EmuClearBreakExecute(Sender: TObject);
    procedure EditorGutterClick(Sender: TObject; Button: TMouseButton; X,
      Y, Line: Integer; Mark: TSynEditMark);
    procedure EditorSpecialLineColors(Sender: TObject; Line: Integer;
      var Special: Boolean; var FG, BG: TColor);
    procedure EditorGutterPaint(Sender: TObject; aLine, X, Y: Integer);
    procedure HelpFaqExecute(Sender: TObject);
    procedure HelpWebExecute(Sender: TObject);
    procedure EmuRunExecute(Sender: TObject);
    procedure MultiDockResize(Sender: TObject);
    procedure ToolBarVisibleChanged(Sender: TObject);
    procedure PopupMenuPopup(Sender: TObject);
    procedure TreeCommandsDblClick(Sender: TObject);
    procedure SearchFilesFindFile(Sender: TObject; const AName: string);
    procedure OptionsLanguageExecute(Sender: TObject);
    procedure ToolsProgramExecute(Sender: TObject);
    procedure InsertIfErrExecute(Sender: TObject);
    procedure InsertSubprogramExecute(Sender: TObject);
    procedure InsertDirectoryExecute(Sender: TObject);
    procedure TabBarTabSelected(Sender: TObject; Item: TJvTabBarItem);
    procedure TabSetChange(Sender: TObject; NewTab: Integer;
      var AllowChange: Boolean);
    procedure StackPanelResize(Sender: TObject);
  private
    FIndex: Integer;
    FNewFile: Integer;
    FBreakPoints: TList;
    FFileNames: TStringList;
    FFileParams: TStringList;
    FHighlighter: TSynUserEditSyn;
    FSearchFromCaret: Boolean;
    FLanguages: TStringList; // ver5
    FStack: TStringList;
    procedure DoChangeStatusBar;
    procedure DoCloseAllFiles(var CanClose: Boolean);
    procedure DoCloseFile;
    procedure DoInsertText(AText: string);
    procedure DoFillStringGrid;
    procedure DoNewFile(EditFile: String; Open: Boolean);
    function DoSave: Boolean;
    function DoSaveAs: Boolean;
    function DoSaveFile(F: String): Boolean;
    function DoSavePage: Boolean;
    procedure DoSearchReplaceText(AReplace: Boolean; ABackwards: Boolean);
    function Editor: TSynEdit;
    function IsEmpty: Boolean;
    procedure LoadPreferences;
    procedure SavePreferences;
    procedure ShowSearchReplaceDialog(AReplace: Boolean);
    procedure ClearStack;
  public
    procedure CopyData(var Msg: TWmCopyData); message WM_COPYDATA;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure ChangeLanguageFile;
  end;

var
  MainProgram: TMainProgram;

implementation

{$R *.DFM}

uses
  DlgSearchText, DlgReplaceText, DlgConfirm, DlgPrintPreview,
  DlgPageSetup, DlgGotoLine, DlgAbout, DlgInput, DlgChoose, DlgInform,
  DlgTipDay, DlgConfigEditor, DlgEnvironment, Registry, ShlObj,
  SynEditPrintTypes, Language, SynEditPrintHeaderFooter, SynEditTypes,
  Emu48Proc, DlgMatrix, HPUtils, DlgTransfer, TBXAluminumTheme, ShellAPI,
  DlgStatus, DlgGrob, Emu48Dll, Math, DlgParam, Globals, DBuilder;

const
  FirstTime: Boolean = True;

var
  gbSearchBackwards: Boolean;
  gbSearchCaseSensitive: Boolean;
  gbSearchFromCaret: Boolean;
  gbSearchSelectionOnly: Boolean;
  gbSearchTextAtCaret: Boolean;
  gbSearchWholeWords: Boolean;

  gsSearchText: string;
  gsSearchTextHistory: string;
  gsReplaceText: string;
  gsReplaceTextHistory: string;

  SymbolHintWnd: THintWindow;

procedure TMainProgram.FormCreate(Sender: TObject);
var
  SplashAbout: TAboutDialog;
  Reg: TRegIniFile;
  I: Integer;
begin
  SplashAbout := TAboutDialog.Create(Application);
  {if oLogoOnStartup then} SplashAbout.MakeSplash; // ver5
  FHighlighter := TSynUserEditSyn.Create(nil);
  with FHighlighter do
  begin
    SpaceAttri.Background := clWhite;
    SpaceAttri.Foreground := clWhite;
    KeyAttri.Background := clWhite;
    KeyAttri.Foreground := clNavy;
    KeyAttri.Style := [fsBold];
    SymbolAttri.Background := clWhite;
    SymbolAttri.Foreground := clGreen;
    StringAttri.Background := clWhite;
    StringAttri.Foreground := clBlue;
    NumberAttri.Background := clWhite;
    NumberAttri.Foreground := $000080FF;
    IdentifierAttri.Background := clWhite;
    IdentifierAttri.Foreground := clBlack;
    CommentAttri.Background := clWhite; // ver5
    CommentAttri.Foreground := clGray; // ver5
    CommentAttri.Style := [fsItalic]; // ver5
    ReservedAttri.Background := clWhite; // ver5
    ReservedAttri.Foreground := clPurple; // ver5
    ReservedAttri.Style := [fsBold]; // ver5
  end;
  AppPath := ExtractFilePath(Application.ExeName);
  //LangPath := AppPath + LANG_FILE;
  TempFile := ComputerInfo.Folders.Temp + '\' + TEMP_FILE;
  LoadPreferences;
  TreeCommands.Font.Name := eFontEditor;
  //StackView.Font.Name := eFontEditor; // ver5
  //StackView.FixedFont.Name := eFontEditor; // ver5
  StringGrid.Font.Name := eFontEditor;
  SymbolsBar.Width := oPanelWidth;
  Application.HelpFile := ChangeFileExt(Application.ExeName, '.chm');
  SynEditPrint.Highlighter := FHighlighter;
  Reg := TRegIniFile.Create(REG_HPUSER_ROOT);
  try
    MRUList.LoadFromRegIni(Reg, REG_EDITOR);
  finally
    Reg.Free;
  end;
  FIndex := -1;
  FNewFile := 1;
  FBreakPoints := TList.Create;
  FFileNames := TStringList.Create;
  FFileParams := TStringList.Create;
  SymbolHintWnd := HintWindowClass.Create(Application);
  LoadTreeCommands(TreeCommands);
  FLanguages := TStringList.Create; // ver5
  SearchFiles.RootDirectory := AppPath + 'Languages'; // ver5
  SearchFiles.Files.Clear; // ver5
  SearchFiles.Search; // ver5
  for I := 0 To FLanguages.Count - 1 do
    with TTBXItem(FindComponent('Lang' + IntToStr(I+1))) do
    begin // ver5
      Caption := ChangeFileExt(ExtractFileName(FLanguages[I]), ''); // ver5
      Visible := True; // ver5
      if Caption = oLanguage then
        Checked := True; // ver5
    end; // ver5
  LangPath := AppPath + 'Languages\' + oLanguage + '.lng'; // ver5
  ChangeLanguageFile;
  DoFillStringGrid;
  StackViewIn.ColWidths[0] := 17; // ver5
  StackViewOut.ColWidths[0] := 17; // ver5
  StackViewIn.ClearSelection; // ver5
  StackViewOut.ClearSelection; // ver5
  for I := 0 to StackViewIn.RowCount - 1 do
  begin
    StackViewIn.Cells[0, I] := IntToStr(StackViewIn.RowCount - I) + ':'; // ver5
    StackViewOut.Cells[0, I] := IntToStr(StackViewOut.RowCount - I) + ':'; // ver5
  end;
  FStack := TStringList.Create;
  StkNameURPL := TStringList.Create; // ver5
  StkArgsURPL := TStringList.Create; // ver5
  if oIsCalc48 then
    LoadStackArgs(AppPath + 'Templates\UserRPL48.stk', StkNameURPL, StkArgsURPL{, nil}) // ver5
  else
    LoadStackArgs(AppPath + 'Templates\UserRPL49.stk', StkNameURPL, StkArgsURPL{, nil}); // ver5
  SplashAbout.Timer.Enabled := True;
end;

procedure TMainProgram.DoNewFile(EditFile: String; Open: Boolean);
var
  Edit: TSynEdit;
  I: Integer;
  Options: TSynEditorOptions;
  Page: TJvStandardPage;
  TabItem: TJvTabBarItem;
begin
  if Open and not FileExists(EditFile) then
  begin
    MsgDlg(Format(Msgs[MSG_FILENOTEXISTS], [EditFile]), MB_ICONERROR + MB_OK);
    Exit;
  end;
  if not Panel.Visible then // ver5
  begin
    //MainProgram.Color := clBtnFace;
    Panel.Visible := True; // ver5
    TabBar.Visible := True; // ver5
  end;
  for I := 0 to PageList.PageCount - 1 do
    if UpperCase(FFileNames[I]) = UpperCase(EditFile) then
    begin
      TabBar.Tabs[I].Selected := True; // ver5
      //PageList.ActivePage := PageList.Pages[I];
      Exit;
    end;
  FFileNames.Add(EditFile);
  FFileParams.Add('');
  FBreakPoints.Add(Pointer(0));
  Page := TJvStandardPage.Create(Self); // ver5
  Page.PageList := PageList; // ver5
  Edit := TSynEdit.Create(Self);
  Options := [];
  Include(Options, eoShowScrollHint);
  Include(Options, eoDropFiles);
  if eAutoIndent then Include(Options, eoAutoIndent);
  if eAltSetsColumn then Include(Options, eoAltSetsColumnMode);
  if eDragDropEditing then Include(Options, eoDragDropEditing);
  if eTrimSpaces then Include(Options, eoTrimTrailingSpaces);
  if eSmallTabs then Include(Options, eoSmartTabs);
  if eTabsToSpaces then Include(Options, eoTabsToSpaces);
  if eUseHighlight then Edit.Highlighter := FHighlighter;
  Edit.Align := alClient;
  Edit.BorderStyle := bsNone;
  Edit.ExtraLineSpacing := eExtraLineSpacing;
  Edit.Font.Name := eFontEditor;
  Edit.Font.Size := eFontEditorSize;
  Edit.Gutter.BorderStyle := gbsNone;
  Edit.Gutter.Color := $00DCDCDC;
  Edit.Gutter.Font.Color := clHighLightText;
  Edit.Gutter.ShowLineNumbers := ViewLineNumbers.Checked;
  Edit.Gutter.Visible := eGutterVisible;
  Edit.Gutter.Width := eGutterSize;
  Edit.HelpContext := 6960;
  Edit.HideSelection := eHideSelection;
  Edit.InsertMode := eInsertMode;
  Edit.MaxUndo := eMaxUndos;
  Edit.Options := Options;
  Edit.Parent := Page; // ver5
  Edit.PopupMenu := PopupMenu;
  if not eMarginVisible then Edit.RightEdge := 0
  else Edit.RightEdge := eMarginSize;
  Edit.ScrollHintFormat := shfTopToBottom;
  Edit.SearchEngine := SynEditSearch;
  Edit.TabWidth := eTabSize;
  Edit.WantTabs := True;
  Edit.OnDropFiles := EditorDropFiles;
  Edit.OnGutterClick := EditorGutterClick;
  Edit.OnGutterPaint := EditorGutterPaint;
  Edit.OnReplaceText := EditorReplaceText;
  Edit.OnSpecialLineColors := EditorSpecialLineColors;
  Edit.OnStatusChange := EditorStatusChange;
  if Open then
  begin
    Edit.Lines.LoadFromFile(EditFile);
    MRUList.Add(EditFile);
  end;
  PageList.ActivePage := Page;
  Edit.ClearUndo;
  Edit.Modified := False;
  Edit.SetFocus;
  TabItem := TabBar.AddTab(ChangeFileExt(ExtractFileName(EditFile), '')); // ver5
  TabItem.Selected := True; // ver5
  TabItem.ImageIndex := 0; // ver5
  FIndex := TabItem.Index; // ver5
  if not Open then
    DoInsertText('%%HP: T(0)A(D)F(.);' + NewLine + '@ Creado con ' + APP_TITLE + NewLine + NewLine + '|'); // ver5
  DoChangeStatusBar;
end;

function TMainProgram.DoSavePage: Boolean;
begin
  if Editor.Modified then
    case MsgDlg(Format(Msgs[MSG_SAVECHANGES], [FFileNames[FIndex]]), MB_ICONEXCLAMATION + MB_YESNOCANCEL) of
      IDYes: Result := DoSave;
      IDNo: Result := True;
    else
      Result := False;
    end
  else
    Result := True;
end;

procedure TMainProgram.EditCopyExecute(Sender: TObject);
begin
  Editor.CopyToClipBoard;
end;

procedure TMainProgram.EditCutExecute(Sender: TObject);
begin
  Editor.CutToClipBoard;
end;

procedure TMainProgram.EditPasteExecute(Sender: TObject);
begin
  Editor.PasteFromClipBoard;
end;

procedure TMainProgram.EditSelectAllExecute(Sender: TObject);
begin
  Editor.SelectAll;
end;

procedure TMainProgram.EditUndoExecute(Sender: TObject);
begin
  Editor.Undo;
  Editor.SetFocus;
end;

procedure TMainProgram.EditRedoExecute(Sender: TObject);
begin
  Editor.Redo;
  Editor.SetFocus;
end;

procedure TMainProgram.FormShow(Sender: TObject);
begin
  if ParamCount > 0 then
    DoNewFile(ParamStr(1), True)
  else if oNewOnStartup then
    FileNewExecute(nil);
  MultiDockResize(nil);
end;

procedure TMainProgram.SearchSearchExecute(Sender: TObject);
begin
  ShowSearchReplaceDialog(False);
end;

procedure TMainProgram.SearchReplaceExecute(Sender: TObject);
begin
  ShowSearchReplaceDialog(True);
end;

procedure TMainProgram.SearchFilesFindFile(Sender: TObject;
  const AName: string);
begin
  FLanguages.Add(AName); // ver5
end;

procedure TMainProgram.SearchFindNextClick(Sender: TObject);
begin
  DoSearchReplaceText(False, False);
end;

procedure TMainProgram.SearchGoToClick(Sender: TObject);
begin
  with TGoToDialog.Create(nil) do
  try
    if ShowModal = mrOK then
      Editor.CaretY := LineNumber.AsInteger;
  finally
    Free;
  end;
end;

procedure TMainProgram.ApplicationEventsHint(Sender: TObject);
begin
  StatusBar.Panels.Items[3].Caption := Utf8ToAnsi(' ' + Application.Hint);
  SymbolHintWnd.ReleaseHandle;
end;

procedure TMainProgram.FileNewExecute(Sender: TObject);
begin
  DoNewFile(Format('%s%d', [Caps[LBL_NEWOBJ], FNewFile]), False);
  Inc(FNewFile);
end;

procedure TMainProgram.FileSaveExecute(Sender: TObject);
begin
  DoSave;
end;

procedure TMainProgram.FileOpenExecute(Sender: TObject);
begin
  //OpenDialog.DefaultExt := 'hpe';
  OpenDialog.Filename := '';
  OpenDialog.Filter := Caps[LBL_FILTER1] + '|'+ Caps[LBL_FILTER2] + '|'+ Caps[LBL_FILTER3] + '|'+
                       Caps[LBL_FILTER4] + '|'+ Caps[LBL_FILTER5] + '|'+ Caps[LBL_FILTER6] + '|'+
                       Caps[LBL_FILTER7] + '|'+ Caps[LBL_FILTER8] + '|'+ Caps[LBL_FILTER9] + '|'+
                       Caps[LBL_HPEFILTER] + '|' + Caps[LBL_FILTER10]; // ver5
  OpenDialog.Title := Caps[LBL_OPEN];
  OpenDialog.FilterIndex := oOpenFilterIndex; // ver5
  if OpenDialog.Execute then
  begin
    DoNewFile(OpenDialog.FileName, True);
    oOpenFilterIndex := OpenDialog.FilterIndex;  // ver5
  end;
end;

procedure TMainProgram.DoSearchReplaceText(AReplace, ABackwards: boolean);
var
  Options: TSynSearchOptions;
begin
  if AReplace then
    Options := [ssoPrompt, ssoReplace, ssoReplaceAll]
  else
    Options := [];
  if ABackwards then Include(Options, ssoBackwards);
  if gbSearchCaseSensitive then Include(Options, ssoMatchCase);
  if not FSearchFromCaret then Include(Options, ssoEntireScope);
  if gbSearchSelectionOnly then Include(Options, ssoSelectedOnly);
  if gbSearchWholeWords then Include(Options, ssoWholeWord);
  if Editor.SearchReplace(gsSearchText, gsReplaceText, Options) = 0 then
  begin
    MsgDlg(Msgs[MSG_TEXTNOTFOUND], MB_ICONINFORMATION + MB_OK);
    if ssoBackwards in Options then
      Editor.BlockEnd := Editor.BlockBegin
    else
      Editor.BlockBegin := Editor.BlockEnd;
    Editor.CaretXY := Editor.BlockBegin;
  end;
  if ConfirmDialog <> nil then ConfirmDialog.Free;
end;

procedure TMainProgram.ShowSearchReplaceDialog(AReplace: boolean);
var
  Dlg: TSearchDialog;
begin
  if AReplace then
    Dlg := TReplaceDialog.Create(Self)
  else
    Dlg := TSearchDialog.Create(Self);
  with Dlg do
  try
    SearchBackwards := gbSearchBackwards;
    SearchCaseSensitive := gbSearchCaseSensitive;
    SearchFromCursor := gbSearchFromCaret;
    SearchInSelectionOnly := gbSearchSelectionOnly;
    SearchText := gsSearchText;
    if gbSearchTextAtCaret then
    begin
      if Editor.SelAvail and (Editor.BlockBegin.Line = Editor.BlockEnd.Line) then
        SearchText := Editor.SelText
      else
        SearchText := Editor.GetWordAtRowCol(Editor.CaretXY);
    end;
    SearchTextHistory := gsSearchTextHistory;
    if AReplace then
      with dlg as TReplaceDialog do
      begin
        ReplaceText := gsReplaceText;
        ReplaceTextHistory := gsReplaceTextHistory;
      end;
    SearchWholeWords := gbSearchWholeWords;
    if ShowModal = mrOk then
    begin
      gbSearchBackwards := SearchBackwards;
      gbSearchCaseSensitive := SearchCaseSensitive;
      gbSearchFromCaret := SearchFromCursor;
      gbSearchSelectionOnly := SearchInSelectionOnly;
      gbSearchWholeWords := SearchWholeWords;
      gsSearchText := SearchText;
      gsSearchTextHistory := SearchTextHistory;
      if AReplace then
        with Dlg as TReplaceDialog do
        begin
          gsReplaceText := ReplaceText;
          gsReplaceTextHistory := ReplaceTextHistory;
        end;
      FSearchFromCaret := gbSearchFromCaret;
      if gsSearchText <> '' then
      begin
        DoSearchReplaceText(AReplace, gbSearchBackwards);
        FSearchFromCaret := True;
      end;
    end;
  finally
    Dlg.Free;
  end;
end;

procedure TMainProgram.SearchFindPrevClick(Sender: TObject);
begin
  DoSearchReplaceText(False, True);
end;

procedure TMainProgram.EditorReplaceText(Sender: TObject; const ASearch,
  AReplace: String; Line, Column: Integer; var Action: TSynReplaceAction);
var
  APos: TPoint;
  EditRect: TRect;
begin
  if ASearch = AReplace then
    Action := raSkip
  else
  begin
    APos := Editor.ClientToScreen(Editor.RowColumnToPixels(Editor.BufferToDisplayPos(BufferCoord(Column, Line))));
    EditRect := ClientRect;
    EditRect.TopLeft := ClientToScreen(EditRect.TopLeft);
    EditRect.BottomRight := ClientToScreen(EditRect.BottomRight);
    if ConfirmDialog = nil then
      ConfirmDialog := TConfirmDialog.Create(Application);
    ConfirmDialog.PrepareShow(EditRect, APos.X, APos.Y, APos.Y + Editor.LineHeight, ASearch);
    case ConfirmDialog.ShowModal of
      mrYes: Action := raReplace;
      mrYesToAll: Action := raReplaceAll;
      mrNo: Action := raSkip;
      else Action := raCancel;
    end;
  end;
end;

procedure TMainProgram.DoChangeStatusBar;
var
  Title: string;
begin
  Title := APP_TITLE + ' - [' + FFileNames[FIndex] + ']';
  if Editor.Modified then
  begin
    StatusBar.Panels.Items[0].Caption := Caps[LBL_MODIFIED];
    Title := Title + ' *'; // ver5
    TabBar.SelectedTab.Caption := ' ' + ChangeFileExt(ExtractFileName(FFileNames[FIndex]), ' *') + ' '; // ver5
  end
  else begin
    StatusBar.Panels.Items[0].Caption := '';
    TabBar.SelectedTab.Caption := ' ' + ChangeFileExt(ExtractFileName(FFileNames[FIndex]), '') + ' '; // ver5
  end;
  MainProgram.Caption := Title;
  if Editor.InsertMode then StatusBar.Panels.Items[1].Caption := Caps[LBL_INSERT]
  else StatusBar.Panels.Items[1].Caption := Caps[LBL_OVERWRITE];
  StatusBar.Panels.Items[2].Caption := Format(Caps[LBL_POSITION], [Editor.CaretY, Editor.CaretX]);
end;

function TMainProgram.DoSaveAs: Boolean;
var
  Temp: string;
begin
  Result := False;
  //SaveDialog.DefaultExt := 'hpe';
  SaveDialog.Title := Caps[LBL_SAVEAS];
  SaveDialog.Filter := Caps[LBL_FILTER1] + '|'+ Caps[LBL_FILTER2] + '|'+ Caps[LBL_FILTER3] + '|'+
                       Caps[LBL_FILTER4] + '|'+ Caps[LBL_FILTER5] + '|'+ Caps[LBL_FILTER6] + '|'+
                       Caps[LBL_FILTER7] + '|'+ Caps[LBL_FILTER8] + '|'+ Caps[LBL_FILTER9] + '|'+
                       Caps[LBL_HPEFILTER] + '|' + Caps[LBL_FILTER10]; // ver5
  Temp := RemoveHead(Editor.Lines.Text); // ver5
  SaveDialog.FilterIndex := oSaveFilterIndex; // ver5
  if Length(Temp) >= 2 then
  begin
    if (Temp[1] = '«') and (Temp[Length(Temp)] = '»') then
      SaveDialog.FilterIndex := 2 // ver5
    else if (Copy(Temp, 1, 3) = 'DIR') and (Copy(Temp, Length(Temp) - 3, 3) = 'END') then
      SaveDialog.FilterIndex := 3 // ver5
    else if (Temp[1] = '{') and (Temp[Length(Temp)] = '}') then
      SaveDialog.FilterIndex := 4 // ver5
    else if (Temp[1] = '"') and (Temp[Length(Temp)] = '"') then
      SaveDialog.FilterIndex := 5 // ver5
    else if (Temp[1] = '[') and (Temp[Length(Temp)] = ']') then
      SaveDialog.FilterIndex := 6 // ver5
    else if ((Temp[1] = '''') and (Temp[Length(Temp)] = '''')) or
            ((Temp[1] = '`') and (Temp[Length(Temp)] = '`')) then
      SaveDialog.FilterIndex := 7 // ver5
    else if Copy(Temp, 1, 4) = 'GROB' then
      SaveDialog.FilterIndex := 8; // ver5
  end;
  SaveDialog.FileName := FFileNames[FIndex];
  if SaveDialog.Execute then
  begin
    oSaveFilterIndex := SaveDialog.FilterIndex; // ver5
    Result := DoSaveFile(SaveDialog.FileName);
  end;
end;

function TMainProgram.DoSaveFile(F: String): Boolean;
var
  BackupName: string;
begin
  try
    if eCreateBackup and FileExists(F) then
    begin
      BackupName := ChangeFileExt(F, '.bak');
      if FileExists(BackupName) then
        DeleteFile(BackupName);
      RenameFile(F, BackupName);
    end;
    if eEndLineFormat then
      StringToFile(RemoveCR(Editor.Text), F)
    else
      Editor.Lines.SaveToFile(F);
    MRUList.Add(F);
    Editor.Modified := False;
    if not eUndoAfterSave then
      Editor.ClearUndo;
    FFileNames[FIndex] := F;
    DoChangeStatusBar;
    Result := True;
  except
    Application.HandleException(Self);
    Result := False;
  end;
end;

function TMainProgram.DoSave: Boolean;
begin
  if (Pos(Caps[LBL_NEWOBJ], FFileNames[FIndex]) <> 0) and
    not FileExists(FFileNames[FIndex]) then
      Result := DoSaveAs
  else
    Result := DoSaveFile(FFileNames[FIndex]);
end;

procedure TMainProgram.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose := True;
  DoCloseAllFiles(CanClose);
end;

procedure TMainProgram.FilePreviewExecute(Sender: TObject);
begin
  SynEditPrint.SynEdit := Editor;
  SynEditPrint.Title := ExtractFileName(FFileNames[FIndex]);
  with TPreviewDialog.Create(nil) do
  try
    SynEditPrintPreview.SynEditPrint := SynEditPrint;
    ShowModal;
  finally
    Free;
  end;
end;

procedure TMainProgram.FilePrintExecute(Sender: TObject);
begin
  if PrintDialog.Execute then
  begin
    SynEditPrint.SynEdit := Editor;
    SynEditPrint.Title := ExtractFileName(FFileNames[FIndex]);
    SynEditPrint.Print;
  end;
end;

procedure TMainProgram.FormDestroy(Sender: TObject);
var
  Reg: TRegIniFile;
begin
  Reg := TRegIniFile.Create(REG_HPUSER_ROOT);
  try
    MRUList.SaveToRegIni(Reg, REG_EDITOR);
  finally
    Reg.Free;
  end;
  FBreakPoints.Free;
  FFileNames.Free;
  FFileParams.Free;
  FLanguages.Free; // ver5
  //DeleteFile(TempFile);
  Emu48Exit;
  SavePreferences;
end;

procedure TMainProgram.HelpIndexExecute(Sender: TObject);
begin
  HelpRouter.HelpContent;
end;

procedure TMainProgram.ToolsInputExecute(Sender: TObject);
begin
  with TInputDialog.Create(nil) do
  try
    if ShowModal = mrOk then
      DoInsertText(Param);
  finally
    Free;
  end;
end;

procedure TMainProgram.ToolsChooseExecute(Sender: TObject);
begin
  with TChooseDialog.Create(nil) do
  try
    if ShowModal = mrOk then
      DoInsertText(Param);
  finally
    Free;
  end;
end;

procedure TMainProgram.ToolsInformExecute(Sender: TObject);
begin
  with TInformDialog.Create(nil) do
  try
    if ShowModal = mrOk then
      DoInsertText(Param);
  finally
    Free;
  end;
end;

procedure TMainProgram.ToolsPictureExecute(Sender: TObject);
begin
  with TGrobDialog.Create(nil) do
  try
    ShowModal; // ver5
    if Param <> '' then
      DoInsertText(Param); // ver5
  finally
    Free; // ver5
  end;
end;

procedure TMainProgram.ToolsProgramExecute(Sender: TObject);
begin
  with TDBuilderForm.Create(nil) do
  try
    ShowModal; // ver5
    if Param <> '' then
      DoInsertText(Param); // ver5
  finally
    Free;
  end;
end;

procedure TMainProgram.OptionsEnvironmentExecute(Sender: TObject);
begin
  if EnvironmentDialog.ShowModal = mrOk then
  begin
    if oStayOnTop then
      MainProgram.FormStyle := fsStayOnTop
    else
      MainProgram.FormStyle := fsNormal;
    Emu48CheckRunning(oIsCalc48);
    if oIsCalc48 then
      LoadStackArgs(AppPath + 'Templates\UserRPL48.stk', StkNameURPL, StkArgsURPL{, nil}) // ver5
    else
      LoadStackArgs(AppPath + 'Templates\UserRPL48.stk', StkNameURPL, StkArgsURPL{, nil}); // ver5
  end;
end;

procedure TMainProgram.OptionsLanguageExecute(Sender: TObject);
var
  I: Integer;
begin
  for I := 1 To 9 do
    with TTBXItem(FindComponent('Lang' + IntToStr(I))) do
      Checked := False; // ver5
  if Sender is TTBXItem then
  begin
    TTBXItem(Sender).Checked := True; // ver5
    oLanguage := TTBXItem(Sender).Caption; // ver5
    LangPath := AppPath + 'Languages\' + oLanguage + '.lng'; // ver5
    ChangeLanguageFile; // ver5
    PageDialog.ChangeLanguageFile; // ver5
    EnvironmentDialog.ChangeLanguageFile; // ver5
    EditorDialog.ChangeLanguageFile; // ver5
    DoChangeStatusBar; // ver5
  end;
end;

function TMainProgram.Editor: TSynEdit;
begin
  if Panel.Visible = False then
    Result := nil // ver5
  else
    Result := TSynEdit(PageList.ActivePage.Controls[0]); // ver5
end;

procedure TMainProgram.CopyData(var Msg: TWmCopyData);
begin
  if IsIconic(Application.Handle) = True then
    Application.Restore;
  if Integer(Msg.CopyDataStruct.cbData) <> 0 then
    DoNewFile(Copy(PChar(Msg.CopyDataStruct.lpData), 1,
      Integer(Msg.CopyDataStruct.cbData)), True);
end;

procedure TMainProgram.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  Params.WinClassName := APP_CLASSNAME;
end;

procedure TMainProgram.EmuSendExecute(Sender: TObject);
var
  s: string;
begin
  s := Editor.Lines.Text; // ver5
  if oSaveIntoEMU then
    s := s + ' ''' + ChangeFileExt(ExtractFileName(FFileNames[FIndex]), '') + ''' STO'; // ver5
  s := RemoveCR(RemoveHead(s)); // ver5
  if Emu48ExecuteObject(s, False) then
    ShowEmu48(True)
  else
    MsgDlg(Msgs[MSG_NOSENDEMU], MB_ICONERROR + MB_OK);
end;

procedure TMainProgram.ApplicationEventsActivate(Sender: TObject);
begin
  if oShowTipDay and FirstTime then
  begin
    FirstTime := False;
    with TTipDialog.Create(nil) do
    try
      ShowModal;
    finally
      Free;
    end;
  end;
end;

procedure TMainProgram.HelpAboutExecute(Sender: TObject);
begin
  with TAboutDialog.Create(nil) do
  try
    ShowModal;
  finally
    Free;
  end;
end;

procedure TMainProgram.FileCloseExecute(Sender: TObject);
begin
  if DoSavePage then DoCloseFile;
end;

procedure TMainProgram.DoInsertText(AText: string);
var
  Command: TStringList;
  TempStr: String;
  I, Position: Integer;
  P: TPoint;
  MoveCursor: Boolean;
begin
  Command := TStringList.Create;
  try
    if Pos('%s', AText) > 0 then
      if Editor.SelAvail then
        AText := StringReplace(AText, '%s', Editor.SelText, [])
      else
        AText := StringReplace(AText, '%s', '', []);
    I := 0;
    P := Point(0, 0);
    Command.Text := AText;
    MoveCursor := False;
    while (I < Command.Count) and not MoveCursor do
      if Pos('|', Command.Strings[I]) = 0 then
        Inc(I)
      else
        MoveCursor := True;
    if MoveCursor then
    begin
      P.X := Pos('|', Command.Strings[I]);
      P.Y := Editor.BlockBegin.Line + I;
      AText := StringReplace(AText, '|', '', []);
    end;
    TempStr := Copy(Editor.Lines.Strings[Editor.BlockBegin.Line - 1], 1, Editor.BlockBegin.Char - 1) +
               Copy(Editor.Lines.Strings[Editor.BlockEnd.Line - 1], Editor.BlockEnd.Char, MaxInt);
    Position := Editor.BlockBegin.Char;
    if (Position <> 1) and (TempStr <> '') then
      if Command.Count > 1 then
      begin
        AText := NewLine + AText;
        Inc(P.Y);
      end
      else if (TempStr[Position - 1] <> #32) and (TempStr[Position - 1] <> '') then
      begin
        AText := #32 + AText;
        Inc(P.X);
      end;
    if (Position <> Length(TempStr) + 1) and (TempStr <> '') then
      if Command.Count > 1 then
        AText := AText + NewLine
      else if TempStr[Position] <> #32 then
        AText := AText + #32;
    Editor.SelText := AText;
    if MoveCursor then
    begin
      if Command.Count = 1 then
        Inc(P.X, Position - 1);
      Editor.CaretXY := BufferCoord(P.X, P.Y);
    end;
  finally
    Command.Free;
  end;
end;

procedure TMainProgram.ToolWindowExecute(Sender: TObject);
begin
  ToolBar.Visible := ViewToolBar.Checked;
  InsertBar.Visible := ViewInsertBar.Checked;
  CommandsBar.Visible := ViewCommandsBar.Checked;
  StackBar.Visible := CommandsBar.Visible; // ver5
  SymbolsBar.Visible := ViewSymbolsBar.Checked;
  StatusBar.Visible := ViewStatusBar.Checked;
end;

procedure TMainProgram.EditorDropFiles(Sender: TObject; X, Y: Integer;
  AFiles: TStrings);
var
  I: Integer;
begin
  for I := 0 to AFiles.Count - 1 do
    DoNewFile(AFiles.Strings[I], True);
end;

procedure TMainProgram.FlatHintShowHint(var HintStr: String;
  var CanShow: Boolean; var HintInfo: THintInfo);
begin
  if Length(HintStr) = 1 then
  begin
    FlatHint.Font.Name := eFontEditor; // ver5
    FlatHint.Font.Size := 24;
    FlatHint.Font.Style := [fsBold];
    SymbolHintWnd.ActivateHint(HintInfo.CursorRect, HintStr);
    FlatHint.Font.Name := 'Tahoma';
    FlatHint.Font.Size := 8;
    FlatHint.Font.Style := [];
    CanShow := False;
  end
  else
    SymbolHintWnd.ReleaseHandle;
end;

procedure TMainProgram.TreeCommandsClick(Sender: TObject);
var
  Cmd: string;
  ix: integer;
begin
  ClearStack; // ver5
  FStack.Clear; // ver5
  TabSet.Tabs.Clear; // ver5
  if TreeCommands.Selected.ImageIndex = 1 then
  begin
    Cmd := TreeCommands.Selected.Text; // ver5
    ix := StkNameURPL.IndexOf(Cmd); // ver5
    while ix <> -1 Do
    begin
      FStack.Add(StkArgsURPL[ix]); // ver5
      inc(ix); // ver5
      if CompareStr(StkNameURPL[ix], Cmd) <> 0 then
        ix := -1; // ver5
    end;
    for ix := 0 to FStack.Count - 1 do
      TabSet.Tabs.Add(Cmd); // ver5
    if FStack.Count > 0 then
      TabSet.TabIndex := 0;  // ver5
  end;
  Editor.SetFocus;
end;

procedure TMainProgram.StringGridMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  M, N: Integer;
begin
  if (Button = mbLeft) and (ssDouble in Shift) then
    with StringGrid do
    begin
      MouseToCell(X, Y, M, N);
      if (M <> -1) and (N <> -1) then
        Editor.SelText := Cells[M,N];
    end;
  Editor.SetFocus;
end;

procedure TMainProgram.StringGridMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
  M, N: Integer;
begin
  with StringGrid do
  begin
    MouseToCell(X, Y, M, N);
    if (M <> -1) and (N <> -1)then
      Hint := Cells[M,N]
    else
      Hint := '';
  end;
end;

procedure TMainProgram.EditorStatusChange(Sender: TObject;
  Changes: TSynStatusChanges);
begin
  DoChangeStatusBar;
end;

procedure TMainProgram.FileCloseAllExecute(Sender: TObject);
var
  CanClose: Boolean;
begin
  CanClose := False;
  DoCloseAllFiles(CanClose);
end;

procedure TMainProgram.FileSaveAsExecute(Sender: TObject);
begin
  if not DoSaveAs then
    MsgDlg(Msgs[MSG_SAVEERROR], MB_ICONERROR + MB_OK);
end;

procedure TMainProgram.FileExitExecute(Sender: TObject);
begin
  Close;
end;

procedure TMainProgram.HelpTipOfDayExecute(Sender: TObject);
begin
  with TTipDialog.Create(nil) do
  try
    ShowModal;
  finally
    Free;
  end;
end;

procedure TMainProgram.OptionsEditorExecute(Sender: TObject);
var
  I: Integer;
  Options: TSynEditorOptions;
begin
  EditorDialog.SetValues(FHighlighter);
  if EditorDialog.ShowModal = mrOk then
  begin
    EditorDialog.GetValues(FHighlighter);
    for I := 0 to PageList.PageCount - 1 do
    begin
      Options := [];
      if eAutoIndent then Include(Options, eoAutoIndent);
      if eTabsToSpaces then Include(Options, eoTabsToSpaces);
      if eSmallTabs then Include(Options, eoSmartTabs);
      if eTrimSpaces then Include(Options, eoTrimTrailingSpaces);
      if eDragDropEditing then Include(Options, eoDragDropEditing);
      if eAltSetsColumn then Include(Options, eoAltSetsColumnMode);
      TSynEdit(PageList.Pages[I].Controls[0]).InsertMode := eInsertMode; // ver5
      TSynEdit(PageList.Pages[I].Controls[0]).HideSelection := eHideSelection; // ver5
      TSynEdit(PageList.Pages[I].Controls[0]).ExtraLineSpacing := eExtraLineSpacing; // ver5
      TSynEdit(PageList.Pages[I].Controls[0]).MaxUndo := eMaxUndos; // ver5
      TSynEdit(PageList.Pages[I].Controls[0]).TabWidth := eTabSize; // ver5
      if eUseHighlight then
        TSynEdit(PageList.Pages[I].Controls[0]).Highlighter := FHighlighter // ver5
      else
        TSynEdit(PageList.Pages[I].Controls[0]).Highlighter := nil; // ver5
      if not eMarginVisible then
        TSynEdit(PageList.Pages[I].Controls[0]).RightEdge := 0 // ver5
      else
        TSynEdit(PageList.Pages[I].Controls[0]).RightEdge := eMarginSize; // ver5
      TSynEdit(PageList.Pages[I].Controls[0]).Gutter.Visible := eGutterVisible; // ver5
      TSynEdit(PageList.Pages[I].Controls[0]).Gutter.Width := eGutterSize; // ver5
      TSynEdit(PageList.Pages[I].Controls[0]).Font.Name := eFontEditor; // ver5
      TSynEdit(PageList.Pages[I].Controls[0]).Font.Size := eFontEditorSize; // ver5
      TSynEdit(PageList.Pages[I].Controls[0]).Options := Options; // ver5
    end;
    TreeCommands.Font.Name := eFontEditor; // ver5
    //StackView.Font.Name := eFontEditor; // ver5
    StringGrid.Font.Name := eFontEditor; // ver5
  end;
end;

procedure TMainProgram.FilePageSetupExecute(Sender: TObject);
begin
  PageDialog.SetValues(SynEditPrint);
  if PageDialog.ShowModal = mrOk then
    PageDialog.GetValues(SynEditPrint);
end;

procedure TMainProgram.ActionManagerUpdate(Action: TBasicAction;
  var Handled: Boolean);
var
  Empty, IsProg: Boolean;
begin
  if Editor = nil then
  begin
    FileClose.Enabled := False;
    FileCloseAll.Enabled := False;
    FileSave.Enabled := False;
    FileSaveAs.Enabled := False;
    FileExport.Enabled := False;
    FileSendToHP.Enabled := False;
    FilePrint.Enabled := False;
    FilePreview.Enabled := False;
    EditUndo.Enabled := False;
    EditRedo.Enabled := False;
    EditCut.Enabled := False;
    EditCopy.Enabled := False;
    EditPaste.Enabled := False;
    EditSelectAll.Enabled := False;
    SearchFind.Enabled := False;
    SearchFindNext.Enabled := False;
    SearchFindPrev.Enabled := False;
    SearchReplace.Enabled := False;
    SearchGoTo.Enabled := False;
    ViewLineNumbers.Enabled := False;
    ViewLineNumbers.Checked := False;
    InsertProgram.Enabled := False;
    InsertSubprogram.Enabled := False; // ver5
    InsertString.Enabled := False;
    InsertEquation.Enabled := False;
    InsertList.Enabled := False;
    InsertArray.Enabled := False;
    InsertComplex.Enabled := False;
    InsertDirectory.Enabled := False; // ver5
    InsertIf.Enabled := False;
    InsertIfErr.Enabled := False;
    InsertCase.Enabled := False;
    InsertStart.Enabled := False;
    InsertFor.Enabled := False;
    InsertDo.Enabled := False;
    InsertWhile.Enabled := False;
    EmuSend.Enabled := False;
    EmuProgramRun.Enabled := False;
    EmuProgramParam.Enabled := False;
    EmuProgramStep.Enabled := False;
    EmuProgramBreak.Enabled := False;
    EmuClearBreak.Enabled := False;
    ToolsMatrixWriter.Enabled := False;
    ToolsInput.Enabled := False;
    ToolsChoose.Enabled := False;
    ToolsInform.Enabled := False;
    ToolsPicture.Enabled := False; // ver5
    ToolsProgram.Enabled := False; // ver5
    CommandsBar.Enabled := False;
    SymbolsBar.Enabled := False;
    StackPanel.Enabled := False; // ver5
  end
  else begin
    Empty := IsEmpty;
    IsProg := IsProgramObject(Editor.Text);
    if not IsProg then FBreakPoints[FIndex] := Pointer(0);
    FileClose.Enabled := True;
    FileCloseAll.Enabled := True;
    FileSave.Enabled := True;
    FileSaveAs.Enabled := True;
    FileExport.Enabled := not Empty;
    FileSendToHP.Enabled := not Empty;
    FilePrint.Enabled := True;
    FilePreview.Enabled := True;
    EditUndo.Enabled := Editor.CanUndo;
    EditRedo.Enabled := Editor.CanRedo;
    EditCut.Enabled := Editor.SelAvail;
    EditCopy.Enabled := Editor.SelAvail;
    EditPaste.Enabled := Editor.CanPaste;
    EditSelectAll.Enabled := True;
    SearchFind.Enabled := not Empty;
    SearchFindNext.Enabled := not Empty and (gsSearchText <> '');
    SearchFindPrev.Enabled := not Empty and (gsSearchText <> '');
    SearchReplace.Enabled := not Empty;
    SearchGoTo.Enabled := True;
    ViewLineNumbers.Enabled := True;
    ViewLineNumbers.Checked := Editor.Gutter.ShowLineNumbers;
    InsertProgram.Enabled := True;
    InsertSubprogram.Enabled := True; // ver5
    InsertString.Enabled := True;
    InsertEquation.Enabled := True;
    InsertList.Enabled := True;
    InsertArray.Enabled := True;
    InsertComplex.Enabled := True;
    InsertDirectory.Enabled := True; // ver5
    InsertIf.Enabled := True;
    InsertIfErr.Enabled := True; // ver5
    InsertCase.Enabled := True;
    InsertStart.Enabled := True;
    InsertFor.Enabled := True;
    InsertDo.Enabled := True;
    InsertWhile.Enabled := True;
    EmuSend.Enabled := not Empty;
    EmuProgramRun.Enabled := IsProg;
    EmuProgramParam.Enabled := IsProg;
    EmuProgramStep.Enabled := IsProg;
    EmuProgramBreak.Enabled := IsProg;
    EmuClearBreak.Enabled := Integer(FBreakPoints[FIndex]) <> 0;
    ToolsMatrixWriter.Enabled := True;
    ToolsInput.Enabled := True;
    ToolsChoose.Enabled := True;
    ToolsInform.Enabled := True;
    ToolsPicture.Enabled := True; // ver5
    ToolsProgram.Enabled := True; // ver5
    CommandsBar.Enabled := True;
    SymbolsBar.Enabled := True;
    StackPanel.Enabled := True; // ver5
  end;
end;

function TMainProgram.IsEmpty: Boolean;
var
  I: Integer;
begin
  Result := True;
  for I := Editor.Lines.Count - 1 downto 0 do
    if Editor.Lines[I] <> '' then
    begin
      Result := False;
      Break;
    end;
end;

procedure TMainProgram.DoCloseAllFiles(var CanClose: Boolean);
var
  CanSave: Boolean;
begin
  CanSave := True;
  while (PageList.ActivePage <> nil) and CanSave do // ver5
  begin
    CanSave := DoSavePage;
    if CanSave then DoCloseFile
    else CanClose := False;
  end;
end;

procedure TMainProgram.DoCloseFile;
var
  Ix: Integer;
begin
  Ix := FIndex; // ver5
  if FIndex < (TabBar.Tabs.Count - 1) then
    Inc(FIndex) // ver5
  else if FIndex > 0 then
    Dec(FIndex); // ver5
  TabBar.Tabs[FIndex].Selected := True; // ver5
  PageList.Pages[Ix].Controls[0].Free; // ver5
  PageList.Pages[Ix].Free; // ver5
  TabBar.Tabs[Ix].Free; // ver5
  FFileNames.Delete(Ix); // ver5
  FFileParams.Delete(Ix); // ver5
  FBreakPoints.Delete(Ix); // ver5
  if TabBar.SelectedTab <> nil  then
    TabBarTabSelected(nil, TabBar.SelectedTab)
  else begin
    //MainProgram.Color := $00DCDCDC;
    Panel.Visible := False; // ver5
    TabBar.Visible := False; // ver5
    StatusBar.Panels.Items[0].Caption := '';
    StatusBar.Panels.Items[1].Caption := '';
    StatusBar.Panels.Items[2].Caption := '';
    Caption := APP_TITLE;
  end;
end;

procedure TMainProgram.ViewLineNumbersExecute(Sender: TObject);
begin
  Editor.Gutter.ShowLineNumbers := ViewLineNumbers.Checked;
end;

procedure TMainProgram.StackPanelResize(Sender: TObject);
begin
  StackViewIn.ColWidths[1] := StackViewIn.Width - 20; // ver5
  StackViewOut.ColWidths[1] := StackViewOut.Width - 20; // ver5
end;

procedure TMainProgram.StringGridDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
var
  Flags: Integer;
begin
  Flags := DT_CENTER or DT_VCENTER or DT_SINGLELINE;
  if (gdFocused in State) then
  begin
    StringGrid.Canvas.Brush.Color := clInfoBk; // ver5
    StringGrid.Canvas.Font.Color := clBlack; // ver5
  end
  else begin
    StringGrid.Canvas.Brush.Color := clWindow; // ver5
    StringGrid.Canvas.Font.Color := clBlack; // ver5
  end;
  StringGrid.Canvas.FillRect(Rect);
  DrawText(StringGrid.Canvas.Handle, PChar(StringGrid.Cells[ACol, ARow]), -1, Rect, Flags);
end;

procedure TMainProgram.ToolsMatrixWriterExecute(Sender: TObject);
begin
  with TMatrixDialog.Create(nil) do
  try
    ShowModal; // ver5
    if Param <> '' then // ver5
      DoInsertText(Param); // ver5
  finally
    Free;
  end;
end;

procedure TMainProgram.MRUListClick(Sender: TObject;
  const Filename: String);
begin
  DoNewFile(Filename, True);
end;

procedure TMainProgram.InsertProgramExecute(Sender: TObject);
begin
  DoInsertText('«' + NewLine + '%s|' + NewLine + '»');
end;

procedure TMainProgram.InsertStringExecute(Sender: TObject);
begin
  DoInsertText('"%s|"');
end;

procedure TMainProgram.InsertSubprogramExecute(Sender: TObject);
begin
  DoInsertText('«' + NewLine + '  '#141' |' + NewLine + '  «' + NewLine + '%s' + NewLine + '  »' + NewLine + '»');
end;

procedure TMainProgram.InsertEquationExecute(Sender: TObject);
begin
  DoInsertText('''%s|''');
end;

procedure TMainProgram.InsertListExecute(Sender: TObject);
begin
  DoInsertText('{ %s| }');
end;

procedure TMainProgram.InsertArrayExecute(Sender: TObject);
begin
  DoInsertText('[ | ]');
end;

procedure TMainProgram.InsertComplexExecute(Sender: TObject);
begin
  DoInsertText('(|,)');
end;

procedure TMainProgram.InsertIfErrExecute(Sender: TObject);
begin
  DoInsertText('IFERR |' + NewLine + 'THEN' + NewLine + 'ELSE' + NewLine + 'END'); // ver5
end;

procedure TMainProgram.InsertIfExecute(Sender: TObject);
begin
  DoInsertText('IF |' + NewLine + 'THEN' + NewLine + 'END');
end;

procedure TMainProgram.InsertCaseExecute(Sender: TObject);
begin
  DoInsertText('CASE |' + NewLine + 'THEN' + NewLine + 'END' + NewLine + 'END');
end;

procedure TMainProgram.InsertStartExecute(Sender: TObject);
begin
  DoInsertText('START |' + NewLine + 'NEXT');
end;

procedure TMainProgram.InsertForExecute(Sender: TObject);
begin
  DoInsertText('FOR |' + NewLine + 'NEXT');
end;

procedure TMainProgram.InsertDirectoryExecute(Sender: TObject);
begin
  DoInsertText('DIR' + NewLine  + '  |' + NewLine + 'END');
end;

procedure TMainProgram.InsertDoExecute(Sender: TObject);
begin
  DoInsertText('DO' + NewLine  + '  |' + NewLine + 'UNTIL' + NewLine + 'END');
end;

procedure TMainProgram.InsertWhileExecute(Sender: TObject);
begin
  DoInsertText('WHILE |' + NewLine + 'REPEAT' + NewLine + 'END');
end;

procedure TMainProgram.FileImportExecute(Sender: TObject);
var
  Cad: string;
begin
  OpenDialog.DefaultExt := '*.hp';
  OpenDialog.FileName := '';
  OpenDialog.Filter := Caps[LBL_BINFILTER];
  OpenDialog.Title := Caps[LBL_IMPORT];
  if OpenDialog.Execute then
    with TStatusDialog.Create(nil) do
    try
      Show;
      MainProgram.Enabled := False;
      SetStatus(Caps[LBL_IMPORTING], OpenDialog.FileName, Caps[LBL_NEWIMPORT]);
      Cad := Emu48ImportObject(OpenDialog.FileName);
      if Cad = '' then
        MsgDlg(Msgs[MSG_NOCANIMPORT], MB_ICONERROR + MB_OK)
      else begin
        MainProgram.Enabled := True;
        FileNewExecute(nil);
        Editor.SelText := Cad;
      end;
    finally
      if not MainProgram.Enabled then
        MainProgram.Enabled := True;
      Free;
    end;
end;

procedure TMainProgram.FileExportExecute(Sender: TObject);
begin
  SaveDialog.DefaultExt := '*.hp';
  SaveDialog.FileName := FFileNames[FIndex];
  SaveDialog.Filter := Caps[LBL_BINFILTER];
  SaveDialog.Title := Caps[LBL_EXPORT];
  if SaveDialog.Execute then
    with TStatusDialog.Create(nil) do
    try
      Show;
      MainProgram.Enabled := False;
      SetStatus(Caps[LBL_EXPORTING], FFileNames[FIndex], SaveDialog.FileName);
      if not Emu48ExportObject(SaveDialog.FileName, Editor.Text) then
        MsgDlg(Msgs[MSG_NOCANEXPORT], MB_ICONERROR + MB_OK)
    finally
      MainProgram.Enabled := True;
      Free;
    end;
end;

procedure TMainProgram.FileSendToHPExecute(Sender: TObject);
var
  FName: TFileName;
begin
  FName := FFileNames[FIndex];
  if (Editor.Modified) or ((Pos(Caps[LBL_NEWOBJ], FFileNames[FIndex]) <> 0)
    and not FileExists(FName)) then
    MsgDlg(Msgs[MSG_SAVEBEFORESEND], MB_ICONINFORMATION + MB_OK)
  else if Emu48ExportObject(ChangeFileExt(FName, '.HP'), Editor.Text) then
    with TransferDialog do
    try
      Show; // ver5
      MainProgram.Enabled := False; // ver5
      TargetFile := ChangeFileExt(FName, '.HP'); // ver5
      TransferFile; // ver5
    finally
      MainProgram.Enabled := True; // ver5
      Free; // ver5
      DeleteFile(ChangeFileExt(FName, '.HP')); // ver5
    end
  else
    MsgDlg(Msgs[MSG_NOSENDFILE], MB_ICONERROR + MB_OK);
end;

procedure TMainProgram.HelpWhatThisIsExecute(Sender: TObject);
begin
  WhatsThis.ContextHelp;
end;

procedure TMainProgram.EmuProgramRunExecute(Sender: TObject);
var
  s: string;
begin
  s := Editor.Text; // ver5
  if oSaveIntoEMU then
    s := s + ' DUP ''' + ChangeFileExt(ExtractFileName(FFileNames[FIndex]), '') + ''' STO'; // ver5
  Emu48RunProgram(s, FFileParams[FIndex], Integer(FBreakPoints[FIndex]));
end;

procedure TMainProgram.EmuProgramParamExecute(Sender: TObject);
begin
  with TParamDialog.Create(nil) do
  try
    Param.Text := FFileParams[FIndex];
    if ShowModal = mrOk then
      FFileParams[FIndex] := Param.Text;
  finally
    Free;
  end;
end;

procedure TMainProgram.EmuProgramStepExecute(Sender: TObject);
var
  s: string;
begin
  s := Editor.Text; // ver5
  if oSaveIntoEMU then
    s := s + ' DUP ''' + ChangeFileExt(ExtractFileName(FFileNames[FIndex]), '') + ''' STO'; // ver5
  Emu48RunProgramStep(Editor.Text, FFileParams[FIndex]);
end;

procedure TMainProgram.EmuProgramBreakExecute(Sender: TObject);
var
  ALine, Line: Integer;
begin
  if Trim(Editor.LineText) = '' then Exit;
  Line := Editor.CaretY;
  ALine := Integer(FBreakPoints[FIndex]);
  if ALine = Line then
    FBreakPoints[FIndex] := Pointer(0)
  else begin
    FBreakPoints[FIndex] := Pointer(Line);
    Editor.InvalidateLine(ALine);
  end;
  Editor.InvalidateLine(Line);
end;

procedure TMainProgram.EmuClearBreakExecute(Sender: TObject);
var
  Line: Integer;
begin
  Line := Integer(FBreakPoints[FIndex]);
  if Line <> 0 then
  begin
    FBreakPoints[FIndex] := Pointer(0);
    Editor.InvalidateLine(Line);
  end;
end;

procedure TMainProgram.EditorGutterClick(Sender: TObject;
  Button: TMouseButton; X, Y, Line: Integer; Mark: TSynEditMark);
begin
  if not IsProgramObject(Editor.Text) then
    Exit;
  EmuProgramBreakExecute(nil);
end;

procedure TMainProgram.EditorSpecialLineColors(Sender: TObject;
  Line: Integer; var Special: Boolean; var FG, BG: TColor);
begin
  if Integer(FBreakPoints[FIndex]) = Line then
  begin
    Special := True;
    FG := clWhite;
    BG := clRed;
  end;
end;

procedure TMainProgram.EditorGutterPaint(Sender: TObject; aLine, X,
  Y: Integer);
begin
  if Integer(FBreakPoints[FIndex]) = aLine then
  begin
    X := 14;
    Y := Y + (Editor.LineHeight - 14) div 2;
    GutterGlyphs.Draw(Editor.Canvas, X, Y, 0);
  end;
end;

procedure TMainProgram.HelpFaqExecute(Sender: TObject);
begin
  HelpRouter.HelpKLink('FAQ');
end;

procedure TMainProgram.HelpWebExecute(Sender: TObject);
begin
  ShellExecute(Application.Handle, 'open', APP_URL, nil, nil, SW_NORMAL);
end;

procedure TMainProgram.EmuRunExecute(Sender: TObject);
begin
  Emu48Run;
end;

procedure TMainProgram.LoadPreferences;
var
  List: TStringList;
  Temp: string;
  I: Integer;
begin
  Registry.Root := REG_HPUSER_ROOT;
  with Registry do
  begin
    Path := REG_EDITOR;
    eAutoIndent := ReadBoolean('AutoIndent', True);
    eInsertMode := ReadBoolean('InsertMode', True);
    eTabsToSpaces := ReadBoolean('TabsToSpaces', True);
    eSmallTabs := ReadBoolean('SmallTabs', True);
    eHideSelection := ReadBoolean('HideSelection', False);
    eUndoAfterSave := ReadBoolean('UndoAfterSave', False);
    eTrimSpaces := ReadBoolean('TrimTrailingSpaces', False); // ver5
    eDragDropEditing := ReadBoolean('DragDropEditing', True);
    eAltSetsColumn := ReadBoolean('AltSetsColumnMode', False);
    eUseHighlight := ReadBoolean('UseHighlight', True);
    eExtraLineSpacing := ReadInteger('ExtraLineSpacing', 2);
    eMaxUndos := ReadInteger('MaxUndo', 1024);
    eTabSize := ReadInteger('TabSize', 2);
    eCreateBackup := ReadBoolean('CreateBackup', False);
    eEndLineFormat := ReadBoolean('EndLineFormat', False);
    eMarginVisible := ReadBoolean('MarginVisible', True);
    eGutterVisible := ReadBoolean('GutterVisible', True);
    eMarginSize := ReadInteger('MarginSize', 30);
    eGutterSize := ReadInteger('GutterSize', 30);
    eFontEditor := ReadString('FontEditor', '_CAS_HP48x-49x-50x_01');
    eFontEditorSize := ReadInteger('FontSize', 12);
    Path := REG_ENVIRONMENT;
    oMultiplesInstances := ReadBoolean('MultiplesInstances', False);
    oLogoOnStartup := ReadBoolean('LogoOnStartup', True);
    oStayOnTop := ReadBoolean('StayOnTop', False);
    oNewOnStartup := ReadBoolean('NewFileOnStartup', True);
    oShortCutDesktop := ReadBoolean('ShortCutDesktop', True);
    oShortCutSendTo := ReadBoolean('ShortCutSendTo', False);
    oShortCutContext := ReadBoolean('ShortCutContextMenu', False);
    oShortCutLaunchBar := ReadBoolean('ShortCutQuickLaunchBar', False);
    oCmdsFile := ReadString('CommandsFilename', AppPath + TEMPLATE_DIR + '\CmdsAndFunctsHP49x-50x.ehc'); // ver5
    oTreeFile := ReadString('TreeViewFilename', AppPath + TEMPLATE_DIR + '\MenusHP49x-50x.mtv'); // ver5
    oEmu48Filename := ReadString('Emu48RamFilename', AppPath + EMU_DIR + 'default 48GX.e48'); // ver5
    oEmu48PortFilename := ReadString('Emu48PortFilename', AppPath + EMU_DIR + 'default 48GX.bin'); // ver5
    oEmu49Filename := ReadString('Emu49RamFilename', AppPath + EMU_DIR + 'default 50G.e49'); // ver5
    oSaveIntoEMU := ReadBoolean('SaveIntoEMU', False); // ver5
    oIsCalc48 := ReadBoolean('DefaultEmulator', False);
    oObjectNameCap := ReadBoolean('ObjectNameCapital', True);
    oObjectNameExt := ReadBoolean('ObjectNameWithoutExt', True);
    oComPort := ReadInteger('ComPortNumber', 0);
    //oSendSpeed := ReadInteger('KermitSendSpeed', 0);
    //oSendChecksum := ReadInteger('KermitSendChecksum', 2);
    //oSendRetry := ReadInteger('KermitSendRetry', 2);
    //oEnableBeep := ReadBoolean('KermitEnableBeep', True);
    oShowTipDay := ReadBoolean('ShowTipDay', True);
    oLanguage := ReadString('Language', 'Spanish'); // ver5
    oOpenFilterIndex := ReadInteger('OpenFilterIndex', 11); // ver5
    oSaveFilterIndex := ReadInteger('SaveFilterIndex', 10); // ver5
    oPanelWidth := ReadInteger('PanelWidth', 229); // ver5
    ViewToolBar.Checked := ReadBoolean('ViewToolBar', True);
    ViewInsertBar.Checked := ReadBoolean('ViewInsertBar', True);
    ViewCommandsBar.Checked := ReadBoolean('ViewCommandsBar', True);
    ViewSymbolsBar.Checked := ReadBoolean('ViewSymbolsBar', True);
    ViewStatusBar.Checked := ReadBoolean('ViewStatusBar', True);
    ViewLineNumbers.Checked := ReadBoolean('ViewLineNumbers', False);
    Height := ReadInteger('WindowHeight', 580); // ver5
    Width := ReadInteger('WindowWidth', 700); // ver5
    Left := ReadInteger('WindowLeft', 0); // ver5
    Top := ReadInteger('WindowTop', 0); // ver5
    WindowState := TWindowState(ReadInteger('WindowState', 0)); // ver5
    Path := REG_PRINTING;
    with SynEditPrint.Margins do
    begin
      UnitSystem := TUnitSystem(ReadInteger('MarginsUnitSystem', 1));
      Left := ReadFloat('MarginsLeft', 2);
      Right := ReadFloat('MarginsRight', 2);
      Top := ReadFloat('MarginsTop', 2);
      Bottom := ReadFloat('MarginsBottom', 2);
      Gutter := ReadFloat('MarginsGutter', 0);
      Header := ReadFloat('MarginsHeader', 1.5);
      Footer := ReadFloat('MarginsFooter', 2);
      LeftHFTextIndent := ReadFloat('MarginsLeftHFTextIndent', 0);
      RightHFTextIndent := ReadFloat('MarginsRightHFTextIndent', 0);
      HFInternalMargin := ReadFloat('MarginsHFInternalMargin', 0.1);
      MirrorMargins := ReadBoolean('MarginsMirrorMargins', False);
    end;
    with SynEditPrint do
    begin
      LineNumbers  := ReadBoolean('PrintLineNumbers', False);
      LineNumbersInMargin := ReadBoolean('PrintLineNumbersInMargin', False);
      Highlight := ReadBoolean('PrintHighlight', True);
      Colors := ReadBoolean('PrintColors', False);
      Wrap := ReadBoolean('PrintWrap', True);
    end;
    with SynEditPrint.Header do
    begin
      FrameTypes := [];
      if ReadBoolean('HeaderLine', True) then FrameTypes := FrameTypes + [ftLine];
      if ReadBoolean('HeaderBox', False) then FrameTypes := FrameTypes + [ftBox];
      if ReadBoolean('HeaderShadow', False) then FrameTypes := FrameTypes + [ftShaded];
      LineColor := ReadInteger('HeaderLineColor', 12);
      ShadedColor := ReadInteger('HeaderShadedColor', 12);
      MirrorPosition := ReadBoolean('HeaderMirrorPosition', False);
      AsString := ReadString('HeaderItems', HEADER_ITEMS);
    end;
    with SynEditPrint.Footer do
    begin
      FrameTypes := [];
      if ReadBoolean('FooterLine', True) then FrameTypes := FrameTypes + [ftLine];
      if ReadBoolean('FooterBox', False) then FrameTypes := FrameTypes + [ftBox];
      if ReadBoolean('FooterShadow', False) then FrameTypes := FrameTypes + [ftShaded];
      LineColor := ReadInteger('FooterLineColor', 12);
      ShadedColor := ReadInteger('FooterShadedColor', 12);
      MirrorPosition := ReadBoolean('FooterMirrorPosition', False);
      AsString := ReadString('FooterItems', FOOTER_ITEMS);
    end;
  end;
  FHighlighter.LoadFromRegistry(HKEY_CURRENT_USER, REG_HPUSER_ROOT + '\Highlighter');
  List := TStringList.Create; // ver5
  try // ver5
    List.LoadFromFile(oCmdsFile); // ver5
    I := 0;
    while I < List.Count do // ver5
    begin // ver5
      if List[I] <> '' then // ver5
      begin // ver5
        Temp := List[I]; // ver5
        if Temp[1] = '@' then // ver5
          List.Delete(List.IndexOf(Temp)) // ver5
        else // ver5
          Inc(I); // ver5
      end // ver5
      else // ver5
        Inc(I); // ver5
    end; // ver5
    FHighlighter.KeyWords.AddStrings(List); // ver5
  finally // ver5
    List.Free; // ver5
  end; // ver5
end;

procedure TMainProgram.SavePreferences;
begin
  Registry.Root := REG_HPUSER_ROOT;
  with Registry do
  begin
    Path := REG_EDITOR;
    WriteBoolean('AutoIndent', eAutoIndent);
    WriteBoolean('InsertMode', eInsertMode);
    WriteBoolean('TabsToSpaces', eTabsToSpaces);
    WriteBoolean('SmallTabs', eSmallTabs);
    WriteBoolean('HideSelection', eHideSelection);
    WriteBoolean('UndoAfterSave', eUndoAfterSave);
    WriteBoolean('TrimTrailingSpaces', eTrimSpaces);
    WriteBoolean('DragDropEditing', eDragDropEditing);
    WriteBoolean('AltSetsColumnMode', eAltSetsColumn);
    WriteBoolean('UseHighlight', eUseHighlight);
    WriteInteger('ExtraLineSpacing', eExtraLineSpacing);
    WriteInteger('MaxUndo', eMaxUndos);
    WriteInteger('TabSize', eTabSize);
    WriteBoolean('CreateBackup', eCreateBackup);
    WriteBoolean('EndLineFormat', eEndLineFormat);
    WriteBoolean('MarginVisible', eMarginVisible);
    WriteBoolean('GutterVisible', eGutterVisible);
    WriteInteger('MarginSize', eMarginSize);
    WriteInteger('GutterSize', eGutterSize);
    WriteString('FontEditor', eFontEditor);
    WriteInteger('FontSize', eFontEditorSize);
    Path := REG_ENVIRONMENT;
    WriteBoolean('MultiplesInstances', oMultiplesInstances);
    WriteBoolean('LogoOnStartup', oLogoOnStartup);
    WriteBoolean('StayOnTop', oStayOnTop);
    WriteBoolean('NewFileOnStartup', oNewOnStartup);
    WriteBoolean('ShortCutDesktop', oShortCutDesktop);
    WriteBoolean('ShortCutSendTo', oShortCutSendTo);
    WriteBoolean('ShortCutContextMenu', oShortCutContext);
    WriteBoolean('ShortCutQuickLaunchBar', oShortCutLaunchBar);
    WriteString('CommandsFilename', oCmdsFile); // ver5
    WriteString('TreeViewFilename', oTreeFile); // ver5
    WriteString('Emu48RamFilename', oEmu48Filename);
    WriteString('Emu48PortFilename', oEmu48PortFilename);
    WriteString('Emu49RamFilename', oEmu49Filename);
    WriteBoolean('SaveIntoEMU', oSaveIntoEMU); // ver5
    WriteBoolean('DefaultEmulator', oIsCalc48);
    WriteBoolean('ObjectNameCapital', oObjectNameCap);
    WriteBoolean('ObjectNameWithoutExt', oObjectNameExt);
    WriteInteger('ComPortNumber', oComPort);
    //WriteInteger('KermitSendSpeed', oSendSpeed);
    //WriteInteger('KermitSendChecksum', oSendChecksum);
    //WriteInteger('KermitSendRetry', oSendRetry);
    //WriteBoolean('KermitEnableBeep', oEnableBeep);
    WriteBoolean('ShowTipDay', oShowTipDay);
    WriteString('Language', oLanguage); // ver5
    WriteInteger('OpenFilterIndex', oOpenFilterIndex); // ver5
    WriteInteger('SaveFilterIndex', oSaveFilterIndex); // ver5
    WriteInteger('PanelWidth', oPanelWidth); // ver5
    WriteBoolean('ViewToolBar', ViewToolBar.Checked);
    WriteBoolean('ViewInsertBar', ViewInsertBar.Checked);
    WriteBoolean('ViewCommandsBar', ViewCommandsBar.Checked);
    WriteBoolean('ViewSymbolsBar', ViewSymbolsBar.Checked);
    WriteBoolean('ViewStatusBar', ViewStatusBar.Checked);
    WriteBoolean('ViewLineNumbers', ViewLineNumbers.Checked);
    WriteInteger('WindowHeight', Height); // ver5
    WriteInteger('WindowWidth', Width); // ver5
    WriteInteger('WindowLeft', Left); // ver5
    WriteInteger('WindowTop', Top); // ver5
    WriteInteger('WindowState', Ord(WindowState)); // ver5
    Path := REG_PRINTING;
    with SynEditPrint.Margins do
    begin
      WriteInteger('MarginsUnitSystem', Ord(UnitSystem));
      WriteFloat('MarginsLeft', Left);
      WriteFloat('MarginsRight', Right);
      WriteFloat('MarginsTop', Top);
      WriteFloat('MarginsBottom', Bottom);
      WriteFloat('MarginsGutter', Gutter);
      WriteFloat('MarginsHeader', Header);
      WriteFloat('MarginsFooter', Footer);
      WriteFloat('MarginsLeftHFTextIndent', LeftHFTextIndent);
      WriteFloat('MarginsRightHFTextIndent', RightHFTextIndent);
      WriteFloat('MarginsHFInternalMargin', HFInternalMargin);
      WriteBoolean('MarginsMirrorMargins', MirrorMargins);
    end;
    with SynEditPrint do
    begin
      WriteBoolean('PrintLineNumbers', LineNumbers);
      WriteBoolean('PrintLineNumbersInMargin', LineNumbersInMargin);
      WriteBoolean('PrintHighlight', Highlight);
      WriteBoolean('PrintColors', Colors);
      WriteBoolean('PrintWrap', Wrap);
    end;
    with SynEditPrint.Header do
    begin
      WriteBoolean('HeaderLine', ftLine in FrameTypes);
      WriteBoolean('HeaderBox', ftBox in FrameTypes);
      WriteBoolean('HeaderShadow', ftShaded in FrameTypes);
      WriteInteger('HeaderLineColor', LineColor);
      WriteInteger('HeaderShadedColor', ShadedColor);
      WriteBoolean('HeaderMirrorPosition', MirrorPosition);
      WriteString('HeaderItems', AsString);
    end;
    with SynEditPrint.Footer do
    begin
      WriteBoolean('FooterLine', ftLine in FrameTypes);
      WriteBoolean('FooterBox', ftBox in FrameTypes);
      WriteBoolean('FooterShadow', ftShaded in FrameTypes);
      WriteInteger('FooterLineColor', LineColor);
      WriteInteger('FooterShadedColor', ShadedColor);
      WriteBoolean('FooterMirrorPosition', MirrorPosition);
      WriteString('FooterItems', AsString);
    end;
  end;
  FHighlighter.KeyWords.Clear;
  FHighlighter.SaveToRegistry(HKEY_CURRENT_USER, REG_HPUSER_ROOT + '\Highlighter');
end;

procedure TMainProgram.MultiDockResize(Sender: TObject);
var
  NCol, NRow: Integer;
begin
  with StringGrid do
  begin
    NCol := Round(ClientWidth / (DefaultColWidth + 1));
    SymbolsBar.Width := NCol * (DefaultColWidth + 1) + (Width - ClientWidth) + (SymbolsBar.Width - Width);
    NRow := Ceil(128 / NCol);
    ColCount := NCol;
    RowCount := NRow;
    Multidock.Width := SymbolsBar.Width;
    CommandsBar.Width := SymbolsBar.Width;
    StackBar.Width := SymbolsBar.Width;
    oPanelWidth := SymbolsBar.Width;
    DoFillStringGrid;
  end;
end;

procedure TMainProgram.DoFillStringGrid;
var
  I, J: Integer;
begin
  for I := 0 to StringGrid.RowCount - 1 do
    for J := 0 to StringGrid.ColCount - 1 do
      if StringGrid.ColCount * I + J < 128 then
        StringGrid.Cells[J,I] := Chr(128 + StringGrid.ColCount * I + J)
      else
        StringGrid.Cells[J,I] := '';
end;

procedure TMainProgram.TabBarTabSelected(Sender: TObject; Item: TJvTabBarItem);
begin
  if Item <> nil then
  begin
    FIndex := Item.Index; // ver5
    PageList.ActivePageIndex := FIndex; // ver5
    Editor.SetFocus; // ver5
    DoChangeStatusBar; // ver5
    Editor.Gutter.ShowLineNumbers := ViewLineNumbers.Checked; // ver5
  end;
end;

procedure TMainProgram.TabSetChange(Sender: TObject; NewTab: Integer;
  var AllowChange: Boolean);
var
  Ain, Aout: TStringList;
  IsOut: Boolean;
  T, s: string;
  P, List, I: Integer;

procedure AddItem;
begin
  if IsOut then
    Aout.Add(s) // ver5
  else
    Ain.Add(s); // ver5
  s := ''; // ver5
end;

begin
  T := FStack[NewTab]; // ver5
  if Pos(#141, T) = 0 then
  begin
    StackViewOut.Visible := False; // ver5
    ShapeLine.Visible := False; // ver5
    StackViewIn.Visible := False; // ver5
    StackPanel.Caption := T; // ver5
  end
  else begin
    ClearStack;  // ver5
    StackViewIn.Visible := True; // ver5
    ShapeLine.Visible := True;
    StackViewOut.Visible := True; // ver5
    Ain := TStringList.Create; // ver5
    Aout := TStringList.Create; // ver5
    try
      s := ''; // ver5
      P := 1; // ver5
      List := 0; // ver5
      IsOut := False; // ver5
      while P <= Length(T) do
      begin
        case T[P] of
          #141: begin
                  IsOut := True; // ver5
                  s := ''; // ver5
                  Inc(P) // ver5
                end;
          '{' : begin
                  Inc(List); // ver5
                  s := s + T[P]; // ver5
                  Inc(P); // ver5
                end;
          '}' : begin
                  Dec(List); // ver5
                  s := s + T[P]; // ver5
                  if P = Length(T) then
                    AddItem; // ver5
                  Inc(P); // ver5
                end;
          ' ' : begin
                  if (List = 0) and (s <> '') then
                    AddItem // ver5
                  else if List <> 0 then
                    s := s + T[P]; // ver5
                  Inc(P); // ver5
                end;
          else begin
            s := s + T[P]; // ver5
            if P = Length(T) then
              AddItem; // ver5
            Inc(P); // ver5
          end;
        end;
      end;
      for I := Ain.Count - 1 downto 0 do
        StackViewIn.Cells[1, StackViewIn.RowCount - (Ain.Count - I)] := Ain[I]; // ver5
      for I := Aout.Count - 1 downto 0 do
        StackViewOut.Cells[1, StackViewOut.RowCount - (Aout.Count - I)] := Aout[I]; // ver5
    finally
      Ain.Free; // ver5
      Aout.Free; // ver5
    end;
  end;
  AllowChange := True; // ver5
end;

procedure TMainProgram.ToolBarVisibleChanged(Sender: TObject);
begin
  ViewToolBar.Checked := ToolBar.Visible;
  ViewInsertBar.Checked := InsertBar.Visible;
  ViewCommandsBar.Checked := CommandsBar.Visible;
  ViewSymbolsBar.Checked := SymbolsBar.Visible;
end;

procedure TMainProgram.ChangeLanguageFile;
begin
  if not FileExists(LangPath) then
  begin
    MsgDlg(Format(Msgs[MSG_FILENOTEXISTS], [LangPath]), MB_ICONERROR + MB_OK);
    Exit;
  end;
  with TLanguageFile.Create(LangPath) do
  try
    Section := 'MainProgram';
    MenuBar.Caption := LoadItem('MenusBarTitle');
    MenuBar.ChevronHint := LoadItem('ToolBarChevronHint');
    ToolBar.Caption := LoadItem('ToolBarTitle');
    ToolBar.ChevronHint := LoadItem('ToolBarChevronHint');
    InsertBar.Caption := LoadItem('InsertBarTitle');
    InsertBar.ChevronHint := LoadItem('ToolBarChevronHint');
    CommandsBar.Caption := LoadItem('CommandsWindowTitle');
    TreeCommands.Hint := LoadItem('CommandsWindowHint');
    SymbolsBar.Caption := LoadItem('SymbolsWindowTitle');
    StringGrid.Hint := LoadItem('SymbolsWindowHint');
    StackViewIn.Hint := LoadItem('StackWindowHint'); // ver5
    StackViewOut.Hint := LoadItem('StackWindowHint'); // ver5
    Section := 'Menus';
    MenuFile.Caption := LoadItem('MenuFile');
    FileNew.Caption := LoadItem('MenuFileNew');
    FileNew.Hint := LoadItem('MenuFileNewTip');
    FileOpen.Caption := LoadItem('MenuFileOpen');
    FileOpen.Hint := LoadItem('MenuFileOpenTip');
    FileClose.Caption := LoadItem('MenuFileClose');
    FileClose.Hint := LoadItem('MenuFileCloseTip');
    FileCloseAll.Caption := LoadItem('MenuFileCloseAll');
    FileCloseAll.Hint := LoadItem('MenuFileCloseAllTip');
    FileSave.Caption := LoadItem('MenuFileSave');
    FileSave.Hint := LoadItem('MenuFileSaveTip');
    FileSaveAs.Caption := LoadItem('MenuFileSaveAs');
    FileSaveAs.Hint := LoadItem('MenuFileSaveAsTip');
    FileImport.Caption := LoadItem('MenuFileImport');
    FileImport.Hint := LoadItem('MenuFileImportTip');
    FileExport.Caption := LoadItem('MenuFileExport');
    FileExport.Hint := LoadItem('MenuFileExportTip');
    FileSendToHP.Caption := LoadItem('MenuFileSendToHP');
    FileSendToHP.Hint := LoadItem('MenuFileSendToHPTip');
    FilePrint.Caption := LoadItem('MenuFilePrint');
    FilePrint.Hint := LoadItem('MenuFilePrintTip');
    FilePreview.Caption := LoadItem('MenuFilePreview');
    FilePreview.Hint := LoadItem('MenuFilePreviewTip');
    FilePageSetup.Caption := LoadItem('MenuFilePageSetup');
    FilePageSetup.Hint := LoadItem('MenuFilePageSetupTip');
    FileExit.Caption := LoadItem('MenuFileExit');
    FileExit.Hint := LoadItem('MenuFileExitTip');
    MenuEdit.Caption := LoadItem('MenuEdit');
    EditUndo.Caption := LoadItem('MenuEditUndo');
    EditUndo.Hint := LoadItem('MenuEditUndoTip');
    EditRedo.Caption := LoadItem('MenuEditRedo');
    EditRedo.Hint := LoadItem('MenuEditRedoTip');
    EditCut.Caption := LoadItem('MenuEditCut');
    EditCut.Hint := LoadItem('MenuEditCutTip');
    EditCopy.Caption := LoadItem('MenuEditCopy');
    EditCopy.Hint := LoadItem('MenuEditCopyTip');
    EditPaste.Caption := LoadItem('MenuEditPaste');
    EditPaste.Hint := LoadItem('MenuEditPasteTip');
    EditSelectAll.Caption := LoadItem('MenuEditSelectAll');
    EditSelectAll.Hint := LoadItem('MenuEditSelectAllTip');
    MenuSearch.Caption := LoadItem('MenuSearch');
    SearchFind.Caption := LoadItem('MenuSearchFind');
    SearchFind.Hint := LoadItem('MenuSearchFindTip');
    SearchFindNext.Caption := LoadItem('MenuSearchFindNext');
    SearchFindNext.Hint := LoadItem('MenuSearchFindNextTip');
    SearchFindPrev.Caption := LoadItem('MenuSearchFindPrevious');
    SearchFindPrev.Hint := LoadItem('MenuSearchFindPreviousTip');
    SearchReplace.Caption := LoadItem('MenuSearchReplace');
    SearchReplace.Hint := LoadItem('MenuSearchReplaceTip');
    SearchGoTo.Caption := LoadItem('MenuSearchGoToLine');
    SearchGoTo.Hint := LoadItem('MenuSearchGoToLineTip');
    MenuView.Caption := LoadItem('MenuView');
    ViewToolBar.Caption := LoadItem('MenuViewToolBar');
    ViewToolBar.Hint := LoadItem('MenuViewToolBarTip');
    ViewInsertBar.Caption := LoadItem('MenuViewInsertObjectsBar');
    ViewInsertBar.Hint := LoadItem('MenuViewInsertObjectsBarTip');
    ViewCommandsBar.Caption := LoadItem('MenuViewCommandsBar');
    ViewCommandsBar.Hint := LoadItem('MenuViewCommandsBarTip');
    ViewSymbolsBar.Caption := LoadItem('MenuViewSymbolsBar');
    ViewSymbolsBar.Hint := LoadItem('MenuViewSymbolsBarTip');
    ViewStatusBar.Caption := LoadItem('MenuViewStatusBar');
    ViewStatusBar.Hint := LoadItem('MenuViewStatusBarTip');
    ViewLineNumbers.Caption := LoadItem('MenuViewNumberLine');
    ViewLineNumbers.Hint := LoadItem('MenuViewNumberLineTip');
    MenuInsert.Caption := LoadItem('MenuInsert');
    InsertProgram.Caption := LoadItem('MenuInsertProgram');
    InsertProgram.Hint := LoadItem('MenuInsertProgramTip');
    InsertSubprogram.Caption := LoadItem('MenuInsertSubprogram'); // ver5
    InsertSubprogram.Hint := LoadItem('MenuInsertSubprogramTip'); // ver5
    InsertString.Caption := LoadItem('MenuInsertString');
    InsertString.Hint := LoadItem('MenuInsertStringTip');
    InsertEquation.Caption := LoadItem('MenuInsertEquation');
    InsertEquation.Hint := LoadItem('MenuInsertEquationTip');
    InsertList.Caption := LoadItem('MenuInsertList');
    InsertList.Hint := LoadItem('MenuInsertListTip');
    InsertArray.Caption := LoadItem('MenuInsertMatrix');
    InsertArray.Hint := LoadItem('MenuInsertMatrixTip');
    InsertComplex.Caption := LoadItem('MenuInsertComplex');
    InsertComplex.Hint := LoadItem('MenuInsertComplexTip');
    InsertDirectory.Caption := LoadItem('MenuInsertDirectory'); // ver5
    InsertDirectory.Hint := LoadItem('MenuInsertDirectoryTip'); // ver5
    InsertIf.Caption := LoadItem('MenuInsertIf');
    InsertIf.Hint := LoadItem('MenuInsertIfTip');
    InsertIfErr.Caption := LoadItem('MenuInsertIfErr'); // ver5
    InsertIfErr.Hint := LoadItem('MenuInsertIfErrTip'); // ver5
    InsertCase.Caption := LoadItem('MenuInsertCase');
    InsertCase.Hint := LoadItem('MenuInsertCaseTip');
    InsertStart.Caption := LoadItem('MenuInsertStart');
    InsertStart.Hint := LoadItem('MenuInsertStartTip');
    InsertFor.Caption := LoadItem('MenuInsertFor');
    InsertFor.Hint := LoadItem('MenuInsertForTip');
    InsertDo.Caption := LoadItem('MenuInsertDo');
    InsertDo.Hint := LoadItem('MenuInsertDoTip');
    InsertWhile.Caption := LoadItem('MenuInsertWhile');
    InsertWhile.Hint := LoadItem('MenuInsertWhileTip');
    MenuEmu.Caption := LoadItem('MenuEmu');
    EmuRun.Caption := LoadItem('MenuEmuRun');
    EmuRun.Hint := LoadItem('MenuEmuRunTip');
    EmuSend.Caption := LoadItem('MenuEmuSend');
    EmuSend.Hint := LoadItem('MenuEmuSendTip');
    EmuProgramRun.Caption := LoadItem('MenuEmuProgramRun');
    EmuProgramRun.Hint := LoadItem('MenuEmuProgramRunTip');
    EmuProgramParam.Caption := LoadItem('MenuEmuProgramParam');
    EmuProgramParam.Hint := LoadItem('MenuEmuProgramParamTip');
    EmuProgramStep.Caption := LoadItem('MenuEmuProgramStep');
    EmuProgramStep.Hint := LoadItem('MenuEmuProgramStepTip');
    EmuProgramBreak.Caption := LoadItem('MenuEmuProgramBreak');
    EmuProgramBreak.Hint := LoadItem('MenuEmuProgramBreakTip');
    EmuClearBreak.Caption := LoadItem('MenuEmuClearBreak');
    EmuClearBreak.Hint := LoadItem('MenuEmuClearBreakTip');
    MenuTools.Caption := LoadItem('MenuTools');
    ToolsMatrixWriter.Caption := LoadItem('MenuToolsMatrixWriter');
    ToolsMatrixWriter.Hint := LoadItem('MenuToolsMatrixWriterTip');
    ToolsInput.Caption := LoadItem('MenuToolsInput');
    ToolsInput.Hint := LoadItem('MenuToolsInputTip');
    ToolsChoose.Caption := LoadItem('MenuToolsChoose');
    ToolsChoose.Hint := LoadItem('MenuToolsChooseTip');
    ToolsInform.Caption := LoadItem('MenuToolsInform');
    ToolsInform.Hint := LoadItem('MenuToolsInformTip');
    ToolsPicture.Caption := LoadItem('MenuToolsPicture'); // ver5
    ToolsPicture.Hint := LoadItem('MenuToolsPictureTip'); // ver5
    ToolsProgram.Caption := LoadItem('MenuToolsBuilder'); // ver5
    ToolsProgram.Hint := LoadItem('MenuToolsBuilderTip'); // ver5
    MenuOptions.Caption := LoadItem('MenuOptions');
    OptionsEnvironment.Caption := LoadItem('MenuOptionsEnvironment');
    OptionsEnvironment.Hint := LoadItem('MenuConfigEvironmentTip');
    OptionsEditor.Caption := LoadItem('MenuOptionsEditor');
    OptionsEditor.Hint := LoadItem('MenuConfigEditorTip');
    OptionsLanguage.Caption := LoadItem('MenuOptionsLanguage'); // ver5
    MenuLanguage.Caption := LoadItem('MenuOptionsLanguage'); // ver5
    MenuHelp.Caption := LoadItem('MenuHelp');
    HelpIndex.Caption := LoadItem('MenuHelpIndex');
    HelpIndex.Hint := LoadItem('MenuHelpIndexTip');
    HelpFaq.Caption := LoadItem('MenuHelpFaq');
    HelpFaq.Hint := LoadItem('MenuHelpFaqTip');
    HelpWeb.Caption := LoadItem('MenuHelpWeb');
    HelpWeb.Hint := LoadItem('MenuHelpWebTip');
    HelpTipOfDay.Caption := LoadItem('MenuHelpTipOfDay');
    HelpTipOfDay.Hint := LoadItem('MenuHelpTipDayTip');
    HelpAbout.Caption := LoadItem('MenuHelpAbout');
    HelpAbout.Hint := LoadItem('MenuHelpAboutTip');
    HelpWhatThisIs.Caption := LoadItem('MenuHelpWhatThisIs');
    HelpWhatThisIs.Hint := LoadItem('MenuHelpWhatThisIsTip');
    LoadLanguageMessages;
    LoadLanguageLabels;
  finally
    Free;
  end;
end;

procedure TMainProgram.ClearStack;
var
  I: Integer;
begin
  for I := 0 to StackViewIn.RowCount - 1 do
  begin
    StackViewIn.Cells[1, I] := ''; // ver5
    StackViewOut.Cells[1, I] := ''; // ver5
  end;
end;

procedure TMainProgram.PopupMenuPopup(Sender: TObject);
var
  DummyHwnd: THandle;
begin
  DummyHwnd := Classes.AllocateHwnd(nil);
  if DummyHwnd <> 0 then
  begin
    Windows.SetFocus(DummyHwnd);
    Classes.DeallocateHwnd(DummyHwnd);
  end;
end;

procedure TMainProgram.TreeCommandsDblClick(Sender: TObject);
begin
  if TreeCommands.Selected.ImageIndex = 1 then
    DoInsertText(TreeCommands.Selected.Text);
  Editor.SetFocus;
end;

end.
