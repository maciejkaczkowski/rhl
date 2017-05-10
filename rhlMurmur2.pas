unit rhlMurmur2;

interface

uses
  rhlCore;

type

  { TrhlMurmur2 }

  TrhlMurmur2 = class(TrhlHashWithKey)
  private
    const
      CKEY: DWord = $C58F1A7B;
      M: DWord = $5BD1E995;
      R: Integer = 24;
    var
      m_key,
      m_working_key,
      m_h: DWord;
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

{ TrhlMurmur2 }

procedure TrhlMurmur2.UpdateBytes(const ABuffer; ASize: LongWord);
var
  a_data: array[0..0] of Byte absolute ABuffer;
  ci: Integer;
  k: DWord;
begin
  if (ASize = 0) then
    Exit;

  m_h := m_working_key xor ASize;
  ci := 0;

  while (ASize >= 4) do
  begin
    k := a_data[ci+0] or (a_data[ci+1] shl 8) or (a_data[ci+2] shl 16) or (a_data[ci+3] shl 24);

    k := k * M;
    k := k xor (k shr R);
    k := k * M;

    m_h := m_h * M;
    m_h := m_h xor k;

    Inc(ci, 4);
    Dec(ASize, 4);
  end;

  case ASize of
    3:  m_h := m_h xor (a_data[ci+0] or a_data[ci+1] shl 8) xor (a_data[ci+2] shl 16);
    2:  m_h := m_h xor (a_data[ci+0] or a_data[ci+1] shl 8);
    1:  m_h := m_h xor (a_data[ci]);
  end;

  if ASize >= 1 then
    m_h := m_h * M;

  m_h := m_h xor (m_h shr 13);
  m_h := m_h * M;
  m_h := m_h xor (m_h shr 15);
end;

function TrhlMurmur2.GetKey: TBytes;
begin
  SetLength(Result, SizeOf(DWord));
  Move(m_key, Result[0], SizeOf(DWord));
end;

procedure TrhlMurmur2.SetKey(AValue: TBytes);
begin
  if Length(AValue) = SizeOf(m_key) then
    Move(AValue[0], m_key, SizeOf(m_key));
end;

constructor TrhlMurmur2.Create;
begin
  HashSize := 4;
  BlockSize := 4;
  m_key := CKEY;
end;

procedure TrhlMurmur2.Init;
begin
  inherited Init;
  m_working_key := m_key;
end;

procedure TrhlMurmur2.Final(var ADigest);
begin
  Move(m_h, ADigest, 4);
end;

end.
