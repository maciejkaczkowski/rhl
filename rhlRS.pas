unit rhlRS;

interface

uses
  rhlCore;

type

  { TrhlRS }

  TrhlRS = class(TrhlHash)
  private
    m_hash, m_a: DWord;
  protected
    procedure UpdateBytes(const ABuffer; ASize: LongWord); override;
  public
    constructor Create; override;
    procedure Init; override;
    procedure Final(var ADigest); override;
  end;

implementation

{ TrhlRS }

procedure TrhlRS.UpdateBytes(const ABuffer; ASize: LongWord);
var
  b: PByte;
begin
  b := @ABuffer;
  while ASize > 0 do
  begin
    m_hash := (m_hash * m_a) + b^;
    m_a := m_a * 378551;
    Inc(b);
    Dec(ASize);
  end;
end;

constructor TrhlRS.Create;
begin
  HashSize := 4;
  BlockSize := 1;
end;

procedure TrhlRS.Init;
begin
  inherited Init;
  m_hash := 0;
  m_a := 63689;
end;

procedure TrhlRS.Final(var ADigest);
begin
  Move(m_hash, ADigest, 4);
end;

end.
