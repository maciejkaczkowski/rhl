unit rhlAdler32;

interface

uses
  rhlCore;

type

  { TrhlAdler32 }

  TrhlAdler32 = class(TrhlHash)
  private
    m_a, m_b: DWord;
  protected
    procedure UpdateBytes(const ABuffer; ASize: LongWord); override;
  public
    constructor Create; override;
    procedure Init; override;
    procedure Final(var ADigest); override;
  end;

implementation

{ TrhlAdler32 }

procedure TrhlAdler32.UpdateBytes(const ABuffer; ASize: LongWord);
const
  MOD_ADLER: DWord = 65521;
var
  b: PByte;
begin
  b := @ABuffer;
  while ASize > 0 do
  begin
    m_a := (m_a + b^) mod MOD_ADLER;
    m_b := (m_b + m_a) mod MOD_ADLER;
    Inc(b);
    Dec(ASize);
  end;
end;

constructor TrhlAdler32.Create;
begin
  HashSize := 4;
  BlockSize := 1;
end;

procedure TrhlAdler32.Init;
begin
  inherited Init;
  m_a := 1;
  m_b := 0;
end;

procedure TrhlAdler32.Final(var ADigest);
var
  x: DWord;
begin
  x := (m_b shl 16) or m_a;
  Move(x, ADigest, 4);
end;

end.
