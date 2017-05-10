unit rhlSipHash;

interface

uses
  rhlCore, sysutils, Dialogs;

type

  { TrhlSipHash }

  TrhlSipHash = class(TrhlHashWithKey)
  private
    const
      V0: QWord = $736f6d6570736575;
      V1: QWord = $646f72616e646f6d;
      V2: QWord = $6c7967656e657261;
      V3: QWord = $7465646279746573;

      KEY0: QWord = $0706050403020100;
      KEY1: QWord = $0F0E0D0C0B0A0908;
    var
      m_v0,
      m_v1,
      m_v2,
      m_v3,
      m_key0,
      m_key1: QWord;
    procedure m_round;
  protected
    procedure UpdateBlock(const AData); override;
    function GetKey: TBytes; override;
    procedure SetKey(AValue: TBytes); override;
  public
    constructor Create; override;
    procedure Init; override;
    procedure Final(var ADigest); override;
  end;

implementation

{ TrhlSipHash }

procedure TrhlSipHash.m_round;
begin
  m_v0 += m_v1;
  m_v1 := RolQWord(m_v1, 13);
  m_v1 := m_v1 xor m_v0;
  m_v0 := RolQWord(m_v0, 32);
  m_v2 += m_v3;
  m_v3 := RolQWord(m_v3, 16);
  m_v3 := m_v3 xor m_v2;
  m_v0 += m_v3;
  m_v3 := RolQWord(m_v3, 21);
  m_v3 := m_v3 xor m_v0;
  m_v2 += m_v1;
  m_v1 := RolQWord(m_v1, 17);
  m_v1 := m_v1 xor m_v2;
  m_v2 := RolQWord(m_v2, 32);
end;

procedure TrhlSipHash.UpdateBlock(const AData);
var
  m: QWord absolute AData;
begin
  m_v3 := m_v3 xor m;
  m_round;
  m_round;
  m_v0 := m_v0 xor m;
end;

function TrhlSipHash.GetKey: TBytes;
begin
  SetLength(Result, SizeOf(QWord)*2);
  Move(m_key0, Result[0], SizeOf(QWord));
  Move(m_key1, Result[8], SizeOf(QWord));
end;

procedure TrhlSipHash.SetKey(AValue: TBytes);
begin
  if Length(AValue) = SizeOf(m_key0)*2 then
  begin
    Move(AValue[0], m_key0, SizeOf(m_key0));
    Move(AValue[8], m_key1, SizeOf(m_key1));
  end;
end;

constructor TrhlSipHash.Create;
begin
  HashSize := 8;
  BlockSize := 8;
  m_key0 := KEY0;
  m_key1 := KEY1;
end;

procedure TrhlSipHash.Init;
begin
  inherited Init;
  m_v0 := V0;
  m_v1 := V1;
  m_v2 := V2;
  m_v3 := V3;

  m_v3 := m_v3 xor m_key1;
  m_v2 := m_v2 xor m_key0;
  m_v1 := m_v1 xor m_key1;
  m_v0 := m_v0 xor m_key0;
end;

procedure TrhlSipHash.Final(var ADigest);
var
  b: QWord;
  left: QWord;
  i: Integer;
begin
  b := QWord(FProcessedBytes) shl 56;

  FBuffer.SetZeroPadded;
  Move(FBuffer.Bytes[0], left, SizeOf(QWord));
  b := b or left;

  UpdateBlock(b);
  m_v2 := m_v2 xor $ff;

  for i := 0 to 3 do
    m_round;

  m_v0 := m_v0 xor m_v1 xor m_v2 xor m_v3;
  Move(m_v0, ADigest, SizeOf(QWord));
end;

end.
