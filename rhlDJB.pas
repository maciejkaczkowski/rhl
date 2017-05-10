unit rhlDJB;

interface

uses
  rhlCore;

type

  { TrhlDJB }

  TrhlDJB = class(TrhlHash)
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

{ TrhlDJB }

procedure TrhlDJB.UpdateBytes(const ABuffer; ASize: LongWord);
var
  b: PByte;
begin
  b := @ABuffer;
  while ASize > 0 do
  begin
    m_hash := ((m_hash shl 5) + m_hash) + b^;
    Inc(b);
    Dec(ASize);
  end;
end;

constructor TrhlDJB.Create;
begin
  HashSize := 4;
  BlockSize := 1;
end;

procedure TrhlDJB.Init;
begin
  inherited Init;
  m_hash := 5381;
end;

procedure TrhlDJB.Final(var ADigest);
begin
  Move(m_hash, ADigest, 4);
end;

end.
