unit Emu48Proc;

interface

uses
  Windows, Forms, Classes, Emu48Dll, SysUtils, ShellAPI, HPUtils, Globals,
  StrUtils;

procedure Emu48Init(Ram: TFileName; Port2: TFileName);

procedure Emu48Run;

function Emu48ExecuteObject(Text: string; Execute: Boolean): Boolean;

function Emu48ImportObject(F: TFileName): string;

function Emu48ExportObject(F: TFileName; Text: string): Boolean;

procedure Emu48CheckRunning(Is48: Boolean);

procedure Emu48Exit;

procedure Emu48RunProgram(Prog: string; Param: string; BreakPoint: Integer);

procedure Emu48RunProgramStep(Prog: string; Param: string);

procedure ShowEmu48(Visible: Boolean);

var
  stkLock: Boolean = False;                                // stop reentry when keys pressed and emu still working

implementation

type
  TKeyPressThread = class (tthread)
    s: string;
    action: TThreadMethod;
    constructor create(s:string; action: TThreadMethod);
    procedure Execute; override;
  end;

const
  HPHeader: string[6] = 'HPHP48';
  IsRunningEMU: Boolean = False;
  RamFile: TFileName = '';
  PortFile: TFileName = '';

procedure CheckTempFile;
begin
  if FileExists(TempFile) then
    if not DeleteFile(TempFile) then
      TempFile := TempFile + '0';
end;

{procedure ReadMemory(var PByte: array of Byte; Adress, Size: integer);
var
  I: integer;
begin
  for I:=0 to Size - 1 do
    EmuGetMem(Adress + I, PByte[I]);
end;

function ReadInteger(Adr: Integer): Integer;
var
  Buf: array [0..4] of Byte;
begin
  ReadMemory(Buf, Adr, 5);
  Result := Buf[0] + Buf[1] * 16 + Buf[2] * 256 + Buf[3] * 16 * 256 + Buf[4] * 65536;
end;}

// wgg wait for debugger Busy flag off or timeout
// returns true if got the signal, false for timeout
// This did not help the Loading to EMU process
function WaitBusy: boolean;
var
  flags: byte;
  targTime: DWORD;

  function Wait(bit: integer; maxTime: integer): boolean;
  begin
  result:= true;
  targTime:= GetTickCount + DWORD(maxTime);
  repeat
    if GetTickCount > targTime then
    begin
      result:= false;
      break;
    end else begin
      //Application.ProcessMessages;     // will inhibit buffering keystrokes in TTextExec
      sleep(0);                                   // 0 ok only if useing EmuGetRegister version
      //sleep(10);                                //wgg, sometimes get exception on build if <10
      //Debugger.ReadMemory(flags, $10C, 1);      // call s/b wait(0,3500)
      flags:= (EmuGetRegister(EMU_REGISTER_FLAGS) and $8000)shr 15;
    end;
  until (flags and 1) = bit;
  end;

begin
  //Wait(1, 100);                           // wait short time for it to go positive ==was 100, usually fails
  Result:= wait(1, 3500);                   // wait for it to clear, was (0,3500)
  //OutputDebugString(pchar('2: ' + booltostr(Result, true)));
end;

// wgg wait for debugger ShutDn signal or timeout
// returns true if got the signal, false for timeout
// revised 11/2006 for time loop and added Sleep(100) at front
function WaitShutDown: boolean;
var
  targTime: DWORD;
const
  maxTime: integer = 10000;        // maximum time for waiting
begin
  targTime:= GetTickCount + DWORD(maxTime);
  Sleep(100);                      // give time for flags to adjust
  while (((EmuGetRegister(EMU_REGISTER_FLAGS) and $8000)shr 15) = 0) do
    if GetTickCount > targTime then
    begin
      break;
    end else begin
      ///Application.ProcessMessages;
      sleep(0);
    end;
  result:= WaitBusy;   // wgg make sure no busy Annunciator
  //OutputDebugString(pchar(booltostr(result,true)));
end;

// wgg added this to interpret new calc types from EMU48
// for the 48Gii and 49G+.  Treat these all as X (or 49G)
//               '6' = HP38G with 64KB RAM
//               'A' = HP38G
//               'E' = HP39/40G
//               'S' = HP48SX
//               'G' = HP48GX
//               'X' = HP49G
//               'P' = HP39G+     // JYA changes
//               'Q' = HP49G+
//               '2' = HP48GII
function LimitedEmuCalculatorType(): char;
var
  T: Char;
begin
    T := EmuCalculatorType;
    case T of
      'X': Result := 'X';
      'P': Result := 'X';
      'Q': Result := 'X';
      '2': Result := 'X';
    else Result := T;
    end;
end;

// wgg This creates a thread sending keys to a dll process in the main body
// Once the thread is created, the main body runs in parallel.
// But the thread does a sleep several times to stage the calculator
// we should not return, until the calc is complete.
procedure ExecKey(s: string; action: TThreadMethod);
var
  t: TThread;
begin
  t:= TKeyPressThread.Create(s, action);
  t.WaitFor;                              // wgg 11/2006 Let the keys be sent then return
  t.Free;
end;

function Emu48LoadFile(F: TFileName): Boolean;
begin
  EmuCallBackDebugNotify(nil);           // wgg EMU will call our DebugNotify during a load
  WaitShutDown;                          // wgg make sure EMU is ready for it
  Result := not EmuLoadObject(Pchar(F)); // because EMU turns debug off then on for loading!
  EmuCallBackDebugNotify(nil);           // we will hang due to single thread on out side if this happens
end;

function Emu48SaveFile(F: TFileName): Boolean;
begin
  EmuCallBackDebugNotify(nil);           // wgg EMU will call our DebugNotify during a load
  WaitShutDown;                          // wgg make sure EMU is ready for it
  Result := not EmuSaveObject(Pchar(F)); // because EMU turns debug off then on for loading!
  EmuCallBackDebugNotify(nil);           // we will hang due to single thread on out side if this happens
end;

procedure Emu48Close(); stdcall;
begin
  IsRunningEMU := False;
  EmuStop;
  EmuDestroy;
end;

procedure DocumentNotify(lpszFileName: PChar) stdcall;

procedure AskChangeRam(var F: TFileName; news: string);
var
  dir: string;
begin
  dir:= GetCurrentDir;
  if UpperCase(ExpandFileName(news)) <> UpperCase(ExpandFileName(F)) then
  begin
    if MsgDlg(Format(Msgs[MSG_CHANGERAM], [news]), MB_ICONWARNING + MB_YESNO) = IDYES then
    F := news;                // wgg do not set unless we have to
  end;
  SetCurrentDir(dir);
end;

var
  T: Char;
begin
  T := LimitedEmuCalculatorType;
  RamFile := string(lpszFileName);
  if T = 'G' then oIsCalc48 := True else oIsCalc48 := False;
  if oIsCalc48 then AskChangeRam(oEmu48Filename, String(lpszFileName))
  else AskChangeRam(oEmu49Filename, String(lpszFileName));
end;

procedure Emu48Init(Ram: TFileName; Port2: TFileName);
var
  Dir: string;
begin
  Dir := GetCurrentDir;
  SetCurrentDir(AppPath + 'EMU\');   // wgg so EMU can default if required
  if Port2 = '' then
    IsRunningEMU := not EmuCreate(PChar(Ram))
  else
    IsRunningEMU := not EmuCreateEx(PChar(Ram), PChar(Port2));
  ShowEmu48(False);
  Application.BringToFront;
  if IsRunningEMU then
  begin
    EmuCallBackClose(Emu48Close);
    EmuCallBackDebugNotify(nil);
    SetCurrentDir(Dir);
    EmuCallBackDocumentNotify(DocumentNotify); // wgg will callback when file opened/saved
  end
  else
    MsgDlg(Msgs[MSG_NOINITEMU], MB_ICONERROR + MB_OK);
end;

function Emu48IsActive: Boolean;
begin
  if oIsCalc48 then
  begin
    RamFile := oEmu48Filename;
    PortFile := oEmu48PortFilename;
    HPHeader := 'HPHP48';
  end
  else begin
    RamFile := oEmu49Filename;
    PortFile := '';
    HPHeader := 'HPHP49';
  end;
  if not IsRunningEMU then Emu48Init(RamFile, PortFile);
  Result := IsRunningEMU;
end;

procedure Emu48Run;
begin
  Emu48IsActive;
  WaitShutDown;
  ShowEmu48(True);
end;

function Emu48ExecuteObject(Text: string; Execute: Boolean): Boolean;
var
  //I: integer;
  s: string;
  sKeys: string;
  T: Char;
begin
  Result := False;
  if stkLock then exit;
  CheckTempFile;
  stkLock := True;
  if Emu48IsActive then
  begin
    WaitShutDown;
    s := IntToHex2(Length(Text) * 2 + 5, 5);
    RevString(s);
    s := 'D9D20' + 'C2A20' + s + BinToHexHP(Text);            // DOCOL DOCSTR  string STR-> EVAL ->STR SEMI
    if oIsCalc48 then
    begin
      s := s + '62BC1';
      if Execute then s := s + 'EB3A1';     // RGB para ejecutarlo si es necesario
      s := s + 'B2130';                     // for HP48: STR-> EVAL SEMI
      sKeys := 'O';                                        // EVAL
    end else
    begin
      s := s + '9DBB3';
      if Execute then s := s + 'CA593';     // RGB para ejecutarlo si es necesario
      s := s + 'B2130';               // for HP49: STR-> EVAL SEMI  was ->STR +'EBBB3' then SEMI
      T := EmuCalculatorType;
      if (T = '2') or (T = 'Q') then
        skeys := 'N'                                             // wgg EVAL for 49G+ or 48GII
      else
        skeys := #19'P';                                         // R Shift, EVAL
    end;
    StringToFile(HPHeader + '-C' + HexToBinHP(s), TempFile);
    Emu48LoadFile(TempFile);
    waitBusy;
    ExecKey(skeys, nil);
    waitBusy;
    //ExecKey(sKeys);
    //Sleep(600);
    DeleteFile(TempFile);
    stkLock := False;
    Result := True;
  end;
end;

procedure Emu48ClearCalc;
begin
  if oIsCalc48 then ExecKey(#16#01, nil)
  else ExecKey(#19#02, nil);
  Sleep(500);
end;

function Emu48ImportObject(F: TFileName): string;
begin
  Result := '';
  CheckTempFile;
  if Emu48IsActive then
  begin
    WaitShutDown;
    if Emu48LoadFile(F) then
    begin
      WaitShutDown;
      if Emu48ExecuteObject(chr(141) + 'STR', True) then
      begin
        Sleep(1200);
        WaitShutDown;
        if Emu48SaveFile(TempFile) then
        begin
          ExecKey(#02, nil);
          Result := HPFileToStr(TempFile);
          DeleteFile(TempFile); // ver5
        end;
      end;
    end;
  end;
end;

function Emu48ExportObject(F: TFileName; Text: string): Boolean;
begin
  Result := False;
  CheckTempFile;
  if Emu48ExecuteObject(RemoveCR(RemoveHead(Text)), False) then
  begin
    Sleep(1200);
    WaitShutDown;
    if Emu48SaveFile(TempFile) then
    begin
      if FileExists(F) then DeleteFile(F);
      Result := Windows.CopyFile(PChar(TempFile), PChar(F), False);
      DeleteFile(TempFile); // ver5
    end;
    WaitShutDown;
    ExecKey(#02, nil);
  end;
end;

procedure ShowEmu48(Visible: Boolean);
var
  hWndEmu48: HWND;
begin
  hWndEmu48 := FindWindow(nil, PChar(RamFile));
  if hWndEmu48 <> 0 then
    if Visible then
    begin
      ShowWindow(hWndEmu48, SW_SHOWNORMAL);
      SetForegroundWindow(hWndEmu48);
    end
    else
      ShowWindow(hWndEmu48, SW_HIDE);
end;

procedure Emu48CheckRunning(Is48: Boolean);
begin
  if IsRunningEMU then
  begin
    Emu48Exit;
    Emu48IsActive;
  end;
end;

procedure Emu48Exit;
begin
  EmuStop;
  EmuDestroy;
end;

procedure Emu48RunProgram(Prog: string; Param: string; BreakPoint: Integer);
var
  P: Integer;
  S: string;
begin
  if BreakPoint <> 0 then
  begin
    with TStringList.Create do
    try
      Text := Prog;
      S := Strings[BreakPoint];
      P := Pos(#171, S);
      if P = 0 then S := 'HALT ' + S
      else S := Copy(S, 1, P) + ' HALT ' + Copy(S, P, Length(S));
      Strings[BreakPoint] := S;
      Prog := Text;
    finally
      Free;
    end;
    Emu48ExecuteObject('41.01 TMENU', True);
    WaitShutDown;
  end;
  if Param <> '' then
  begin
    Emu48ExecuteObject(Param, True);
    WaitShutDown;
  end;
  Emu48ExecuteObject(RemoveCR(RemoveHead(Prog)), True);
  ShowEmu48(True);
end;

procedure Emu48RunProgramStep(Prog: string; Param: string);
begin
  Emu48ExecuteObject('41.01 TMENU', True);
  WaitShutDown;
  if Param <> '' then
  begin
    Emu48ExecuteObject(Param, True);
    WaitShutDown;
  end;
  Emu48ExecuteObject(RemoveCR(RemoveHead(Prog)), False);
  WaitShutDown;
  Sleep(1200);
  ExecKey('A', nil);
  ShowEmu48(True);
end;

{ TKeyPressThread }

constructor TKeyPressThread.create(s: string; action: TThreadMethod);
begin
  inherited create(true);
  self.action:= action;
  self.s:= s;
  freeOnterminate:= false;                   // changed to false, so we can WaitFor the thread above
  resume;
end;

procedure TKeyPressThread.execute;
const
//
// Codes for HP49
//
// wgg: There are program calls for #17 (a red shift), #27 (ON) and #19 (after autoload)
//      These values do not make any sense that I can see and they conflict with published key tables
//
//      I make the following definitions:
//      #01=del,  #02=bksp,  #9=alpha,  #13=ENTER,  #16=left-shift,  #19=right-shift,  #27=ON
//
   outv49: array [1..47] of integer = (5,  5,  5,  5,  5,  5,  5,  4,  3,  2,  1,  0,  4,  3,  2,  1,  4,  3,  2,  1,  0,  4,  3,  2,  1,  0,  7,  3,  2,  1,  0,  7,  3,  2,  1,  0,  7,  3,  2,  1,  0,  0,  3,  2,  1,  0,  0);
    inv49: array [1..47] of integer = (0,  1,  2,  3,  4,  5,  7,  7,  7,  7,  7,  7,  6,  6,  6,  6,  5,  5,  5,  5,  5,  4,  4,  4,  4,  4,  3,  3,  3,  3,  3,  2,  2,  2,  2,  2,  1,  1,  1,  1,  1, 15,  0,  0,  0,  0,  6);
   keyv49=                            'A'+'B'+'C'+'D'+'E'+'F'+'G'+'H'+'I'+'J'+'K'+'L'+'M'+'N'+'O'+'P'+'Q'+'R'+'S'+'T'+'U'+'V'+'W'+'X'+'Y'+'Z'+#9+ '7'+'8'+'9'+'*'+#16+'4'+'5'+'6'+'-'+#19+'1'+'2'+'3'+'+'+#27+'0'+'.'+' '+#13+#02; // last two are ENTER BKSP

//
//    wgg - Codes for HP-48
//
   outv48: array [1..49] of integer = (1,  8,  8,  8,  8,  8,  2,  7,  7,  7,  7,  7,  0,  6,  6,  6,  6,  6,  3,  5,  5,  5,  5,  5,  4,  4,  3,  3,  3,  3,  3,  2,  2,  2,  2,  2,  1,  1,  1,  1,  1,  0,  0,  0,  0,  0,  4,  4,  4);
    inv48: array [1..49] of integer = (4,  4,  3,  2,  1,  0,  4,  4,  3,  2,  1,  0,  4,  4,  3,  2,  1,  0,  4,  4,  3,  2,  1,  0,  3,  2,  5,  3,  2,  1,  0,  5,  3,  2,  1,  0,  5,  3,  2,  1,  0, 15,  3,  2,  1,  0,  4,  1,  0);
   keyv48=                            'A'+'B'+'C'+'D'+'E'+'F'+'G'+'H'+'I'+'J'+'K'+'L'+'M'+'N'+'O'+'P'+'Q'+'R'+'S'+'T'+'U'+'V'+'W'+'X'+'Y'+'Z'+#9+ '7'+'8'+'9'+'/'+#16+'4'+'5'+'6'+'*'+#19+'1'+'2'+'3'+'-'+#27+'0'+'.'+' '+'+'+#13+#01+#02; // last three are ENTER DEL bkspc
var
  i: integer;
  c: char;
begin
  c:= #0;
  for i:= 1 to length(s) do
  begin
    if s[i]=c then sleep(250); // avoid problem when the same key is press twice in a row
    c:= s[i];
    if LimitedEmuCalculatorType ='X' then                        // wgg - its HP49
    begin
      EmuSimulateKey(true, outv49[pos(s[i], keyv49)], 1 shl  inv49[pos(s[i], keyv49)]);  //Sleep(0);
      EmuSimulateKey(False, outv49[pos(s[i], keyv49)], 1 shl  inv49[pos(s[i], keyv49)]); //Sleep(0);
    end else                                     // wgg - else its a HP48
    begin
      EmuSimulateKey(true, outv48[pos(s[i], keyv48)], 1 shl  inv48[pos(s[i], keyv48)]);  //Sleep(100);
      EmuSimulateKey(False, outv48[pos(s[i], keyv48)], 1 shl  inv48[pos(s[i], keyv48)]); //Sleep(50);
    end;
  end;
  if assigned(action) then
  Begin
    sleep(600);
    Synchronize(action);
  end;
end;

end.
