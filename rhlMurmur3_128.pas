unit rhlMurmur3_128;

interface

uses
  rhlCore;

type

  { TrhlMurmur3_128 }

  TrhlMurmur3_128 = class(TrhlHashWithKey)
  private
    const
      CKEY: DWord = $C58F1A7B;
      C1: QWord = $87C37B91114253D5;
      C2: QWord = $4CF5AD432745937F;
      C3: DWord = $52DCE729;
      C4: DWord = $38495AB5;
      C5: QWord = $FF51AFD7ED558CCD;
      C6: QWord = $C4CEB9FE1A85EC53;
    var
      m_h1, m_h2: QWord;
      m_key: DWord;
  protected
    procedure UpdateBlock(const ABuffer); override;
    function GetKey: TBytes; override;
    procedure SetKey(AValue: TBytes); override;
  public
    constructor Create; override;
    procedure Init; override;
    procedure Final(var ADigest); override;
  end;

implementation

{ TrhlMurmur3_128 }

procedure TrhlMurmur3_128.UpdateBlock(const ABuffer);
var
  k1, k2: QWord;
  a_data: array[0..0] of Byte absolute ABuffer;
begin
  k1 := QWord(a_data[0]) or QWord(a_data[1]) shl 8 or
        QWord(a_data[2]) shl 16 or QWord(a_data[3]) shl 24 or
        QWord(a_data[4]) shl 32 or QWord(a_data[5]) shl 40 or
        QWord(a_data[6]) shl 48 or QWord(a_data[7]) shl 56;

  k1 := k1 * C1;
  k1 := (k1 shl 31) or (k1 shr 33);
  k1 := k1 * C2;
  m_h1 := m_h1 xor k1;

  m_h1 := (m_h1 shl 27) or (m_h1 shr 37);
  m_h1 := m_h1 + m_h2;
  m_h1 := m_h1 * 5 + C3;

  k2 := QWord(a_data[8]) or QWord(a_data[9]) shl 8 or
        QWord(a_data[10]) shl 16 or QWord(a_data[11]) shl 24 or
        QWord(a_data[12]) shl 32 or QWord(a_data[13]) shl 40 or
        QWord(a_data[14]) shl 48 or QWord(a_data[15]) shl 56;

  k2 *= C2;
  k2 := (k2 shl 33) or (k2 shr 31);
  k2 *= C1;
  m_h2 := m_h2 xor k2;

  m_h2 := (m_h2 shl 31) or (m_h2 shr 33);
  m_h2 += m_h1;
  m_h2 := m_h2 * 5 + C4;
end;

function TrhlMurmur3_128.GetKey: TBytes;
begin
  SetLength(Result, SizeOf(DWord));
  Move(m_key, Result[0], SizeOf(DWord));
end;

procedure TrhlMurmur3_128.SetKey(AValue: TBytes);
begin
  if Length(AValue) = SizeOf(m_key) then
    Move(AValue[0], m_key, SizeOf(m_key));
end;

constructor TrhlMurmur3_128.Create;
begin
  HashSize := 16;
  BlockSize := 16;
  m_key := CKEY;
end;

procedure TrhlMurmur3_128.Init;
begin
  inherited Init;
  m_h1 := m_key;
  m_h2 := m_key;
end;

procedure TrhlMurmur3_128.Final(var ADigest);
var
  data: array[0..15] of Byte;
  k2, k1: QWord;
  len: Integer;
  b: PByte;
begin
  len := FBuffer.Pos;
  FBuffer.SetZeroPadded;
  Move(FBuffer.Bytes[0], data[0], SizeOf(data));

  case len of
    15:
      begin
        k2 := QWord(data[14]) << 48 xor
              QWord(data[13]) << 40 xor
              QWord(data[12]) << 32 xor
              QWord(data[11]) << 24 xor
              QWord(data[10]) << 16 xor
              QWord(data[9]) << 8 xor
              QWord(data[8]) << 0;
        k2 *= C2;
        k2 := (k2 << 33) or (k2 >> 31);
        k2 *= C1;
        m_h2 := m_h2 xor k2;
      end;
    14:
      begin
        k2 := QWord(data[13]) << 40 xor
              QWord(data[12]) << 32 xor
              QWord(data[11]) << 24 xor
              QWord(data[10]) << 16 xor
              QWord(data[9]) << 8 xor
              QWord(data[8]) << 0;
        k2 *= C2;
        k2 := (k2 << 33) or (k2 >> 31);
        k2 *= C1;
        m_h2 := m_h2 xor k2;
      end;
    13:
      begin
        k2 := QWord(data[12]) << 32 xor
              QWord(data[11]) << 24 xor
              QWord(data[10]) << 16 xor
              QWord(data[9]) << 8 xor
              QWord(data[8]) << 0;
        k2 *= C2;
        k2 := (k2 << 33) or (k2 >> 31);
        k2 *= C1;
        m_h2 := m_h2 xor k2;
      end;
    12:
      begin
        k2 := QWord(data[11]) << 24 xor
              QWord(data[10]) << 16 xor
              QWord(data[9]) << 8 xor
              QWord(data[8]) << 0;
        k2 *= C2;
        k2 := (k2 << 33) or (k2 >> 31);
        k2 *= C1;
        m_h2 := m_h2 xor k2;
      end;
    11:
      begin
        k2 := QWord(data[10]) << 16 xor
              QWord(data[9]) << 8 xor
              QWord(data[8]) << 0;
        k2 *= C2;
        k2 := (k2 << 33) or (k2 >> 31);
        k2 *= C1;
        m_h2 := m_h2 xor k2;
      end;
    10:
      begin
        k2 := QWord(data[9]) << 8 xor
              QWord(data[8]) << 0;
        k2 *= C2;
        k2 := (k2 << 33) or (k2 >> 31);
        k2 *= C1;
        m_h2 := m_h2 xor k2;
      end;
    9:
      begin
        k2 := QWord(data[8]) << 0;
        k2 *= C2;
        k2 := (k2 << 33) or (k2 >> 31);
        k2 *= C1;
        m_h2 := m_h2 xor k2;
      end;
  end;

  if (len > 8) then
    len := 8;

  case len of
    8:
      begin
        k1 := QWord(data[7]) << 56 xor
              QWord(data[6]) << 48 xor
              QWord(data[5]) << 40 xor
              QWord(data[4]) << 32 xor
              QWord(data[3]) << 24 xor
              QWord(data[2]) << 16 xor
              QWord(data[1]) << 8 xor
              QWord(data[0]) << 0;
        k1 *= C1;
        k1 := (k1 << 31) or (k1 >> 33);
        k1 *= C2;
        m_h1 := m_h1 xor k1;
      end;
    7:
      begin
        k1 := QWord(data[6]) << 48 xor
              QWord(data[5]) << 40 xor
              QWord(data[4]) << 32 xor
              QWord(data[3]) << 24 xor
              QWord(data[2]) << 16 xor
              QWord(data[1]) << 8 xor
              QWord(data[0]) << 0;
        k1 *= C1;
        k1 := (k1 << 31) or (k1 >> 33);
        k1 *= C2;
        m_h1 := m_h1 xor k1;
      end;
    6:
      begin
        k1 := QWord(data[5]) << 40 xor
              QWord(data[4]) << 32 xor
              QWord(data[3]) << 24 xor
              QWord(data[2]) << 16 xor
              QWord(data[1]) << 8 xor
              QWord(data[0]) << 0;
        k1 *= C1;
        k1 := (k1 << 31) or (k1 >> 33);
        k1 *= C2;
        m_h1 := m_h1 xor k1;
      end;
    5:
      begin
        k1 := QWord(data[4]) << 32 xor
              QWord(data[3]) << 24 xor
              QWord(data[2]) << 16 xor
              QWord(data[1]) << 8 xor
              QWord(data[0]) << 0;
        k1 *= C1;
        k1 := (k1 << 31) or (k1 >> 33);
        k1 *= C2;
        m_h1 := m_h1 xor k1;
      end;
    4:
      begin
        k1 := QWord(data[3]) << 24 xor
              QWord(data[2]) << 16 xor
              QWord(data[1]) << 8 xor
              QWord(data[0]) << 0;
        k1 *= C1;
        k1 := (k1 << 31) or (k1 >> 33);
        k1 *= C2;
        m_h1 := m_h1 xor k1;
      end;
    3:
      begin
        k1 := QWord(data[2]) << 16 xor
              QWord(data[1]) << 8 xor
              QWord(data[0]) << 0;
        k1 *= C1;
        k1 := (k1 << 31) or (k1 >> 33);
        k1 *= C2;
        m_h1 := m_h1 xor k1;
      end;
    2:
      begin
        k1 := QWord(data[1]) << 8 xor
              QWord(data[0]) << 0;
        k1 *= C1;
        k1 := (k1 << 31) or (k1 >> 33);
        k1 *= C2;
        m_h1 := m_h1 xor k1;
      end;
    1:
      begin
        k1 := QWord(data[0]) << 0;
        k1 *= C1;
        k1 := (k1 << 31) or (k1 >> 33);
        k1 *= C2;
        m_h1 := m_h1 xor k1;
      end;
  end;

  m_h1 := m_h1 xor QWord(FProcessedBytes);
  m_h2 := m_h2 xor QWord(FProcessedBytes);

  m_h1 += m_h2;
  m_h2 += m_h1;

  m_h1 := m_h1 xor (m_h1 >> 33);
  m_h1 *= C5;
  m_h1 := m_h1 xor (m_h1 >> 33);
  m_h1 *= C6;
  m_h1 := m_h1 xor (m_h1 >> 33);

  m_h2 := m_h2 xor (m_h2 >> 33);
  m_h2 *= C5;
  m_h2 := m_h2 xor (m_h2 >> 33);
  m_h2 *= C6;
  m_h2 := m_h2 xor (m_h2 >> 33);

  m_h1 += m_h2;
  m_h2 += m_h1;

  b := @ADigest;
  Move(m_h1, b^, SizeOf(QWord));
  Inc(b, SizeOf(QWord));
  Move(m_h2, b^, SizeOf(QWord));
end;

end.
