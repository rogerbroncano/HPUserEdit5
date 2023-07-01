unit Globals;

interface

uses
  Windows, Classes, Forms, SysUtils, ComCtrls;

const
  APP_TITLE = 'HPUserEdit 5';
  APP_NAME = APP_TITLE;
  APP_LNK = APP_NAME + '.lnk';
  APP_URL = 'http://www.gaak.org/hpuser'; // ver5
  APP_CLASSNAME = 'HP_UserRPL_Edit';

  REG_HPUSER_ROOT = 'Software\HPUserEdit';
  REG_EDITOR = 'Editor';
  REG_ENVIRONMENT = 'Environment';
  REG_PRINTING = 'Printing';
  REG_BUILDER = 'Builder';

  DEF_GROB_WITH = 131;
  DEF_GROB_HEIGHT = 80;

  HEADER_ITEMS = 'Página: $PAGENUM$ de $PAGECOUNT$\.0\.0\.-11\.Arial\.0\.96\.8\.0\.1\.0/$TITLE$\.1\.0\.-13\.Arial\.0\.96\.10\.0\.1\.2/$DATE$ - $TIME$\.0\.0\.-11\.Arial\.0\.96\.8\.0\.1\.1';
  FOOTER_ITEMS = 'Impreso con HPUserEdit\.0\.0\.-11\.Arial\.0\.96\.8\.0\.1\.0/$PAGENUM$\.1\.0\.-11\.Arial\.0\.96\.8\.0\.1\.1';

  CONSOLE_TITLE = 'HPUserEdit - Kermit';

  CFGK_FILE = 'MSKERMIT.INI';
  //CMDS_FILE = 'COMMANDS.DAT';
  //LANG_FILE = 'LANGUAGE.DAT';
  TEMP_FILE = 'UETEMP.TMP';
  TIPS_FILE = 'TIPS.TXT';
  TEMPLATE_DIR = 'Templates';

  NewLine = #13#10;

  MSG_TEXTNOTFOUND     = 1;
  MSG_SAVECHANGES      = 2;
  MSG_SAVEERROR        = 3;
  MSG_REPLACETEXT      = 4;
  MSG_FILENOTEXISTS    = 5;
  MSG_NOIMPORTGRAPH    = 6;
  MSG_NOSENDEMU        = 7;
  MSG_NOCANIMPORT      = 8;
  MSG_NOCANEXPORT      = 9;
  MSG_SAVEBEFORESEND   = 10;
  MSG_NOSENDFILE       = 11;
  MSG_NOINITEMU        = 12;
  MSG_NOTRANSFER       = 13;
  MSG_CHANGERAM        = 14; // ver5
  MSG_CHANGEGROB       = 15; // ver5
  MSG_NOOPENDIAGRAM    = 16; // ver5
  MSG_NOSAVEDIAGRAM    = 17; // ver5
  MSG_NOBLOCKCONECT    = 18; // ver5
  MSG_SELECTOTHERBLOCK = 19; // ver5
  MSG_VAREXPECTED      = 20; // ver5
  MSG_NOINPUTDATA      = 21; // ver5
  MSG_VARBADNAME       = 22; // ver5
  MSG_STRINGEXPECTED   = 23; // ver5
  MSG_NOEXISTSVAR      = 24; // ver5
  MSG_INCORRECTVARNAME = 25; // ver5
  MSG_ASSOCIATION      = 26; // ver5                     
  MSG_NOEVALFORMULA    = 27; // ver5
  MSG_NOINITVALUE      = 28; // ver5
  MSG_NOENDVALUE       = 29; // ver5
  MSG_BUCLESYNERROR    = 30; // ver5
  MSG_RUNNINGDIAGRAM   = 31; // ver5
  MSG_DIAGRAMMODIFIED  = 32; // ver5
  MSG_NOVALIDFORMAT    = 33; // ver5
  MSG_NOACCESSDIAGRAM  = 34; // ver5
  MSG_NOBEGINBLOCK     = 35; // ver5
  MSG_NOENDBLOCK       = 36; // ver5
  MSG_BLANKBLOCK       = 37; // ver5
  MSG_CODEERROR        = 38; // ver5

  MAX_MSGS = 38; // ver5

  LBL_NEWOBJ     = 1;
  LBL_POSITION   = 2;
  LBL_INSERT     = 3;
  LBL_MODIFIED   = 4;
  LBL_OVERWRITE  = 5;
  LBL_PAGE       = 6;
  LBL_OPEN       = 7;
  LBL_SAVEAS     = 8;
  LBL_HPEFILTER  = 9;
  LBL_IMPORT     = 10;
  LBL_EXPORT     = 11;
  LBL_GRBFILTER  = 12;
  LBL_BINFILTER  = 13;
  LBL_ASSOCIATE  = 14;
  LBL_IMPORTING  = 15;
  LBL_NEWIMPORT  = 16;
  LBL_EXPORTING  = 17;
  LBL_COMPLETED  = 18;
  LBL_ERROR      = 19;
  LBL_CANCELED   = 20;
  LBL_SENDING    = 21;
  LBL_CONECTING  = 22;
  LBL_FILTER1    = 23; // ver5
  LBL_FILTER2    = 24; // ver5
  LBL_FILTER3    = 25; // ver5
  LBL_FILTER4    = 26; // ver5
  LBL_FILTER5    = 27; // ver5
  LBL_FILTER6    = 28; // ver5
  LBL_FILTER7    = 29; // ver5
  LBL_FILTER8    = 30; // ver5
  LBL_FILTER9    = 31; // ver5
  LBL_FILTER10   = 32; // ver5
  LBL_INPUTVAR   = 33; // ver5
  LBL_NONAME     = 34; // ver5
  LBL_TRUE       = 35; // ver5
  LBL_FALSE      = 36; // ver5

  MAX_LBLS = 36; // ver5

var

  { Editor Options }

  eAutoIndent: Boolean;
  eInsertMode: Boolean;
  eTabsToSpaces: Boolean;
  eSmallTabs: Boolean;
  eHideSelection: Boolean;
  eUndoAfterSave: Boolean;
  eTrimSpaces: Boolean;
  eDragDropEditing: Boolean;
  eAltSetsColumn: Boolean;
  eUseHighlight: Boolean;
  eExtraLineSpacing: Integer;
  eMaxUndos: Integer;
  eTabSize: Integer;
  eCreateBackup: Boolean;
  eEndLineFormat: Boolean;
  eMarginVisible: Boolean;
  eGutterVisible: Boolean;
  eMarginSize: Integer;
  eGutterSize: Integer;
  eFontEditor: ShortString;
  eFontEditorSize: Integer;

  { Environment Options }

  oMultiplesInstances: Boolean;
  oLogoOnStartup: Boolean;
  oStayOnTop: Boolean;
  oNewOnStartup: Boolean;
  oShortCutDesktop: Boolean;
  oShortCutSendTo: Boolean;
  oShortCutContext: Boolean;
  oShortCutLaunchBar: Boolean;
  oCmdsFile: TFileName; // ver5
  oTreeFile: TFileName; // ver5
  oEmu48Filename: TFileName;
  oEmu48PortFilename: TFileName;
  oEmu49Filename: TFileName;
  oSaveIntoEMU: Boolean;
  oIsCalc48: Boolean;
  oObjectNameCap: Boolean;
  oObjectNameExt: Boolean;
  oComPort: Integer; // ver5
  oComPortName: ShortString; // ver5
  //oSendSpeed: Integer;
  //oSendChecksum: Integer;
  //oSendRetry: Integer;
  //oEnableBeep: Boolean;
  oAutoLoad: Boolean; // ver5
  oShowTipDay: Boolean;
  oLanguage: ShortString; // ver5
  oPanelWidth: Integer; // ver5
  oOpenFilterIndex: Integer;
  oSaveFilterIndex: Integer;

  { Diagram Builder }

  VarNames: TStringList;
  VarValues: array [0..100] of extended;
  GridSize: Integer = 8;

  { Global Names }

  AppPath: TFileName;
  LangPath: TFileName;
  TempFile: TFileName;
  StkNameURPL: TStringList;                                       // wgg
  StkArgsURPL: TStringList;                                       // wgg
  Msgs: array [1..MAX_MSGS] of ShortString; // ver5
  Caps: array [1..MAX_LBLS] of ShortString; // ver5

function MsgDlg(const Msg: string; aButtons: Cardinal): Word;

function SnapToGrid(const Value: Integer): Integer;

procedure LoadStackArgs(f: TFilename; sname: TStringList; sargs: TStringList{; verbname: TStringList});   // wgg

procedure LoadTreeCommands(TreeView: TTreeView);

implementation

uses
  HPUtils;

function MsgDlg(const Msg: string; aButtons: Cardinal): Word;
begin
  Result := MessageBox(Application.Handle, PChar(Msg), APP_TITLE, aButtons);
end;

function SnapToGrid(const Value: Integer): Integer;
begin
  Result := Round(Value / GridSize) * GridSize;
end;

procedure LoadStackArgs(f: TFilename; sname: TStringList; sargs: TStringList);
var
  stackFile: TStringList;
  line: Integer;
  Name, Args: string;

procedure ProcessLine(const T: string);
var
  I, Par: Integer;
begin
  Name := '';
  Args := '';
  if Copy(T, 1, 2) = '%%' then
    Exit;
  if T[1] = '@' then
    Exit;
  I := 1;
  while I <= Length(T) do
    if T[I] = ' ' then
    begin
      Inc(I);
      Break;
    end
    else begin
      Name := Name + T[I];
      Inc(I);
    end;
  Par := 0;
  while I <= Length(T) do
    if T[I] = '(' then
    begin
      Par := 1;
      Inc(I);
      Break;
    end
    else
      Inc(I);
  if Par = 1 then
  begin
    while (I <= Length(T)) or (Par <> 0) do
    begin
      Args := Args + T[I];
      if T[I] = '(' then
        Inc(Par)
      else if T[I] = ')' then
        Dec(Par);
      Inc(I);
    end;
    Args := Trim(Copy(Args, 1, Length(Args) - 1));
  end;
end;

begin
  if not FileExists(f) then
  begin
    MsgDlg(Format(Msgs[MSG_FILENOTEXISTS], [f]), MB_ICONERROR + MB_OK);
    Exit;
  end;
  stackFile := TStringList.Create;
  stackFile.CaseSensitive := True;
  stackFile.LoadFromFile(f);
  sname.Clear;
  sargs.Clear;
  sname.CaseSensitive := true;
  for line := 0 to stackFile.Count - 1 do
    if length(stackFile[line]) > 0 then
    begin
      ProcessLine(stackFile[line]);
      if (Name <> '') and (Args <> '') then
      begin
        sname.Add(Name);
        sargs.Add(Args);
      end
      else if (Name = '') and (Args <> '') then
      begin
        sname.add(sname[sname.Count - 1]);
        sargs.Add(Args);
      end;
    end;
end;

procedure LoadTreeCommands(TreeView: TTreeView);

function GetBufStart(Buffer: PChar; var Level: Integer): PChar;
begin
  Level := 0;
  while Buffer^ in [' ', #9] do
  begin
    Inc(Buffer);
    Inc(Level);
  end;
  Result := Buffer;
end;

var
  List: TStringList;
  ANode, NextNode: TTreeNode;
  ALevel, I: Integer;
  CurrStr: string;
begin
  if not FileExists(oTreeFile) then
  begin
    MsgDlg(Format(Msgs[MSG_FILENOTEXISTS], [oTreeFile]), MB_ICONERROR + MB_OK);
    Exit;
  end;
  List := TStringList.Create;
  try
    List.LoadFromFile(oTreeFile); // ver5
    ANode := nil;
    for I := 0 to List.Count - 1 do
    begin
      CurrStr := GetBufStart(PChar(List[I]), ALevel);
      if CurrStr = '' then Continue; // ver5
      if CurrStr[1] = '@' then Continue; // ver5
      if Pos('=[', CurrStr) <> 0 then // ver5
        CurrStr := Copy(CurrStr, Pos('[', CurrStr) + 1, Length(CurrStr) - Pos('[', CurrStr) - 1); // ver5
      if ANode = nil then
        ANode := TreeView.Items.AddChild(nil, CurrStr)
      else if ANode.Level = ALevel then
      begin
        ANode := TreeView.Items.AddChild(ANode.Parent, CurrStr);
        ANode.ImageIndex := 1;
        ANode.SelectedIndex := 1;
      end
      else if ANode.Level = (ALevel - 1) then
      begin
        ANode := TreeView.Items.AddChild(ANode, CurrStr);
        ANode.Parent.ImageIndex := 0;
        ANode.Parent.SelectedIndex := 0;
        ANode.ImageIndex := 1;
        ANode.SelectedIndex := 1;
      end
      else if ANode.Level > ALevel then
      begin
        NextNode := ANode.Parent;
        while NextNode.Level > ALevel do
          NextNode := NextNode.Parent;
        NextNode.ImageIndex := 0;
        NextNode.SelectedIndex := 0;
        ANode := TreeView.Items.AddChild(NextNode.Parent, CurrStr);
        ANode.ImageIndex := 1;
        ANode.SelectedIndex := 1;
      end;
    end;
  finally
    List.Free;
  end;
end;

end.
