unit rhlFNV1a64;

interface

uses
  rhlCore;

type

  { TrhlFNV1a64 }

  TrhlFNV1a64 = class(TrhlHash)
  private
    m_hash: QWord;
  protected
    procedure UpdateBytes(const ABuffer; ASize: LongWord); override;
  public
    constructor Create; override;
    procedure Init; override;
    procedure Final(var ADigest); override;
  end;

implementation

{ TrhlFNV1a64 }

procedure TrhlFNV1a64.UpdateBytes(const ABuffer; ASize: LongWord);
var
  b: PByte;
begin
  b := @ABuffer;
  while ASize > 0 do
  begin
    m_hash := (m_hash xor b^) * 1099511628211;
    Inc(b);
    Dec(ASize);
  end;
end;

constructor TrhlFNV1a64.Create;
begin
  HashSize := 8;
  BlockSize := 1;
end;

procedure TrhlFNV1a64.Init;
begin
  inherited Init;
  m_hash := 14695981039346656037;
end;

procedure TrhlFNV1a64.Final(var ADigest);
begin
  Move(m_hash, ADigest, SizeOf(m_hash));
end;

end.
