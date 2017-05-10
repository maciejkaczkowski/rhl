unit rhlPJW;

interface

uses
  rhlCore;

type

  { TrhlPJW }

  TrhlPJW = class(TrhlHash)
  private
    const
      BitsInUnsignedInt = SizeOf(DWord) * 8;
      ThreeQuarters = (BitsInUnsignedInt * 3) div 4;
      OneEighth = BitsInUnsignedInt div 8;
      HighBits = High(DWord) shl (BitsInUnsignedInt - OneEighth);
    var
      m_hash: DWord;
  protected
    procedure UpdateBytes(const ABuffer; ASize: LongWord); override;
  public
    constructor Create; override;
    procedure Init; override;
    procedure Final(var ADigest); override;
  end;

implementation

{ TrhlPJW }

procedure TrhlPJW.UpdateBytes(const ABuffer; ASize: LongWord);
var
  b: PByte;
  test: DWord;
begin
  b := @ABuffer;
  while ASize > 0 do
  begin
    m_hash := (m_hash shl OneEighth) + b^;

    test := m_hash and HighBits;
    if (test <> 0) then
      m_hash := ((m_hash xor (test shr ThreeQuarters)) and (not HighBits));

    Inc(b);
    Dec(ASize);
  end;
end;

constructor TrhlPJW.Create;
begin
  HashSize := 4;
  BlockSize := 1;
end;

procedure TrhlPJW.Init;
begin
  inherited Init;
  m_hash := 0;
end;

procedure TrhlPJW.Final(var ADigest);
begin
  Move(m_hash, ADigest, 4);
end;

end.
