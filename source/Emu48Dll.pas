(*
 *   Emu48Dll.h
 *
 *   This file is part of Emu48
 *
 *   Copyright (C) 2000 Christoph Giesselink
 *
 *)

(*
 * Emu48dll.pas
 *
 * this file implements the interface to emu49.dll
 *
 * pascalisation by Cyrille de brebisson
 *
 * wgg: changed boolean to longbool in all argument lists
 *      had difficulty passing (Not someBool) but (Not someLongBool) works 
 *
 *)

//////////////////////////////////
//
//  REGISTER ACCESS API
//
//////////////////////////////////
unit emu48dll;

interface

uses
  windows;

const
  EMU_DIR = 'EMU\';
  EMU_DLLNAME = 'EMU48.DLL';
  EMU_WINDOWNAME = 'CEmu48';

  EMU_REGISTER_PC     =  0;
  EMU_REGISTER_D0     =  1;
  EMU_REGISTER_D1     =  2;
  EMU_REGISTER_DUMMY  =  3;
  EMU_REGISTER_AL     =  4;
  EMU_REGISTER_AH     =  5;
  EMU_REGISTER_BL     =  6;
  EMU_REGISTER_BH     =  7;
  EMU_REGISTER_CL     =  8;
  EMU_REGISTER_CH     =  9;
  EMU_REGISTER_DL     = 10;
  EMU_REGISTER_DH     = 11;
  EMU_REGISTER_R0L    = 12;
  EMU_REGISTER_R0H    = 13;
  EMU_REGISTER_R1L    = 14;
  EMU_REGISTER_R1H    = 15;
  EMU_REGISTER_R2L    = 16;
  EMU_REGISTER_R2H    = 17;
  EMU_REGISTER_R3L    = 18;
  EMU_REGISTER_R3H    = 19;
  EMU_REGISTER_R4L    = 20;
  EMU_REGISTER_R4H    = 21;
  EMU_REGISTER_R5L    = 22;
  EMU_REGISTER_R5H    = 23;
  EMU_REGISTER_R6L    = 24;
  EMU_REGISTER_R6H    = 25;
  EMU_REGISTER_R7L    = 26;
  EMU_REGISTER_R7H    = 27;
  EMU_REGISTER_FLAGS  = 28;
  EMU_REGISTER_OUT    = 29;
  EMU_REGISTER_IN     = 30;
  EMU_REGISTER_VIEW1  = 31;
  EMU_REGISTER_VIEW2  = 32;
  EMU_REGISTER_RSTKP  = 63;
  EMU_REGISTER_RSTK0  = 64;
  EMU_REGISTER_RSTK1  = 65;
  EMU_REGISTER_RSTK2  = 66;
  EMU_REGISTER_RSTK3  = 67;
  EMU_REGISTER_RSTK4  = 68;
  EMU_REGISTER_RSTK5  = 69;
  EMU_REGISTER_RSTK6  = 70;
  EMU_REGISTER_RSTK7  = 71;
  EMU_REGISTER_CLKL   = 72;
  EMU_REGISTER_CLKH   = 73;
  EMU_REGISTER_CRC    = 74;                   // wgg

//////////////////////////////////
//
//  breakpoint type definitions
//
//////////////////////////////////
  EMU_BP_EXEC   =1;							// code breakpoint
  EMU_BP_READ   =2;							// read memory breakpoint
  EMU_BP_WRITE  =4;							// write memory breakpoint
  EMU_BP_ACCESS =(EMU_BP_READ or EMU_BP_WRITE);                         // read/write memory breakpoint
  EMU_BP_ROM    =$8000;

(**
 *  "FLAGS" register format :
 *
  *  +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
 *  |               ST              |S|x|x|x|K|I|C|M|  HST  |   P   |
 *  +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
 *  M : Mode (0:Hex, 1:Dec)
 *  C : Carry
 *  I : Interrupt pending
 *  K : KDN Interrupts Enabled
 *  S : Shutdn Flag (read only)
 *  x : reserved
 *)

// breakpoint notify definitions
BN_ASM    =0;      // ASM breakpoint
BN_RPL    =1;      // RPL breakpoint
BN_ASM_BT =2;      // ASM and RPL breakpoint


(****************************************************************************
* EmuCreate
*****************************************************************************
*
* @func   start Emu48 and load Ram file into emulator
*
* @xref   none
*
* @rdesc  BOOL: FALSE = OK, TRUE = Error
*
****************************************************************************)

function EmuCreate(lpszFilename: PChar): boolean; stdcall;			// @parm String with RAM filename
(****************************************************************************   // wgg got an update from Christop
* EmuCreateEx
*****************************************************************************
*
* @func   start Emu48 and load Ram and Port2 file into emulator, if Ram file
*         don't exist create a new one and save it under the given name
*
* @xref   none
*
* @rdesc  BOOL: FALSE = OK, TRUE = Error
*
****************************************************************************)
                                                                                   // second param may be Null, then emu48.ini will be used
function EmuCreateEx(lpszFilename: PChar; lpszPort2Name: PChar): boolean; stdcall; // @parm String with RAM filename  @parm String with Port2 filename
(****************************************************************************
(****************************************************************************
* EmuDestroy
*****************************************************************************
*
* @func   close Emu48, free all memory
*
* @xref   none
*
* @rdesc  BOOL: FALSE = OK, TRUE = Error
*
****************************************************************************)

function EmuDestroy(): boolean; stdcall;

(****************************************************************************
* EmuCallBackClose
*****************************************************************************
*
* @func   init CallBack handler to notify caller when Emu48 window close
*
* @xref   none
*
* @rdesc  VOID
*
****************************************************************************)

type TCallBack= procedure(); stdcall;
procedure EmuCallBackClose(EmuClose: TCallBack); stdcall		// @parm CallBack function notify caller Emu48 closed

(****************************************************************************
* EmuCallBackDocumentNotify
*****************************************************************************
*
* @func   init CallBack handler to notify caller for actual document file
*
* @xref   none
*
* @rdesc  VOID
*
****************************************************************************)

type TNotifyCallBack= procedure(lpszFileName: PChar); stdcall;
procedure EmuCallBackDocumentNotify(EmuDocNotify: TNotifyCallBack) stdcall;	// @parm CallBack function notify document filename

(****************************************************************************
* EmuLoadRamFile
*****************************************************************************
*
* @func   load Ram file into emulator
*
* @xref   none
*
* @rdesc  BOOL: FALSE = OK, TRUE = Error (old file reloaded)
*
****************************************************************************)

function EmuLoadRamFile(lpszFilename: PChar): boolean; stdcall;			// @parm String with RAM filename

(****************************************************************************
* EmuSaveRamFile
*****************************************************************************
*
* @func   save the current emulator Ram to file
*
* @xref   none
*
* @rdesc  BOOL: FALSE = OK, TRUE = Error (old file reloaded)
*
****************************************************************************)

function EmuSaveRamFile(): boolean; stdcall;

(****************************************************************************
* EmuLoadObject
*****************************************************************************
*
* @func   load object file to stack
*
* @xref   none
*
* @rdesc  BOOL: FALSE = OK, TRUE = Error
*
****************************************************************************)

function EmuLoadObject(lpszObjectFilename: PChar): boolean; stdcall;		// @parm String with object filename

(****************************************************************************
* EmuSaveObject
*****************************************************************************
*
* @func   save object on stack to file
*
* @xref   none
*
* @rdesc  BOOL: FALSE = OK, TRUE = Error
*
****************************************************************************)
                                                                           
function EmuSaveObject(lpszObjectFilename: PChar): boolean; stdcall;  // @parm String with object filename

(****************************************************************************
* EmuCalculatorType
*****************************************************************************
*
* @func   get ID of current calculator type
*
* @xref   none
*
* @rdesc  BYTE: '6' = HP38G with 64KB RAM
*               'A' = HP38G
*               'E' = HP39/40G
*               'S' = HP48SX
*               'G' = HP48GX
*               'X' = HP49G
*
****************************************************************************)

function EmuCalculatorType(): char; stdcall;

(****************************************************************************
* EmuSimulateKey
*****************************************************************************
*
* @func   simulate a key action
*
* @xref   none
*
* @rdesc  VOID
*
****************************************************************************)
                                  
procedure EmuSimulateKey(bKeyState: longbool; outm, inm: integer); stdcall	// @parm TRUE = pressed, FALSE = released
                								// @parm key out line
		                						// @parm key in  line

(****************************************************************************
* EmuPressOn
*****************************************************************************
*
* @func   press On key (emulation must run)
*
* @xref   none
*
* @rdesc  VOID
*
****************************************************************************)
                                
procedure EmuPressOn(bKeyState: longbool); stdcall;  				// @parm TRUE = pressed, FALSE = released

(****************************************************************************
* EmuInitLastInstr
*****************************************************************************
*
* @func   init a circular buffer area for saving the last instruction
*         addresses
*
* @xref   none
*
* @rdesc  BOOL: FALSE = OK, TRUE = Error
*
****************************************************************************)

function EmuInitLastInstr(wNoInstr: integer; pdwArray: pint): boolean; stdcall;	// @parm number of saved instructions,
                                                                                //       0 = frees the memory buffer
                                						// @parm pointer to linear array

(****************************************************************************
* EmuGetLastInstr
*****************************************************************************
*
* @func   return number of valid entries in the last instruction array,
*         each entry contents a PC address, array[0] contents the oldest,
*         array[*pwNoEntries-1] the last PC address
*
* @xref   none
*
* @rdesc  BOOL: FALSE = OK, TRUE = Error
*
****************************************************************************)

function EmuGetLastInstr(var pwNoEntries: DWord): boolean;	stdcall;		// @parm return number of valid entries in array

(****************************************************************************
* EmuRun
*****************************************************************************
*
* @func   run emulation
*
* @xref   none
*
* @rdesc  VOID
*
****************************************************************************)

procedure EmuRun(); stdcall;

(****************************************************************************
* EmuRunPC
*****************************************************************************
*
* @func   run emulation until stop address
*
* @xref   none
*
* @rdesc  VOID
*
****************************************************************************)

procedure EmuRunPC(dwAddressPC: DWORD);	stdcall;				// @parm breakpoint address

(****************************************************************************
* EmuStep
*****************************************************************************
*
* @func   execute one ASM instruction and return to caller
*
* @xref   none
*
* @rdesc  VOID
*
****************************************************************************)

procedure EmuStep(); stdcall;

(****************************************************************************
* EmuStepOver
*****************************************************************************
*
* @func   execute one ASM instruction but skip GOSUB, GOSUBL, GOSBVL
*         subroutines
*
* @xref   none
*
* @rdesc  VOID
*
****************************************************************************)

procedure EmuStepOver; stdcall;

(****************************************************************************
* EmuStepOut
*****************************************************************************
*
* @func   run emulation until a RTI, RTN, RTNC, RTNCC, RTNNC, RTNSC, RTNSXN,
*         RTNYES instruction is found above the current stack level
*
* @xref   none
*
* @rdesc  VOID
*
****************************************************************************)

procedure EmuStepOut; stdcall;

(****************************************************************************
* EmuStop
*****************************************************************************
*
* @func   break emulation
*
* @xref   none
*
* @rdesc  bool
*
****************************************************************************)

function EmuStop(): boolean; stdcall;

(****************************************************************************
* EmuCallBackDebugNotify  (called after PC=(A) in interpreter
*****************************************************************************
*
* @func   init CallBack handler to notify caller on debugger breakpoint
*
* @xref   none
*
* @rdesc  VOID
*
****************************************************************************)

type TBreakCallBack= procedure (nBreakType: integer); stdcall;
procedure EmuCallBackDebugNotify(EmuDbgNotify: TBreakCallBack); stdcall; // @parm CallBack function notify Debug breakpoint

(****************************************************************************
* EmuCallBackStackNotify
*****************************************************************************
*
* @func   init CallBack handler to notify caller on hardware stack change;
*         if the CallBack function return TRUE, emulation stops behind the
*         opcode changed hardware stack content, otherwise, if the CallBack
*         function return FALSE, no breakpoint is set
*
* @xref   none
*
* @rdesc  VOID
*
****************************************************************************)

type TStackCallBack= function(): longbool; stdcall;
procedure EmuCallBackStackNotify(EmuStackNotify: TStackCallBack); stdcall; // @parm CallBack function notify stack changed

(****************************************************************************
* EmuGetRegister
*****************************************************************************
*
* @func   read a 32 bit register
*
* @xref   none
*
* @rdesc  DWORD: 32 bit value of register
*
****************************************************************************)

function EmuGetRegister(uRegister: integer): DWORD; stdcall;			// @parm index of register

(****************************************************************************
* EmuSetRegister
*****************************************************************************
*
* @func   write a 32 bit register
*
* @xref   none
*
* @rdesc  VOID
*
****************************************************************************)

procedure EmuSetRegister(uRegister: integer; dwValue: DWORD); stdcall;		// @parm index of register
                                						// @parm new 32 bit value
(****************************************************************************
* EmuGetMem
*****************************************************************************
*
* @func   read one nibble from the specified mapped address
*
* @xref   none
*
* @rdesc  VOID
*
****************************************************************************)

procedure EmuGetMem(dwMapAddr: DWORD; var pbyValue: BYTE); stdcall;	        // @parm mapped address of Saturn CPU
                                                                		// @parm readed nibble

(****************************************************************************
* EmuSetMem
*****************************************************************************
*
* @func   write one nibble to the specified mapped address
*
* @xref   none
*
* @rdesc  VOID
*
****************************************************************************)

procedure EmuSetMem(dwMapAddr: DWORD; byValue: BYTE); stdcall;		        // @parm mapped address of Saturn CPU
                                						// @parm nibble to write
(****************************************************************************
* EmuGetRom
*****************************************************************************
*
* @func   return size and base address of mapped ROM
*
* @xref   none
*
* @rdesc  LPBYTE: base address of ROM (pointer to original data)
*
****************************************************************************)

function EmuGetRom(var pdwRomSize: DWORD): PBYTE; stdcall;			        // @parm return size of ROM in nibbles

(****************************************************************************
* EmuSetBreakpoint
*****************************************************************************
*
* @func   set ASM code/data breakpoint
*
* @xref   none
*
* @rdesc  BOOL: TRUE  = Error, Breakpoint table full
*               FALSE = OK, Breakpoint set
*
****************************************************************************)

function EmuSetBreakpoint(dwAddress: Dword; 					// @parm breakpoint address to set
                          nBreakpointType: integer): boolean; stdcall;		// @parm breakpoint type to set

(****************************************************************************
* EmuClearBreakpoint
*****************************************************************************
*
* @func   clear ASM code/data breakpoint
*
* @xref   none
*
* @rdesc  BOOL: TRUE  = Error, Breakpoint not found
*               FALSE = OK, Breakpoint cleared
*
****************************************************************************)

function EmuClearBreakpoint(dwAddress: DWORD;					// @parm breakpoint address to clear
                            nBreakpointType: integer): boolean; stdcall;	// @parm breakpoint type to clear

(****************************************************************************
* EmuClearAllBreakpoints
*****************************************************************************
*
* @func   clear all breakpoints
*
* @xref   none
*
* @rdesc  VOID
*
****************************************************************************)

procedure EmuClearAllBreakpoints(); stdcall;

(****************************************************************************
* EmuEnableNop3Breakpoint
*****************************************************************************
*
* @func   enable/disable NOP3 breakpoint
*         stop emulation at Opcode 420 for GOC + (next line)
*
* @xref   none
*
* @rdesc  VOID
*
****************************************************************************)

procedure EmuEnableNop3Breakpoint(bEnable: longbool); stdcall;                  // @parm stop on NOP3 opcode

(****************************************************************************
* EmuEnableRplBreakpoint
*****************************************************************************
*
* @func   enable/disable RPL breakpoint
*
* @xref   none
*
* @rdesc  VOID
*
****************************************************************************)

procedure EmuEnableRplBreakpoint(bEnable: longbool); stdcall;			// @parm stop on RPL exit

(****************************************************************************
* EmuEnableSkipInterruptCode
*****************************************************************************
*
* @func   enable/disable skip single step execution inside the interrupt
*         handler, this option has no effect on code and data breakpoints
*
* @xref   none
*
* @rdesc  VOID
*
****************************************************************************)

procedure EmuEnableSkipInterruptCode(bEnable: longbool);	stdcall;                // @parm TRUE = skip code instructions

implementation

function  EmuCreate(lpszFilename:PChar):boolean; stdcall;                                   external EMU_DLLNAME name '_EmuCreate@4';
function  EmuCreateEx(lpszFilename: PChar; lpszPort2Name: PChar): boolean; stdcall;         external EMU_DLLNAME name '_EmuCreateEx@8';
function  EmuDestroy:boolean; stdcall;                                                      external EMU_DLLNAME name '_EmuDestroy@0';
function  EmuLoadRamFile(lpszFilename:PChar):boolean; stdcall;                              external EMU_DLLNAME name '_EmuLoadRamFile@4';
function  EmuLoadObject(lpszObjectFilename:PChar): boolean; stdcall;                        external EMU_DLLNAME name '_EmuLoadObject@4';
function  EmuSaveObject(lpszObjectFilename:PChar): boolean; stdcall;                        external EMU_DLLNAME name '_EmuSaveObject@4';
procedure EmuSimulateKey(bKeyState:longbool;outm,inm: integer); stdcall;                    external EMU_DLLNAME name '_EmuSimulateKey@12';
procedure EmuPressOn(bKeyState:longbool); stdcall;                                          external EMU_DLLNAME name '_EmuPressOn@4';
function  EmuInitLastInstr(wNoInstr:integer; pdwArray: pint): boolean; stdcall;             external EMU_DLLNAME name '_EmuInitLastInstr@8';
function  EmuGetLastInstr(var pwNoEntries: DWord):boolean; stdcall;                         external EMU_DLLNAME name '_EmuGetLastInstr@4';
procedure EmuRun; stdcall;                                                                  external EMU_DLLNAME name '_EmuRun@0';
function  EmuStop: boolean; stdcall;                                                        external EMU_DLLNAME name '_EmuStop@0';
procedure EmuStep; stdcall;                                                                 external EMU_DLLNAME name '_EmuStep@0';
function  EmuGetRegister(uRegister:integer):DWORD; stdcall;                                 external EMU_DLLNAME name '_EmuGetRegister@4';
procedure EmuSetRegister(uRegister:integer;dwValue: DWORD); stdcall;                        external EMU_DLLNAME name '_EmuSetRegister@8';
procedure EmuGetMem(dwMapAddr:DWORD;var pbyValue:BYTE); stdcall;                            external EMU_DLLNAME name '_EmuGetMem@8';
procedure EmuSetMem(dwMapAddr:DWORD;byValue:BYTE); stdcall;                                 external EMU_DLLNAME name '_EmuSetMem@8';
function  EmuGetRom(var pdwRomSize:DWORD):PBYTE;stdcall;                                    external EMU_DLLNAME name '_EmuGetRom@4';
function  EmuCallAsmBreak(var pdwAddress:DWORD):boolean; stdcall;                           external EMU_DLLNAME name '_EmuCallAsmBreak@4';
function  EmuCallRplBreak(var pdwAddress:DWORD):boolean; stdcall;                           external EMU_DLLNAME name '_EmuCallRplBreak@4';
//function  EmuSetCodeBreakpoint(dwAddress:DWORD):boolean; stdcall;                           external EMU_DLLNAME name '_EmuSetCodeBreakpoint@4';
//function  EmuClearCodeBreakpoint(dwAddress:DWORD): boolean; stdcall;                        external EMU_DLLNAME name '_EmuClearCodeBreakpoint@4';
procedure EmuEnableRplBreakpoint(bEnable:longbool); stdcall;                                external EMU_DLLNAME name '_EmuEnableRplBreakpoint@4';
procedure EmuCallBackClose(EmuClose: TCallBack); stdcall      		                          external EMU_DLLNAME name '_EmuCallBackClose@4';
procedure EmuRunPC(dwAddressPC: DWORD);	stdcall;                                            external EMU_DLLNAME name '_EmuRunPC@4';
procedure EmuStepOver; stdcall;                                                             external EMU_DLLNAME name '_EmuStepOver@0';
procedure EmuStepOut; stdcall;                                                              external EMU_DLLNAME name '_EmuStepOut@0';
procedure EmuCallBackDocumentNotify(EmuDocNotify: TNotifyCallBack) stdcall;                 external EMU_DLLNAME name '_EmuCallBackDocumentNotify@4';
procedure EmuCallBackDebugNotify(EmuDbgNotify: TBreakCallBack); stdcall;                    external EMU_DLLNAME name '_EmuCallBackDebugNotify@4';
procedure EmuCallBackStackNotify(EmuStackNotify: TStackCallBack); stdcall;                  external EMU_DLLNAME name '_EmuCallBackStackNotify@4';
function  EmuSetBreakpoint(dwAddress: DWORD; nBreakpointType: integer): boolean; stdcall;   external EMU_DLLNAME name '_EmuSetBreakpoint@8';
function  EmuClearBreakpoint(dwAddress: DWORD; nBreakpointType: integer): boolean; stdcall; external EMU_DLLNAME name '_EmuClearBreakpoint@8';
procedure EmuClearAllBreakpoints; stdcall;                                                  external EMU_DLLNAME name '_EmuClearAllBreakpoints@0';
procedure EmuEnableNop3Breakpoint(bEnable: longbool); stdcall;                              external EMU_DLLNAME name '_EmuEnableNop3Breakpoint@4';
procedure EmuEnableSkipInterruptCode(bEnable: longbool);	stdcall;                          external EMU_DLLNAME name '_EmuEnableSkipInterruptCode@4';
function EmuSaveRamFile(): boolean; stdcall;                                                external EMU_DLLNAME name '_EmuSaveRamFile@0';
function EmuCalculatorType(): char; stdcall;                                                external EMU_DLLNAME name '_EmuCalculatorType@0';

end.
