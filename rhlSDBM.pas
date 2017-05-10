unit rhlSDBM;

interface

uses
  rhlCore;

type

  { TrhlSDBM }

  TrhlSDBM = class(TrhlHash)
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

{ TrhlSDBM }

procedure TrhlSDBM.UpdateBytes(const ABuffer; ASize: LongWord);
var
  b: PByte;
begin
  b := @ABuffer;
  while ASize > 0 do
  begin
    m_hash := b^ + (m_hash shl 6) + (m_hash shl 16) - m_hash;
    Inc(b);
    Dec(ASize);
  end;
end;

constructor TrhlSDBM.Create;
begin
  HashSize := 4;
  BlockSize := 1;
end;

procedure TrhlSDBM.Init;
begin
  inherited Init;
  m_hash := 0;
end;

procedure TrhlSDBM.Final(var ADigest);
begin
  Move(m_hash, ADigest, 4);
end;

end.
