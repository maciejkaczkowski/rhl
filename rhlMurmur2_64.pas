unit rhlMurmur2_64;

interface

uses
  rhlCore;

type

  { TrhlMurmur2_64 }

  TrhlMurmur2_64 = class(TrhlHashWithKey)
  private
    const
      CKEY: DWord = $C58F1A7B;
      M: QWord = $C6A4A7935BD1E995;
      R: Integer = 47;
    var
      m_key,
      m_working_key: DWord;
      m_h: QWord;
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

{ TrhlMurmur2_64 }

procedure TrhlMurmur2_64.UpdateBytes(const ABuffer; ASize: LongWord);
var
  a_data: array[0..0] of Byte absolute ABuffer;
  ci: Integer;
  k: QWord;
begin
  if (ASize = 0) then
    Exit;

  m_h := m_working_key xor ASize;
  ci := 0;

  while (ASize >= 8) do
  begin
    k := (QWord(a_data[ci+0])) or (QWord(a_data[ci+1]) shl 8) or
         (QWord(a_data[ci+2]) shl 16) or (QWord(a_data[ci+3]) shl 24) or
         (QWord(a_data[ci+4]) shl 32) or (QWord(a_data[ci+5]) shl 40) or
         (QWord(a_data[ci+6]) shl 48) or (QWord(a_data[ci+7]) shl 56);

    k := k * M;
    k := k xor (k shr R);
    k := k * M;

    m_h := m_h xor k;
    m_h := m_h * M;

    Inc(ci, 8);
    Dec(ASize, 8);
  end;

  case ASize of
    7: m_h := m_h xor ((QWord(a_data[ci+0]) shl 48) or (QWord(a_data[ci+1]) shl 40) or
                       (QWord(a_data[ci+2]) shl 32) or (QWord(a_data[ci+3]) shl 24) or
                       (QWord(a_data[ci+4]) shl 16) or (QWord(a_data[ci+5]) shl 8) or
                        QWord(a_data[ci+6]));
    6: m_h := m_h xor ((QWord(a_data[ci+0]) shl 40) or (QWord(a_data[ci+1]) shl 32) or
                       (QWord(a_data[ci+2]) shl 24) or (QWord(a_data[ci+3]) shl 16) or
                       (QWord(a_data[ci+4]) shl 8)  or  QWord(a_data[ci+5]));
    5: m_h := m_h xor ((QWord(a_data[ci+0]) shl 32) or (QWord(a_data[ci+1]) shl 24) or
                       (QWord(a_data[ci+2]) shl 16) or (QWord(a_data[ci+3]) shl 8) or
                        QWord(a_data[ci+4]));
    4: m_h := m_h xor ((QWord(a_data[ci+0]) shl 24) or (QWord(a_data[ci+1]) shl 16) or
                       (QWord(a_data[ci+2]) shl 8)  or  QWord(a_data[ci+3]));
    3: m_h := m_h xor ((QWord(a_data[ci+0]) shl 16) or (QWord(a_data[ci+1]) shl 8) or
                        QWord(a_data[ci+2]));
    2: m_h := m_h xor ((QWord(a_data[ci+0]) shl 8)  or  QWord(a_data[ci+1]));
    1: m_h := m_h xor  (QWord(a_data[ci+0]));
  end;

  if ASize >= 1 then
    m_h := m_h * M;

  m_h := m_h xor (m_h shr R);
  m_h := m_h * M;
  m_h := m_h xor (m_h shr R);
end;

function TrhlMurmur2_64.GetKey: TBytes;
begin
  SetLength(Result, SizeOf(DWord));
  Move(m_key, Result[0], SizeOf(DWord));
end;

procedure TrhlMurmur2_64.SetKey(AValue: TBytes);
begin
  if Length(AValue) = SizeOf(m_key) then
    Move(AValue[0], m_key, SizeOf(m_key));
end;

constructor TrhlMurmur2_64.Create;
begin
  HashSize := 8;
  BlockSize := 8;
  m_key := CKEY;
end;

procedure TrhlMurmur2_64.Init;
begin
  inherited Init;
  m_working_key := m_key;
end;

procedure TrhlMurmur2_64.Final(var ADigest);
begin
  Move(m_h, ADigest, SizeOf(m_h));
end;

end.
