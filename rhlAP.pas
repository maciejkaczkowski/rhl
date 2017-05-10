unit rhlAP;

interface

uses
  rhlCore;

type

  { TrhlAP }

  TrhlAP = class(TrhlHash)
  private
    m_hash, m_index: DWord;
  protected
    procedure UpdateBytes(const ABuffer; ASize: LongWord); override;
  public
    constructor Create; override;
    procedure Init; override;
    procedure Final(var ADigest); override;
  end;

implementation

{ TrhlAP }

procedure TrhlAP.UpdateBytes(const ABuffer; ASize: LongWord);
var
  b: PByte;
begin
  b := @ABuffer;
  while ASize > 0 do
  begin
    if (m_index and 1) = 0 then
      m_hash := m_hash xor ((m_hash shl 7) xor b^ xor (m_hash shr 3))
    else
      m_hash := m_hash xor (not ((m_hash shl 11) xor b^ xor (m_hash shr 5)));
    Inc(m_index);

    Inc(b);
    Dec(ASize);
  end;
end;

constructor TrhlAP.Create;
begin
  HashSize := 4;
  BlockSize := 1;
end;

procedure TrhlAP.Init;
begin
  inherited Init;
  m_hash := 0;
  m_index := 0;
end;

procedure TrhlAP.Final(var ADigest);
begin
  Move(m_hash, ADigest, 4);
end;

end.
