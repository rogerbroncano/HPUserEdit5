unit Language;

interface

uses
  SysUtils, IniFiles, Globals;

type
  TLanguageFile = class(TIniFile)
  private
    FSection: string;
  public
    constructor Create(const FileName: string);
    destructor Destroy; override;
    function LoadItem(const Ident: string): string;
  published
    property Section: string read FSection write FSection;
  end;

procedure LoadLanguageMessages;

procedure LoadLanguageLabels;

implementation

procedure LoadLanguageMessages;
var
  I: Integer;
begin
  with TLanguageFile.Create(LangPath) do
  try
    Section := 'Messages';
    for I := 1 to High(Msgs) do
      Msgs[I] := LoadItem('Message' + IntToStr(I));
  finally
    Free;
  end;
end;

procedure LoadLanguageLabels;
var
  I: Integer;
begin
  with TLanguageFile.Create(LangPath) do
  try
    Section := 'Labels';
    for I := 1 to High(Caps) do
      Caps[I] := LoadItem('Label' + IntToStr(I));
  finally
    Free;
  end;
end;

{ TLanguageFile }

constructor TLanguageFile.Create(const FileName: string);
begin
  inherited Create(FileName);
end;

destructor TLanguageFile.Destroy;
begin
  inherited Destroy;
end;

function TLanguageFile.LoadItem(const Ident: string): string;
begin
  if Ident = '' then Result := '¿...?'
  else Result := ReadString(FSection, Ident, '¿...?');
end;

end.
