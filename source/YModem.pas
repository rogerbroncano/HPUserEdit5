{ file YModem.pas, created on 7/11/2000 by Cyrille de Brébisson

//  Changes marked with WGG are copyright 2002, William G. Graves

{$B-,H+,X+,J-} //Essential directives

{ wgg notes:
  file to HP49               file from HP49
  'P'                           'G'
  .put                          .get
  TX.Execute                    RX.Execute
}

unit YModem;

interface

uses Windows, Classes, SysUtils, forms, {CmStatus,} controls, ScktComp,
     HPUtils;                                                          // wgg removed hyperstr

type
  TYModemCallBack = procedure(Status:AnsiString; operation, v1, v2, v3: integer) of object;

const
//  Debug = true;
  Debug = false;
  SAVETOSTRING: DWORD = MAXINT;           // wgg used as a flag meaning save to RXFileText
  Disconnect = 'Disconnect';
  NUL = #0;
  SOH = #1;                               //Start of header of 128 byte block
  STX = #2;                               //Start of header of 1K block
  EOT = #4;                               //End of transmission
  ACK = #6;                               //Packet OK
  NAK = #21;                              //Packet not OK
  CAN = #24;                              //Cancel
  CRC = #67;                              //CRC transfer
  HPCRC = #68;

procedure setDelimiter(s: string);                                   // wgg
function ListComm: string;                                           // wgg

type
  TYModemRX = class(TThread)
  private
    Port:THandle;
    FileName: TFileName;
    FileSize: DWORD;
    StatusCallBack:TYModemCallBack;
    Msg:AnsiString;
    o, v1, v2, v3: integer;
    TryChk: boolean;
  protected
    procedure Execute; override;
    procedure DoCallBack;
    procedure ShowStatus(S:AnsiString; o: integer; v1 : integer = 0; v2: integer = 0; v3: integer = 0);
  public
    SendOK: boolean;
    RXFileText: string;                                              // wgg for blind transfers
    constructor Create(FPort:THandle; FFileName: TFileName; FStatus: TYModemCallBack; FileSize: DWORD);
  end;

type
  TYModemTX = class(TThread)
  private
    Port: THandle;
    FileName: TFileName;
    StatusCallBack: TYModemCallBack;
    Msg: AnsiString;
    o, v1, v2, v3: integer;
    Block128: boolean;                                         // wgg added
  protected
    procedure Execute; override;
    procedure DoCallBack;
    procedure ShowStatus(S:AnsiString; o: integer; V1: integer = 0; v2: integer = 0; v3: integer = 0);
  public
    SendOK: boolean;
    constructor Create(FPort: THandle; FFileName: TFileName;
                FStatus: TYModemCallBack; Use128: boolean=false);         // wgg added Use128
  end;

type
  TSRX = class(TThread)                      // wgg simple (not xmodem) receive
  private
    Port:THandle;
    RXFileText: string;
    FileSize: DWORD;
    StatusCallBack:TYModemCallBack;
    Msg:AnsiString;
    o, v1, v2, v3: integer;
    TryChk: boolean;
  protected
    procedure Execute; override;
    procedure DoCallBack;
    procedure ShowStatus(S:AnsiString; o: integer; v1 : integer = 0; v2: integer = 0; v3: integer = 0);
  public
    SendOK: boolean;
    constructor Create(FPort:THandle; FStatus: TYModemCallBack; FileSize: DWORD);
  end;

const
  ImDirectory = 0;

type
  TXModemServer = class;
  TXPObject = class;
  TItemList= array of TXPObject;
  TXPObject = class
  private
    FItems: TItemList;
    FItemsUpToDate: boolean;
    function GetItemsList: TItemList;
  public
    parent: TXPObject;
    Caption: string;
    size: integer;
    ImageIndex: integer;
    XModemServer: TXModemServer;
    destructor Destroy; override;
    property Items: TItemList read GetItemsList;
    function IsDirectory: boolean;
    Function GetfullPathName: string;
    Procedure FreeSubObjects;
  end;

  TStatusReport = procedure(sender: TObject; messages: string; o, v1, v2, v3: integer) of object;
  TXModemServer = class
  private
    Fstatus: string;
    procedure Setstatus(const Value: string);
  private
    ClientSocket: TClientSocket;
    port: THandle;
    Fcom: string;
    FSpeed: string;
    FStatusReport: TStatusReport;
    //ReportForm: TFCmStatus;
    FVersion: string;
    NotStarted: boolean;
    procedure Setcom(const Value: string);
    Procedure SendCommandPacket(s: string);
    function GetCommandPacket(timeout: integer = 2000): string;
    Procedure SendCommand(c: char);
    function DetectDevice: string;
    procedure SetSpeed(const Value: string);
    property status: string read Fstatus write Setstatus;
    procedure ClientSocket1Connect(Sender: TObject; Socket: TCustomWinSocket);
    procedure ClientSocket1Disconnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure TestConnected;
  public
    FileText: string;                                              // wgg for blind transfers
    constructor create;
    Destructor Destroy; override;
    Procedure changeDirectory(path: TFileName);
    Procedure PurgeFile(FileName: TFileName);
    Procedure status2(s: string; o, v1, v2, v3: integer);
    procedure Rename(f1, f2: TFileName; IsDir: boolean);        // wgg added IsDir
    Procedure ExecFile(f: TFileName);
    Procedure Kill;
    procedure DoCommand(s: string);                                // wgg
    function put(f, PCName: TFileName): boolean;
    function DownLoad(PCName: TFileName): boolean;                       // wgg
    function UpLoad(PCName: TFileName): boolean;                         // wgg
    function Get(f, PCName: TFileName; FileSize: integer): boolean;
    Function GetDirList(Path: TFileName): TItemList;
    Function Connected: boolean;
    function GetMemory: string;                                    // wgg
    function SetDowncom(const Value: string): boolean;             // wgg
    function ScreenCapture: string;                                // wgg
    function CheckHPHP(f: TFileName): boolean;                     // wgg
    Property Version: string read FVersion;
    property com: string read Fcom write Setcom;
    Property Speed: string read FSpeed write SetSpeed;
    property StatusReport: TStatusReport read FStatusReport write FStatusReport;
  end;

const
  opError = 0;
  opMessage = 1;
  opPercent = 2;
  opEnd = 3;
  opCancelState = 4;
var
  ListCommDelim: string;

implementation

uses {LogIt,} Registry, {HPDir} DlgTransfer, Globals;

// wgg used to replace Hyperstr - ChkSumXY:
// Simple, additive 1 byte checksum used in X/Ymodem communication protocols.
// wgg XModem checksum is a simple sum of bytes mod 256
function ChkSumXY(s: string): byte;
var
  i: integer;
begin
  result:= 0;
  for i:=1 to length(s) do
    result:= result + ord(s[i]);
end;

// wgg standard CRC16
// CRC16: Standard, table based CRC16 calculation. Initial string MUST use IniCRC:=-1 (or $FFFF).
//   To add subsequent strings to the calcs, use IniCrc:= Prior CRC16 resultant.
//   Final resultant must be inverted using NOT operator to conform to specs.
//   Equivalent Pascal implementation might be:
//    for I:=1 to Length(Source) do
//      CRC:=((CRC SHR 8) AND $FF) XOR CRCTable[(CRC XOR Source[I]) AND $FF];
// function CRC16(const IniCRC:Word; Source:AnsiString): Word;
//
// wgg I have not detected a use with HP49
function CRC16(CRCStart: word; s: String): word;
const
  IntegerCRCTable: Array[0..255] of Integer = (
    $0000, $C0C1, $C181, $0140, $C301, $03C0, $0280, $C241,
    $C601, $06C0, $0780, $C741, $0500, $C5C1, $C481, $0440,
    $CC01, $0CC0, $0080, $CD41, $0F00, $CFC1, $CE81, $0E40,
    $0A00, $CAC1, $C881, $0B40, $C901, $09C0, $0880, $C841,
    $D801, $18C0, $1980, $D941, $1B00, $DBC1, $DA81, $1A40,
    $1E00, $DEC1, $DF81, $1F40, $DD01, $1DC0, $1C80, $DC41,
    $1400, $D4C1, $D581, $1540, $D701, $17C0, $1680, $0641,
    $D201, $12C0, $1380, $D341, $1100, $D1C1, $D081, $1040,
    $F001, $30C0, $3180, $F141, $3300, $F3C1, $F281, $3240,
    $3600, $F6C1, $F781, $3740, $F501, $35C0, $3480, $F441,
    $3C00, $FCC1, $FD81, $3D40, $FF01, $3FC0, $3E80, $FE41,
    $FA01, $3AC0, $3B80, $FB41, $3900, $F9C1, $F881, $3840,
    $2800, $E8C1, $E981, $2940, $EB01, $2BC0, $2A80, $EA41,
    $EE01, $2EC0, $2F80, $EF41, $2D00, $EDC1, $EC81, $2C40,
    $E401, $24C0, $2580, $E541, $2700, $E7C1, $E681, $2640,
    $2200, $E2C1, $E381, $2340, $E101, $21C0, $2080, $E041,
    $A001, $60C0, $6180, $A141, $6300, $A3C1, $A281, $6240,
    $6600, $A6C1, $A781, $6740, $A501, $65C0, $6480, $A441,
    $6C00, $ACC1, $AD81, $6D40, $AF01, $6FC0, $6E80, $AE41,
    $AA01, $6AC0, $6B80, $AB41, $6900, $A9C1, $A881, $6840,
    $7800, $B8C1, $B981, $7940, $BB01, $7BC0, $7A80, $BA41,
    $BE01, $7EC0, $7F80, $BF41, $7D00, $BDC1, $BC81, $7C40,
    $B401, $74C0, $7580, $B541, $7700, $B7C1, $B681, $7640,
    $7200, $B2C1, $B381, $7340, $B101, $71C0, $7080, $B041,
    $5000, $90C1, $9181, $5140, $9301, $53C0, $5280, $9241,
    $9601, $56C0, $5780, $9741, $5500, $95C1, $9481, $5440,
    $9C01, $5CC0, $5D80, $9041, $5F00, $9FC1, $9E81, $5E40,
    $5A00, $9AC1, $9B81, $5B40, $9901, $59C0, $5880, $9841,
    $8801, $48C0, $4980, $8941, $4B00, $8BC1, $8A81, $4A40,
    $4E00, $8EC1, $8F81, $4F40, $8D01, $4DC0, $4C80, $8C41,
    $4400, $84C1, $8581, $4540, $8701, $47C0, $4680, $8641,
    $8201, $42C0, $4380, $8341, $4100, $81C1, $8081, $4040
    );
type
  CRCRecord = Record
      Low: Byte;
      High: Byte;
  end;
var
  i, j: Integer;
  CRCTable: Array[0..255] of CRCRecord absolute IntegerCRCTable;
  CRC: CRCRecord;

begin
  CRC.High:= (CRCStart shr 8) And $FF; CRC.Low:= CRCStart and $FF;
  for i:= 1 to Length(s) do
  begin
    j:= Ord(s[i]) xor CRC.Low;
    CRC.Low:= CRCTable[j].Low xor CRC.High;
    CRC.High:= CRCTable[j].High;
  end;
  result:= (CRC.High shl 8) or CRC.Low;
end;

// wgg compute XModem style CRC16
// may need to add two final bytes of zero and recompute
// CRCXY: 16-bit CRC variant used in the popular X/YModem communication protocols.
//   Initial string MUST use IniCRC:= 0. To include additional strings, use IniCrc:= Prior resultant.
// function CRCXY(const IniCRC: Word; Source: AnsiString): Word;
//
// wgg I have not detected a use with HP49
function CRCXY(const CRCStart: word; s: String): word;
begin
  result:= CRC16(CRCStart, s);  // wgg obviously wrong!
end;

// wgg a substitute for Hyperstr ListComm
procedure setDelimiter(s: string);
begin
  ListCommDelim:= s;
end;

function ListComm: string;
var
  r: TRegistry;
  sList: TStringList;
  i: integer;
begin
  result:= '';
  r:= TRegistry.Create;
  r.RootKey:=HKEY_LOCAL_MACHINE;
  sList:=TStringList.Create;
  if r.OpenKey('Hardware\DeviceMap\SerialComm', false) then
  begin
    r.GetValueNames(sList as TStrings);
    for i:= 0 to sList.Count-1 do
      result:= result+r.ReadString(sList.Strings[i])+ListCommDelim;
  end;
end;

procedure Error(s: string);
begin
  raise Exception.Create('Error ('+s+')');
end;

const
  conerr: string = 'Connection error.'#13#10'Please check your connections.';

Procedure Eror2; // this function is called Eror2 and not Error2 bacause I was pissed of doing some searches on Error and finding all this
// things I did not care about.
begin
    TransferDialog.SetConnected(false);     // wgg might be reset via refresh/timer cycle via SendCommand Packet
    raise Exception.Create(ConErr);
end;

/// reads up to 'Length' bytes from 'com' and copy them in 'buf'. Returns the number of read bytes. Throws an exception if eror
function ReadComm(port: THANDLE; var buf: string): integer;
var
  NbRead: DWORD;	// number of bytes read
  i: integer;
begin
  if not ReadFile(Port, (@(buf[1]))^, Length(buf), NbRead, nil) then	// exception if read eror
    Eror2;
  for i:=NbRead+1 to Length(buf) do
    buf[i] := #0;
  result:= NbRead;
end;

/// writes up to 'Length' bytes from 'buf' to 'com'. Throws an exception if eror
Procedure WriteComm(port: THANDLE; const buf: string);
var
  NbWrite: DWORD;	// number of bytes read
begin
  if not WriteFile(Port, (@(buf[1]))^, Length(buf), NbWrite, nil) then	// exception if write eror
    Eror2;
end;

/// open the com specified by ComName. returns a handle on this com. Throws an exception if eror
function OpenCom(const ComName: string; baud: integer): THANDLE;
var
  PortDCB: TDCB;	// comm configuration data structure
  port: THandle;
begin
  TransferDialog.StatusPanel.Caption := 'Conectando...'; //FHPDir.Panel1.Visible:= true;  Application.ProcessMessages;            // wgg
  // open com
  Port := CreateFile(pchar(ComName), GENERIC_READ or GENERIC_WRITE, 0, nil, OPEN_EXISTING, 0, 0);
  if Port=0 then Eror2
  else
  begin
    // configure com
    PortDCB.DCBlength := sizeof(DCB);
    GetCommState(Port, PortDCB);
    //change the contents
    PortDCB.BaudRate := baud;
    //	PortDCB.BaudRate = 19200;
  {  PortDCB.fBinary := TRUE;
    PortDCB.fParity := FALSE;
    PortDCB.fOutxCtsFlow := FALSE;
    PortDCB.fOutxDsrFlow := FALSE;
    PortDCB.fDtrControl := DTR_CONTROL_DISABLE;
    PortDCB.fDsrSensitivity := FALSE;
    PortDCB.fTXContinueOnXoff := TRUE;
    PortDCB.fOutX := FALSE;
    PortDCB.fInX := FALSE;
    PortDCB.fErrorChar := FALSE;
    PortDCB.fNull := FALSE;
    PortDCB.fRtsControl := RTS_CONTROL_DISABLE;
    PortDCB.fAbortOnError := FALSE; }
    PortDCB.Flags := $5091;
    PortDCB.ByteSize := 8;
    PortDCB.Parity := NOPARITY;
    PortDCB.StopBits := ONESTOPBIT;
    // do the configuration
    if not SetCommState(Port, PortDCB) then Eror2;
  end;
  result:= port;
  TransferDialog.StatusPanel.Caption := ''; //FHPDir.Panel1.Visible:= false;  Application.ProcessMessages;            // wgg
end;

/// close the 'com'. Throws an exception if eror
procedure CloseCom(port: THANDLE);
begin
  if 0<>Port then
    try
      CloseHandle(Port);
    except
    end;
end;

// clear a com line
procedure FlushPort(port: THandle);
begin
  PurgeComm(Port, PURGE_RXCLEAR);  //clear receive buffer
end;

/// set the timeout time for 'com'. When reading, the timeout is GlobalTimeOut+CharTimeOut*NbChrToRead. Throws an exception if eror
procedure SetRxTime(port: THANDLE; GlobalTimeOut, CharTimeOut: integer);
var
  CommTimeouts: TCOMMTIMEOUTS;						// data structure
begin
  GetCommTimeouts(Port, CommTimeouts);			// get the current datastructure
  CommTimeouts.ReadIntervalTimeout := 0;                // set our perticular value
  CommTimeouts.ReadTotalTimeoutMultiplier := CharTimeOut;
  CommTimeouts.ReadTotalTimeoutConstant := GlobalTimeOut;
  CommTimeouts.WriteTotalTimeoutConstant := 100;
  CommTimeouts.WriteTotalTimeoutMultiplier := 10;

  if not SetCommTimeouts(Port, CommTimeouts) then		// and set the value in the driver
    Eror2;
end;

/// wait for a clear line for .5s
procedure ClearLine(port: THandle; timeout1, timeout2: integer);
var
  s: string;
begin
  SetRxTime(Port, 200, 0);      //set response wait time
  repeat
    s:=#0#0#0#0#0#0#0#0#0#0;
    FlushPort(port);
    ReadComm(port, s);
  until s=#0#0#0#0#0#0#0#0#0#0;
  SetRxTime(Port, timeout1, timeout2);      //set response wait time
end;

procedure log(s: string);
begin
  if debug then
    {FLog.Memo1.Lines.Add(s);}
end;
// display a % competion message to the user
type cbstat = procedure (S:AnsiString; o: integer; v1 : integer = 0; v2: integer = 0; v3: integer = 0) of object;

Procedure ShowProg(o: tobject; BytesDone, BytesTot, TimeStart: integer; op: string; ShowStatus: cbstat);
begin
  if BytesTot>0 then
  begin
    if BytesTot<10000 then
      ShowStatus(inttostr(BytesDone)+'/'+inttostr(BytesTot)+' bytes'#13#10+     // wgg used to start   op+' Packet '+inttostr(PktNum)+#13#10+
                 '('+inttostr((BytesDone*100) div BytesTot)+'%)'#13#10+
                 inttostr(BytesDone div integer((integer(GetTickCount)-TimeStart) div 1000+1)div 1)+' byte/s'
                 , opPercent, BytesDone, BytesTot, 0)
    else
      ShowStatus(inttostr(BytesDone div 1024)+'/'+inttostr(BytesTot div 1024)+' Kbytes'#13#10+
                 '('+inttostr(((BytesDone-1)*100) div BytesTot)+'%)'#13#10+
                 inttostr(BytesDone div integer((integer(GetTickCount)-TimeStart) div 1000+1)div 1024)+' Kbyte/s'
                 , opPercent, BytesDone, BytesTot, 0);
  end;
end;

// min of 2 integers
function min(a, b: integer): integer;
begin
  if a<b then result:= a else result:= b;
end;

// get an integer as a 4 chr string
Function IntToStr32(i: integer): string;
Begin
  result:= chr((i shr 0) and $FF) + chr((i shr 8) and $FF) + chr((i shr 16) and $FF) + chr((i shr 24) and $FF);
end;

{ TSRX }
// wgg create the simple receive thread
constructor TSRX.Create(FPort:THandle; FStatus: TYModemCallBack; FileSize: DWORD);
begin
  self.TryChk:= false;                        // wgg True used to be for XpandHW
  Self.FileSize:= FileSize;
  Port := FPort;
  RXFileText:= StringOfChar(#00, 1100);             // big enough for either calc
  StatusCallBack:= FStatus;
  inherited Create(False);
end;

// call back
procedure TSRX.DoCallBack;
begin
  if assigned(StatusCallBack) then
    StatusCallBack(Msg, o, v1, v2, v3)
end;

// wgg the working part of the simple receive
procedure TSRX.Execute;
var
  c: string;
begin
  SendOK:= false;
  try
    ShowStatus('', opPercent, 10, 100, 100);
    FileSize:= (131+4)*64 div 8; // wgg leading $1B nn, trailing $0D0A each line of 8 bits
    SetLength(c, 64*17+3 - FileSize);     // the extra length needed for HP49
    SetLength(RXFileText, FileSize);
    if ReadComm(port, RXFileText)=length(RXFileText) then SendOK:= true;
    if SendOK = true then
    begin
      if RXFileText[1]<>#$1B then ReadComm(port, c);   // if HP-48 string, no more to read
      ShowStatus('', opPercent, 90, 100, 100);   // just to give a sense of feedback
      Application.ProcessMessages;
      RXFileText:= RXFileText+c;
      Sleep(300);                                // just to give a sense of feedback
    end
    else RXFileText:= '';
  except
    on e: Exception do
    begin
      RXFileText:= '';
    end;
  end;
  ShowStatus('', opEnd);
end;

//--- Relay current status back to main thread
procedure TSRX.ShowStatus(S:AnsiString; o: integer; v1 : integer = 0; v2: integer = 0; v3: integer = 0);
begin
  Msg:=S;
  self.o :=o;
  self.v1:= v1;
  self.v2:= v2;
  self.v3:= v3;
  if IsConsole then  //Dedicated StatusCallBack function required to avoid
    DoCallBack       //synchronization problems
  else Synchronize(DoCallBack); //Shared StatusCallBack OK
end;

{ TYModem }
// create the XModem receive thread
constructor TYModemRX.Create(FPort:THandle; FFileName: TFileName;
       FStatus: TYModemCallBack; FileSize: DWORD);
begin
  self.TryChk:= false;                        // wgg True used to be for XpandHW
  Self.FileSize:= FileSize;
  Port := FPort;
  FileName := FFileName;
  StatusCallBack:= FStatus;
  inherited Create(False);
end;

// call back
procedure TYModemRX.DoCallBack;
begin
  if assigned(StatusCallBack) then
    StatusCallBack(Msg, o, v1, v2, v3)
end;

//--- Relay current status back to main thread
procedure TYModemRX.ShowStatus(S:AnsiString; o: integer; v1 : integer = 0; v2: integer = 0; v3: integer = 0);
begin
  Msg:=S;
  self.o :=o;
  self.v1:= v1;
  self.v2:= v2;
  self.v3:= v3;
  if IsConsole then  //Dedicated StatusCallBack function required to avoid
    DoCallBack       //synchronization problems
  else Synchronize(DoCallBack); //Shared StatusCallBack OK
end;

type
  crcs = (c16, c8, chp);
// receive the file
procedure TYModemRX.Execute;
const
  timeout = 2000;
var
  hF: THANDLE;
  TimeStart: DWORD;
  CRCFlg: crcs;
  realfilesize: DWORD;
  PktNum: integer;
  Reply: string;
  ErrCnt: integer;

  ///---  Get Data Packet. Internal XRecv procedure
  function XRecvGetIt(PacketSize: integer): boolean;
  var
    NbWrite: DWORD;
    Packet: String;
    function CrcOk: boolean;
    begin
      case CRCFlg of	        					// get the CRC and send it
        c16: result:= CRC16(0, copy(Packet, 3, PacketSize)) =
                        ord(packet[PacketSize+3])*256+ord(packet[PacketSize+4]);
        c8: result:= ChkSumXY(copy(Packet, 3, PacketSize)) = ord(packet[PacketSize+3]);
        chp: result:= StringCrc(copy(Packet, 3, PacketSize)) =
                        ord(packet[PacketSize+3])+ord(packet[PacketSize+4])*256;
        else result:= false;
      end;
    end;
  Begin
    case CRCFlg of	        					// get the CRC and send it
      c16, chp: SetLength(Packet, 2+PacketSize+2);
      c8: SetLength(Packet, 2+PacketSize+1);
    end;
    if TimeStart=0 then
      TimeStart:= GetTickCount;
    if FileSize=DWORD(SAVETOSTRING) then
      ShowProg(self, (PktNum-1)*PacketSize, PktNum*PacketSize, TimeStart, 'Received', ShowStatus)
    else
      ShowProg(self, (PktNum-1)*PacketSize, FileSize, TimeStart, 'Received', ShowStatus);
    if (Length(Packet) = ReadComm(port, Packet)) and
       (((PktNum and 255) = ord(Packet[1])) and ((255-(PktNum and 255)) = ord(Packet[2]))) and
       CrcOk then
    begin
      if FileSize=DWORD(SAVETOSTRING) then        // means save to a string
        RXFileText:= RXFileText + copy(Packet, 3, length(Packet)-3)
      else
        WriteFile(hF, (@(Packet[3]))^, min(PacketSize, FileSize-realfilesize), NbWrite, nil);
      inc(realfilesize, PacketSize);
      WriteComm(port, ACK);
      result:= true;
    End else begin
      ShowStatus(conErr, opError);
      ClearLine(port, timeout, 0);
      WriteComm(port, NAK);
      result:= false;
    end;
  End;
var
  PacketOk: boolean;
begin
  SendOK:= false;
  realfilesize:= 0;
  TimeStart := 0;
  CRCFlg := c8;
  Setlength(Reply, 1);
  hF:= 0;

  SetRxTime(port, timeout, 0);     //set response wait time
  SetupComm(Port, 2048, 2048);       //ask for these min. buffer sizes

  try
    // Open file
    if FileSize=SAVETOSTRING then   // means save to a string
      RXFileText:= ''
    else
    begin
      hF := CreateFile(pchar(FileName), GENERIC_WRITE, 0, nil, CREATE_ALWAYS,  0, 0);
      if INVALID_HANDLE_VALUE = hF then
        error('Unable to open file '+FileName+' '+inttostr(GetLastError));
    end;
    // start receiving it!
    PktNum := 0;
    WriteComm(port, NAK);
    repeat
      inc(PktNum);								// ready to receive next packet
      ErrCnt := 0;
      PacketOk := false;
      repeat				// try receiving a packet until ok or too many erors
        if Terminated then Eror2;
        ReadComm(port, Reply);				// get again packet header
        case Reply[1] of
          SOH: PacketOk := XRecvGetIt(128);
          STX: PacketOk := XRecvGetIt(1024);
          EOT: PacketOK := true;
          CAN: Eror2;
          else
            ClearLine(port, timeout, 0);
            WriteComm(port, NAK);
            inc(ErrCnt);
            if (ErrCnt>5) then Eror2;
            if (ErrCnt>2) and (CRCFlg<>c8) then
            begin
//              ShowStatus('Switching to checksum', opError);
              CRCFlg:= c8;
            end;
//            ShowStatus(ConErr, opError);
        end;
      until PacketOK;
    until Reply = EOT;

    WriteComm(port, ACK);

    if debug then
      ShowStatus(ExtractFileName(FileName)+' Received at '+inttostr(realfilesize div ((GetTickCount-TimeStart) div 1000 + 1) div 1)+' byte/s', opMessage)
    else
      ShowStatus(ExtractFileName(FileName)+' Received at '+inttostr(realfilesize div ((GetTickCount-TimeStart) div 1000 + 1) div 1024)+' Kbyte/s', opMessage);
    if FileSize<>SAVETOSTRING then   // means save to a string
      CloseHandle(hF);		// close file
    SendOK:= true;
  except
    on e: Exception do
    begin
//      showStatus(e.Message, opError);
      WriteComm(Port, CAN+CAN+CAN+CAN);
      if FileSize<>SAVETOSTRING then   // means save to a string
        CloseHandle(hF);
      DeleteFile(FileName);
      Sleep(2000);
    end;
  end;
  ShowStatus('', opEnd);
end;

// xmodem send stuff
constructor TYmodemTX.Create(FPort: THandle; FFileName: TFileName;
         FStatus: TYModemCallBack; Use128: boolean=false);        // wgg added Use128
begin
  Port:= FPort;
  FileName:= FFileName;
  StatusCallBack:= FStatus;
  Block128:= Use128;                 // wgg
  inherited Create(False);
end;

procedure TYModemTX.DoCallback;
begin
  StatusCallBack(Msg, o, v1, v2, v3);
end;

//--- Relay current status back to main thread
procedure TYModemTX.ShowStatus(S:AnsiString; o: integer; V1: integer = 0; v2: integer = 0; v3: integer = 0);
begin
  Msg:= S;
  self.o:= o;
  self.v1:= v1;
  self.v2:= v2;
  self.v3:= v3;
  if IsConsole then  //Dedicated StatusCallBack function required to avoid
    DoCallBack       //synchronization problems
  else Synchronize(DoCallBack); //Shared StatusCallBack OK
end;

/// receive a file using Xmodem store this file in 'FileName'. returns FALSE if eror
procedure TYModemTX.Execute;
const
  timeout = 2000;
var
  PktNum, ErrCnt, FileLen: integer;
  Packet, iCRC, Response: string;
  CRCFlg: crcs;
  hF: THandle;
  Start: DWord;
  StChr: char;
  realfilesize: DWORD;

  function GetIt: boolean;
  var
    NbRead: DWORD;
  begin
    if (FileLen - Integer(realfilesize)) < 1024 then SetLength(Packet, 128);
    if not ReadFile(hF, Pchar(Packet)^, length(Packet), NbRead, nil) then
    begin
      Error('Cannot read from file '+inttostr(GetLastError));
      result:= false;
    end else  result:= NbRead <> 0;
  end;

begin
  SendOK:= false;
  SetupComm(Port, 2048, 2048); //requested min. buffer sizes
  SetRxTime(Port, timeout, 0);
  hF:= 0;
  realfilesize:= 0;
  SetLength(Response, 1);

  try
    ShowStatus('Connecting ...', opMessage);
    CRCFlg := c8;
    ErrCnt:= 0;                                   // wait 10s to get syncro. we are not using a set RX time of 60 in order to test for terminason
    repeat
      ReadComm(port, Response);
      case Response[1] of
        NAK: CRCFlg := c8;
        CRC: CRCFlg := c16;
        HPCRC: CRCFlg := chp;
        CAN: Eror2;
        else
        begin
          inc(ErrCnt);
          if ErrCnt>5 then Eror2;
          if Terminated then Eror2;
        end;
      end;
    until Response[1] in [NAK, CRC, HPCRC];

    // open the file
    hF := CreateFile(pchar(FileName), GENERIC_READ, 0, nil, OPEN_EXISTING,  0, 0);
    if INVALID_HANDLE_VALUE = hF then
      error('Unable to open file '+FileName+' '+inttostr(GetLastError));
    FileLen:= GetFileSize(hF, nil);
    Start:= GetTickCount;
{ wgg there is a problem on the HP49.  After sending the object, if the padding
  is over 255 bytes in length, the sent string will not be converted to an HP object.
  xmitted data:
    HPHP49-R           version string from xmitted file
    object prologue
    object length (includes these 5 nibbles) - not all objects have this
    object data
        *
    padding to fill out last block: = total xmitted - 16  (HPHP string)
                                                    -  5  ( object prologue)
                                                    - object length (include length nibbles)
    So we will send big blocks until we get within 256 nibbles so there is never
    too much padding!
}
    SetLength(Packet, 1024);          // wgg added 128 byte modes
    StChr:= STX;                      // assume 1024 mode
    if Block128 Or (FileLen < 7*128) then SetLength(Packet, 128);   // wgg rough trade-off
    ShowStatus('Copying '+FileName, opMessage);
    PktNum := 0;
    while GetIt do   // while there is something to send. GetIt may setlength(Packet)=128
    Begin
      if Length(Packet)=128 then StChr:= SOH;
      inc(PktNum);
      ShowProg(self, realfilesize, FileLen, Start, 'Send', ShowStatus);
      ErrCnt := 0;				 				// set erors to 0
      repeat
        // Send packet
        case CRCFlg of	        					// get the CRC and send it
          c16 : icrc := copy(IntToStr32(CRC16(0, Packet)), 1, 2);
          c8 : icrc := chr(ChkSumXY(Packet));
          chp : begin icrc := copy(IntToStr32(StringCrc(Packet)), 1, 2); icrc:= icrc[2]+icrc[1]; end;
        end;
        WriteComm(Port, StChr+chr(PktNum and 255)+chr(255-(PktNum and 255)) + Packet + icrc); // send packet

        // wait for ack
        ReadComm(port, Response);
        if Terminated then Eror2;
        case Response[1] of
          NAK:
            begin
              inc(ErrCnt);							// and more erors
              if (ErrCnt>10) then Eror2;
            end;
          NUL:
            begin
              inc(ErrCnt);							// and more erors
              if (ErrCnt>10) then Eror2;
              sleep(800);
            end;
          CAN: Eror2;
          ACK: begin end;
          else
            ClearLine(port, timeout, 0);
        end;
        if ACK<>Response then
          ShowStatus(ConErr, opError);
      until (ACK=Response);            		// until ACK. In this case, we continue with next packet
      inc(realfilesize, Length(Packet));
    End;

    if debug then
      ShowStatus(ExtractFileName(FileName)+' sent at '+inttostr((FileLen) div integer((GetTickCount-Start) div 1000+1)div 1)+' byte/s', OpMessage)
    else
      ShowStatus(ExtractFileName(FileName)+' sent at '+inttostr((FileLen) div integer((GetTickCount-Start) div 1000+1)div 1024)+' Kbyte/s', OpMessage);

    ErrCnt := 0;								// sending EOT part
    repeat
    Begin
      if Terminated then Eror2;
      inc(ErrCnt);
      if (ErrCnt>10) then Eror2;
      WriteComm(Port, EOT);				                	// send eot
      ReadComm(port, Response); 			        		// wait for ack
    End until (Response[1]=ACK);                           	// until too many erors or ACK

    SendOK:= true;
    CloseHandle(hF);
  except
    on e: Exception do
    begin
      showStatus(e.Message, opError);
      WriteComm(Port, CAN+CAN+CAN);
      CloseHandle(hF);
      Sleep(2000);
    end;
  end;

  ShowStatus('', opEnd);
End;

{ TXModemServer }
procedure TXModemServer.changeDirectory(path: TFileName);
begin
  TestConnected;
  Path := Path+'\';
  while pos('\\', path)<>0 do
    Path := StringReplace(Path, '\\', '\', [rfReplaceAll]);
  Status:= 'Change current dir to '+path;
  path:= 'HOME '+StringReplace(Path, '\', ' ', [rfReplaceAll]);
  FlushPort(port);
  SendCommand('E');
  SendCommandPacket(path);
  Status:='';                                  // wgg clear status when done
end;

procedure TXModemServer.ClientSocket1Connect(Sender: TObject; Socket: TCustomWinSocket);
begin
  NotStarted:= true;
end;

procedure TXModemServer.ClientSocket1Disconnect(Sender: TObject; Socket: TCustomWinSocket);
begin
  Com:= '';
end;

function TXModemServer.Connected: boolean;
begin
  result:= Com <> '';
end;

constructor TXModemServer.create;
begin
  inherited create;
  port:= INVALID_HANDLE_VALUE;
  FCom:= '';
  TransferDialog.StatusPanel.Caption := ''; // ReportForm:= TFCmStatus.Create(application);
  ClientSocket:= TClientSocket.Create(nil);
  ClientSocket.OnConnect:= ClientSocket1Connect;
  ClientSocket.OnDisconnect:= ClientSocket1Disconnect;
  ClientSocket.Port:= 46601;
  ClientSocket.ClientType:= ctBlocking;
end;

destructor TXModemServer.destroy;
begin
  Com:= '';
  ClientSocket.free;
  TransferDialog.StatusPanel.Caption := ''; //ReportForm.Free;
  inherited;
end;

function TXModemServer.DetectDevice: string;
var
  s: TstringList;
  i: integer;
begin
  s:= TStringList.Create;
  SetDelimiter(#10);
  s.text:= ListComm;
  s.Sorted:= true;
  for i:=0 to s.count-1 do
    try
      com:= s[i];
      exit;
    except
    end;
  s.free;
  if com = '' then
    status:= 'No device detected. Check the cable connections and the calculator.';
end;

procedure TXModemServer.ExecFile(f: TFileName);
begin
  TestConnected;
  SendCommand('o');
  SendCommandPacket(f);
end;

function TXModemServer.Get(f, PCName: TFileName; FileSize: integer): boolean;
begin
  TestConnected;
  Status:= 'Requesting file '+extractFileName(f);
  SendCommand('G');
  SendCommandPacket(f);
  status:= 'Copying '+ExtractFileName(f);
  FileSize:= FileSize+9; // allow HPHP48-x for 48 calculators
  with TYModemRX.Create(Port,PCName, status2, FileSize) do
    try
      TransferDialog.StatusPanel.Caption := 'Copiando...'; //ReportForm.Execute('Copying '+extractFileName(f));
      Terminate;
      WaitFor;
      Sleep(500);
      Status:='';                                  // wgg clear status when done
    finally
      result:= SendOK;
      free;
//      Sleep(500);
    end;
end;

function TXModemServer.GetCommandPacket(timeout: integer = 2000): string;
var
  ErrCnt:Integer;
  size: string;
  resultok: boolean;
  crc: string;
begin
  size:= #0#0;
  crc:= #0;
  ErrCnt := 0;
  SetRxTime(Port, timeout, 30);      //set response wait time
  SetupComm(Port, 10000, 10000); //requested min. buffer sizes
  ResultOK:= false;
  repeat
    if ReadComm(Port, Size)=2 then
    begin
      if Size[1] = 'V' then begin result:= ''; exit; end;   // patch to detect a ready to upgrade expander...
      Log('got command packet size = '+inttostr(ord(size[1])*256+ord(size[2])));
      SetLength(Result, ord(size[1])*256+ord(size[2]));
      if length(result)>10000 then setlength(result, 10000);
      if ReadComm(port, Result)=length(result) then
      begin
        ResultOK:= (ReadComm(Port, crc)=1) and (ord(crc[1])=ChkSumXY(result));
        if Resultok then
          Log('CRC ok ')
        else
          Log('CRC pb ')
      end else
        log('cannot get the command packet');
    end else
      log('cannot get the command packet size');
    if not ResultOK then
    begin
      ClearLine(port, timeout, 30);
      inc(ErrCnt);
      WriteComm(Port, NAK);
      if ErrCnt>=4 then
        Eror2
    end;
  until ResultOK;
  WriteComm(Port,ACK);
end;

function TXModemServer.GetDirList(Path: TFileName): TItemList;
var
  s: string;
  i: integer;
begin
  TestConnected;
  SetLength(result, 0);
  changeDirectory(path);
  Status:= 'Get list of files from device';
  SendCommand('L');
  Sleep(300);
  s:= GetCommandPacket;
  i:=1;
  while i<=length(s) do
  begin
    SetLength(result, length(result)+1);
    result[high(result)]:= TXPObject.Create;
    with result[high(result)] do
    begin
      XModemServer:= self;
      FItemsUpToDate:= false;
      parent:= nil;
      // 1 byte: size n bytes: text, 2 bytes, type, 3 bytes: size, 2 bytes: crc
      Caption:= copy(s, i+1, ord(s[i]));
      i:= i+ord(s[i])+1;
      case ord(s[i])+ord(s[i+1])*256 of
        $2DCC, $2D9D: ImageIndex:= 3;
        $2A96: ImageIndex:= 0;
        $2A2C: ImageIndex:= 1;
        else
          ImageIndex:= 1;
      end;
      i:= i+2;
      size:= (ord(s[i])+ord(s[i+1])*256+ord(s[i+2])*65536+1) div 2;
      FItemsUpToDate:= false;
      i:= i+3+2;
    end;
  end;
  Status:='';                                  // wgg clear status when done
end;

procedure TXModemServer.Kill;
begin
//   TestConnected;           // wgg, do not want the error msg from this
    SendCommand('Q');         // wgg added Q command
//    Application.MessageBox('Connection closed', 'Message', MB_OK);
    TransferDialog.connected:= false;
end;

procedure TXModemServer.PurgeFile(FileName: TFileName);
begin
  TestConnected;
  SendCommand('E');
  SendCommandPacket(''''+FileName+''' IFERR PURGE THEN PGDIR END');   // wgg deal with directories
end;

// wgg screen capture from HP48 or HP49
function TXModemServer.ScreenCapture: string;
var
  Filesize: integer;
  b: integer;
begin
  b:= 0;
  Status:= 'Capturing screen';
  FileSize:= 0;    // wgg will be fixed in .execute
  with TSRX.Create(Port, status2, FileSize) do
    try
      //RGB //b:= ReportForm.Execute('Capturing Screen');
      Terminate;
      WaitFor;
    finally
      if b<>mrOK then RXFileText:= '';
      result:= RXFileText;
      free;
    end;
end;

// wgg special download procedure for download via XRECV
function TXModemServer.DownLoad(PCName: TFileName): boolean;
begin
  status:= 'Copying '+ExtractFileName(PCName);
  with TYModemTX.Create(Port, PCName, status2, true) do          // wgg true+128 byte blocks
    try
      TransferDialog.StatusPanel.Caption := 'Copiando...'; //ReportForm.Execute('Copying '+PCName);
      Terminate;
      WaitFor;
      //Sleep(1000);
      Status:='';                                  // wgg clear status when done
    finally
      result:= SendOK;
      free;
    end;
end;

// wgg special upload procedure for upload via XSEND
function TXModemServer.UpLoad(PCName: TFileName): boolean;
begin
  status:= 'Copying '+ExtractFileName(PCName);
  with TYModemRX.Create(Port, PCName, status2, SAVETOSTRING) do      // wgg file size will have extra padding
    try
      TransferDialog.StatusPanel.Caption := 'Copiando...'; //ReportForm.Execute('Copying '+PCName);
      Terminate;
      WaitFor;
    finally
      result:= SendOK;
      FileText:= RXFileText;
      free;
      // Sleep(1000);
    end;
end;

// wgg check that the HPHP4x-x string matches the calculator
function TXModemServer.CheckHPHP(f: TFileName): boolean;
var
  s: string;
  sHP: string;
  NbRead: DWORD;
  hF: THANDLE;
begin
  result:= false;
  setlength(s, 8);
  hF := CreateFile(pchar(f), GENERIC_READ, 0, nil, OPEN_EXISTING,  0, 0);
  if hF = INVALID_HANDLE_VALUE then
    error('Unable to open file '+f+' '+inttostr(GetLastError))
  else
    if not ReadFile(hF, Pchar(s)^, length(s), NbRead, nil) then
      Error('Cannot read from file '+f+inttostr(GetLastError))
    else begin
      if not oIsCalc48 then sHP:= 'HPHP49'
      else sHP:= 'HPHP48';
      if copy(s, 1, length(sHP)) = sHP then result:= true
      else if Application.MessageBox(pchar(f+#13#10#13#10'is a '+copy(s, 3, 4)
              +' file and does not match the calculator.'#13#10
              +'This may damage the calculator contents.'#13#10#13#10
              +'Do you wish to continue?'), pchar('Warning'), MB_OKCANCEL)
              = idOK then result:= true;
    end;
  CloseHandle(hF);
end;

function TXModemServer.put(f, PCName: TFileName): boolean;
begin
  TestConnected;
  result:= false;
  if Not CheckHPHP(PCName) then exit;    // wgg check for file type matching
  if UpperCase(ExtractFileExt(f))='.HP' then f:=ChangeFileExt(f, '');  // wgg remove any .hp extension
  Status:= 'Sending PUT command';
  SendCommand('P');
  SendCommandPacket(f);
  status:= 'Copying '+ExtractFileName(f);
  // wgg force 128 for all HP-49 xfers
  // we can use 1024 and then run FixObj but if we send a duplicate named file
  // the calc puts it into name.1,  name.2 etc and then it does not get fixed
  with TYModemTX.Create(Port, PCName, status2, false) do
    try
      TransferDialog.StatusPanel.Caption := 'Copiando...'; //ReportForm.Execute('Copying '+f);
      Terminate;
      WaitFor; //fiddle while the modem burns
      result:= SendOK;
      // Sleep(1000);
      // wgg we used to fix up 49 files but now the .Execute will
      // make sure no more than 128 bytes extra are sent.
      Status:='';                                  // wgg clear status when done
    finally
      free;
    end;
end;

procedure TXModemServer.Rename(f1, f2: TFileName; IsDir: boolean);
begin
  TestConnected;
  sendCommand('E');
  // wgg added directory stuff
  if isDir then SendCommandPacket(''''+f1+''' DUP RCL SWAP PGDIR '''+f2+''' STO ')
  else SendCommandPacket(''''+f1+''' DUP RCL SWAP PURGE '''+f2+''' STO ');
  Sleep(1000);
end;

//wgg get memory state from calc
function TXModemServer.GetMemory: string;                                    // wgg
begin
  SendCommand('M');
  Sleep(300);
  result:= GetCommandPacket;
end;

// wgg a public procedure to send a calculator command
procedure TXModemServer.DoCommand(s: string);
begin
  TestConnected;
  SendCommand('E');
  SendCommandPacket(s);
end;

procedure TXModemServer.SendCommand(c: char);
begin
  ClearLine(port, 1000, 30);      //clear receive buffer
  WriteComm(port, c);
  Sleep(20);
end;

procedure TXModemServer.SendCommandPacket(s: string);
var
  ErrCnt: Integer;
  C: string;
begin
  ErrCnt := 0;
  s:= chr(length(s) div 256)+chr(length(s) and $ff)+s+chr(ChkSumXY(s));
  SetRxTime(Port, 1000, 0);      //set response wait time
  SetupComm(Port, 1029, 1029); //requested min. buffer sizes
  repeat
    WriteComm(Port, s);
    c:= #0;
    ReadComm(Port, C);
    if C[1]<>ACK then
    begin
      Inc(ErrCnt);
      if ErrCnt>4 then  Eror2;
      Status:= ConErr;
      ClearLine(port, 1000, 0);
    end;
  until C=ACK;
  TransferDialog.Setconnected(true);               // wgg
end;

procedure TXModemServer.Setcom(const Value: string);
const
  tname: string='$$$t';
  revision: string='Revision #';
var
  s: string;
begin
 // Fcom = Uppercase(Value) then exit;                 // wgg
  try
    CloseCom(port);
  finally
    port := 0;
  end;
  Fcom := Uppercase(Value);
  ClientSocket.Active:= false;

  if FCom = 'AUTO' then
  begin
    DetectDevice;
    exit;
  end;

  if (FCom <> 'AUTO') and (FCom<>'') and (FSpeed<>'') then
    try
      Status:= 'Opening Comm '+FCom;
      Port := OpenCom(FCom, strtoint(FSpeed));
      SendCommand('V');
      FVersion:= GetCommandPacket(500);
      TransferDialog.CalcTypeString := '';
      Transferdialog.CalcVersion:= '';
      Status:= 'Device connected on '+fcom;
      SendCommand('E');
      SendCommandPacket('VERSION DROP '''+tname+''' STO');
      if Get(tname, tname, 100) then
      begin
        s:= FileToString(tname);
        DeleteFile(tname);
        TransferDialog.CalcTypeString:= copy(s, 5, 2);                  // wgg 2 digit calc number
        if copy(s, 1, 6)='HPHP48' then TransferDialog.CalcVersion:= copy(s, 8, 1)
        else
        begin
          s:= copy(s, pos(revision, s)+length(revision), maxint);
          TransferDialog.CalcVersion:= copy(s, 1, pos('@', s)-1);
        end;
      end;
      PurgeFile(tname);
      FVersion:= FVersion + '   ROM: '+TransferDialog.CalcVersion;
    except
      Fcom := '';
      error('The connectivity kit is unable to open the communication com :'+Value)
    end;
end;

function TXModemServer.SetDowncom(const Value: string): boolean;
begin
  result:= true;
  if Fcom = Uppercase(Value) then exit;
  try
    CloseCom(port);
  finally
    port := 0;
  end;
  Fcom := Uppercase(Value);
  ClientSocket.Active:= false;

  if FCom = 'AUTO' then
  begin
    Application.MessageBox(pchar('Com port cannot be auto for this operation'),
                            pchar('Com Setting Error'));
    result:= false;
    exit;
  end;

  if (FCom <> 'AUTO') and (FCom<>'') and (FSpeed<>'') then
    try
      Status:= 'Opening Comm '+FCom;
      Port := OpenCom(FCom, strtoint(FSpeed));
      Status:= 'Device connected on '+fcom;
      ClearLine(Port, 100, 2);                  // very important to ScreenCapture
    except
      Fcom := '';
      error('The connectivity kit is unable to open the communication com :'+Value);
      result:= false;
    end;
end;

procedure TXModemServer.SetSpeed(const Value: string);
var
  fcom: string;
begin
  if FSpeed = Value then exit;
  fcom:= com;
  com:= '';
  FSpeed := Value;
  com:= fcom;
end;

procedure TXModemServer.Setstatus(const Value: string);
begin
  Fstatus := Value;
  if assigned(StatusReport) then
    StatusReport(self, Value, 0, 0, 0, 0);
end;

procedure TXModemServer.status2(s: string; o, v1, v2, v3: integer);
begin
  TransferDialog.Action(s, o, v1, v2, v3); //ReportForm.Action(s, o, v1, v2, v3);
end;

procedure TXModemServer.TestConnected;
begin
  if not Connected then
    error('No device connected. Check you are in Xmodem server (RShift RightArrow)')
end;

{ TXPObject }

destructor TXPObject.destroy;
begin
  FreeSubObjects;
  inherited;
end;

procedure TXPObject.FreeSubObjects;
var
  i: integer;
begin
  for i:=0 to high(FItems) do
    FItems[i].free;
  SetLength(FItems, 0);
  FItemsUpToDate:= false;
end;

function TXPObject.GetfullPathName: string;
begin
  if parent=nil then
    result:= Caption
  else
    result:= parent.GetfullPathName+'\'+Caption;
end;

function TXPObject.GetItemsList: TItemList;
var
  i: integer;
begin
  if not FItemsUpToDate then
  Begin
    FItems:= XModemServer.GetDirList(GetfullPathName);
    for i:=low(fitems) to high(fitems) do
      fitems[i].parent:= self;
    FItemsUpToDate:= true;
  end;
  result:= FItems
end;

function TXPObject.IsDirectory: boolean;
begin
  result:= ImageIndex = ImDirectory;
end;

end.
