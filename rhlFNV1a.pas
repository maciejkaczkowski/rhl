unit rhlFNV1a;

interface

uses
  rhlCore;

type

  { TrhlFNV1a }

  TrhlFNV1a = class(TrhlHash)
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

{ TrhlFNV1a }

procedure TrhlFNV1a.UpdateBytes(const ABuffer; ASize: LongWord);
var
  b: PByte;
begin
  b := @ABuffer;
  while ASize > 0 do
  begin
    m_hash := (m_hash xor b^) * 16777619;
    Inc(b);
    Dec(ASize);
  end;
end;

constructor TrhlFNV1a.Create;
begin
  HashSize := 4;
  BlockSize := 1;
end;

procedure TrhlFNV1a.Init;
begin
  inherited Init;
  m_hash := 2166136261;
end;

procedure TrhlFNV1a.Final(var ADigest);
begin
  Move(m_hash, ADigest, 4);
end;

end.
