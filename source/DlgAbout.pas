unit DlgAbout;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  JvExControls, JvComponent, JvLinkLabel, ExtCtrls, StdCtrls, jpeg, JvGIF;

type
  TAboutDialog = class(TForm)
    Image: TImage;
    Timer: TTimer;
    Version: TLabel;
    About: TLabel;
    Credits: TLabel;
    Delphi: TImage;
    procedure ImageClick(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    function GetUserEditVersion: string;
  public
    procedure MakeSplash;
  end;

var
  AboutDialog: TAboutDialog;

implementation

{$R *.DFM}

procedure TAboutDialog.FormCreate(Sender: TObject);
begin
  Version.Caption := 'v' + GetUserEditVersion;
end;

function TAboutDialog.GetUserEditVersion: string;
var
  FData: Pointer;
  FSize: Cardinal;
  sz, lpHandle, tbl: Cardinal;
  lpBuffer: Pointer;
  str: PChar;
  strtbl: string;
  int: PInteger;
  hiW, loW: Word;
begin
  FSize := GetFileVersionInfoSize(PChar(ParamStr(0)), lpHandle);
  FData := AllocMem(FSize);
  GetFileVersionInfo(PChar(ParamStr(0)), lpHandle, FSize, FData);
  VerQueryValue(FData, '\\VarFileInfo\Translation', lpBuffer, sz);
  int := lpBuffer;
  hiW := HiWord(int^);
  loW := LoWord(int^);
  tbl := (loW shl 16) or hiW;
  strtbl := Format('%x', [tbl]);
  if Length(strtbl) < 8 then strtbl := '0' + strtbl;
  VerQueryValue(FData, PChar('\\StringFileInfo\' + strtbl + '\FileVersion'), lpBuffer, sz);
  str := lpBuffer;
  Result := str;
end;

procedure TAboutDialog.ImageClick(Sender: TObject);
begin
  Close;
end;

procedure TAboutDialog.MakeSplash;
begin
  About.Visible := False;
  Credits.Visible := False;
  Version.Visible := False;
  Delphi.Visible := False;
  BorderStyle := bsNone;
  FormStyle := fsStayOnTop;
  Show;
  Update;
end;

procedure TAboutDialog.TimerTimer(Sender: TObject);
begin
  Close;
  Release;
end;

end.

