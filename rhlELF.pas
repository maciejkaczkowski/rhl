unit rhlELF;

interface

uses
  rhlCore;

type

  { TrhlELF }

  TrhlELF = class(TrhlHash)
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

{ TrhlELF }

procedure TrhlELF.UpdateBytes(const ABuffer; ASize: LongWord);
var
  b: PByte;
  g: DWord;
begin
  b := @ABuffer;
  while ASize > 0 do
  begin
    m_hash := (m_hash shl 4) + b^;
    g := m_hash and $f0000000;

    if (g <> 0) then
      m_hash := m_hash xor (g shr 24);

    m_hash := m_hash and (not g);

    Inc(b);
    Dec(ASize);
  end;
end;

constructor TrhlELF.Create;
begin
  HashSize := 4;
  BlockSize := 1;
end;

procedure TrhlELF.Init;
begin
  inherited Init;
  m_hash := 0;
end;

procedure TrhlELF.Final(var ADigest);
begin
  Move(m_hash, ADigest, 4);
end;

end.
