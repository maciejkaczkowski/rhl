unit rhlRotating;

interface

uses
  rhlCore;

type

  { TrhlRotating }

  TrhlRotating = class(TrhlHash)
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

{ TrhlRotating }

procedure TrhlRotating.UpdateBytes(const ABuffer; ASize: LongWord);
var
  b: PByte;
begin
  b := @ABuffer;
  while ASize > 0 do
  begin
    m_hash := (m_hash shl 4) xor (m_hash shr 28) xor b^;
    Inc(b);
    Dec(ASize);
  end;
end;

constructor TrhlRotating.Create;
begin
  HashSize := 4;
  BlockSize := 1;
end;

procedure TrhlRotating.Init;
begin
  inherited Init;
  m_hash := 0;
end;

procedure TrhlRotating.Final(var ADigest);
begin
  Move(m_hash, ADigest, 4);
end;

end.
