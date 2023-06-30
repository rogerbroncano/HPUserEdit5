{-------------------------------------------------------------------------------
The contents of this file are subject to the Mozilla Public License
Version 1.1 (the "License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at
http://www.mozilla.org/MPL/

Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for
the specific language governing rights and limitations under the License.

The Original Code is: SynHighlighterUserEdit.pas, released 2002-04-07.
The Original Code is based on the SynHighlighterGeneral.pas.
Portions written by Martin Waldenburg are copyright 1999 Martin Waldenburg.
All Rights Reserved.

Contributors to the SynEdit and mwEdit projects are listed in the
Contributors.txt file.

Alternatively, the contents of this file may be used under the terms of the
GNU General Public License Version 2 or later (the "GPL"), in which case
the provisions of the GPL are applicable instead of those above.
If you wish to allow use of your version of this file only under the terms
of the GPL and not to allow others to use your version of this file
under the MPL, indicate your decision by deleting the provisions above and
replace them with the notice and other provisions required by the GPL.
If you do not delete the provisions above, a recipient may use your version
of this file under either the MPL or the GPL.

$Id: SynHighlighterUserEdit.pas,v 1.1 2002/04/17 12:19:00 Roger Broncano $

You may retrieve the latest version of this file at the SynEdit home page,
located at http://SynEdit.SourceForge.net

Known Issues:
-------------------------------------------------------------------------------}
{
@abstract(Provides a customizable highlighter for SynEdit)
@author(Roger Broncano Reyes)
@created(2002)
@lastmod(2002-04-17)
The SynHighlighterUserEdit unit provides a customizable highlighter for SynEdit.
}

unit SynHighlighterUserEdit;

{$I SynEdit.inc}

interface

uses
  SysUtils, Classes,
  {$IFDEF SYN_KYLIX}
  Qt, QControls, QGraphics,
  {$ELSE}
  Windows, Messages, Controls, Graphics, Registry,
  {$ENDIF}
  SynEditTypes, SynEditHighlighter, SynEditStrConst;

type
  TtkuTokenKind = (tkuNull, tkuComment, tkuIdentifier, tkuNumber, tkuKey,
    tkuSpace, tkuString, tkuSymbol, tkuReserved); // ver5
var
  tkuTokenName: array[TtkuTokenKind] of string = (SYNS_AttrNull,
    SYNS_AttrComment, SYNS_AttrIdentifier, SYNS_AttrNumber,
    SYNS_AttrReservedWord, SYNS_AttrSpace, SYNS_AttrString,
    SYNS_AttrSymbol, 'ReservedWord'); // ver5                                                  // wgg

type
  TRangeState = (rsKey, rsUnKnown);
  TProcTableProc = procedure of object;

type
  TSynUserEditSyn = class(TSynCustomHighlighter)
  private
    fRange: TRangeState;
    fLine: PChar;
    fProcTable: array[#0..#255] of TProcTableProc;
    Run: LongInt;
    fTokenPos: Integer;
    Attribs: array[TtkuTokenKind] of TSynHighlighterAttributes;
    fTokenID: TtkuTokenKind;
    fLineNumber : Integer;
    fKeyWords: TStrings;
    fReservedWords: TStrings; // ver5
    fSpecialSymbols: TStrings; // ver5
    function GetAttrib(Index: integer): TSynHighlighterAttributes;              //wgg
    procedure SetAttrib(Index: integer; Value: TSynHighlighterAttributes);      //wgg

    procedure ArrobaProc;
    procedure CRProc;
    procedure IdentProc;
    procedure IntegerProc;
    procedure LFProc;
    procedure NullProc;
    procedure NumberProc;
    procedure SpaceProc;
    procedure StringProc;
    procedure AlgebraicProc;
    procedure Algebraic50Proc;
    procedure MakeMethodTables;
    procedure EndOfToken;
    procedure SetHighLightChange;
    procedure SetKeyWords(const Value: TStrings);
  protected
    function GetAttribCount: integer; override;
    function GetAttribute(idx: integer): TSynHighlighterAttributes; override;
  public
    {$IFNDEF SYN_CPPB_1} class {$ENDIF}
    function GetLanguageName: string; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetDefaultAttribute(Index: integer): TSynHighlighterAttributes;
      override;
    function GetEol: Boolean; override;
    function GetRange: Pointer; override;
    function GetTokenID: TtkuTokenKind;
    function GetToken: String; override;
    function GetTokenAttribute: TSynHighlighterAttributes; override;
    function GetTokenKind: integer; override;
    function GetTokenPos: Integer; override;
    function IsKeyword(const AKeyword: string): boolean; override;
    function IsReserved(const AReserved: string): boolean; // ver5
    function IsSpecialSymbol(const ASymbol: string): boolean; // ver5
    procedure Next; override;
    procedure ResetRange; override;
    procedure SetRange(Value: Pointer); override;
    procedure SetLine(NewValue: String; LineNumber: Integer); override;
    {$IFNDEF SYN_KYLIX}
    function SaveToRegistry(RootKey: HKEY; Key: string): boolean; override;
    function LoadFromRegistry(RootKey: HKEY; Key: string): boolean; override;
    {$ENDIF}
    procedure Assign(Source: TPersistent); override;                           //wgg
  published
    property CommentAttri: TSynHighlighterAttributes index Ord(tkuComment)     //wgg
      read GetAttrib write SetAttrib;
    property IdentifierAttri: TSynHighlighterAttributes index Ord(tkuIdentifier)
      read GetAttrib write SetAttrib;
    property NumberAttri: TSynHighlighterAttributes index Ord(tkuNumber)
      read GetAttrib write SetAttrib;
    property KeyAttri: TSynHighlighterAttributes index Ord(tkuKey)
      read GetAttrib write SetAttrib;
    property SpaceAttri: TSynHighlighterAttributes index Ord(tkuSpace)
      read GetAttrib write SetAttrib;
    property StringAttri: TSynHighlighterAttributes index Ord(tkuString)
      read GetAttrib write SetAttrib;
    property SymbolAttri: TSynHighlighterAttributes index Ord(tkuSymbol)
      read GetAttrib write SetAttrib;
    property ReservedAttri: TSynHighlighterAttributes index Ord(tkuReserved) // ver5
      read GetAttrib write SetAttrib; // ver5
    property KeyWords: TStrings read fKeyWords write SetKeyWords;
  end;

implementation

const
  ReservedWords: string = 'IF'#13#10'THEN'#13#10'END'#13#10'ELSE'#13#10 +
    'IFERR'#13#10'START'#13#10'NEXT'#13#10'STEP'#13#10'DO'#13#10'REPEAT' +
    #13#10'FOR'#13#10'UNTIL'#13#10'WHILE'#13#10'CASE'#13#10#171#13#10#187 +
    #13#10#141#13#10'DIR'#13#10'IFT'#13#10'IFTE'; // ver5

  SpecialSymbols: string = '+'#13#10'/'#13#10'-'#13#10'*'#13#10'^'#13#10 +
    '%'#13#10'!'#13#10'e'#13#10'='#13#10'>'#13#10'<'#13#10'|'#13#10#131#13#10 +
    #132#13#10#133#13#10#135#13#10#136#13#10#137#13#10#138#13#10#139#13#10 +
    #159#13#10'=='#13#10'i'; // ver5

var
  Identifiers: array[#0..#255] of ByteBool;

procedure MakeIdentTable;
var
  I: Char;
begin
  for I := #0 to #255 do
    Case I of
      '_', '0'..'9', 'a'..'z', 'A'..'Z': Identifiers[I] := True;
    else Identifiers[I] := False;
    end;
end;

function TSynUserEditSyn.IsKeyword(const AKeyword: string): boolean;
var
  I: Integer;
  Token: String;
begin
  Result := False;
  Token := AKeyword;
  for I := 0 to fKeywords.Count - 1 do
    if CompareStr(fKeywords[I], Token) = 0 then
    begin
      Result := True;
      break;
    end;
end;

function TSynUserEditSyn.IsReserved(const AReserved: string): boolean;
var
  I: Integer;
  Token: String;
begin
  Result := False; // ver5
  Token := AReserved; // ver5
  for I := 0 to fReservedWords.Count - 1 do
    if CompareStr(fReservedWords[I], Token) = 0 then
    begin
      Result := True; // ver5
      break; // ver5
    end;
end;

function TSynUserEditSyn.IsSpecialSymbol(const ASymbol: string): boolean;
var
  I: Integer;
  Token: String;
begin
  Result := False; // ver5
  Token := ASymbol; // ver5
  for I := 0 to fSpecialSymbols.Count - 1 do
    if CompareStr(fSpecialSymbols[I], Token) = 0 then
    begin
      Result := True; // ver5
      break; // ver5
    end;
end;

procedure TSynUserEditSyn.MakeMethodTables;
var
  I: Char;
begin
  for I := #0 to #255 do
    case I of
      '(': fProcTable[I] := IntegerProc;
      '#': fProcTable[I] := IntegerProc;
      '@': fProcTable[I] := ArrobaProc;
      #13: fProcTable[I] := CRProc;
      #10: fProcTable[I] := LFProc;
      #0: fProcTable[I] := NullProc;
      '.', '0'..'9': fProcTable[I] := NumberProc;
      #1..#9, #11, #12, #14..#32: fProcTable[I] := SpaceProc;
      else fProcTable[I] := IdentProc;
    end;
  fProcTable['"'] := StringProc;
  fProcTable[''''] := AlgebraicProc;
  fProcTable['`'] := Algebraic50Proc; // ver5
end;

constructor TSynUserEditSyn.Create(AOwner: TComponent);
var
  i: TtkuTokenKind;
begin
  inherited Create(AOwner);
  for i := low(TtkuTokenKind) to High(TtkuTokenKind) do
  begin
    Attribs[i] := TSynHighlighterAttributes.Create(tkuTokenName[i]);
    AddAttribute(Attribs[i]);
  end;
  SetHighLightChange;                                                         // wgg
  fKeyWords := TStringList.Create;
  TStringList(fKeyWords).Sorted := True;
  TStringList(fKeyWords).Duplicates := dupIgnore;  
  fReservedWords := TStringList.Create; // ver5
  fReservedWords.Text := ReservedWords; // ver5
  fSpecialSymbols := TStringList.Create; // ver5
  fSpecialSymbols.Text := SpecialSymbols; // ver5

  //Attribs[tkuComment].Style:= [fsItalic];
  //Attribs[tkuKey].Style:= [fsBold];

  SetAttributesOnChange(DefHighlightChange);
  MakeMethodTables;
  fRange := rsUnknown;
end;

destructor TSynUserEditSyn.Destroy;
var
  i: TtkuTokenKind;
begin
  for i := low(TtkuTokenKind) to High(TtkuTokenKind) do
    Attribs[i].Free;
  fKeyWords.Free;
  fReservedWords.Free;
  fSpecialSymbols.Free;
  inherited Destroy;
end;

procedure TSynUserEditSyn.SetLine(NewValue: String; LineNumber:Integer);
begin
  fLine := PChar(NewValue);
  Run := 0;
  fLineNumber := LineNumber;
  Next;
end;

procedure TSynUserEditSyn.ArrobaProc;
begin
  fTokenID := tkuComment;
  fRange := rsUnknown;
  inc(Run);
  while (FLine[Run] <> #0) And (FLine[Run] <> '@') do    // wgg added search for 2nd '@'
  begin
    fTokenID := tkuComment;
    inc(Run);
  end;
  if FLine[Run] <> #0 then inc(Run);                     // wgg skip the second @ if exists
end;

procedure TSynUserEditSyn.CRProc;
begin
  fTokenID := tkuSpace;
  Inc(Run);
  if fLine[Run] = #10 then Inc(Run);
end;

procedure TSynUserEditSyn.IdentProc;
var
  S: string;
begin
  EndOfToken;
  while Identifiers[fLine[Run]] do inc(Run);
  S := GetToken;
  if IsSpecialSymbol(S) then
    fTokenId := tkuSymbol // ver5
  else if IsReserved(S) then
    fTokenId := tkuReserved // ver5
  else if IsKeyWord(S) then
    fTokenId := tkuKey
  else if (S[1] in ['A'..'Z', 'a'..'z', '_', #142]) then
    fTokenId := tkuIdentifier
  else if S[1] = #128 then
    fTokenId := tkuNumber // ver5
  else
    fTokenId := tkuSymbol;
end;

procedure TSynUserEditSyn.IntegerProc;
begin
  inc(Run);
  fTokenID := tkuNumber;
  while FLine[Run] in ['0'..'9', 'A'..'F', 'b', 'd', 'h', 'o', ',', ')', '.'] do inc(Run);
end;

procedure TSynUserEditSyn.LFProc;
begin
  fTokenID := tkuSpace;
  inc(Run);
end;

procedure TSynUserEditSyn.NullProc;
begin
  fTokenID := tkuNull;
end;

procedure TSynUserEditSyn.NumberProc;
begin
  inc(Run);
  fTokenID := tkuNumber;
  while FLine[Run] in ['0'..'9', '.', 'e', 'E', 'b', 'd', 'h', 'o', '+', '-'] do
  begin
    if FLine[Run] = '.' then
      if FLine[Run + 1] = '.' then break;
    inc(Run);
  end;
end;

procedure TSynUserEditSyn.SpaceProc;
begin
  inc(Run);
  fTokenID := tkuSpace;
  while FLine[Run] in [#1..#9, #11, #12, #14..#32] do inc(Run);
end;

procedure TSynUserEditSyn.StringProc;
begin
  fTokenID := tkuString;    // wgg was tkIdentifier;
  if (fLine[Run + 1] = '"') and (fLine[Run + 2] = '"') then
    Inc(Run, 2);
  repeat
    case FLine[Run] of
      #0, #10, #13: break;
    end;
    inc(Run);
  until FLine[Run] = '"';
  if FLine[Run] <> #0 then inc(Run);
end;

procedure TSynUserEditSyn.Algebraic50Proc;
begin
  fTokenID := tkuString; // ver5
  if (fLine[Run + 1] = '`') and (fLine[Run + 2] = '`') then
    Inc(Run, 2);  // ver5
  repeat
    case FLine[Run] of
      #0, #10, #13: break; // ver5
    end;
    inc(Run); // ver5
  until FLine[Run] = '`';
  if FLine[Run] <> #0 then inc(Run); // ver5
end;

procedure TSynUserEditSyn.AlgebraicProc;
begin
  fTokenID := tkuString;
  if (fLine[Run + 1] = '''') and (fLine[Run + 2] = '''') then
    Inc(Run, 2);
  repeat
    case FLine[Run] of
      #0, #10, #13: break;
    end;
    inc(Run);
  until FLine[Run] = '''';
  if FLine[Run] <> #0 then inc(Run);
end;

procedure TSynUserEditSyn.Next;
begin
  fTokenPos := Run;
  fProcTable[fLine[Run]];
end;

function TSynUserEditSyn.GetDefaultAttribute(Index: integer): TSynHighlighterAttributes;
begin
  case Index of
    SYN_ATTR_COMMENT: Result := Attribs[tkuComment];
    SYN_ATTR_IDENTIFIER: Result := Attribs[tkuIdentifier];
    SYN_ATTR_KEYWORD: Result := Attribs[tkuKey];
    SYN_ATTR_STRING: Result := Attribs[tkuString];
    SYN_ATTR_WHITESPACE: Result := Attribs[tkuSpace];
    SYN_ATTR_SYMBOL: Result := Attribs[tkuSymbol];
    //SYM_ATTR_RESERVED: Result := Attribs[tkuReserved];
  else
    Result := nil;
  end;
end;

function TSynUserEditSyn.GetEol: Boolean;
begin
  Result := fTokenId = tkuNull;
end;

function TSynUserEditSyn.GetRange: Pointer;
begin
  Result := Pointer(fRange);
end;

function TSynUserEditSyn.GetToken: String;
var
  Len: LongInt;
begin
  Len := Run - fTokenPos;
  SetString(Result, (fLine + fTokenPos), Len);
end;

function TSynUserEditSyn.GetTokenID: TtkuTokenKind;
begin
  Result := fTokenId;
end;

function TSynUserEditSyn.GetTokenAttribute: TSynHighlighterAttributes;
begin
  Result := GetAttrib(Ord(fTokenID));
end;

function TSynUserEditSyn.GetTokenKind: integer;
begin
  Result := Ord(fTokenId);
end;

function TSynUserEditSyn.GetTokenPos: Integer;
begin
  Result := fTokenPos;
end;

procedure TSynUserEditSyn.ReSetRange;
begin
  fRange := rsUnknown;
end;

procedure TSynUserEditSyn.SetRange(Value: Pointer);
begin
  fRange := TRangeState(Value);
end;

procedure TSynUserEditSyn.SetKeyWords(const Value: TStrings);
var
  i: Integer;
begin
  if Value <> nil then
    begin
      Value.BeginUpdate;
      for i := 0 to Value.Count - 1 do
        Value[i] := UpperCase(Value[i]);
      Value.EndUpdate;
    end;
  fKeyWords.Assign(Value);
  DefHighLightChange(nil);
end;

procedure TSynUserEditSyn.Assign(Source: TPersistent);
var
  i: TtkuTokenKind;
begin
  if Source is TSynUserEditSyn then begin
    for i := Low(Attribs) to High(Attribs) do begin
      Attribs[i].Background := TSynUserEditSyn(source).Attribs[i].Background;
      Attribs[i].Foreground := TSynUserEditSyn(source).Attribs[i].Foreground;
      Attribs[i].Style := TSynUserEditSyn(source).Attribs[i].Style;
    end;
    KeyWords.Text := TSynUserEditSyn(source).KeyWords.Text;
  end
  else
    inherited Assign(Source);
end;

function TSynUserEditSyn.GetAttribCount: integer;
begin
  Result := Ord(High(Attribs)) - Ord(Low(Attribs)) + 1;
end;

function TSynUserEditSyn.GetAttribute(idx: integer): TSynHighlighterAttributes;
begin // sorted by name
  if (idx <= Ord(High(TtkuTokenKind))) then
    Result := Attribs[TtkuTokenKind(idx)]
  else
    Result := nil;
end;

procedure TSynUserEditSyn.SetHighLightChange;
var
  i: TtkuTokenKind;
begin
  for i := Low(Attribs) to High(Attribs) do begin
    Attribs[i].OnChange := DefHighLightChange;
    Attribs[i].InternalSaveDefaultValues;                                       //mh 2000-10-08
  end;
end;

{$IFNDEF SYN_CPPB_1} class {$ENDIF}
function TSynUserEditSyn.GetLanguageName: string;
begin
  Result := 'UserEdit';
end;

{$IFNDEF SYN_KYLIX}
function TSynUserEditSyn.LoadFromRegistry(RootKey: HKEY; Key: string): boolean;
var
  r: TBetterRegistry;
begin
  r:= TBetterRegistry.Create;
  try
    r.RootKey := RootKey;
    if r.OpenKeyReadOnly(Key) then
    begin
      if r.ValueExists('RPLKeyWordList')
        then Keywords.Text := r.ReadString({'RPLSyntax',}'RPLKeyWordList' {, Keywords.Text});
      Result := inherited LoadFromRegistry(RootKey, Key);
    end
    else Result := false;
  finally r.Free; end;
end;

function TSynUserEditSyn.SaveToRegistry(RootKey: HKEY; Key: string): boolean;
var
  r: TBetterRegistry;
begin
  r:= TBetterRegistry.Create;
  try
    r.RootKey := RootKey;
    if r.OpenKey(Key,true) then
    begin
      Result := true;
			r.WriteString({'RPLSyntax',}'RPLKeyWordList', Keywords.Text);
			Result := inherited SaveToRegistry(RootKey, Key)
    end
    else Result := false;
  finally r.Free; end;
end;
{$ENDIF}

function TSynUserEditSyn.GetAttrib(Index: integer): TSynHighlighterAttributes;
begin
  Result := Attribs[TtkuTokenKind(Index)];
end;

procedure TSynUserEditSyn.SetAttrib(Index: integer; Value: TSynHighlighterAttributes);
begin
  Attribs[TtkuTokenKind(Index)].Assign(Value);
end;

procedure TSynUserEditSyn.EndOfToken;
begin
  while (Run <= Length(fLine)) and (FLine[Run] > ' ') do
    Inc(Run);
end;

initialization
  MakeIdentTable;
{$IFNDEF SYN_CPPB_1}
  RegisterPlaceableHighlighter(TSynUserEditSyn);
{$ENDIF}
end.