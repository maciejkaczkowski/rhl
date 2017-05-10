unit rhlFNV;

interface

uses
  rhlCore;

type

  { TrhlFNV }

  TrhlFNV = class(TrhlHash)
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

{ TrhlFNV }

procedure TrhlFNV.UpdateBytes(const ABuffer; ASize: LongWord);
var
  b: PByte;
begin
  b := @ABuffer;
  while ASize > 0 do
  begin
    m_hash := (m_hash * 16777619) xor b^;
    Inc(b);
    Dec(ASize);
  end;
end;

constructor TrhlFNV.Create;
begin
  HashSize := 4;
  BlockSize := 1;
end;

procedure TrhlFNV.Init;
begin
  inherited Init;
  m_hash := 2166136261;
end;

procedure TrhlFNV.Final(var ADigest);
begin
  Move(m_hash, ADigest, 4);
end;

end.
