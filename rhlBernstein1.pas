unit rhlBernstein1;

interface

uses
  rhlCore;

type

  { TrhlBernstein1 }

  TrhlBernstein1 = class(TrhlHash)
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

{ TrhlBernstein1 }

procedure TrhlBernstein1.UpdateBytes(const ABuffer; ASize: LongWord);
var
  b: PByte;
begin
  b := @ABuffer;
  while ASize > 0 do
  begin
    m_hash := (m_hash * 33) xor b^;
    Inc(b);
    Dec(ASize);
  end;
end;

constructor TrhlBernstein1.Create;
begin
  HashSize := 4;
  BlockSize := 1;
end;

procedure TrhlBernstein1.Init;
begin
  inherited Init;
  m_hash := 5381;
end;

procedure TrhlBernstein1.Final(var ADigest);
begin
  Move(m_hash, ADigest, 4);
end;

end.
