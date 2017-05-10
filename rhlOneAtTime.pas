unit rhlOneAtTime;

interface

uses
  rhlCore;

type

  { TrhlOneAtTime }

  TrhlOneAtTime = class(TrhlHash)
  private
    m_hash: DWord;
  protected
    procedure UpdateBytes(const ABuffer; ASize: LongWord); override;
  public
    constructor Create; override;
    procedure Init; override;
    procedure Final(var ADigest); override;
  end;

implementation

{ TrhlOneAtTime }

procedure TrhlOneAtTime.UpdateBytes(const ABuffer; ASize: LongWord);
var
  b: PByte;
begin
  b := @ABuffer;
  while ASize > 0 do
  begin
    Inc(m_hash, b^);
    Inc(m_hash, m_hash shl 10);
    m_hash := m_hash xor (m_hash shr 6);

    Inc(b);
    Dec(ASize);
  end;
end;

constructor TrhlOneAtTime.Create;
begin
  HashSize := 4;
  BlockSize := 1;
end;

procedure TrhlOneAtTime.Init;
begin
  inherited Init;
  m_hash := 0;
end;

procedure TrhlOneAtTime.Final(var ADigest);
begin
  Inc(m_hash, m_hash shl 3);
  m_hash := m_hash xor (m_hash shr 11);
  Inc(m_hash, m_hash shl 15);

  Move(m_hash, ADigest, 4);
end;

end.
