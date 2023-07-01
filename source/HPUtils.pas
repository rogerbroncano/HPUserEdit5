{
  Cyrille de Brebisson utility classes
  This unit is copyright Cyrille de Brebisson

  Changes marked with WGG are copyright 2002, William G. Graves
  Changes marked with RGB are copyright 2003, Roger G. Broncano
}

unit HPUtils;

interface

uses
  Classes, Math, StrUtils, SysUtils, Globals, Windows;

type
  TGrob = Record
    Width: Integer;
    Height: Integer;
    Pixels: string;
  end;

const
  HexStr = '0123456789ABCDEF';

  function PictureFileToGrob(FileName: string): TGrob;             // rgb
  procedure GrobToPictureFile(Grob: TGrob; FileName: string);      // rgb
  function HPFileToStr(F: TFileName): string;                      // rgb
  function IsProgramObject(Text: string): Boolean;                 // rgb
  function RemoveHead(s: string): string;                          // rgb              // wgg

  function ScanForCR(s: string): Boolean;                                         // wgg
  function RemoveCR(s: string): string;                                        // wgg
  function Pos2(const SubStr, S: string; InitialPos: Integer): Integer;
  function RemoveTab(s: string; TabSize: Integer = 2): string;
  function SkipWhite(const s: string; I: Integer): integer;
  function FindWhite(const s: string; I: Integer): integer;
  function GetToken(const s: string; I: Integer): string;
  function NxtToken(const s: string; I: Integer): integer;
  function FileToString(F: TFileName): string; overload;
  function FileToString(F: TFileName; Readsize: Integer): string; overload;
  function HPFileToString(F: TFileName): string;
  procedure StringToFile(s: string; F: TFileName);
  function NibbleToByte(s: string): string;
  function ByteToNibble(s: string): string;
  function ByteToNibble2(s: string): string;
  function IntToHex2(I: int64; Digit: integer): string;
  function HexToStr(s: string): Int64;
  Procedure swap(var I, J: Integer); overload;
  procedure swap(var I, J: Byte); overload;
  procedure swap(var I, J: Char); overload;
  procedure RevString(var s: string);
  procedure Repl(var Dest: string; Source: string; Pos: Integer);
  function Removeslashslash(s: string): string;
  function ExpandText(const s: string): string;
  function ShrinkText(const s: string): string;
  function StringCrc(const S: string): Integer;
  function StrToHex(s: string): Integer;
  function GetSpaces(number: Integer): string;
  function TokenAtPos(s: string; var p: Integer): string;
  function Distance2(x1, y1, x2, y2: Single): Real;
  function AddSpaces(const s: string; Int: Integer): string;
  function BinToHex(const s: string): string;
  function BinToHexHP(const s: string): string;
  function HexToBinHP(const s: string): string;
  function cutstr(const s: string; size: Integer): string;
  function QuoteIf(s: string): string;                                    // wgg
  function BackToName(s: string): Integer;                                // wgg

Implementation

function PictureFileToGrob(FileName: string): TGrob;
var
  X, Y: Integer;
  Texto: string;
begin
  Result.Width := 0;
  Result.Height := 0;
  Result.Pixels := '';
  Texto := FileToString(FileName);
  if Copy(Texto, 1, 5) <> 'HPHP4' then Exit;
  Delete(Texto, 1, 8);
  Texto := BinToHexHP(Texto);
  if Copy(Texto, 1, 5) <> 'E1B20' then Exit;
  Delete(Texto, 1, 10);
  if TryStrToInt('$' + ReverseString(Copy(Texto, 1, 5)), Y) and
     TryStrToInt('$' + ReverseString(Copy(Texto, 6, 5)), X) then
  begin
    Delete(Texto, 1, 10);
    Result.Width := X;
    Result.Height := Y;
    Result.Pixels := Texto;
  end;
end;

procedure GrobToPictureFile(Grob: TGrob; FileName: string);      // rgb
var
  sX, sY, sZ: string;
  Texto: string;
begin
  sX := ReverseString(IntToHex(Grob.Width, 5));
  sY := ReverseString(IntToHex(Grob.Height, 5));
  Texto := sY + sX + Grob.Pixels;
  sZ := ReverseString(IntToHex(Length(Texto) + 5, 5));
  Texto := 'E1B20' + sZ + Texto;
  Texto := HexToBinHP(Texto);
  if oIsCalc48 then
    Texto := 'HPHP48-W' + Texto
  else
    Texto := 'HPHP49-W' + Texto;
  StringToFile(Texto, FileName);
end;

function HPFileToStr(F: TFileName): string;
var
  Temp: string;
  I, Desp, SPos: Integer;
  IsCad, IsMat: Boolean;
begin
  Result := '';
  Temp := FileToString(F);
  if Copy(Temp, 1, 5) = 'HPHP4' then
  begin
    Delete(Temp, 1, 8);
    Temp := BinToHexHP(Temp);
    if Copy(Temp, 1, 5) = 'C2A20' then
    begin
      Delete(Temp, 1, 10);
      Temp := HexToBinHP(Temp);
      Desp := 0;
      SPos := 0;
      IsCad := False;
      IsMat := False;
      for I := 1 to Length(Temp) do
      begin
        Inc(Desp);
        if (Temp[I] = '"') and not IsCad then IsCad := True;
        if (Temp[I] = '"') and IsCad then IsCad := False;
        if (Temp[I] = '[') then IsMat := True;
        if (Temp[I] = ']') then IsMat := False;
        if (Temp[I] = ' ') and not IsCad and not IsMat then
          if Desp > eMarginSize then
          begin
            if SPos = 0 then
            begin
              Temp[I] := #10;
              Desp := 0;
            end
            else begin
              Temp[SPos] := #10;
              Desp := I - SPos;
            end;
            SPos := 0;
          end
          else SPos := I;
        if (Temp[I] = #10) and (Desp < eMarginSize) then
        begin
          Desp := 0;
          SPos := 0;
        end;
      end;
      Result := Temp;
    end;
  end;
end;

function IsProgramObject(Text: string): Boolean;
begin
  Result := False;
  Text := RemoveHead(Text); // ver5
  if Length(Text) >= 2 then
    if (Text[1] = #171) and (Text[Length(Text)] = #187) then
      Result := True;
end;

function RemoveHead(s: string): string;                          // rgb              // wgg
begin
  Result := s; // ver5
  s := Trim(s); // ver5
  if (Pos('%%HP:', s) = 1) and (Pos(';', s) = 19) then
    s := Copy(s, Pos(';', s) + 1, Length(s)); // ver5
  s := Trim(s); // ver5
  while Pos('@', s) = 1 do
  begin
    if Pos(#13, s) <> 0 then
      s := Copy(s, Pos(#13, s), Length(s)) // ver5
    else
      s := '';
    s := Trim(s); // ver5
  end;
  Result := s;
end;

// wgg work backwards in a string, until a space.
// then continue until a non-space and return length of the left hand side
// Used for * File xxx error msgs in a long name environment
function BackToName(s: string): integer;
var
  i, j: integer;
begin
  j := length(s);
  for i := j downto 1 do
    if s[i] = ' ' then break;
  if i > 1 then
    for j := i - 1 downto 1 do
      if s[j] <> ' ' then break;
  result := j;
end;

// wgg add quotes around a string if it has any embedded spaces
// used for INCLUDE file names
function QuoteIf(s: string): string;
begin
  if Pos(' ', s)<> 0 then result:= '"'+s+'"'
  else result:= s;
end;

// wgg function for removing cr #13 from a file string
// This keeps the Unix people happy
function RemoveCR(s: string): string;                                        // wgg
var
  I, J: integer;
begin
  I := 1;
  J := 1;
  SetLength(Result, Length(s));        // so we dont keep stretching a character at a time
  while I <= Length(s) do
  begin
    Result[J] := s[I];
    if s[I] <> #13 then Inc(J);
    Inc(I);
  end;
  SetLength(Result, J - 1);
end;

// wgg function scans for CR #13 in a file
function ScanForCR(s: string): Boolean;                                        // wgg
var
  I: integer;
begin
  I := 1;
  Result := False;
  while I <= Length(s) do
  begin
    if s[I] = #13 then
      begin
        Result := True;
        Break;
      end;
    if S[I] = #10 then Break;              // we should see #13 before #10
    Inc(I);
  end;
end;

function CutStr(const s: string; size: integer): string;
var
  i: integer;
Begin
  result:= '';
  i:=1;
  while i <= length(s) do
  begin
    result:= result+copy(s, i, size)+#13#10;
    inc(i, size);
  end;
end;

const
  AsciiBin = '0123456789ABCDEF';

Function BinToHexHP(const s: string): string;
var
  i: integer;
Begin
  setlength(result, 2*Length(s));
  for i:=0 to length(s)-1 do
  Begin
    result[2*i+1]:= AsciiBin[ord(s[i+1]) and $F+1];
    result[2*i+2]:= AsciiBin[(ord(s[i+1]) div 16) and $F+1];
  end;
end;

Function HexToBinHP(const s: string): string;
var
  i: integer;
Begin
  setlength(result, (Length(s)+1) div 2);
  for i:=0 to length(result)-1 do
    result[i+1]:= chr((pos(s[i*2+2], HexStr)-1)*16+(pos(s[i*2+1], HexStr)-1));
end;

Function BinToHex(const s: string): string;
var
  i: integer;
Begin
  setlength(result, 2*Length(s));
  for i:=0 to length(s)-1 do
  Begin
    result[2*i+2]:= AsciiBin[ord(s[i+1]) and $F+1];
    result[2*i+1]:= AsciiBin[(ord(s[i+1]) div 16) and $F+1];
  end;
end;

Function AddSpaces(const s: string; int: integer): string;
Begin
  result:= s;
  while length(result)<int do result:= result+' ';
end;

Function Distance2(x1, y1, x2, y2: single): real;
begin
  result:= sqr(x1-x2)+sqr(y1-y2);
end;

Function TokenAtPos(s: string; var p: integer): string;
var
  i: integer;
Begin
  i:= skipwhite(s, p);
  p:= findwhite(s, i);
  result:= copy(s, i, p-i);
end;

function GetSpaces(number: integer): string;
begin
  SetLength(result, number);
  FillMemory(@(result[1]), number, 32);
end;

type
  TMatrix=array [0..15, 0..15] of integer;
  TArray=array[0..$100-1] of integer;
var
  CrcTable:TMatrix;
  CrcTableArray:TArray absolute CrcTable;

Function StrToHex(s: string): integer;
var
  I: integer;
Begin
  Val('$' + s, result, I);
  if I <> 0 then
    raise exception.create(s + ' is not an hex number');
end;

function StringCrc(Const S: string): integer;
var
  i,l,j,k :integer;
  c:^Byte;
begin
  result:=0;
  l:=length(s);
  c:=@s[1];
  for i:=1 to l do
  begin
    j:=c^;
    inc(c);
    k:=(result and $F) shl 4;
    result:= (result shr 4) xor CrcTAbleArray[k+ (j and $F)];
    k:=(result and $F) shl 4;
    result:= (result shr 4) xor CrcTAbleArray[k+ (j shr 4)];
  end;
end;

procedure CrcInitTable;
var
  crc, input: integer;
Begin
  for crc:= 0 to 15 do
    for input:= 0 to 15 do
      CrcTable[crc, input]:= (crc xor input)*$1081
end;

Function ExpandText(const s: string): string;
var
  i: integer;
Begin
  SetLength(result, length(s));
  for i:= 1 to length(s) do
    case s[i] of
      #10: result[i]:= chr(256-10);
      #13: result[i]:= chr(256-13);
      else result[i]:= s[i];
    end;
end;

Function ShrinkText(const s: string): string;
var
  i: integer;
Begin
  SetLength(result, length(s));
  for i:= 1 to length(s) do
    case s[i] of
      chr(256-10): result[i]:= #10;
      chr(256-13): result[i]:= #13;
      else result[i]:= s[i];
    end;
end;

Function Removeslashslash(s: string): string;
Begin
  result:= '';
  while s<>'' do
    if (s[1]='\') then
    begin
      result:=result+'\';
      while (s<>'') and (s[1]='\') do
        s:= copy(s, 2, maxint);
    end else begin
      result:= result+s[1];
      s:= copy(s, 2, maxint);
    end;
end;

Function HPFileToString(f: TFileName): string;
Begin
  result:= FileToString(f);
  if copy(result, 1, 5)='HPHP4' then
    result:= copy(result, 9, maxint);
  result:= ByteToNibble(result);
end;

Procedure RevString(var s: string);
var
  i: integer;
  l: integer;
Begin
  l:= length(s);
  for i:= 0 to (l-1) div 2 do
    swap(s[i+1], s[l-i]);
end;

Procedure swap(var i, j: integer);
var
  t: integer;
begin
  t:= i;
  i:= j;
  j:= t;
end;

procedure swap(var i, j: byte);
var
  t: byte;
begin
  t:= i;
  i:= j;
  j:= t;
end;

procedure swap(var i, j: char);
var
  t: char;
begin
  t:= i;
  i:= j;
  j:= t;
end;

Function IntToHex2(i: int64; digit: integer): String;
Var
  j: integer;
Begin
  SetLength(Result, digit);
  For j := 0 To digit - 1 Do
  Begin
    result[digit - j] := HexStr[i And $F + 1];
    i := i Div 16;
  End;
End;

Function GetToken(Const s: String; i: integer): String;
Var
  j: integer;
Begin
  j := SkipWhite(s, 1);
  While i > 1 Do
  Begin
    j := SkipWhite(s, FindWhite(s, j));
    dec(i);
  end;
  i := FindWhite(s, j);
  result := copy(s, j, i - j);
End;

Function HexToStr(s: String): int64;
Var
  p: pchar;
  i, l: integer;
Begin
  result := 0;
  l := length(s);
  If l <> 0 Then
  Begin
    p := pointer(s);
    For i := 1 To l Do
    Begin
      result := result * 16;
      If p^ < '0' Then
        Raise exception.Create(s + ' is Not an hex value');
      If p^ <= '9' Then
        result := result + ord(p^) - ord('0')
      Else
      Begin
        If p^ < 'A' Then
          Raise exception.Create(s + ' is Not an hex value');
        If p^ <= 'F' Then
          result := result + ord(p^) - ord('A') + 10
        Else
        Begin
          If p^ < 'a' Then
            Raise exception.Create(s + ' is Not an hex value');
          If p^ <= 'f' Then
            result := result + ord(p^) - ord('a') + 10
          Else
            Raise exception.Create(s + ' is Not an hex value');
        End;
      End;
      inc(p);
    End;
  End;
End;

Procedure Repl(Var Dest: String; Source: String; pos: integer);
Begin
  If Pos + length(Source) > Length(Dest) Then
    SetLength(Dest, Pos + length(Source));
  move(pchar(source)^, dest[pos], length(source));
End;

Procedure StringToFile(s: String; f: TFileName);
Begin
  With TFileStream.Create(f, fmCreate) Do
  Try
    Write(pchar(s)^, length(s));
  Finally
    free;
  End;
End;

Function FileToString(f: TFileName; Readsize: integer): String;
Begin
  With TFileStream.Create(f, fmOpenRead) Do
  Try
    SetLength(result, max(size,Readsize));
    read(pchar(result)^, max(size,Readsize));
  Finally
    free;
  End;
End;

Function FileToString(f: TFileName): String;
Begin
  With TFileStream.Create(f, fmOpenRead) Do
  Try
    SetLength(result, size);
    read(pchar(result)^, size);
  Finally
    free;
  End;
End;

Function NibbleToByte(s: String): String;
Var
  i: integer;
Begin
  SetLength(result, (length(s) + 1) Div 2);
  For i := 0 To length(result) - 1 Do
    result[i + 1] := chr((ord(s[i * 2 + 1]) And $F) + ((ord(s[i * 2 + 2]) And $F) * 16));
End;

Function ByteToNibble(s: String): String;
Var
  i: integer;
Begin
  SetLength(result, length(s) * 2);
  For i := 0 To length(s) - 1 Do
  Begin
    result[i * 2 + 1] := chr(ord(s[i + 1]) And $F);
    result[i * 2 + 2] := chr((ord(s[i + 1]) Div 16) And $F);
  End;
End;

Function ByteToNibble2(s: String): String;
Var
  i: integer;
Begin
  SetLength(result, length(s) * 2);
  For i := 0 To length(s) - 1 Do
  Begin
    result[i * 2 + 1] := chr((ord(s[i + 1]) Div 16) And $F);
    result[i * 2 + 2] := chr(ord(s[i + 1]) And $F);
  End;
End;

Function SkipWhite(Const s: String; i: integer): integer;
Begin
  While (i <= length(s)) And (s[i] <= ' ') Do
    inc(i);
  result := i;
End;

Function FindWhite(Const s: String; i: integer): integer;
Begin
  While (i <= length(s)) And (s[i] > ' ') Do
    inc(i);
  result := i;
End;

Function NxtToken(Const s: String; i: integer): integer;
Begin
  result := SkipWhite(s, FindWhite(s, i));
End;

Function RemoveTAb(s: String; TabSize: integer = 2): String;
Var
  i, j, d: integer;
Begin
  i := 0;
  d := 0;
  For j := 1 To Length(s) Do
  Begin
    If Length(result) < I + TabSize + 1 Then
      SetLength(Result, I + TabSize + 10000);
    Case s[j] Of
      #9:
        Begin
          inc(i);
          result[i] := ' ';
          While (i - d) Mod TabSize <> 0 Do
          Begin
            inc(i);
            result[i] := ' ';
          End;
        End;
      #10:
        Begin
          inc(i);
          result[i] := s[j];
         d := i;
        End;
    Else
      Begin
        inc(i);
        result[i] := s[j];
      End;
    End;
  End;
  SetLength(result, i);
End;

Function Pos2(Const SubStr, S: String; InitialPos: integer): integer;
Var
  substrlenght: integer;

  Function StrEqual(p: integer): Boolean;
  Var
    i: integer;
  Begin
    For i := 1 To substrlenght Do
      If SubStr[i] <> s[i - 1 + p] Then
      Begin
        result := False;
        exit;
      End;
    result := true;
  End;

Begin
  substrlenght := Length(SubStr);
  If substrlenght = 0 Then
    result := 0
  Else
  Begin
    result := InitialPos;
    While (result <= length(s) - length(SubStr) + 1) And Not StrEqual(result) Do
      inc(result);
    If (result > length(s) - length(SubStr) + 1) Then
      result := 0;
  End;
End;

initialization
  CrcInitTable;

End.

