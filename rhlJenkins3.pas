unit rhlJenkins3;

interface

uses
  rhlCore;

type

  { TrhlJenkins3 }

  TrhlJenkins3 = class(TrhlHash)
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

{ TrhlJenkins3 }

procedure TrhlJenkins3.UpdateBytes(const ABuffer; ASize: LongWord);
var
  a_data: array[0..0] of Byte absolute ABuffer;
  a, b, c: DWord;
  ci: Integer;
begin

  if (ASize = 0) then
  begin
    m_hash := 0;
    Exit;
  end;

  a := $deadbeef + ASize;
  b := a;
  c := a;

  ci := 0;

  while ASize > 12 do
  begin
    Inc(a, a_data[ci+0] or a_data[ci+1] shl 8 or a_data[ci+2]  shl 16 or a_data[ci+3]  shl 24);
    Inc(b, a_data[ci+4] or a_data[ci+5] shl 8 or a_data[ci+6]  shl 16 or a_data[ci+7]  shl 24);
    Inc(c, a_data[ci+8] or a_data[ci+9] shl 8 or a_data[ci+10] shl 16 or a_data[ci+11] shl 24);

    Dec(a, c);
    a := a xor RolDWord(c, 4);
    Inc(c, b);
    Dec(b, a);
    b := b xor RolDWord(a, 6);
    Inc(a, c);
    Dec(c, b);
    c := c xor RolDWord(b, 8);
    Inc(b, a);
    Dec(a, c);
    a := a xor RolDWord(c, 16);
    Inc(c, b);
    Dec(b, a);
    b := b xor RolDWord(a, 19);
    Inc(a, c);
    Dec(c, b);
    c := c xor RolDWord(b, 4);
    Inc(b, a);

    Inc(ci, 12);
    Dec(ASize, 12);
  end;

  case ASize of
    4..12: Inc(a, a_data[ci+0] or a_data[ci+1] shl 8 or a_data[ci+2] shl 16 or a_data[ci+3] shl 24);
        3: Inc(a, a_data[ci+0] or a_data[ci+1] shl 8 or a_data[ci+2] shl 16);
        2: Inc(a, a_data[ci+0] or a_data[ci+1] shl 8);
        1: Inc(a, a_data[ci+0]);
  end;

  case ASize of
    8..12: Inc(b, a_data[ci+4] or a_data[ci+5] shl 8 or a_data[ci+6] shl 16 or a_data[ci+7] shl 24);
        7: Inc(b, a_data[ci+4] or a_data[ci+5] shl 8 or a_data[ci+6] shl 16);
        6: Inc(b, a_data[ci+4] or a_data[ci+5] shl 8);
        5: Inc(b, a_data[ci+4]);
  end;

  case ASize of
    12: Inc(c, a_data[ci+8] or a_data[ci+9] shl 8 or a_data[ci+10] shl 16 or a_data[ci+11] shl 24);
    11: Inc(c, a_data[ci+8] or a_data[ci+9] shl 8 or a_data[ci+10] shl 16);
    10: Inc(c, a_data[ci+8] or a_data[ci+9] shl 8);
     9: Inc(c, a_data[ci+8]);
  end;

  c := c xor b;
  c := c - RolDWord(b, 14);
  a := a xor c;
  a := a - RolDWord(c, 11);
  b := b xor a;
  b := b - RolDWord(a, 25);
  c := c xor b;
  c := c - RolDWord(b, 16);
  a := a xor c;
  a := a - RolDWord(c, 4);;
  b := b xor a;
  b := b - RolDWord(a, 14);
  c := c xor b;
  c := c - RolDWord(b, 24);

  m_hash := c;
end;

constructor TrhlJenkins3.Create;
begin
  HashSize := 4;
  BlockSize := 12;
end;

procedure TrhlJenkins3.Init;
begin
  inherited Init;
  m_hash := 0;
end;

procedure TrhlJenkins3.Final(var ADigest);
begin
  Move(m_hash, ADigest, 4);
end;

end.
