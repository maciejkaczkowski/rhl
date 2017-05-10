unit rhlCore;
{$MODESWITCH ADVANCEDRECORDS+}
interface

uses
  sysutils;

type
  TBytes = array of Byte;

  { TrhlHashBuffer }

  TrhlHashBuffer = record
  private
    FBuffer: TBytes;
    FPos: LongWord;
    function GetSize: LongWord;
    procedure SetSize(AValue: LongWord);
  public
    procedure Init;
    function Feed(var AData; var ALength: LongWord; var AProcessedBytes: LongWord): LongWord;
    function IsEmpty: Boolean;
    function IsFull: Boolean;
    procedure SetZeroPadded;
    property Bytes: TBytes read FBuffer;
    property Size: LongWord read GetSize write SetSize;
    property Pos: LongWord read FPos;
  end;

  { TrhlHash }

  TrhlHash = class abstract(TObject)
  private
    function GetBlockSize: LongWord;
  protected
    FHashSize: LongWord;
    FBuffer: TrhlHashBuffer;
    FProcessedBytes: LongWord;
    procedure SetHashSize(AValue: LongWord); virtual;
    procedure SetBlockSize(AValue: LongWord);
    procedure UpdateBuffer; virtual;
    procedure UpdateBytes(const ABuffer; ASize: LongWord); virtual;
    procedure UpdateBlock(const ABuffer); virtual;
  public
    constructor Create; virtual; abstract;
    procedure Init; virtual;
    procedure Update(const AStr: ansistring); virtual;
    procedure Final(var ADigest); virtual; abstract;
    property HashSize: LongWord read FHashSize write SetHashSize;
    property BlockSize: LongWord read GetBlockSize write SetBlockSize;
  end;

  TrhlHashClass = class of TrhlHash;

  { TrhlHashWithKey }

  TrhlHashWithKey = class abstract(TrhlHash)
  protected
    function GetKey: TBytes; virtual;
    procedure SetKey(AValue: TBytes); virtual;
  public
    property Key: TBytes read GetKey write SetKey;
  end;

  TrhlHashWithKeyClass = class of TrhlHashWithKey;


function rhlHash(const text: ansistring; dig: TrhlHashClass): ansistring; overload;
function rhlHash(const text, key: ansistring; dig: TrhlHashWithKeyClass): ansistring; overload;
function rhlHMAC(message, key: ansistring; hash: TrhlHashClass; blocksize: Integer = 64): ansistring;
function rhlPBKDF1(const pass, salt: ansistring; count: Integer; hash: TrhlHashClass): ansistring; overload; // standard
function rhlPBKDF1(const pass, salt: ansistring; count, kLen: Integer; hash: TrhlHashClass; Reset: Boolean = True): ansistring; overload; // dotNET
function rhlPBKDF2(const pass, salt: ansistring; count, kLen: Integer; hash: TrhlHashClass): ansistring;

procedure ConvertBytesToDWordsSwapOrder(const b; l: Integer; var r);
procedure ConvertBytesToQWordsSwapOrder(const b; l: Integer; var r);
procedure ConvertQWordsToBytesSwapOrder(const w; l: Integer; var r);
procedure ConvertDWordsToBytesSwapOrder(const w; l: Integer; var r);

implementation

uses
  math;

function RPad(const x: ansistring; const c: Char; const s: Integer): ansistring;
var
  i: Integer;
begin
  Result := x;
  if Length(x) < s then
    for i := 1 to s-Length(x) do
      Result := Result + c;
end;

function XorBlock(s, x: ansistring): ansistring; inline;
var
  i: Integer;
begin
  SetLength(Result, Length(s));
  for i := 1 to Length(s) do
    Result[i] := Char(Byte(s[i]) xor Byte(x[i]));
end;

function rhlHash(const text: ansistring; dig: TrhlHashClass): ansistring;
var
  x: TrhlHash;
begin
  x := dig.Create;
  try
    x.Init;
    x.Update(text);
    SetLength(Result, x.HashSize);
    x.Final(Result[1]);
  finally
    x.Free;
  end;
end;

function rhlHash(const text, key: ansistring; dig: TrhlHashWithKeyClass
  ): ansistring;
var
  x: TrhlHashWithKey;
  b: TBytes;
  i: Integer;
begin
  x := dig.Create;
  try
    i := Length(key);
    if i > 0 then
    begin
      SetLength(b, i);
      Move(key[1], b[0], i);
      x.Key := b;
    end;
    x.Init;
    x.Update(text);
    SetLength(Result, x.HashSize);
    x.Final(Result[1]);
  finally
    x.Free;
  end;
end;

function rhlHMAC(message, key: ansistring; hash: TrhlHashClass;
  blocksize: Integer): ansistring;
begin
  // Definition RFC 2104
  if Length(key) > blocksize then
    key := rhlHash(key, hash);
  key := RPad(key, #0, blocksize);

  Result := rhlHash(XorBlock(key, RPad('', #$36, blocksize)) + message, hash);
  Result := rhlHash(XorBlock(key, RPad('', #$5c, blocksize)) + result, hash);
end;

function rhlPBKDF1(const pass, salt: ansistring; count: Integer; hash: TrhlHashClass
  ): ansistring;
var
  i: Integer;
begin
  Result := pass+salt;
  for i := 0 to count-1 do
    Result := rhlHash(Result, hash);
end;

function rhlPBKDF1(const pass, salt: ansistring; count, kLen: Integer;
  hash: TrhlHashClass; Reset: Boolean): ansistring;
{$WRITEABLECONST ON}
const
  PBKDF1_base: ansistring = '';
  PBKDF1_extra: ansistring = '';
  PBKDF1_extracount: Integer = 0;
  PBKDF1_hashno: Integer = 0;
  PBKDF1_state: Integer = 0;
{$WRITEABLECONST OFF}
var
  i: Integer;
  rlen: Integer;
  cb: Integer;
  clen: Integer;
  current: ansistring;
  remain: Integer;
begin
  //http://stackoverflow.com/questions/9011635/how-do-i-convert-this-c-sharp-rijndael-encryption-to-php

  if Reset then
  begin
    PBKDF1_state := 0;
    PBKDF1_hashno := 0;
    PBKDF1_extra := '';
    PBKDF1_extracount := 0;
    PBKDF1_base := '';
  end;

  cb := kLen;
  if (PBKDF1_state = 0) then
  begin
    PBKDF1_hashno := 0;
    PBKDF1_state := 1;

    PBKDF1_base := pass + salt;
    for i := 1 to count - 1 do
      PBKDF1_base := rhlHash(PBKDF1_base, hash);
  end;

  result := '';

  if (PBKDF1_extracount > 0) then
  begin
    rlen := Length(PBKDF1_extra) - PBKDF1_extracount;
    if (rlen >= cb) then
    begin
      result := Copy(PBKDF1_extra, PBKDF1_extracount+1, cb);
      if (rlen > cb) then
      begin
        PBKDF1_extracount := PBKDF1_extracount + cb;
      end
      else
      begin
        PBKDF1_extra := '';
        PBKDF1_extracount := 0;
      end;
      //return $result;
      exit;
    end;
    result := Copy(PBKDF1_extra, rlen+1, rlen);
  end;

  current := '';
  clen := 0;
  remain := cb - Length(result);
  while (remain > clen) do
  begin
    if (PBKDF1_hashno = 0) then
      current := rhlHash(PBKDF1_base, hash)
    else
    if (PBKDF1_hashno < 1000) then
      current := current + rhlHash(IntToStr(PBKDF1_hashno)+PBKDF1_base, hash)
    else
      exit;
    Inc(PBKDF1_hashno);
    clen := Length(current);
  end;

  // $current now holds at least as many bytes as we need
  result := result + Copy(current, 1, remain);

  // Save any left over bytes for any future requests
  if (clen > remain) then
  begin
    PBKDF1_extra := current;
    PBKDF1_extracount := remain;
  end;

  //return $result;
end;

function rhlPBKDF2(const pass, salt: ansistring; count, kLen: Integer;
  hash: TrhlHashClass): ansistring;

  function IntX(i: Integer): ansistring; inline;
  begin
    Result := Char(i shr 24) + Char(i shr 16) + Char(i shr 8) + Char(i);
  end;

var
  D, I, J: Integer;
  T, F, U: ansistring;
  H: TrhlHash;
begin
  H := hash.Create;
  try
    T := '';
    D := Ceil(kLen / (H.HashSize div 8));
  finally
    H.Free;
  end;
  for i := 1 to D do
  begin
    F := rhlHMAC(salt + IntX(i), pass, hash);
    U := F;
    for j := 2 to count do
    begin
      U := rhlHMAC(U, pass, hash);
      F := XorBlock(F, U);
    end;
    T := T + F;
  end;
  Result := Copy(T, 1, kLen);
end;

procedure ConvertBytesToDWordsSwapOrder(const b; l: Integer; var r);
var
  bb: array[0..0] of Byte absolute b;
  rr: array[0..0] of DWord absolute r;
  i, j: DWord;
begin
  i := 0;
  j := 0;
  while l > 0 do
  begin
    rr[i] :=
      (bb[j  ] shl 24) or
      (bb[j+1] shl 16) or
      (bb[j+2] shl  8) or
      (bb[j+3]);
    Inc(i);
    Inc(j, SizeOf(DWord));
    Dec(l, SizeOf(DWord));
  end;
end;

procedure ConvertBytesToQWordsSwapOrder(const b; l: Integer; var r);
var
  bb: array[0..0] of Byte absolute b;
  rr: array[0..0] of QWord absolute r;
  i, j: Integer;
begin
  i := 0;
  j := 0;
  while l > 0 do
  begin
    rr[i] :=
        (QWord(bb[j  ]) shl 56) or
        (QWord(bb[j+1]) shl 48) or
        (QWord(bb[j+2]) shl 40) or
        (QWord(bb[j+3]) shl 32) or
        (QWord(bb[j+4]) shl 24) or
        (QWord(bb[j+5]) shl 16) or
        (QWord(bb[j+6]) shl  8) or
        (QWord(bb[j+7]));
    Inc(i);
    Inc(j, SizeOf(QWord));
    Dec(l, SizeOf(QWord));
  end;
end;

procedure ConvertQWordsToBytesSwapOrder(const w; l: Integer; var r);
var
  i, j: Integer;
  ww: array[0..0] of QWord absolute w;
  t: QWord;
  rr: array[0..0] of Byte absolute r;
begin
  j := 0;
  i := 0;
  while l > 0 do
  begin
    t := ww[i];
    rr[j+0] := Byte($ff and (t shr 56));
    rr[j+1] := Byte($ff and (t shr 48));
    rr[j+2] := Byte($ff and (t shr 40));
    rr[j+3] := Byte($ff and (t shr 32));
    rr[j+4] := Byte($ff and (t shr 24));
    rr[j+5] := Byte($ff and (t shr 16));
    rr[j+6] := Byte($ff and (t shr 8));
    rr[j+7] := Byte($ff and (t));
    Inc(j, SizeOf(QWord));
    Inc(i);
    Dec(l);
  end
end;

procedure ConvertDWordsToBytesSwapOrder(const w; l: Integer; var r);
var
  ww: array[0..0] of DWord absolute w;
  t: DWord;
  rr: array[0..0] of Byte absolute r;
  i, j: Integer;
begin
  j := 0;
  i := 0;
  while l > 0 do
  begin
    t := ww[i];
    rr[j+0] := $ff and (t shr 24);
    rr[j+1] := $ff and (t shr 16);
    rr[j+2] := $ff and (t shr 8);
    rr[j+3] := $ff and (t);
    Inc(j, SizeOf(DWord));
    Inc(i);
    Dec(l);
  end
end;

{ TrhlHashWithKey }

function TrhlHashWithKey.GetKey: TBytes;
begin

end;

procedure TrhlHashWithKey.SetKey(AValue: TBytes);
begin

end;

{ TrhlHashBuffer }

function TrhlHashBuffer.GetSize: LongWord;
begin
  Result := Length(FBuffer);
end;

procedure TrhlHashBuffer.SetSize(AValue: LongWord);
begin
  SetLength(FBuffer, AValue);
end;

procedure TrhlHashBuffer.Init;
begin
  FPos := 0;
end;

function TrhlHashBuffer.Feed(var AData; var ALength: LongWord;
  var AProcessedBytes: LongWord): LongWord;
var
  len: LongWord;
begin
  if (ALength = 0) then
    Exit(0);

  len := GetSize - FPos;
  if (len > ALength) then
    len := ALength;

  Move(AData, FBuffer[FPos], len);
  Inc(FPos, len);
  Inc(AProcessedBytes, len);
  Dec(ALength, len);
  Result := len;
end;

function TrhlHashBuffer.IsEmpty: Boolean;
begin
  Result := FPos = 0;
end;

function TrhlHashBuffer.IsFull: Boolean;
begin
  Result := FPos = GetSize;
end;

procedure TrhlHashBuffer.SetZeroPadded;
var
  i: Integer;
begin
  for i := Pos to Size - 1 do
    FBuffer[i] := 0;
  FPos := 0;
end;

{ TrhlHash }

procedure TrhlHash.SetBlockSize(AValue: LongWord);
begin
  FBuffer.Size := AValue;
end;

function TrhlHash.GetBlockSize: LongWord;
begin
  Result := FBuffer.Size;
end;

procedure TrhlHash.SetHashSize(AValue: LongWord);
begin
  FHashSize := AValue;
end;

procedure TrhlHash.UpdateBuffer;
begin
  UpdateBlock(FBuffer.Bytes[0]);
end;

procedure TrhlHash.UpdateBytes(const ABuffer; ASize: LongWord);
var
  PBuf: ^Byte;
  Offset: LongWord;
begin
  PBuf := @ABuffer;

  if (not FBuffer.IsEmpty) then
  begin
    Offset := FBuffer.Feed(PBuf^, ASize, FProcessedBytes);
    if Offset > 0 then
    begin
      UpdateBuffer;
      Inc(PBuf, Offset);
    end;
  end;

  while (ASize >= FBuffer.Size) do
  begin
    Inc(FProcessedBytes, FBuffer.Size);
    UpdateBlock(PBuf^);
    Inc(PBuf, FBuffer.Size);
    Dec(ASize, FBuffer.Size);
  end;

  if (ASize > 0) then
    FBuffer.Feed(PBuf^, ASize, FProcessedBytes);
end;

procedure TrhlHash.UpdateBlock(const ABuffer);
begin

end;

procedure TrhlHash.Init;
begin
  FBuffer.Init;
  FProcessedBytes := 0;
end;

procedure TrhlHash.Update(const AStr: ansistring);
begin
  UpdateBytes(AStr[1], Length(AStr));
end;

end.
