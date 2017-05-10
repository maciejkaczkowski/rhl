unit rhlJS;

interface

uses
  rhlCore;

type

  { TrhlJS }

  TrhlJS = class(TrhlHash)
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

{ TrhlJS }

procedure TrhlJS.UpdateBytes(const ABuffer; ASize: LongWord);
var
  b: PByte;
begin
  b := @ABuffer;
  while ASize > 0 do
  begin
    m_hash := m_hash xor ((m_hash shl 5) + b^ + (m_hash shr 2));
    Inc(b);
    Dec(ASize);
  end;
end;

constructor TrhlJS.Create;
begin
  HashSize := 4;
  BlockSize := 1;
end;

procedure TrhlJS.Init;
begin
  inherited Init;
  m_hash := 1315423911;
end;

procedure TrhlJS.Final(var ADigest);
begin
  Move(m_hash, ADigest, 4);
end;

end.
