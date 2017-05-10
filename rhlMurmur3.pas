unit rhlMurmur3;

interface

uses
  rhlCore;

type

  { TrhlMurmur3 }

  TrhlMurmur3 = class(TrhlHashWithKey)
  private
    const
      CKEY: DWord = $C58F1A7B;
    var
      m_h: DWord;
      m_key: DWord;
  protected
    procedure UpdateBytes(const ABuffer; ASize: LongWord); override;
    function GetKey: TBytes; override;
    procedure SetKey(AValue: TBytes); override;
  public
    constructor Create; override;
    procedure Init; override;
    procedure Final(var ADigest); override;
  end;

implementation

{ TrhlMurmur3 }

procedure TrhlMurmur3.UpdateBytes(const ABuffer; ASize: LongWord);
const
  c: array[1..5] of DWord = ( $CC9E2D51, $1B873593, $E6546B64, $85EBCA6B, $C2B2AE35);
var
  ci: Integer;
  k: DWord;
  a_data: array[0..0] of Byte absolute ABuffer;
  len: DWord;
begin
  m_h := m_key;

  ci := 0;
  len := ASize;

  while (len >= 4) do
  begin
     k := (a_data[ci+0]) or
          (a_data[ci+1] shl 8) or
          (a_data[ci+2] shl 16) or
          (a_data[ci+3] shl 24);

    k := RolDWord(k * C[1], 15) * C[2];
    m_h := RolDWord(m_h xor k, 13) * 5 + C[3];

    Inc(ci, 4);
    Dec(len, 4);
  end;

  case (len) of
    3: k := (a_data[ci + 2] shl 16) or (a_data[ci + 1] shl 8) or a_data[ci];
    2: k := (a_data[ci + 1] shl 8) or a_data[ci];
    1: k := a_data[ci];
  end;

  if len >= 1 then
    m_h := m_h xor RolDWord(k * C[1], 15) * C[2];

  m_h := m_h xor ASize;

  m_h := m_h xor (m_h shr 16);
  m_h := m_h * C[4];
  m_h := m_h xor (m_h shr 13);
  m_h := m_h * C[5];
  m_h := m_h xor (m_h shr 16);
end;

function TrhlMurmur3.GetKey: TBytes;
begin
  SetLength(Result, SizeOf(m_key));
  Move(m_key, Result[0], SizeOf(m_key));
end;

procedure TrhlMurmur3.SetKey(AValue: TBytes);
begin
  if Length(AValue) = SizeOf(m_key) then
    Move(AValue[0], m_key, SizeOf(m_key));
end;

constructor TrhlMurmur3.Create;
begin
  HashSize := 4;
  BlockSize := 4;
  m_key := CKEY;
end;

procedure TrhlMurmur3.Init;
begin
  inherited Init;
  m_h := m_key;
end;

procedure TrhlMurmur3.Final(var ADigest);
begin
  Move(m_h, ADigest, 4);
end;

end.
