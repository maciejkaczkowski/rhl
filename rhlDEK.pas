unit rhlDEK;

interface

uses
  rhlCore;

type

  { TrhlDEK }

  TrhlDEK = class(TrhlHash)
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

{ TrhlDEK }

procedure TrhlDEK.UpdateBytes(const ABuffer; ASize: LongWord);
var
  b: PByte;
begin
  m_hash := ASize;
  b := @ABuffer;
  while ASize > 0 do
  begin
    m_hash := ((m_hash shl 5) xor (m_hash shr 27)) xor b^;
    Inc(b);
    Dec(ASize);
  end;
end;

constructor TrhlDEK.Create;
begin
  HashSize := 4;
  BlockSize := 1;
end;

procedure TrhlDEK.Init;
begin
  inherited Init;
  m_hash := 0;
end;

procedure TrhlDEK.Final(var ADigest);
begin
  Move(m_hash, ADigest, 4);
end;

end.
