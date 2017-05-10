unit rhlHAVAL;
//TrhlHAVAL256r3p1
//TrhlHAVAL128r4p128
//==================
//hash len-^^^
//no of rounds-^
//padding byte---^^^
interface

uses
  rhlCore;

type

  { TrhlHAVAL }

  TrhlHAVAL = class abstract(TrhlHash)
  private
    m_hash: array[0..7] of DWord;
    procedure Compress(var ADigest);
  protected
    FRounds: Integer;
    FPadding: Byte;
  public
    constructor Create; override;
    procedure Init; override;
    procedure Final(var ADigest); override;
  end;

  { TrhlHAVAL3 }

  TrhlHAVAL3 = class abstract(TrhlHAVAL)
  protected
    procedure UpdateBlock(const AData); override;
  public
    constructor Create; override;
  end;

  { TrhlHAVAL4 }

  TrhlHAVAL4 = class abstract(TrhlHAVAL)
  protected
    procedure UpdateBlock(const AData); override;
  public
    constructor Create; override;
  end;

  { TrhlHAVAL5 }

  TrhlHAVAL5 = class abstract(TrhlHAVAL)
  protected
    procedure UpdateBlock(const AData); override;
  public
    constructor Create; override;
  end;

implementation

{ TrhlHAVAL3 }

procedure TrhlHAVAL3.UpdateBlock(const AData);
var
  temp: array[0..0] of DWord absolute AData;
  a, b, c, d, e, f, g, h, t: DWord;
begin
  a := m_hash[0];
  b := m_hash[1];
  c := m_hash[2];
  d := m_hash[3];
  e := m_hash[4];
  f := m_hash[5];
  g := m_hash[6];
  h := m_hash[7];

  t := 0;

  t := c and (e xor d) xor g and a xor f and b xor e;
  h := temp[0] + (t shr 7 or t shl 25) + (h shr 11 or h shl 21);

  t := b and (d xor c) xor f and h xor e and a xor d;
  g := temp[1] + (t shr 7 or t shl 25) + (g shr 11 or g shl 21);

  t := a and (c xor b) xor e and g xor d and h xor c;
  f := temp[2] + (t shr 7 or t shl 25) + (f shr 11 or f shl 21);

  t := h and (b xor a) xor d and f xor c and g xor b;
  e := temp[3] + (t shr 7 or t shl 25) + (e shr 11 or e shl 21);

  t := g and (a xor h) xor c and e xor b and f xor a;
  d := temp[4] + (t shr 7 or t shl 25) + (d shr 11 or d shl 21);

  t := f and (h xor g) xor b and d xor a and e xor h;
  c := temp[5] + (t shr 7 or t shl 25) + (c shr 11 or c shl 21);

  t := e and (g xor f) xor a and c xor h and d xor g;
  b := temp[6] + (t shr 7 or t shl 25) + (b shr 11 or b shl 21);

  t := d and (f xor e) xor h and b xor g and c xor f;
  a := temp[7] + (t shr 7 or t shl 25) + (a shr 11 or a shl 21);

  t := c and (e xor d) xor g and a xor f and b xor e;
  h := temp[8] + (t shr 7 or t shl 25) + (h shr 11 or h shl 21);

  t := b and (d xor c) xor f and h xor e and a xor d;
  g := temp[9] + (t shr 7 or t shl 25) + (g shr 11 or g shl 21);

  t := a and (c xor b) xor e and g xor d and h xor c;
  f := temp[10] + (t shr 7 or t shl 25) + (f shr 11 or f shl 21);

  t := h and (b xor a) xor d and f xor c and g xor b;
  e := temp[11] + (t shr 7 or t shl 25) + (e shr 11 or e shl 21);

  t := g and (a xor h) xor c and e xor b and f xor a;
  d := temp[12] + (t shr 7 or t shl 25) + (d shr 11 or d shl 21);

  t := f and (h xor g) xor b and d xor a and e xor h;
  c := temp[13] + (t shr 7 or t shl 25) + (c shr 11 or c shl 21);

  t := e and (g xor f) xor a and c xor h and d xor g;
  b := temp[14] + (t shr 7 or t shl 25) + (b shr 11 or b shl 21);

  t := d and (f xor e) xor h and b xor g and c xor f;
  a := temp[15] + (t shr 7 or t shl 25) + (a shr 11 or a shl 21);

  t := c and (e xor d) xor g and a xor f and b xor e;
  h := temp[16] + (t shr 7 or t shl 25) + (h shr 11 or h shl 21);

  t := b and (d xor c) xor f and h xor e and a xor d;
  g := temp[17] + (t shr 7 or t shl 25) + (g shr 11 or g shl 21);

  t := a and (c xor b) xor e and g xor d and h xor c;
  f := temp[18] + (t shr 7 or t shl 25) + (f shr 11 or f shl 21);

  t := h and (b xor a) xor d and f xor c and g xor b;
  e := temp[19] + (t shr 7 or t shl 25) + (e shr 11 or e shl 21);

  t := g and (a xor h) xor c and e xor b and f xor a;
  d := temp[20] + (t shr 7 or t shl 25) + (d shr 11 or d shl 21);

  t := f and (h xor g) xor b and d xor a and e xor h;
  c := temp[21] + (t shr 7 or t shl 25) + (c shr 11 or c shl 21);

  t := e and (g xor f) xor a and c xor h and d xor g;
  b := temp[22] + (t shr 7 or t shl 25) + (b shr 11 or b shl 21);

  t := d and (f xor e) xor h and b xor g and c xor f;
  a := temp[23] + (t shr 7 or t shl 25) + (a shr 11 or a shl 21);

  t := c and (e xor d) xor g and a xor f and b xor e;
  h := temp[24] + (t shr 7 or t shl 25) + (h shr 11 or h shl 21);

  t := b and (d xor c) xor f and h xor e and a xor d;
  g := temp[25] + (t shr 7 or t shl 25) + (g shr 11 or g shl 21);

  t := a and (c xor b) xor e and g xor d and h xor c;
  f := temp[26] + (t shr 7 or t shl 25) + (f shr 11 or f shl 21);

  t := h and (b xor a) xor d and f xor c and g xor b;
  e := temp[27] + (t shr 7 or t shl 25) + (e shr 11 or e shl 21);

  t := g and (a xor h) xor c and e xor b and f xor a;
  d := temp[28] + (t shr 7 or t shl 25) + (d shr 11 or d shl 21);

  t := f and (h xor g) xor b and d xor a and e xor h;
  c := temp[29] + (t shr 7 or t shl 25) + (c shr 11 or c shl 21);

  t := e and (g xor f) xor a and c xor h and d xor g;
  b := temp[30] + (t shr 7 or t shl 25) + (b shr 11 or b shl 21);

  t := d and (f xor e) xor h and b xor g and c xor f;
  a := temp[31] + (t shr 7 or t shl 25) + (a shr 11 or a shl 21);

  t := f and (d and not a xor b and c xor e xor g) xor b and (d xor c) xor a and c xor g;
  h := temp[5] + $452821E6 + (t shr 7 or t shl 25) + (h shr 11 or h shl 21);

  t := e and (c and not h xor a and b xor d xor f) xor a and (c xor b) xor h and b xor f;
  g := temp[14] + $38D01377 + (t shr 7 or t shl 25) + (g shr 11 or g shl 21);

  t := d and (b and not g xor h and a xor c xor e) xor h and (b xor a) xor g and a xor e;
  f := temp[26] + $BE5466CF + (t shr 7 or t shl 25) + (f shr 11 or f shl 21);

  t := c and (a and not f xor g and h xor b xor d) xor g and (a xor h) xor f and h xor d;
  e := temp[18] + $34E90C6C + (t shr 7 or t shl 25) + (e shr 11 or e shl 21);

  t := b and (h and not e xor f and g xor a xor c) xor f and (h xor g) xor e and g xor c;
  d := temp[11] + $C0AC29B7 + (t shr 7 or t shl 25) + (d shr 11 or d shl 21);

  t := a and (g and not d xor e and f xor h xor b) xor e and (g xor f) xor d and f xor b;
  c := temp[28] + $C97C50DD + (t shr 7 or t shl 25) + (c shr 11 or c shl 21);

  t := h and (f and not c xor d and e xor g xor a) xor d and (f xor e) xor c and e xor a;
  b := temp[7] + $3F84D5B5 + (t shr 7 or t shl 25) + (b shr 11 or b shl 21);

  t := g and (e and not b xor c and d xor f xor h) xor c and (e xor d) xor b and d xor h;
  a := temp[16] + $B5470917 + (t shr 7 or t shl 25) + (a shr 11 or a shl 21);

  t := f and (d and not a xor b and c xor e xor g) xor b and (d xor c) xor a and c xor g;
  h := temp[0] + $9216D5D9 + (t shr 7 or t shl 25) + (h shr 11 or h shl 21);

  t := e and (c and not h xor a and b xor d xor f) xor a and (c xor b) xor h and b xor f;
  g := temp[23] + $8979FB1B + (t shr 7 or t shl 25) + (g shr 11 or g shl 21);

  t := d and (b and not g xor h and a xor c xor e) xor h and (b xor a) xor g and a xor e;
  f := temp[20] + $D1310BA6 + (t shr 7 or t shl 25) + (f shr 11 or f shl 21);

  t := c and (a and not f xor g and h xor b xor d) xor g and (a xor h) xor f and h xor d;
  e := temp[22] + $98DFB5AC + (t shr 7 or t shl 25) + (e shr 11 or e shl 21);

  t := b and (h and not e xor f and g xor a xor c) xor f and (h xor g) xor e and g xor c;
  d := temp[1] + $2FFD72DB + (t shr 7 or t shl 25) + (d shr 11 or d shl 21);

  t := a and (g and not d xor e and f xor h xor b) xor e and (g xor f) xor d and f xor b;
  c := temp[10] + $D01ADFB7 + (t shr 7 or t shl 25) + (c shr 11 or c shl 21);

  t := h and (f and not c xor d and e xor g xor a) xor d and (f xor e) xor c and e xor a;
  b := temp[4] + $B8E1AFED + (t shr 7 or t shl 25) + (b shr 11 or b shl 21);

  t := g and (e and not b xor c and d xor f xor h) xor c and (e xor d) xor b and d xor h;
  a := temp[8] + $6A267E96 + (t shr 7 or t shl 25) + (a shr 11 or a shl 21);

  t := f and (d and not a xor b and c xor e xor g) xor b and (d xor c) xor a and c xor g;
  h := temp[30] + $BA7C9045 + (t shr 7 or t shl 25) + (h shr 11 or h shl 21);

  t := e and (c and not h xor a and b xor d xor f) xor a and (c xor b) xor h and b xor f;
  g := temp[3] + $F12C7F99 + (t shr 7 or t shl 25) + (g shr 11 or g shl 21);

  t := d and (b and not g xor h and a xor c xor e) xor h and (b xor a) xor g and a xor e;
  f := temp[21] + $24A19947 + (t shr 7 or t shl 25) + (f shr 11 or f shl 21);

  t := c and (a and not f xor g and h xor b xor d) xor g and (a xor h) xor f and h xor d;
  e := temp[9] + $B3916CF7 + (t shr 7 or t shl 25) + (e shr 11 or e shl 21);

  t := b and (h and not e xor f and g xor a xor c) xor f and (h xor g) xor e and g xor c;
  d := temp[17] + $0801F2E2 + (t shr 7 or t shl 25) + (d shr 11 or d shl 21);

  t := a and (g and not d xor e and f xor h xor b) xor e and (g xor f) xor d and f xor b;
  c := temp[24] + $858EFC16 + (t shr 7 or t shl 25) + (c shr 11 or c shl 21);

  t := h and (f and not c xor d and e xor g xor a) xor d and (f xor e) xor c and e xor a;
  b := temp[29] + $636920D8 + (t shr 7 or t shl 25) + (b shr 11 or b shl 21);

  t := g and (e and not b xor c and d xor f xor h) xor c and (e xor d) xor b and d xor h;
  a := temp[6] + $71574E69 + (t shr 7 or t shl 25) + (a shr 11 or a shl 21);

  t := f and (d and not a xor b and c xor e xor g) xor b and (d xor c) xor a and c xor g;
  h := temp[19] + $A458FEA3 + (t shr 7 or t shl 25) + (h shr 11 or h shl 21);

  t := e and (c and not h xor a and b xor d xor f) xor a and (c xor b) xor h and b xor f;
  g := temp[12] + $F4933D7E + (t shr 7 or t shl 25) + (g shr 11 or g shl 21);

  t := d and (b and not g xor h and a xor c xor e) xor h and (b xor a) xor g and a xor e;
  f := temp[15] + $0D95748F + (t shr 7 or t shl 25) + (f shr 11 or f shl 21);

  t := c and (a and not f xor g and h xor b xor d) xor g and (a xor h) xor f and h xor d;
  e := temp[13] + $728EB658 + (t shr 7 or t shl 25) + (e shr 11 or e shl 21);

  t := b and (h and not e xor f and g xor a xor c) xor f and (h xor g) xor e and g xor c;
  d := temp[2] + $718BCD58 + (t shr 7 or t shl 25) + (d shr 11 or d shl 21);

  t := a and (g and not d xor e and f xor h xor b) xor e and (g xor f) xor d and f xor b;
  c := temp[25] + $82154AEE + (t shr 7 or t shl 25) + (c shr 11 or c shl 21);

  t := h and (f and not c xor d and e xor g xor a) xor d and (f xor e) xor c and e xor a;
  b := temp[31] + $7B54A41D + (t shr 7 or t shl 25) + (b shr 11 or b shl 21);

  t := g and (e and not b xor c and d xor f xor h) xor c and (e xor d) xor b and d xor h;
  a := temp[27] + $C25A59B5 + (t shr 7 or t shl 25) + (a shr 11 or a shl 21);

  t := d and (f and e xor g xor a) xor f and c xor e and b xor a;
  h := temp[19] + $9C30D539 + (t shr 7 or t shl 25) + (h shr 11 or h shl 21);

  t := c and (e and d xor f xor h) xor e and b xor d and a xor h;
  g := temp[9] + $2AF26013 + (t shr 7 or t shl 25) + (g shr 11 or g shl 21);

  t := b and (d and c xor e xor g) xor d and a xor c and h xor g;
  f := temp[4] + $C5D1B023 + (t shr 7 or t shl 25) + (f shr 11 or f shl 21);

  t := a and (c and b xor d xor f) xor c and h xor b and g xor f;
  e := temp[20] + $286085F0 + (t shr 7 or t shl 25) + (e shr 11 or e shl 21);

  t := h and (b and a xor c xor e) xor b and g xor a and f xor e;
  d := temp[28] + $CA417918 + (t shr 7 or t shl 25) + (d shr 11 or d shl 21);

  t := g and (a and h xor b xor d) xor a and f xor h and e xor d;
  c := temp[17] + $B8DB38EF + (t shr 7 or t shl 25) + (c shr 11 or c shl 21);

  t := f and (h and g xor a xor c) xor h and e xor g and d xor c;
  b := temp[8] + $8E79DCB0 + (t shr 7 or t shl 25) + (b shr 11 or b shl 21);

  t := e and (g and f xor h xor b) xor g and d xor f and c xor b;
  a := temp[22] + $603A180E + (t shr 7 or t shl 25) + (a shr 11 or a shl 21);

  t := d and (f and e xor g xor a) xor f and c xor e and b xor a;
  h := temp[29] + $6C9E0E8B + (t shr 7 or t shl 25) + (h shr 11 or h shl 21);

  t := c and (e and d xor f xor h) xor e and b xor d and a xor h;
  g := temp[14] + $B01E8A3E + (t shr 7 or t shl 25) + (g shr 11 or g shl 21);

  t := b and (d and c xor e xor g) xor d and a xor c and h xor g;
  f := temp[25] + $D71577C1 + (t shr 7 or t shl 25) + (f shr 11 or f shl 21);

  t := a and (c and b xor d xor f) xor c and h xor b and g xor f;
  e := temp[12] + $BD314B27 + (t shr 7 or t shl 25) + (e shr 11 or e shl 21);

  t := h and (b and a xor c xor e) xor b and g xor a and f xor e;
  d := temp[24] + $78AF2FDA + (t shr 7 or t shl 25) + (d shr 11 or d shl 21);

  t := g and (a and h xor b xor d) xor a and f xor h and e xor d;
  c := temp[30] + $55605C60 + (t shr 7 or t shl 25) + (c shr 11 or c shl 21);

  t := f and (h and g xor a xor c) xor h and e xor g and d xor c;
  b := temp[16] + $E65525F3 + (t shr 7 or t shl 25) + (b shr 11 or b shl 21);

  t := e and (g and f xor h xor b) xor g and d xor f and c xor b;
  a := temp[26] + $AA55AB94 + (t shr 7 or t shl 25) + (a shr 11 or a shl 21);

  t := d and (f and e xor g xor a) xor f and c xor e and b xor a;
  h := temp[31] + $57489862 + (t shr 7 or t shl 25) + (h shr 11 or h shl 21);

  t := c and (e and d xor f xor h) xor e and b xor d and a xor h;
  g := temp[15] + $63E81440 + (t shr 7 or t shl 25) + (g shr 11 or g shl 21);

  t := b and (d and c xor e xor g) xor d and a xor c and h xor g;
  f := temp[7] + $55CA396A + (t shr 7 or t shl 25) + (f shr 11 or f shl 21);

  t := a and (c and b xor d xor f) xor c and h xor b and g xor f;
  e := temp[3] + $2AAB10B6 + (t shr 7 or t shl 25) + (e shr 11 or e shl 21);

  t := h and (b and a xor c xor e) xor b and g xor a and f xor e;
  d := temp[1] + $B4CC5C34 + (t shr 7 or t shl 25) + (d shr 11 or d shl 21);

  t := g and (a and h xor b xor d) xor a and f xor h and e xor d;
  c := temp[0] + $1141E8CE + (t shr 7 or t shl 25) + (c shr 11 or c shl 21);

  t := f and (h and g xor a xor c) xor h and e xor g and d xor c;
  b := temp[18] + $A15486AF + (t shr 7 or t shl 25) + (b shr 11 or b shl 21);

  t := e and (g and f xor h xor b) xor g and d xor f and c xor b;
  a := temp[27] + $7C72E993 + (t shr 7 or t shl 25) + (a shr 11 or a shl 21);

  t := d and (f and e xor g xor a) xor f and c xor e and b xor a;
  h := temp[13] + $B3EE1411 + (t shr 7 or t shl 25) + (h shr 11 or h shl 21);

  t := c and (e and d xor f xor h) xor e and b xor d and a xor h;
  g := temp[6] + $636FBC2A + (t shr 7 or t shl 25) + (g shr 11 or g shl 21);

  t := b and (d and c xor e xor g) xor d and a xor c and h xor g;
  f := temp[21] + $2BA9C55D + (t shr 7 or t shl 25) + (f shr 11 or f shl 21);

  t := a and (c and b xor d xor f) xor c and h xor b and g xor f;
  e := temp[10] + $741831F6 + (t shr 7 or t shl 25) + (e shr 11 or e shl 21);

  t := h and (b and a xor c xor e) xor b and g xor a and f xor e;
  d := temp[23] + $CE5C3E16 + (t shr 7 or t shl 25) + (d shr 11 or d shl 21);

  t := g and (a and h xor b xor d) xor a and f xor h and e xor d;
  c := temp[11] + $9B87931E + (t shr 7 or t shl 25) + (c shr 11 or c shl 21);

  t := f and (h and g xor a xor c) xor h and e xor g and d xor c;
  b := temp[5] + $AFD6BA33 + (t shr 7 or t shl 25) + (b shr 11 or b shl 21);

  t := e and (g and f xor h xor b) xor g and d xor f and c xor b;
  a := temp[2] + $6C24CF5C + (t shr 7 or t shl 25) + (a shr 11 or a shl 21);

  m_hash[0] += a;
  m_hash[1] += b;
  m_hash[2] += c;
  m_hash[3] += d;
  m_hash[4] += e;
  m_hash[5] += f;
  m_hash[6] += g;
  m_hash[7] += h;
end;

constructor TrhlHAVAL3.Create;
begin
  inherited Create;
  FRounds := 3;
end;

{ TrhlHAVAL4 }

procedure TrhlHAVAL4.UpdateBlock(const AData);
var
  W: array[0..0] of DWord absolute AData;
  t7, t6, t5, t4, t3, t2, t1, t0, t: DWord;
begin
  t0 := m_hash[0];
  t1 := m_hash[1];
  t2 := m_hash[2];
  t3 := m_hash[3];
  t4 := m_hash[4];
  t5 := m_hash[5];
  t6 := m_hash[6];
  t7 := m_hash[7];

  T:= (t3 and (t0 xor t1) xor t5 and t6 xor t4 and t2 xor t0);
  t7:= ((T shr 7) or (T shl 25)) + ((t7 shr 11) or (t7 shl 21)) + w[ 0];
  T:= (t2 and (t7 xor t0) xor t4 and t5 xor t3 and t1 xor t7);
  t6:= ((T shr 7) or (T shl 25)) + ((t6 shr 11) or (t6 shl 21)) + w[ 1];
  T:= (t1 and (t6 xor t7) xor t3 and t4 xor t2 and t0 xor t6);
  t5:= ((T shr 7) or (T shl 25)) + ((t5 shr 11) or (t5 shl 21)) + w[ 2];
  T:= (t0 and (t5 xor t6) xor t2 and t3 xor t1 and t7 xor t5);
  t4:= ((T shr 7) or (T shl 25)) + ((t4 shr 11) or (t4 shl 21)) + w[ 3];
  T:= (t7 and (t4 xor t5) xor t1 and t2 xor t0 and t6 xor t4);
  t3:= ((T shr 7) or (T shl 25)) + ((t3 shr 11) or (t3 shl 21)) + w[ 4];
  T:= (t6 and (t3 xor t4) xor t0 and t1 xor t7 and t5 xor t3);
  t2:= ((T shr 7) or (T shl 25)) + ((t2 shr 11) or (t2 shl 21)) + w[ 5];
  T:= (t5 and (t2 xor t3) xor t7 and t0 xor t6 and t4 xor t2);
  t1:= ((T shr 7) or (T shl 25)) + ((t1 shr 11) or (t1 shl 21)) + w[ 6];
  T:= (t4 and (t1 xor t2) xor t6 and t7 xor t5 and t3 xor t1);
  t0:= ((T shr 7) or (T shl 25)) + ((t0 shr 11) or (t0 shl 21)) + w[ 7];

  T:= (t3 and (t0 xor t1) xor t5 and t6 xor t4 and t2 xor t0);
  t7:= ((T shr 7) or (T shl 25)) + ((t7 shr 11) or (t7 shl 21)) + w[ 8];
  T:= (t2 and (t7 xor t0) xor t4 and t5 xor t3 and t1 xor t7);
  t6:= ((T shr 7) or (T shl 25)) + ((t6 shr 11) or (t6 shl 21)) + w[ 9];
  T:= (t1 and (t6 xor t7) xor t3 and t4 xor t2 and t0 xor t6);
  t5:= ((T shr 7) or (T shl 25)) + ((t5 shr 11) or (t5 shl 21)) + w[10];
  T:= (t0 and (t5 xor t6) xor t2 and t3 xor t1 and t7 xor t5);
  t4:= ((T shr 7) or (T shl 25)) + ((t4 shr 11) or (t4 shl 21)) + w[11];
  T:= (t7 and (t4 xor t5) xor t1 and t2 xor t0 and t6 xor t4);
  t3:= ((T shr 7) or (T shl 25)) + ((t3 shr 11) or (t3 shl 21)) + w[12];
  T:= (t6 and (t3 xor t4) xor t0 and t1 xor t7 and t5 xor t3);
  t2:= ((T shr 7) or (T shl 25)) + ((t2 shr 11) or (t2 shl 21)) + w[13];
  T:= (t5 and (t2 xor t3) xor t7 and t0 xor t6 and t4 xor t2);
  t1:= ((T shr 7) or (T shl 25)) + ((t1 shr 11) or (t1 shl 21)) + w[14];
  T:= (t4 and (t1 xor t2) xor t6 and t7 xor t5 and t3 xor t1);
  t0:= ((T shr 7) or (T shl 25)) + ((t0 shr 11) or (t0 shl 21)) + w[15];

  T:= (t3 and (t0 xor t1) xor t5 and t6 xor t4 and t2 xor t0);
  t7:= ((T shr 7) or (T shl 25)) + ((t7 shr 11) or (t7 shl 21)) + w[16];
  T:= (t2 and (t7 xor t0) xor t4 and t5 xor t3 and t1 xor t7);
  t6:= ((T shr 7) or (T shl 25)) + ((t6 shr 11) or (t6 shl 21)) + w[17];
  T:= (t1 and (t6 xor t7) xor t3 and t4 xor t2 and t0 xor t6);
  t5:= ((T shr 7) or (T shl 25)) + ((t5 shr 11) or (t5 shl 21)) + w[18];
  T:= (t0 and (t5 xor t6) xor t2 and t3 xor t1 and t7 xor t5);
  t4:= ((T shr 7) or (T shl 25)) + ((t4 shr 11) or (t4 shl 21)) + w[19];
  T:= (t7 and (t4 xor t5) xor t1 and t2 xor t0 and t6 xor t4);
  t3:= ((T shr 7) or (T shl 25)) + ((t3 shr 11) or (t3 shl 21)) + w[20];
  T:= (t6 and (t3 xor t4) xor t0 and t1 xor t7 and t5 xor t3);
  t2:= ((T shr 7) or (T shl 25)) + ((t2 shr 11) or (t2 shl 21)) + w[21];
  T:= (t5 and (t2 xor t3) xor t7 and t0 xor t6 and t4 xor t2);
  t1:= ((T shr 7) or (T shl 25)) + ((t1 shr 11) or (t1 shl 21)) + w[22];
  T:= (t4 and (t1 xor t2) xor t6 and t7 xor t5 and t3 xor t1);
  t0:= ((T shr 7) or (T shl 25)) + ((t0 shr 11) or (t0 shl 21)) + w[23];

  T:= (t3 and (t0 xor t1) xor t5 and t6 xor t4 and t2 xor t0);
  t7:= ((T shr 7) or (T shl 25)) + ((t7 shr 11) or (t7 shl 21)) + w[24];
  T:= (t2 and (t7 xor t0) xor t4 and t5 xor t3 and t1 xor t7);
  t6:= ((T shr 7) or (T shl 25)) + ((t6 shr 11) or (t6 shl 21)) + w[25];
  T:= (t1 and (t6 xor t7) xor t3 and t4 xor t2 and t0 xor t6);
  t5:= ((T shr 7) or (T shl 25)) + ((t5 shr 11) or (t5 shl 21)) + w[26];
  T:= (t0 and (t5 xor t6) xor t2 and t3 xor t1 and t7 xor t5);
  t4:= ((T shr 7) or (T shl 25)) + ((t4 shr 11) or (t4 shl 21)) + w[27];
  T:= (t7 and (t4 xor t5) xor t1 and t2 xor t0 and t6 xor t4);
  t3:= ((T shr 7) or (T shl 25)) + ((t3 shr 11) or (t3 shl 21)) + w[28];
  T:= (t6 and (t3 xor t4) xor t0 and t1 xor t7 and t5 xor t3);
  t2:= ((T shr 7) or (T shl 25)) + ((t2 shr 11) or (t2 shl 21)) + w[29];
  T:= (t5 and (t2 xor t3) xor t7 and t0 xor t6 and t4 xor t2);
  t1:= ((T shr 7) or (T shl 25)) + ((t1 shr 11) or (t1 shl 21)) + w[30];
  T:= (t4 and (t1 xor t2) xor t6 and t7 xor t5 and t3 xor t1);
  t0:= ((T shr 7) or (T shl 25)) + ((t0 shr 11) or (t0 shl 21)) + w[31];

  T:= (t1 and (t6 and not t0 xor t2 and t5 xor t3 xor t4) xor t2 and (t6 xor t5) xor t0 and t5 xor t4);
  t7:= ((T shr 7) or (T shl 25)) + ((t7 shr 11) or (t7 shl 21)) + w[ 5] + $452821E6;
  T:= (t0 and (t5 and not t7 xor t1 and t4 xor t2 xor t3) xor t1 and (t5 xor t4) xor t7 and t4 xor t3);
  t6:= ((T shr 7) or (T shl 25)) + ((t6 shr 11) or (t6 shl 21)) + w[14] + $38D01377;
  T:= (t7 and (t4 and not t6 xor t0 and t3 xor t1 xor t2) xor t0 and (t4 xor t3) xor t6 and t3 xor t2);
  t5:= ((T shr 7) or (T shl 25)) + ((t5 shr 11) or (t5 shl 21)) + w[26] + $BE5466CF;
  T:= (t6 and (t3 and not t5 xor t7 and t2 xor t0 xor t1) xor t7 and (t3 xor t2) xor t5 and t2 xor t1);
  t4:= ((T shr 7) or (T shl 25)) + ((t4 shr 11) or (t4 shl 21)) + w[18] + $34E90C6C;
  T:= (t5 and (t2 and not t4 xor t6 and t1 xor t7 xor t0) xor t6 and (t2 xor t1) xor t4 and t1 xor t0);
  t3:= ((T shr 7) or (T shl 25)) + ((t3 shr 11) or (t3 shl 21)) + w[11] + $C0AC29B7;
  T:= (t4 and (t1 and not t3 xor t5 and t0 xor t6 xor t7) xor t5 and (t1 xor t0) xor t3 and t0 xor t7);
  t2:= ((T shr 7) or (T shl 25)) + ((t2 shr 11) or (t2 shl 21)) + w[28] + $C97C50DD;
  T:= (t3 and (t0 and not t2 xor t4 and t7 xor t5 xor t6) xor t4 and (t0 xor t7) xor t2 and t7 xor t6);
  t1:= ((T shr 7) or (T shl 25)) + ((t1 shr 11) or (t1 shl 21)) + w[ 7] + $3F84D5B5;
  T:= (t2 and (t7 and not t1 xor t3 and t6 xor t4 xor t5) xor t3 and (t7 xor t6) xor t1 and t6 xor t5);
  t0:= ((T shr 7) or (T shl 25)) + ((t0 shr 11) or (t0 shl 21)) + w[16] + $B5470917;

  T:= (t1 and (t6 and not t0 xor t2 and t5 xor t3 xor t4) xor t2 and (t6 xor t5) xor t0 and t5 xor t4);
  t7:= ((T shr 7) or (T shl 25)) + ((t7 shr 11) or (t7 shl 21)) + w[ 0] + $9216D5D9;
  T:= (t0 and (t5 and not t7 xor t1 and t4 xor t2 xor t3) xor t1 and (t5 xor t4) xor t7 and t4 xor t3);
  t6:= ((T shr 7) or (T shl 25)) + ((t6 shr 11) or (t6 shl 21)) + w[23] + $8979FB1B;
  T:= (t7 and (t4 and not t6 xor t0 and t3 xor t1 xor t2) xor t0 and (t4 xor t3) xor t6 and t3 xor t2);
  t5:= ((T shr 7) or (T shl 25)) + ((t5 shr 11) or (t5 shl 21)) + w[20] + $D1310BA6;
  T:= (t6 and (t3 and not t5 xor t7 and t2 xor t0 xor t1) xor t7 and (t3 xor t2) xor t5 and t2 xor t1);
  t4:= ((T shr 7) or (T shl 25)) + ((t4 shr 11) or (t4 shl 21)) + w[22] + $98DFB5AC;
  T:= (t5 and (t2 and not t4 xor t6 and t1 xor t7 xor t0) xor t6 and (t2 xor t1) xor t4 and t1 xor t0);
  t3:= ((T shr 7) or (T shl 25)) + ((t3 shr 11) or (t3 shl 21)) + w[ 1] + $2FFD72DB;
  T:= (t4 and (t1 and not t3 xor t5 and t0 xor t6 xor t7) xor t5 and (t1 xor t0) xor t3 and t0 xor t7);
  t2:= ((T shr 7) or (T shl 25)) + ((t2 shr 11) or (t2 shl 21)) + w[10] + $D01ADFB7;
  T:= (t3 and (t0 and not t2 xor t4 and t7 xor t5 xor t6) xor t4 and (t0 xor t7) xor t2 and t7 xor t6);
  t1:= ((T shr 7) or (T shl 25)) + ((t1 shr 11) or (t1 shl 21)) + w[ 4] + $B8E1AFED;
  T:= (t2 and (t7 and not t1 xor t3 and t6 xor t4 xor t5) xor t3 and (t7 xor t6) xor t1 and t6 xor t5);
  t0:= ((T shr 7) or (T shl 25)) + ((t0 shr 11) or (t0 shl 21)) + w[ 8] + $6A267E96;

  T:= (t1 and (t6 and not t0 xor t2 and t5 xor t3 xor t4) xor t2 and (t6 xor t5) xor t0 and t5 xor t4);
  t7:= ((T shr 7) or (T shl 25)) + ((t7 shr 11) or (t7 shl 21)) + w[30] + $BA7C9045;
  T:= (t0 and (t5 and not t7 xor t1 and t4 xor t2 xor t3) xor t1 and (t5 xor t4) xor t7 and t4 xor t3);
  t6:= ((T shr 7) or (T shl 25)) + ((t6 shr 11) or (t6 shl 21)) + w[ 3] + $F12C7F99;
  T:= (t7 and (t4 and not t6 xor t0 and t3 xor t1 xor t2) xor t0 and (t4 xor t3) xor t6 and t3 xor t2);
  t5:= ((T shr 7) or (T shl 25)) + ((t5 shr 11) or (t5 shl 21)) + w[21] + $24A19947;
  T:= (t6 and (t3 and not t5 xor t7 and t2 xor t0 xor t1) xor t7 and (t3 xor t2) xor t5 and t2 xor t1);
  t4:= ((T shr 7) or (T shl 25)) + ((t4 shr 11) or (t4 shl 21)) + w[ 9] + $B3916CF7;
  T:= (t5 and (t2 and not t4 xor t6 and t1 xor t7 xor t0) xor t6 and (t2 xor t1) xor t4 and t1 xor t0);
  t3:= ((T shr 7) or (T shl 25)) + ((t3 shr 11) or (t3 shl 21)) + w[17] + $0801F2E2;
  T:= (t4 and (t1 and not t3 xor t5 and t0 xor t6 xor t7) xor t5 and (t1 xor t0) xor t3 and t0 xor t7);
  t2:= ((T shr 7) or (T shl 25)) + ((t2 shr 11) or (t2 shl 21)) + w[24] + $858EFC16;
  T:= (t3 and (t0 and not t2 xor t4 and t7 xor t5 xor t6) xor t4 and (t0 xor t7) xor t2 and t7 xor t6);
  t1:= ((T shr 7) or (T shl 25)) + ((t1 shr 11) or (t1 shl 21)) + w[29] + $636920D8;
  T:= (t2 and (t7 and not t1 xor t3 and t6 xor t4 xor t5) xor t3 and (t7 xor t6) xor t1 and t6 xor t5);
  t0:= ((T shr 7) or (T shl 25)) + ((t0 shr 11) or (t0 shl 21)) + w[ 6] + $71574E69;

  T:= (t1 and (t6 and not t0 xor t2 and t5 xor t3 xor t4) xor t2 and (t6 xor t5) xor t0 and t5 xor t4);
  t7:= ((T shr 7) or (T shl 25)) + ((t7 shr 11) or (t7 shl 21)) + w[19] + $A458FEA3;
  T:= (t0 and (t5 and not t7 xor t1 and t4 xor t2 xor t3) xor t1 and (t5 xor t4) xor t7 and t4 xor t3);
  t6:= ((T shr 7) or (T shl 25)) + ((t6 shr 11) or (t6 shl 21)) + w[12] + $F4933D7E;
  T:= (t7 and (t4 and not t6 xor t0 and t3 xor t1 xor t2) xor t0 and (t4 xor t3) xor t6 and t3 xor t2);
  t5:= ((T shr 7) or (T shl 25)) + ((t5 shr 11) or (t5 shl 21)) + w[15] + $0D95748F;
  T:= (t6 and (t3 and not t5 xor t7 and t2 xor t0 xor t1) xor t7 and (t3 xor t2) xor t5 and t2 xor t1);
  t4:= ((T shr 7) or (T shl 25)) + ((t4 shr 11) or (t4 shl 21)) + w[13] + $728EB658;
  T:= (t5 and (t2 and not t4 xor t6 and t1 xor t7 xor t0) xor t6 and (t2 xor t1) xor t4 and t1 xor t0);
  t3:= ((T shr 7) or (T shl 25)) + ((t3 shr 11) or (t3 shl 21)) + w[ 2] + $718BCD58;
  T:= (t4 and (t1 and not t3 xor t5 and t0 xor t6 xor t7) xor t5 and (t1 xor t0) xor t3 and t0 xor t7);
  t2:= ((T shr 7) or (T shl 25)) + ((t2 shr 11) or (t2 shl 21)) + w[25] + $82154AEE;
  T:= (t3 and (t0 and not t2 xor t4 and t7 xor t5 xor t6) xor t4 and (t0 xor t7) xor t2 and t7 xor t6);
  t1:= ((T shr 7) or (T shl 25)) + ((t1 shr 11) or (t1 shl 21)) + w[31] + $7B54A41D;
  T:= (t2 and (t7 and not t1 xor t3 and t6 xor t4 xor t5) xor t3 and (t7 xor t6) xor t1 and t6 xor t5);
  t0:= ((T shr 7) or (T shl 25)) + ((t0 shr 11) or (t0 shl 21)) + w[27] + $C25A59B5;

  T:= (t6 and (t2 and t0 xor t1 xor t5) xor t2 and t3 xor t0 and t4 xor t5);
  t7:= ((T shr 7) or (T shl 25)) + ((t7 shr 11) or (t7 shl 21)) + w[19] + $9C30D539;
  T:= (t5 and (t1 and t7 xor t0 xor t4) xor t1 and t2 xor t7 and t3 xor t4);
  t6:= ((T shr 7) or (T shl 25)) + ((t6 shr 11) or (t6 shl 21)) + w[ 9] + $2AF26013;
  T:= (t4 and (t0 and t6 xor t7 xor t3) xor t0 and t1 xor t6 and t2 xor t3);
  t5:= ((T shr 7) or (T shl 25)) + ((t5 shr 11) or (t5 shl 21)) + w[ 4] + $C5D1B023;
  T:= (t3 and (t7 and t5 xor t6 xor t2) xor t7 and t0 xor t5 and t1 xor t2);
  t4:= ((T shr 7) or (T shl 25)) + ((t4 shr 11) or (t4 shl 21)) + w[20] + $286085F0;
  T:= (t2 and (t6 and t4 xor t5 xor t1) xor t6 and t7 xor t4 and t0 xor t1);
  t3:= ((T shr 7) or (T shl 25)) + ((t3 shr 11) or (t3 shl 21)) + w[28] + $CA417918;
  T:= (t1 and (t5 and t3 xor t4 xor t0) xor t5 and t6 xor t3 and t7 xor t0);
  t2:= ((T shr 7) or (T shl 25)) + ((t2 shr 11) or (t2 shl 21)) + w[17] + $B8DB38EF;
  T:= (t0 and (t4 and t2 xor t3 xor t7) xor t4 and t5 xor t2 and t6 xor t7);
  t1:= ((T shr 7) or (T shl 25)) + ((t1 shr 11) or (t1 shl 21)) + w[ 8] + $8E79DCB0;
  T:= (t7 and (t3 and t1 xor t2 xor t6) xor t3 and t4 xor t1 and t5 xor t6);
  t0:= ((T shr 7) or (T shl 25)) + ((t0 shr 11) or (t0 shl 21)) + w[22] + $603A180E;

  T:= (t6 and (t2 and t0 xor t1 xor t5) xor t2 and t3 xor t0 and t4 xor t5);
  t7:= ((T shr 7) or (T shl 25)) + ((t7 shr 11) or (t7 shl 21)) + w[29] + $6C9E0E8B;
  T:= (t5 and (t1 and t7 xor t0 xor t4) xor t1 and t2 xor t7 and t3 xor t4);
  t6:= ((T shr 7) or (T shl 25)) + ((t6 shr 11) or (t6 shl 21)) + w[14] + $B01E8A3E;
  T:= (t4 and (t0 and t6 xor t7 xor t3) xor t0 and t1 xor t6 and t2 xor t3);
  t5:= ((T shr 7) or (T shl 25)) + ((t5 shr 11) or (t5 shl 21)) + w[25] + $D71577C1;
  T:= (t3 and (t7 and t5 xor t6 xor t2) xor t7 and t0 xor t5 and t1 xor t2);
  t4:= ((T shr 7) or (T shl 25)) + ((t4 shr 11) or (t4 shl 21)) + w[12] + $BD314B27;
  T:= (t2 and (t6 and t4 xor t5 xor t1) xor t6 and t7 xor t4 and t0 xor t1);
  t3:= ((T shr 7) or (T shl 25)) + ((t3 shr 11) or (t3 shl 21)) + w[24] + $78AF2FDA;
  T:= (t1 and (t5 and t3 xor t4 xor t0) xor t5 and t6 xor t3 and t7 xor t0);
  t2:= ((T shr 7) or (T shl 25)) + ((t2 shr 11) or (t2 shl 21)) + w[30] + $55605C60;
  T:= (t0 and (t4 and t2 xor t3 xor t7) xor t4 and t5 xor t2 and t6 xor t7);
  t1:= ((T shr 7) or (T shl 25)) + ((t1 shr 11) or (t1 shl 21)) + w[16] + $E65525F3;
  T:= (t7 and (t3 and t1 xor t2 xor t6) xor t3 and t4 xor t1 and t5 xor t6);
  t0:= ((T shr 7) or (T shl 25)) + ((t0 shr 11) or (t0 shl 21)) + w[26] + $AA55AB94;

  T:= (t6 and (t2 and t0 xor t1 xor t5) xor t2 and t3 xor t0 and t4 xor t5);
  t7:= ((T shr 7) or (T shl 25)) + ((t7 shr 11) or (t7 shl 21)) + w[31] + $57489862;
  T:= (t5 and (t1 and t7 xor t0 xor t4) xor t1 and t2 xor t7 and t3 xor t4);
  t6:= ((T shr 7) or (T shl 25)) + ((t6 shr 11) or (t6 shl 21)) + w[15] + $63E81440;
  T:= (t4 and (t0 and t6 xor t7 xor t3) xor t0 and t1 xor t6 and t2 xor t3);
  t5:= ((T shr 7) or (T shl 25)) + ((t5 shr 11) or (t5 shl 21)) + w[ 7] + $55CA396A;
  T:= (t3 and (t7 and t5 xor t6 xor t2) xor t7 and t0 xor t5 and t1 xor t2);
  t4:= ((T shr 7) or (T shl 25)) + ((t4 shr 11) or (t4 shl 21)) + w[ 3] + $2AAB10B6;
  T:= (t2 and (t6 and t4 xor t5 xor t1) xor t6 and t7 xor t4 and t0 xor t1);
  t3:= ((T shr 7) or (T shl 25)) + ((t3 shr 11) or (t3 shl 21)) + w[ 1] + $B4CC5C34;
  T:= (t1 and (t5 and t3 xor t4 xor t0) xor t5 and t6 xor t3 and t7 xor t0);
  t2:= ((T shr 7) or (T shl 25)) + ((t2 shr 11) or (t2 shl 21)) + w[ 0] + $1141E8CE;
  T:= (t0 and (t4 and t2 xor t3 xor t7) xor t4 and t5 xor t2 and t6 xor t7);
  t1:= ((T shr 7) or (T shl 25)) + ((t1 shr 11) or (t1 shl 21)) + w[18] + $A15486AF;
  T:= (t7 and (t3 and t1 xor t2 xor t6) xor t3 and t4 xor t1 and t5 xor t6);
  t0:= ((T shr 7) or (T shl 25)) + ((t0 shr 11) or (t0 shl 21)) + w[27] + $7C72E993;

  T:= (t6 and (t2 and t0 xor t1 xor t5) xor t2 and t3 xor t0 and t4 xor t5);
  t7:= ((T shr 7) or (T shl 25)) + ((t7 shr 11) or (t7 shl 21)) + w[13] + $B3EE1411;
  T:= (t5 and (t1 and t7 xor t0 xor t4) xor t1 and t2 xor t7 and t3 xor t4);
  t6:= ((T shr 7) or (T shl 25)) + ((t6 shr 11) or (t6 shl 21)) + w[ 6] + $636FBC2A;
  T:= (t4 and (t0 and t6 xor t7 xor t3) xor t0 and t1 xor t6 and t2 xor t3);
  t5:= ((T shr 7) or (T shl 25)) + ((t5 shr 11) or (t5 shl 21)) + w[21] + $2BA9C55D;
  T:= (t3 and (t7 and t5 xor t6 xor t2) xor t7 and t0 xor t5 and t1 xor t2);
  t4:= ((T shr 7) or (T shl 25)) + ((t4 shr 11) or (t4 shl 21)) + w[10] + $741831F6;
  T:= (t2 and (t6 and t4 xor t5 xor t1) xor t6 and t7 xor t4 and t0 xor t1);
  t3:= ((T shr 7) or (T shl 25)) + ((t3 shr 11) or (t3 shl 21)) + w[23] + $CE5C3E16;
  T:= (t1 and (t5 and t3 xor t4 xor t0) xor t5 and t6 xor t3 and t7 xor t0);
  t2:= ((T shr 7) or (T shl 25)) + ((t2 shr 11) or (t2 shl 21)) + w[11] + $9B87931E;
  T:= (t0 and (t4 and t2 xor t3 xor t7) xor t4 and t5 xor t2 and t6 xor t7);
  t1:= ((T shr 7) or (T shl 25)) + ((t1 shr 11) or (t1 shl 21)) + w[ 5] + $AFD6BA33;
  T:= (t7 and (t3 and t1 xor t2 xor t6) xor t3 and t4 xor t1 and t5 xor t6);
  t0:= ((T shr 7) or (T shl 25)) + ((t0 shr 11) or (t0 shl 21)) + w[ 2] + $6C24CF5C;

  T:= (t0 and (t4 and not t2 xor t5 and not t6 xor t1 xor t6 xor t3) xor t5 and (t1 and t2 xor t4 xor t6) xor t2 and t6 xor t3);
  t7:= ((T shr 7) or (T shl 25)) + ((t7 shr 11) or (t7 shl 21)) + w[24] + $7A325381;
  T:= (t7 and (t3 and not t1 xor t4 and not t5 xor t0 xor t5 xor t2) xor t4 and (t0 and t1 xor t3 xor t5) xor t1 and t5 xor t2);
  t6:= ((T shr 7) or (T shl 25)) + ((t6 shr 11) or (t6 shl 21)) + w[ 4] + $28958677;
  T:= (t6 and (t2 and not t0 xor t3 and not t4 xor t7 xor t4 xor t1) xor t3 and (t7 and t0 xor t2 xor t4) xor t0 and t4 xor t1);
  t5:= ((T shr 7) or (T shl 25)) + ((t5 shr 11) or (t5 shl 21)) + w[ 0] + $3B8F4898;
  T:= (t5 and (t1 and not t7 xor t2 and not t3 xor t6 xor t3 xor t0) xor t2 and (t6 and t7 xor t1 xor t3) xor t7 and t3 xor t0);
  t4:= ((T shr 7) or (T shl 25)) + ((t4 shr 11) or (t4 shl 21)) + w[14] + $6B4BB9AF;
  T:= (t4 and (t0 and not t6 xor t1 and not t2 xor t5 xor t2 xor t7) xor t1 and (t5 and t6 xor t0 xor t2) xor t6 and t2 xor t7);
  t3:= ((T shr 7) or (T shl 25)) + ((t3 shr 11) or (t3 shl 21)) + w[ 2] + $C4BFE81B;
  T:= (t3 and (t7 and not t5 xor t0 and not t1 xor t4 xor t1 xor t6) xor t0 and (t4 and t5 xor t7 xor t1) xor t5 and t1 xor t6);
  t2:= ((T shr 7) or (T shl 25)) + ((t2 shr 11) or (t2 shl 21)) + w[ 7] + $66282193;
  T:= (t2 and (t6 and not t4 xor t7 and not t0 xor t3 xor t0 xor t5) xor t7 and (t3 and t4 xor t6 xor t0) xor t4 and t0 xor t5);
  t1:= ((T shr 7) or (T shl 25)) + ((t1 shr 11) or (t1 shl 21)) + w[28] + $61D809CC;
  T:= (t1 and (t5 and not t3 xor t6 and not t7 xor t2 xor t7 xor t4) xor t6 and (t2 and t3 xor t5 xor t7) xor t3 and t7 xor t4);
  t0:= ((T shr 7) or (T shl 25)) + ((t0 shr 11) or (t0 shl 21)) + w[23] + $FB21A991;

  T:= (t0 and (t4 and not t2 xor t5 and not t6 xor t1 xor t6 xor t3) xor t5 and (t1 and t2 xor t4 xor t6) xor t2 and t6 xor t3);
  t7:= ((T shr 7) or (T shl 25)) + ((t7 shr 11) or (t7 shl 21)) + w[26] + $487CAC60;
  T:= (t7 and (t3 and not t1 xor t4 and not t5 xor t0 xor t5 xor t2) xor t4 and (t0 and t1 xor t3 xor t5) xor t1 and t5 xor t2);
  t6:= ((T shr 7) or (T shl 25)) + ((t6 shr 11) or (t6 shl 21)) + w[ 6] + $5DEC8032;
  T:= (t6 and (t2 and not t0 xor t3 and not t4 xor t7 xor t4 xor t1) xor t3 and (t7 and t0 xor t2 xor t4) xor t0 and t4 xor t1);
  t5:= ((T shr 7) or (T shl 25)) + ((t5 shr 11) or (t5 shl 21)) + w[30] + $EF845D5D;
  T:= (t5 and (t1 and not t7 xor t2 and not t3 xor t6 xor t3 xor t0) xor t2 and (t6 and t7 xor t1 xor t3) xor t7 and t3 xor t0);
  t4:= ((T shr 7) or (T shl 25)) + ((t4 shr 11) or (t4 shl 21)) + w[20] + $E98575B1;
  T:= (t4 and (t0 and not t6 xor t1 and not t2 xor t5 xor t2 xor t7) xor t1 and (t5 and t6 xor t0 xor t2) xor t6 and t2 xor t7);
  t3:= ((T shr 7) or (T shl 25)) + ((t3 shr 11) or (t3 shl 21)) + w[18] + $DC262302;
  T:= (t3 and (t7 and not t5 xor t0 and not t1 xor t4 xor t1 xor t6) xor t0 and (t4 and t5 xor t7 xor t1) xor t5 and t1 xor t6);
  t2:= ((T shr 7) or (T shl 25)) + ((t2 shr 11) or (t2 shl 21)) + w[25] + $EB651B88;
  T:= (t2 and (t6 and not t4 xor t7 and not t0 xor t3 xor t0 xor t5) xor t7 and (t3 and t4 xor t6 xor t0) xor t4 and t0 xor t5);
  t1:= ((T shr 7) or (T shl 25)) + ((t1 shr 11) or (t1 shl 21)) + w[19] + $23893E81;
  T:= (t1 and (t5 and not t3 xor t6 and not t7 xor t2 xor t7 xor t4) xor t6 and (t2 and t3 xor t5 xor t7) xor t3 and t7 xor t4);
  t0:= ((T shr 7) or (T shl 25)) + ((t0 shr 11) or (t0 shl 21)) + w[ 3] + $D396ACC5;

  T:= (t0 and (t4 and not t2 xor t5 and not t6 xor t1 xor t6 xor t3) xor t5 and (t1 and t2 xor t4 xor t6) xor t2 and t6 xor t3);
  t7:= ((T shr 7) or (T shl 25)) + ((t7 shr 11) or (t7 shl 21)) + w[22] + $0F6D6FF3;
  T:= (t7 and (t3 and not t1 xor t4 and not t5 xor t0 xor t5 xor t2) xor t4 and (t0 and t1 xor t3 xor t5) xor t1 and t5 xor t2);
  t6:= ((T shr 7) or (T shl 25)) + ((t6 shr 11) or (t6 shl 21)) + w[11] + $83F44239;
  T:= (t6 and (t2 and not t0 xor t3 and not t4 xor t7 xor t4 xor t1) xor t3 and (t7 and t0 xor t2 xor t4) xor t0 and t4 xor t1);
  t5:= ((T shr 7) or (T shl 25)) + ((t5 shr 11) or (t5 shl 21)) + w[31] + $2E0B4482;
  T:= (t5 and (t1 and not t7 xor t2 and not t3 xor t6 xor t3 xor t0) xor t2 and (t6 and t7 xor t1 xor t3) xor t7 and t3 xor t0);
  t4:= ((T shr 7) or (T shl 25)) + ((t4 shr 11) or (t4 shl 21)) + w[21] + $A4842004;
  T:= (t4 and (t0 and not t6 xor t1 and not t2 xor t5 xor t2 xor t7) xor t1 and (t5 and t6 xor t0 xor t2) xor t6 and t2 xor t7);
  t3:= ((T shr 7) or (T shl 25)) + ((t3 shr 11) or (t3 shl 21)) + w[ 8] + $69C8F04A;
  T:= (t3 and (t7 and not t5 xor t0 and not t1 xor t4 xor t1 xor t6) xor t0 and (t4 and t5 xor t7 xor t1) xor t5 and t1 xor t6);
  t2:= ((T shr 7) or (T shl 25)) + ((t2 shr 11) or (t2 shl 21)) + w[27] + $9E1F9B5E;
  T:= (t2 and (t6 and not t4 xor t7 and not t0 xor t3 xor t0 xor t5) xor t7 and (t3 and t4 xor t6 xor t0) xor t4 and t0 xor t5);
  t1:= ((T shr 7) or (T shl 25)) + ((t1 shr 11) or (t1 shl 21)) + w[12] + $21C66842;
  T:= (t1 and (t5 and not t3 xor t6 and not t7 xor t2 xor t7 xor t4) xor t6 and (t2 and t3 xor t5 xor t7) xor t3 and t7 xor t4);
  t0:= ((T shr 7) or (T shl 25)) + ((t0 shr 11) or (t0 shl 21)) + w[ 9] + $F6E96C9A;

  T:= (t0 and (t4 and not t2 xor t5 and not t6 xor t1 xor t6 xor t3) xor t5 and (t1 and t2 xor t4 xor t6) xor t2 and t6 xor t3);
  t7:= ((T shr 7) or (T shl 25)) + ((t7 shr 11) or (t7 shl 21)) + w[ 1] + $670C9C61;
  T:= (t7 and (t3 and not t1 xor t4 and not t5 xor t0 xor t5 xor t2) xor t4 and (t0 and t1 xor t3 xor t5) xor t1 and t5 xor t2);
  t6:= ((T shr 7) or (T shl 25)) + ((t6 shr 11) or (t6 shl 21)) + w[29] + $ABD388F0;
  T:= (t6 and (t2 and not t0 xor t3 and not t4 xor t7 xor t4 xor t1) xor t3 and (t7 and t0 xor t2 xor t4) xor t0 and t4 xor t1);
  t5:= ((T shr 7) or (T shl 25)) + ((t5 shr 11) or (t5 shl 21)) + w[ 5] + $6A51A0D2;
  T:= (t5 and (t1 and not t7 xor t2 and not t3 xor t6 xor t3 xor t0) xor t2 and (t6 and t7 xor t1 xor t3) xor t7 and t3 xor t0);
  t4:= ((T shr 7) or (T shl 25)) + ((t4 shr 11) or (t4 shl 21)) + w[15] + $D8542F68;
  T:= (t4 and (t0 and not t6 xor t1 and not t2 xor t5 xor t2 xor t7) xor t1 and (t5 and t6 xor t0 xor t2) xor t6 and t2 xor t7);
  t3:= ((T shr 7) or (T shl 25)) + ((t3 shr 11) or (t3 shl 21)) + w[17] + $960FA728;
  T:= (t3 and (t7 and not t5 xor t0 and not t1 xor t4 xor t1 xor t6) xor t0 and (t4 and t5 xor t7 xor t1) xor t5 and t1 xor t6);
  t2:= ((T shr 7) or (T shl 25)) + ((t2 shr 11) or (t2 shl 21)) + w[10] + $AB5133A3;
  T:= (t2 and (t6 and not t4 xor t7 and not t0 xor t3 xor t0 xor t5) xor t7 and (t3 and t4 xor t6 xor t0) xor t4 and t0 xor t5);
  t1:= ((T shr 7) or (T shl 25)) + ((t1 shr 11) or (t1 shl 21)) + w[16] + $6EEF0B6C;
  T:= (t1 and (t5 and not t3 xor t6 and not t7 xor t2 xor t7 xor t4) xor t6 and (t2 and t3 xor t5 xor t7) xor t3 and t7 xor t4);
  t0:= ((T shr 7) or (T shl 25)) + ((t0 shr 11) or (t0 shl 21)) + w[13] + $137A3BE4;

  Inc(m_hash[0],t0);
  Inc(m_hash[1],t1);
  Inc(m_hash[2],t2);
  Inc(m_hash[3],t3);
  Inc(m_hash[4],t4);
  Inc(m_hash[5],t5);
  Inc(m_hash[6],t6);
  Inc(m_hash[7],t7);
end;

constructor TrhlHAVAL4.Create;
begin
  inherited Create;
  FRounds := 4;
end;

{ TrhlHAVAL5 }

procedure TrhlHAVAL5.UpdateBlock(const AData);
var
  W: array[0..0] of DWord absolute AData;
  t7, t6, t5, t4, t3, t2, t1, t0, t: DWord;
begin
  t0 := m_hash[0];
  t1 := m_hash[1];
  t2 := m_hash[2];
  t3 := m_hash[3];
  t4 := m_hash[4];
  t5 := m_hash[5];
  t6 := m_hash[6];
  t7 := m_hash[7];

  T:= (t2 and (t6 xor t1) xor t5 and t4 xor t0 and t3 xor t6);
  t7:= ((T shr 7) or (T shl 25)) + ((t7 shr 11) or (t7 shl 21)) + w[ 0];
  T:= (t1 and (t5 xor t0) xor t4 and t3 xor t7 and t2 xor t5);
  t6:= ((T shr 7) or (T shl 25)) + ((t6 shr 11) or (t6 shl 21)) + w[ 1];
  T:= (t0 and (t4 xor t7) xor t3 and t2 xor t6 and t1 xor t4);
  t5:= ((T shr 7) or (T shl 25)) + ((t5 shr 11) or (t5 shl 21)) + w[ 2];
  T:= (t7 and (t3 xor t6) xor t2 and t1 xor t5 and t0 xor t3);
  t4:= ((T shr 7) or (T shl 25)) + ((t4 shr 11) or (t4 shl 21)) + w[ 3];
  T:= (t6 and (t2 xor t5) xor t1 and t0 xor t4 and t7 xor t2);
  t3:= ((T shr 7) or (T shl 25)) + ((t3 shr 11) or (t3 shl 21)) + w[ 4];
  T:= (t5 and (t1 xor t4) xor t0 and t7 xor t3 and t6 xor t1);
  t2:= ((T shr 7) or (T shl 25)) + ((t2 shr 11) or (t2 shl 21)) + w[ 5];
  T:= (t4 and (t0 xor t3) xor t7 and t6 xor t2 and t5 xor t0);
  t1:= ((T shr 7) or (T shl 25)) + ((t1 shr 11) or (t1 shl 21)) + w[ 6];
  T:= (t3 and (t7 xor t2) xor t6 and t5 xor t1 and t4 xor t7);
  t0:= ((T shr 7) or (T shl 25)) + ((t0 shr 11) or (t0 shl 21)) + w[ 7];

  T:= (t2 and (t6 xor t1) xor t5 and t4 xor t0 and t3 xor t6);
  t7:= ((T shr 7) or (T shl 25)) + ((t7 shr 11) or (t7 shl 21)) + w[ 8];
  T:= (t1 and (t5 xor t0) xor t4 and t3 xor t7 and t2 xor t5);
  t6:= ((T shr 7) or (T shl 25)) + ((t6 shr 11) or (t6 shl 21)) + w[ 9];
  T:= (t0 and (t4 xor t7) xor t3 and t2 xor t6 and t1 xor t4);
  t5:= ((T shr 7) or (T shl 25)) + ((t5 shr 11) or (t5 shl 21)) + w[10];
  T:= (t7 and (t3 xor t6) xor t2 and t1 xor t5 and t0 xor t3);
  t4:= ((T shr 7) or (T shl 25)) + ((t4 shr 11) or (t4 shl 21)) + w[11];
  T:= (t6 and (t2 xor t5) xor t1 and t0 xor t4 and t7 xor t2);
  t3:= ((T shr 7) or (T shl 25)) + ((t3 shr 11) or (t3 shl 21)) + w[12];
  T:= (t5 and (t1 xor t4) xor t0 and t7 xor t3 and t6 xor t1);
  t2:= ((T shr 7) or (T shl 25)) + ((t2 shr 11) or (t2 shl 21)) + w[13];
  T:= (t4 and (t0 xor t3) xor t7 and t6 xor t2 and t5 xor t0);
  t1:= ((T shr 7) or (T shl 25)) + ((t1 shr 11) or (t1 shl 21)) + w[14];
  T:= (t3 and (t7 xor t2) xor t6 and t5 xor t1 and t4 xor t7);
  t0:= ((T shr 7) or (T shl 25)) + ((t0 shr 11) or (t0 shl 21)) + w[15];

  T:= (t2 and (t6 xor t1) xor t5 and t4 xor t0 and t3 xor t6);
  t7:= ((T shr 7) or (T shl 25)) + ((t7 shr 11) or (t7 shl 21)) + w[16];
  T:= (t1 and (t5 xor t0) xor t4 and t3 xor t7 and t2 xor t5);
  t6:= ((T shr 7) or (T shl 25)) + ((t6 shr 11) or (t6 shl 21)) + w[17];
  T:= (t0 and (t4 xor t7) xor t3 and t2 xor t6 and t1 xor t4);
  t5:= ((T shr 7) or (T shl 25)) + ((t5 shr 11) or (t5 shl 21)) + w[18];
  T:= (t7 and (t3 xor t6) xor t2 and t1 xor t5 and t0 xor t3);
  t4:= ((T shr 7) or (T shl 25)) + ((t4 shr 11) or (t4 shl 21)) + w[19];
  T:= (t6 and (t2 xor t5) xor t1 and t0 xor t4 and t7 xor t2);
  t3:= ((T shr 7) or (T shl 25)) + ((t3 shr 11) or (t3 shl 21)) + w[20];
  T:= (t5 and (t1 xor t4) xor t0 and t7 xor t3 and t6 xor t1);
  t2:= ((T shr 7) or (T shl 25)) + ((t2 shr 11) or (t2 shl 21)) + w[21];
  T:= (t4 and (t0 xor t3) xor t7 and t6 xor t2 and t5 xor t0);
  t1:= ((T shr 7) or (T shl 25)) + ((t1 shr 11) or (t1 shl 21)) + w[22];
  T:= (t3 and (t7 xor t2) xor t6 and t5 xor t1 and t4 xor t7);
  t0:= ((T shr 7) or (T shl 25)) + ((t0 shr 11) or (t0 shl 21)) + w[23];

  T:= (t2 and (t6 xor t1) xor t5 and t4 xor t0 and t3 xor t6);
  t7:= ((T shr 7) or (T shl 25)) + ((t7 shr 11) or (t7 shl 21)) + w[24];
  T:= (t1 and (t5 xor t0) xor t4 and t3 xor t7 and t2 xor t5);
  t6:= ((T shr 7) or (T shl 25)) + ((t6 shr 11) or (t6 shl 21)) + w[25];
  T:= (t0 and (t4 xor t7) xor t3 and t2 xor t6 and t1 xor t4);
  t5:= ((T shr 7) or (T shl 25)) + ((t5 shr 11) or (t5 shl 21)) + w[26];
  T:= (t7 and (t3 xor t6) xor t2 and t1 xor t5 and t0 xor t3);
  t4:= ((T shr 7) or (T shl 25)) + ((t4 shr 11) or (t4 shl 21)) + w[27];
  T:= (t6 and (t2 xor t5) xor t1 and t0 xor t4 and t7 xor t2);
  t3:= ((T shr 7) or (T shl 25)) + ((t3 shr 11) or (t3 shl 21)) + w[28];
  T:= (t5 and (t1 xor t4) xor t0 and t7 xor t3 and t6 xor t1);
  t2:= ((T shr 7) or (T shl 25)) + ((t2 shr 11) or (t2 shl 21)) + w[29];
  T:= (t4 and (t0 xor t3) xor t7 and t6 xor t2 and t5 xor t0);
  t1:= ((T shr 7) or (T shl 25)) + ((t1 shr 11) or (t1 shl 21)) + w[30];
  T:= (t3 and (t7 xor t2) xor t6 and t5 xor t1 and t4 xor t7);
  t0:= ((T shr 7) or (T shl 25)) + ((t0 shr 11) or (t0 shl 21)) + w[31];

  T:= (t3 and (t4 and not t0 xor t1 and t2 xor t6 xor t5) xor t1 and (t4 xor t2) xor t0 and t2 xor t5);
  t7:= ((T shr 7) or (T shl 25)) + ((t7 shr 11) or (t7 shl 21)) + w[ 5] + $452821E6;
  T:= (t2 and (t3 and not t7 xor t0 and t1 xor t5 xor t4) xor t0 and (t3 xor t1) xor t7 and t1 xor t4);
  t6:= ((T shr 7) or (T shl 25)) + ((t6 shr 11) or (t6 shl 21)) + w[14] + $38D01377;
  T:= (t1 and (t2 and not t6 xor t7 and t0 xor t4 xor t3) xor t7 and (t2 xor t0) xor t6 and t0 xor t3);
  t5:= ((T shr 7) or (T shl 25)) + ((t5 shr 11) or (t5 shl 21)) + w[26] + $BE5466CF;
  T:= (t0 and (t1 and not t5 xor t6 and t7 xor t3 xor t2) xor t6 and (t1 xor t7) xor t5 and t7 xor t2);
  t4:= ((T shr 7) or (T shl 25)) + ((t4 shr 11) or (t4 shl 21)) + w[18] + $34E90C6C;
  T:= (t7 and (t0 and not t4 xor t5 and t6 xor t2 xor t1) xor t5 and (t0 xor t6) xor t4 and t6 xor t1);
  t3:= ((T shr 7) or (T shl 25)) + ((t3 shr 11) or (t3 shl 21)) + w[11] + $C0AC29B7;
  T:= (t6 and (t7 and not t3 xor t4 and t5 xor t1 xor t0) xor t4 and (t7 xor t5) xor t3 and t5 xor t0);
  t2:= ((T shr 7) or (T shl 25)) + ((t2 shr 11) or (t2 shl 21)) + w[28] + $C97C50DD;
  T:= (t5 and (t6 and not t2 xor t3 and t4 xor t0 xor t7) xor t3 and (t6 xor t4) xor t2 and t4 xor t7);
  t1:= ((T shr 7) or (T shl 25)) + ((t1 shr 11) or (t1 shl 21)) + w[ 7] + $3F84D5B5;
  T:= (t4 and (t5 and not t1 xor t2 and t3 xor t7 xor t6) xor t2 and (t5 xor t3) xor t1 and t3 xor t6);
  t0:= ((T shr 7) or (T shl 25)) + ((t0 shr 11) or (t0 shl 21)) + w[16] + $B5470917;

  T:= (t3 and (t4 and not t0 xor t1 and t2 xor t6 xor t5) xor t1 and (t4 xor t2) xor t0 and t2 xor t5);
  t7:= ((T shr 7) or (T shl 25)) + ((t7 shr 11) or (t7 shl 21)) + w[ 0] + $9216D5D9;
  T:= (t2 and (t3 and not t7 xor t0 and t1 xor t5 xor t4) xor t0 and (t3 xor t1) xor t7 and t1 xor t4);
  t6:= ((T shr 7) or (T shl 25)) + ((t6 shr 11) or (t6 shl 21)) + w[23] + $8979FB1B;
  T:= (t1 and (t2 and not t6 xor t7 and t0 xor t4 xor t3) xor t7 and (t2 xor t0) xor t6 and t0 xor t3);
  t5:= ((T shr 7) or (T shl 25)) + ((t5 shr 11) or (t5 shl 21)) + w[20] + $D1310BA6;
  T:= (t0 and (t1 and not t5 xor t6 and t7 xor t3 xor t2) xor t6 and (t1 xor t7) xor t5 and t7 xor t2);
  t4:= ((T shr 7) or (T shl 25)) + ((t4 shr 11) or (t4 shl 21)) + w[22] + $98DFB5AC;
  T:= (t7 and (t0 and not t4 xor t5 and t6 xor t2 xor t1) xor t5 and (t0 xor t6) xor t4 and t6 xor t1);
  t3:= ((T shr 7) or (T shl 25)) + ((t3 shr 11) or (t3 shl 21)) + w[ 1] + $2FFD72DB;
  T:= (t6 and (t7 and not t3 xor t4 and t5 xor t1 xor t0) xor t4 and (t7 xor t5) xor t3 and t5 xor t0);
  t2:= ((T shr 7) or (T shl 25)) + ((t2 shr 11) or (t2 shl 21)) + w[10] + $D01ADFB7;
  T:= (t5 and (t6 and not t2 xor t3 and t4 xor t0 xor t7) xor t3 and (t6 xor t4) xor t2 and t4 xor t7);
  t1:= ((T shr 7) or (T shl 25)) + ((t1 shr 11) or (t1 shl 21)) + w[ 4] + $B8E1AFED;
  T:= (t4 and (t5 and not t1 xor t2 and t3 xor t7 xor t6) xor t2 and (t5 xor t3) xor t1 and t3 xor t6);
  t0:= ((T shr 7) or (T shl 25)) + ((t0 shr 11) or (t0 shl 21)) + w[ 8] + $6A267E96;

  T:= (t3 and (t4 and not t0 xor t1 and t2 xor t6 xor t5) xor t1 and (t4 xor t2) xor t0 and t2 xor t5);
  t7:= ((T shr 7) or (T shl 25)) + ((t7 shr 11) or (t7 shl 21)) + w[30] + $BA7C9045;
  T:= (t2 and (t3 and not t7 xor t0 and t1 xor t5 xor t4) xor t0 and (t3 xor t1) xor t7 and t1 xor t4);
  t6:= ((T shr 7) or (T shl 25)) + ((t6 shr 11) or (t6 shl 21)) + w[ 3] + $F12C7F99;
  T:= (t1 and (t2 and not t6 xor t7 and t0 xor t4 xor t3) xor t7 and (t2 xor t0) xor t6 and t0 xor t3);
  t5:= ((T shr 7) or (T shl 25)) + ((t5 shr 11) or (t5 shl 21)) + w[21] + $24A19947;
  T:= (t0 and (t1 and not t5 xor t6 and t7 xor t3 xor t2) xor t6 and (t1 xor t7) xor t5 and t7 xor t2);
  t4:= ((T shr 7) or (T shl 25)) + ((t4 shr 11) or (t4 shl 21)) + w[ 9] + $B3916CF7;
  T:= (t7 and (t0 and not t4 xor t5 and t6 xor t2 xor t1) xor t5 and (t0 xor t6) xor t4 and t6 xor t1);
  t3:= ((T shr 7) or (T shl 25)) + ((t3 shr 11) or (t3 shl 21)) + w[17] + $0801F2E2;
  T:= (t6 and (t7 and not t3 xor t4 and t5 xor t1 xor t0) xor t4 and (t7 xor t5) xor t3 and t5 xor t0);
  t2:= ((T shr 7) or (T shl 25)) + ((t2 shr 11) or (t2 shl 21)) + w[24] + $858EFC16;
  T:= (t5 and (t6 and not t2 xor t3 and t4 xor t0 xor t7) xor t3 and (t6 xor t4) xor t2 and t4 xor t7);
  t1:= ((T shr 7) or (T shl 25)) + ((t1 shr 11) or (t1 shl 21)) + w[29] + $636920D8;
  T:= (t4 and (t5 and not t1 xor t2 and t3 xor t7 xor t6) xor t2 and (t5 xor t3) xor t1 and t3 xor t6);
  t0:= ((T shr 7) or (T shl 25)) + ((t0 shr 11) or (t0 shl 21)) + w[ 6] + $71574E69;

  T:= (t3 and (t4 and not t0 xor t1 and t2 xor t6 xor t5) xor t1 and (t4 xor t2) xor t0 and t2 xor t5);
  t7:= ((T shr 7) or (T shl 25)) + ((t7 shr 11) or (t7 shl 21)) + w[19] + $A458FEA3;
  T:= (t2 and (t3 and not t7 xor t0 and t1 xor t5 xor t4) xor t0 and (t3 xor t1) xor t7 and t1 xor t4);
  t6:= ((T shr 7) or (T shl 25)) + ((t6 shr 11) or (t6 shl 21)) + w[12] + $F4933D7E;
  T:= (t1 and (t2 and not t6 xor t7 and t0 xor t4 xor t3) xor t7 and (t2 xor t0) xor t6 and t0 xor t3);
  t5:= ((T shr 7) or (T shl 25)) + ((t5 shr 11) or (t5 shl 21)) + w[15] + $0D95748F;
  T:= (t0 and (t1 and not t5 xor t6 and t7 xor t3 xor t2) xor t6 and (t1 xor t7) xor t5 and t7 xor t2);
  t4:= ((T shr 7) or (T shl 25)) + ((t4 shr 11) or (t4 shl 21)) + w[13] + $728EB658;
  T:= (t7 and (t0 and not t4 xor t5 and t6 xor t2 xor t1) xor t5 and (t0 xor t6) xor t4 and t6 xor t1);
  t3:= ((T shr 7) or (T shl 25)) + ((t3 shr 11) or (t3 shl 21)) + w[ 2] + $718BCD58;
  T:= (t6 and (t7 and not t3 xor t4 and t5 xor t1 xor t0) xor t4 and (t7 xor t5) xor t3 and t5 xor t0);
  t2:= ((T shr 7) or (T shl 25)) + ((t2 shr 11) or (t2 shl 21)) + w[25] + $82154AEE;
  T:= (t5 and (t6 and not t2 xor t3 and t4 xor t0 xor t7) xor t3 and (t6 xor t4) xor t2 and t4 xor t7);
  t1:= ((T shr 7) or (T shl 25)) + ((t1 shr 11) or (t1 shl 21)) + w[31] + $7B54A41D;
  T:= (t4 and (t5 and not t1 xor t2 and t3 xor t7 xor t6) xor t2 and (t5 xor t3) xor t1 and t3 xor t6);
  t0:= ((T shr 7) or (T shl 25)) + ((t0 shr 11) or (t0 shl 21)) + w[27] + $C25A59B5;

  T:= (t4 and (t1 and t3 xor t2 xor t5) xor t1 and t0 xor t3 and t6 xor t5);
  t7:= ((T shr 7) or (T shl 25)) + ((t7 shr 11) or (t7 shl 21)) + w[19] + $9C30D539;
  T:= (t3 and (t0 and t2 xor t1 xor t4) xor t0 and t7 xor t2 and t5 xor t4);
  t6:= ((T shr 7) or (T shl 25)) + ((t6 shr 11) or (t6 shl 21)) + w[ 9] + $2AF26013;
  T:= (t2 and (t7 and t1 xor t0 xor t3) xor t7 and t6 xor t1 and t4 xor t3);
  t5:= ((T shr 7) or (T shl 25)) + ((t5 shr 11) or (t5 shl 21)) + w[ 4] + $C5D1B023;
  T:= (t1 and (t6 and t0 xor t7 xor t2) xor t6 and t5 xor t0 and t3 xor t2);
  t4:= ((T shr 7) or (T shl 25)) + ((t4 shr 11) or (t4 shl 21)) + w[20] + $286085F0;
  T:= (t0 and (t5 and t7 xor t6 xor t1) xor t5 and t4 xor t7 and t2 xor t1);
  t3:= ((T shr 7) or (T shl 25)) + ((t3 shr 11) or (t3 shl 21)) + w[28] + $CA417918;
  T:= (t7 and (t4 and t6 xor t5 xor t0) xor t4 and t3 xor t6 and t1 xor t0);
  t2:= ((T shr 7) or (T shl 25)) + ((t2 shr 11) or (t2 shl 21)) + w[17] + $B8DB38EF;
  T:= (t6 and (t3 and t5 xor t4 xor t7) xor t3 and t2 xor t5 and t0 xor t7);
  t1:= ((T shr 7) or (T shl 25)) + ((t1 shr 11) or (t1 shl 21)) + w[ 8] + $8E79DCB0;
  T:= (t5 and (t2 and t4 xor t3 xor t6) xor t2 and t1 xor t4 and t7 xor t6);
  t0:= ((T shr 7) or (T shl 25)) + ((t0 shr 11) or (t0 shl 21)) + w[22] + $603A180E;

  T:= (t4 and (t1 and t3 xor t2 xor t5) xor t1 and t0 xor t3 and t6 xor t5);
  t7:= ((T shr 7) or (T shl 25)) + ((t7 shr 11) or (t7 shl 21)) + w[29] + $6C9E0E8B;
  T:= (t3 and (t0 and t2 xor t1 xor t4) xor t0 and t7 xor t2 and t5 xor t4);
  t6:= ((T shr 7) or (T shl 25)) + ((t6 shr 11) or (t6 shl 21)) + w[14] + $B01E8A3E;
  T:= (t2 and (t7 and t1 xor t0 xor t3) xor t7 and t6 xor t1 and t4 xor t3);
  t5:= ((T shr 7) or (T shl 25)) + ((t5 shr 11) or (t5 shl 21)) + w[25] + $D71577C1;
  T:= (t1 and (t6 and t0 xor t7 xor t2) xor t6 and t5 xor t0 and t3 xor t2);
  t4:= ((T shr 7) or (T shl 25)) + ((t4 shr 11) or (t4 shl 21)) + w[12] + $BD314B27;
  T:= (t0 and (t5 and t7 xor t6 xor t1) xor t5 and t4 xor t7 and t2 xor t1);
  t3:= ((T shr 7) or (T shl 25)) + ((t3 shr 11) or (t3 shl 21)) + w[24] + $78AF2FDA;
  T:= (t7 and (t4 and t6 xor t5 xor t0) xor t4 and t3 xor t6 and t1 xor t0);
  t2:= ((T shr 7) or (T shl 25)) + ((t2 shr 11) or (t2 shl 21)) + w[30] + $55605C60;
  T:= (t6 and (t3 and t5 xor t4 xor t7) xor t3 and t2 xor t5 and t0 xor t7);
  t1:= ((T shr 7) or (T shl 25)) + ((t1 shr 11) or (t1 shl 21)) + w[16] + $E65525F3;
  T:= (t5 and (t2 and t4 xor t3 xor t6) xor t2 and t1 xor t4 and t7 xor t6);
  t0:= ((T shr 7) or (T shl 25)) + ((t0 shr 11) or (t0 shl 21)) + w[26] + $AA55AB94;

  T:= (t4 and (t1 and t3 xor t2 xor t5) xor t1 and t0 xor t3 and t6 xor t5);
  t7:= ((T shr 7) or (T shl 25)) + ((t7 shr 11) or (t7 shl 21)) + w[31] + $57489862;
  T:= (t3 and (t0 and t2 xor t1 xor t4) xor t0 and t7 xor t2 and t5 xor t4);
  t6:= ((T shr 7) or (T shl 25)) + ((t6 shr 11) or (t6 shl 21)) + w[15] + $63E81440;
  T:= (t2 and (t7 and t1 xor t0 xor t3) xor t7 and t6 xor t1 and t4 xor t3);
  t5:= ((T shr 7) or (T shl 25)) + ((t5 shr 11) or (t5 shl 21)) + w[ 7] + $55CA396A;
  T:= (t1 and (t6 and t0 xor t7 xor t2) xor t6 and t5 xor t0 and t3 xor t2);
  t4:= ((T shr 7) or (T shl 25)) + ((t4 shr 11) or (t4 shl 21)) + w[ 3] + $2AAB10B6;
  T:= (t0 and (t5 and t7 xor t6 xor t1) xor t5 and t4 xor t7 and t2 xor t1);
  t3:= ((T shr 7) or (T shl 25)) + ((t3 shr 11) or (t3 shl 21)) + w[ 1] + $B4CC5C34;
  T:= (t7 and (t4 and t6 xor t5 xor t0) xor t4 and t3 xor t6 and t1 xor t0);
  t2:= ((T shr 7) or (T shl 25)) + ((t2 shr 11) or (t2 shl 21)) + w[ 0] + $1141E8CE;
  T:= (t6 and (t3 and t5 xor t4 xor t7) xor t3 and t2 xor t5 and t0 xor t7);
  t1:= ((T shr 7) or (T shl 25)) + ((t1 shr 11) or (t1 shl 21)) + w[18] + $A15486AF;
  T:= (t5 and (t2 and t4 xor t3 xor t6) xor t2 and t1 xor t4 and t7 xor t6);
  t0:= ((T shr 7) or (T shl 25)) + ((t0 shr 11) or (t0 shl 21)) + w[27] + $7C72E993;

  T:= (t4 and (t1 and t3 xor t2 xor t5) xor t1 and t0 xor t3 and t6 xor t5);
  t7:= ((T shr 7) or (T shl 25)) + ((t7 shr 11) or (t7 shl 21)) + w[13] + $B3EE1411;
  T:= (t3 and (t0 and t2 xor t1 xor t4) xor t0 and t7 xor t2 and t5 xor t4);
  t6:= ((T shr 7) or (T shl 25)) + ((t6 shr 11) or (t6 shl 21)) + w[ 6] + $636FBC2A;
  T:= (t2 and (t7 and t1 xor t0 xor t3) xor t7 and t6 xor t1 and t4 xor t3);
  t5:= ((T shr 7) or (T shl 25)) + ((t5 shr 11) or (t5 shl 21)) + w[21] + $2BA9C55D;
  T:= (t1 and (t6 and t0 xor t7 xor t2) xor t6 and t5 xor t0 and t3 xor t2);
  t4:= ((T shr 7) or (T shl 25)) + ((t4 shr 11) or (t4 shl 21)) + w[10] + $741831F6;
  T:= (t0 and (t5 and t7 xor t6 xor t1) xor t5 and t4 xor t7 and t2 xor t1);
  t3:= ((T shr 7) or (T shl 25)) + ((t3 shr 11) or (t3 shl 21)) + w[23] + $CE5C3E16;
  T:= (t7 and (t4 and t6 xor t5 xor t0) xor t4 and t3 xor t6 and t1 xor t0);
  t2:= ((T shr 7) or (T shl 25)) + ((t2 shr 11) or (t2 shl 21)) + w[11] + $9B87931E;
  T:= (t6 and (t3 and t5 xor t4 xor t7) xor t3 and t2 xor t5 and t0 xor t7);
  t1:= ((T shr 7) or (T shl 25)) + ((t1 shr 11) or (t1 shl 21)) + w[ 5] + $AFD6BA33;
  T:= (t5 and (t2 and t4 xor t3 xor t6) xor t2 and t1 xor t4 and t7 xor t6);
  t0:= ((T shr 7) or (T shl 25)) + ((t0 shr 11) or (t0 shl 21)) + w[ 2] + $6C24CF5C;

  T:= (t3 and (t5 and not t0 xor t2 and not t1 xor t4 xor t1 xor t6) xor t2 and (t4 and t0 xor t5 xor t1) xor t0 and t1 xor t6);
  t7:= ((T shr 7) or (T shl 25)) + ((t7 shr 11) or (t7 shl 21)) + w[24] + $7A325381;
  T:= (t2 and (t4 and not t7 xor t1 and not t0 xor t3 xor t0 xor t5) xor t1 and (t3 and t7 xor t4 xor t0) xor t7 and t0 xor t5);
  t6:= ((T shr 7) or (T shl 25)) + ((t6 shr 11) or (t6 shl 21)) + w[ 4] + $28958677;
  T:= (t1 and (t3 and not t6 xor t0 and not t7 xor t2 xor t7 xor t4) xor t0 and (t2 and t6 xor t3 xor t7) xor t6 and t7 xor t4);
  t5:= ((T shr 7) or (T shl 25)) + ((t5 shr 11) or (t5 shl 21)) + w[ 0] + $3B8F4898;
  T:= (t0 and (t2 and not t5 xor t7 and not t6 xor t1 xor t6 xor t3) xor t7 and (t1 and t5 xor t2 xor t6) xor t5 and t6 xor t3);
  t4:= ((T shr 7) or (T shl 25)) + ((t4 shr 11) or (t4 shl 21)) + w[14] + $6B4BB9AF;
  T:= (t7 and (t1 and not t4 xor t6 and not t5 xor t0 xor t5 xor t2) xor t6 and (t0 and t4 xor t1 xor t5) xor t4 and t5 xor t2);
  t3:= ((T shr 7) or (T shl 25)) + ((t3 shr 11) or (t3 shl 21)) + w[ 2] + $C4BFE81B;
  T:= (t6 and (t0 and not t3 xor t5 and not t4 xor t7 xor t4 xor t1) xor t5 and (t7 and t3 xor t0 xor t4) xor t3 and t4 xor t1);
  t2:= ((T shr 7) or (T shl 25)) + ((t2 shr 11) or (t2 shl 21)) + w[ 7] + $66282193;
  T:= (t5 and (t7 and not t2 xor t4 and not t3 xor t6 xor t3 xor t0) xor t4 and (t6 and t2 xor t7 xor t3) xor t2 and t3 xor t0);
  t1:= ((T shr 7) or (T shl 25)) + ((t1 shr 11) or (t1 shl 21)) + w[28] + $61D809CC;
  T:= (t4 and (t6 and not t1 xor t3 and not t2 xor t5 xor t2 xor t7) xor t3 and (t5 and t1 xor t6 xor t2) xor t1 and t2 xor t7);
  t0:= ((T shr 7) or (T shl 25)) + ((t0 shr 11) or (t0 shl 21)) + w[23] + $FB21A991;

  T:= (t3 and (t5 and not t0 xor t2 and not t1 xor t4 xor t1 xor t6) xor t2 and (t4 and t0 xor t5 xor t1) xor t0 and t1 xor t6);
  t7:= ((T shr 7) or (T shl 25)) + ((t7 shr 11) or (t7 shl 21)) + w[26] + $487CAC60;
  T:= (t2 and (t4 and not t7 xor t1 and not t0 xor t3 xor t0 xor t5) xor t1 and (t3 and t7 xor t4 xor t0) xor t7 and t0 xor t5);
  t6:= ((T shr 7) or (T shl 25)) + ((t6 shr 11) or (t6 shl 21)) + w[ 6] + $5DEC8032;
  T:= (t1 and (t3 and not t6 xor t0 and not t7 xor t2 xor t7 xor t4) xor t0 and (t2 and t6 xor t3 xor t7) xor t6 and t7 xor t4);
  t5:= ((T shr 7) or (T shl 25)) + ((t5 shr 11) or (t5 shl 21)) + w[30] + $EF845D5D;
  T:= (t0 and (t2 and not t5 xor t7 and not t6 xor t1 xor t6 xor t3) xor t7 and (t1 and t5 xor t2 xor t6) xor t5 and t6 xor t3);
  t4:= ((T shr 7) or (T shl 25)) + ((t4 shr 11) or (t4 shl 21)) + w[20] + $E98575B1;
  T:= (t7 and (t1 and not t4 xor t6 and not t5 xor t0 xor t5 xor t2) xor t6 and (t0 and t4 xor t1 xor t5) xor t4 and t5 xor t2);
  t3:= ((T shr 7) or (T shl 25)) + ((t3 shr 11) or (t3 shl 21)) + w[18] + $DC262302;
  T:= (t6 and (t0 and not t3 xor t5 and not t4 xor t7 xor t4 xor t1) xor t5 and (t7 and t3 xor t0 xor t4) xor t3 and t4 xor t1);
  t2:= ((T shr 7) or (T shl 25)) + ((t2 shr 11) or (t2 shl 21)) + w[25] + $EB651B88;
  T:= (t5 and (t7 and not t2 xor t4 and not t3 xor t6 xor t3 xor t0) xor t4 and (t6 and t2 xor t7 xor t3) xor t2 and t3 xor t0);
  t1:= ((T shr 7) or (T shl 25)) + ((t1 shr 11) or (t1 shl 21)) + w[19] + $23893E81;
  T:= (t4 and (t6 and not t1 xor t3 and not t2 xor t5 xor t2 xor t7) xor t3 and (t5 and t1 xor t6 xor t2) xor t1 and t2 xor t7);
  t0:= ((T shr 7) or (T shl 25)) + ((t0 shr 11) or (t0 shl 21)) + w[ 3] + $D396ACC5;

  T:= (t3 and (t5 and not t0 xor t2 and not t1 xor t4 xor t1 xor t6) xor t2 and (t4 and t0 xor t5 xor t1) xor t0 and t1 xor t6);
  t7:= ((T shr 7) or (T shl 25)) + ((t7 shr 11) or (t7 shl 21)) + w[22] + $0F6D6FF3;
  T:= (t2 and (t4 and not t7 xor t1 and not t0 xor t3 xor t0 xor t5) xor t1 and (t3 and t7 xor t4 xor t0) xor t7 and t0 xor t5);
  t6:= ((T shr 7) or (T shl 25)) + ((t6 shr 11) or (t6 shl 21)) + w[11] + $83F44239;
  T:= (t1 and (t3 and not t6 xor t0 and not t7 xor t2 xor t7 xor t4) xor t0 and (t2 and t6 xor t3 xor t7) xor t6 and t7 xor t4);
  t5:= ((T shr 7) or (T shl 25)) + ((t5 shr 11) or (t5 shl 21)) + w[31] + $2E0B4482;
  T:= (t0 and (t2 and not t5 xor t7 and not t6 xor t1 xor t6 xor t3) xor t7 and (t1 and t5 xor t2 xor t6) xor t5 and t6 xor t3);
  t4:= ((T shr 7) or (T shl 25)) + ((t4 shr 11) or (t4 shl 21)) + w[21] + $A4842004;
  T:= (t7 and (t1 and not t4 xor t6 and not t5 xor t0 xor t5 xor t2) xor t6 and (t0 and t4 xor t1 xor t5) xor t4 and t5 xor t2);
  t3:= ((T shr 7) or (T shl 25)) + ((t3 shr 11) or (t3 shl 21)) + w[ 8] + $69C8F04A;
  T:= (t6 and (t0 and not t3 xor t5 and not t4 xor t7 xor t4 xor t1) xor t5 and (t7 and t3 xor t0 xor t4) xor t3 and t4 xor t1);
  t2:= ((T shr 7) or (T shl 25)) + ((t2 shr 11) or (t2 shl 21)) + w[27] + $9E1F9B5E;
  T:= (t5 and (t7 and not t2 xor t4 and not t3 xor t6 xor t3 xor t0) xor t4 and (t6 and t2 xor t7 xor t3) xor t2 and t3 xor t0);
  t1:= ((T shr 7) or (T shl 25)) + ((t1 shr 11) or (t1 shl 21)) + w[12] + $21C66842;
  T:= (t4 and (t6 and not t1 xor t3 and not t2 xor t5 xor t2 xor t7) xor t3 and (t5 and t1 xor t6 xor t2) xor t1 and t2 xor t7);
  t0:= ((T shr 7) or (T shl 25)) + ((t0 shr 11) or (t0 shl 21)) + w[ 9] + $F6E96C9A;

  T:= (t3 and (t5 and not t0 xor t2 and not t1 xor t4 xor t1 xor t6) xor t2 and (t4 and t0 xor t5 xor t1) xor t0 and t1 xor t6);
  t7:= ((T shr 7) or (T shl 25)) + ((t7 shr 11) or (t7 shl 21)) + w[ 1] + $670C9C61;
  T:= (t2 and (t4 and not t7 xor t1 and not t0 xor t3 xor t0 xor t5) xor t1 and (t3 and t7 xor t4 xor t0) xor t7 and t0 xor t5);
  t6:= ((T shr 7) or (T shl 25)) + ((t6 shr 11) or (t6 shl 21)) + w[29] + $ABD388F0;
  T:= (t1 and (t3 and not t6 xor t0 and not t7 xor t2 xor t7 xor t4) xor t0 and (t2 and t6 xor t3 xor t7) xor t6 and t7 xor t4);
  t5:= ((T shr 7) or (T shl 25)) + ((t5 shr 11) or (t5 shl 21)) + w[ 5] + $6A51A0D2;
  T:= (t0 and (t2 and not t5 xor t7 and not t6 xor t1 xor t6 xor t3) xor t7 and (t1 and t5 xor t2 xor t6) xor t5 and t6 xor t3);
  t4:= ((T shr 7) or (T shl 25)) + ((t4 shr 11) or (t4 shl 21)) + w[15] + $D8542F68;
  T:= (t7 and (t1 and not t4 xor t6 and not t5 xor t0 xor t5 xor t2) xor t6 and (t0 and t4 xor t1 xor t5) xor t4 and t5 xor t2);
  t3:= ((T shr 7) or (T shl 25)) + ((t3 shr 11) or (t3 shl 21)) + w[17] + $960FA728;
  T:= (t6 and (t0 and not t3 xor t5 and not t4 xor t7 xor t4 xor t1) xor t5 and (t7 and t3 xor t0 xor t4) xor t3 and t4 xor t1);
  t2:= ((T shr 7) or (T shl 25)) + ((t2 shr 11) or (t2 shl 21)) + w[10] + $AB5133A3;
  T:= (t5 and (t7 and not t2 xor t4 and not t3 xor t6 xor t3 xor t0) xor t4 and (t6 and t2 xor t7 xor t3) xor t2 and t3 xor t0);
  t1:= ((T shr 7) or (T shl 25)) + ((t1 shr 11) or (t1 shl 21)) + w[16] + $6EEF0B6C;
  T:= (t4 and (t6 and not t1 xor t3 and not t2 xor t5 xor t2 xor t7) xor t3 and (t5 and t1 xor t6 xor t2) xor t1 and t2 xor t7);
  t0:= ((T shr 7) or (T shl 25)) + ((t0 shr 11) or (t0 shl 21)) + w[13] + $137A3BE4;

  T:= (t1 and (t3 and t4 and t6 xor not t5) xor t3 and t0 xor t4 and t5 xor t6 and t2);
  t7:= ((T shr 7) or (T shl 25)) + ((t7 shr 11) or (t7 shl 21)) + w[27] + $BA3BF050;
  T:= (t0 and (t2 and t3 and t5 xor not t4) xor t2 and t7 xor t3 and t4 xor t5 and t1);
  t6:= ((T shr 7) or (T shl 25)) + ((t6 shr 11) or (t6 shl 21)) + w[ 3] + $7EFB2A98;
  T:= (t7 and (t1 and t2 and t4 xor not t3) xor t1 and t6 xor t2 and t3 xor t4 and t0);
  t5:= ((T shr 7) or (T shl 25)) + ((t5 shr 11) or (t5 shl 21)) + w[21] + $A1F1651D;
  T:= (t6 and (t0 and t1 and t3 xor not t2) xor t0 and t5 xor t1 and t2 xor t3 and t7);
  t4:= ((T shr 7) or (T shl 25)) + ((t4 shr 11) or (t4 shl 21)) + w[26] + $39AF0176;
  T:= (t5 and (t7 and t0 and t2 xor not t1) xor t7 and t4 xor t0 and t1 xor t2 and t6);
  t3:= ((T shr 7) or (T shl 25)) + ((t3 shr 11) or (t3 shl 21)) + w[17] + $66CA593E;
  T:= (t4 and (t6 and t7 and t1 xor not t0) xor t6 and t3 xor t7 and t0 xor t1 and t5);
  t2:= ((T shr 7) or (T shl 25)) + ((t2 shr 11) or (t2 shl 21)) + w[11] + $82430E88;
  T:= (t3 and (t5 and t6 and t0 xor not t7) xor t5 and t2 xor t6 and t7 xor t0 and t4);
  t1:= ((T shr 7) or (T shl 25)) + ((t1 shr 11) or (t1 shl 21)) + w[20] + $8CEE8619;
  T:= (t2 and (t4 and t5 and t7 xor not t6) xor t4 and t1 xor t5 and t6 xor t7 and t3);
  t0:= ((T shr 7) or (T shl 25)) + ((t0 shr 11) or (t0 shl 21)) + w[29] + $456F9FB4;

  T:= (t1 and (t3 and t4 and t6 xor not t5) xor t3 and t0 xor t4 and t5 xor t6 and t2);
  t7:= ((T shr 7) or (T shl 25)) + ((t7 shr 11) or (t7 shl 21)) + w[19] + $7D84A5C3;
  T:= (t0 and (t2 and t3 and t5 xor not t4) xor t2 and t7 xor t3 and t4 xor t5 and t1);
  t6:= ((T shr 7) or (T shl 25)) + ((t6 shr 11) or (t6 shl 21)) + w[ 0] + $3B8B5EBE;
  T:= (t7 and (t1 and t2 and t4 xor not t3) xor t1 and t6 xor t2 and t3 xor t4 and t0);
  t5:= ((T shr 7) or (T shl 25)) + ((t5 shr 11) or (t5 shl 21)) + w[12] + $E06F75D8;
  T:= (t6 and (t0 and t1 and t3 xor not t2) xor t0 and t5 xor t1 and t2 xor t3 and t7);
  t4:= ((T shr 7) or (T shl 25)) + ((t4 shr 11) or (t4 shl 21)) + w[ 7] + $85C12073;
  T:= (t5 and (t7 and t0 and t2 xor not t1) xor t7 and t4 xor t0 and t1 xor t2 and t6);
  t3:= ((T shr 7) or (T shl 25)) + ((t3 shr 11) or (t3 shl 21)) + w[13] + $401A449F;
  T:= (t4 and (t6 and t7 and t1 xor not t0) xor t6 and t3 xor t7 and t0 xor t1 and t5);
  t2:= ((T shr 7) or (T shl 25)) + ((t2 shr 11) or (t2 shl 21)) + w[ 8] + $56C16AA6;
  T:= (t3 and (t5 and t6 and t0 xor not t7) xor t5 and t2 xor t6 and t7 xor t0 and t4);
  t1:= ((T shr 7) or (T shl 25)) + ((t1 shr 11) or (t1 shl 21)) + w[31] + $4ED3AA62;
  T:= (t2 and (t4 and t5 and t7 xor not t6) xor t4 and t1 xor t5 and t6 xor t7 and t3);
  t0:= ((T shr 7) or (T shl 25)) + ((t0 shr 11) or (t0 shl 21)) + w[10] + $363F7706;

  T:= (t1 and (t3 and t4 and t6 xor not t5) xor t3 and t0 xor t4 and t5 xor t6 and t2);
  t7:= ((T shr 7) or (T shl 25)) + ((t7 shr 11) or (t7 shl 21)) + w[ 5] + $1BFEDF72;
  T:= (t0 and (t2 and t3 and t5 xor not t4) xor t2 and t7 xor t3 and t4 xor t5 and t1);
  t6:= ((T shr 7) or (T shl 25)) + ((t6 shr 11) or (t6 shl 21)) + w[ 9] + $429B023D;
  T:= (t7 and (t1 and t2 and t4 xor not t3) xor t1 and t6 xor t2 and t3 xor t4 and t0);
  t5:= ((T shr 7) or (T shl 25)) + ((t5 shr 11) or (t5 shl 21)) + w[14] + $37D0D724;
  T:= (t6 and (t0 and t1 and t3 xor not t2) xor t0 and t5 xor t1 and t2 xor t3 and t7);
  t4:= ((T shr 7) or (T shl 25)) + ((t4 shr 11) or (t4 shl 21)) + w[30] + $D00A1248;
  T:= (t5 and (t7 and t0 and t2 xor not t1) xor t7 and t4 xor t0 and t1 xor t2 and t6);
  t3:= ((T shr 7) or (T shl 25)) + ((t3 shr 11) or (t3 shl 21)) + w[18] + $DB0FEAD3;
  T:= (t4 and (t6 and t7 and t1 xor not t0) xor t6 and t3 xor t7 and t0 xor t1 and t5);
  t2:= ((T shr 7) or (T shl 25)) + ((t2 shr 11) or (t2 shl 21)) + w[ 6] + $49F1C09B;
  T:= (t3 and (t5 and t6 and t0 xor not t7) xor t5 and t2 xor t6 and t7 xor t0 and t4);
  t1:= ((T shr 7) or (T shl 25)) + ((t1 shr 11) or (t1 shl 21)) + w[28] + $075372C9;
  T:= (t2 and (t4 and t5 and t7 xor not t6) xor t4 and t1 xor t5 and t6 xor t7 and t3);
  t0:= ((T shr 7) or (T shl 25)) + ((t0 shr 11) or (t0 shl 21)) + w[24] + $80991B7B;

  T:= (t1 and (t3 and t4 and t6 xor not t5) xor t3 and t0 xor t4 and t5 xor t6 and t2);
  t7:= ((T shr 7) or (T shl 25)) + ((t7 shr 11) or (t7 shl 21)) + w[ 2] + $25D479D8;
  T:= (t0 and (t2 and t3 and t5 xor not t4) xor t2 and t7 xor t3 and t4 xor t5 and t1);
  t6:= ((T shr 7) or (T shl 25)) + ((t6 shr 11) or (t6 shl 21)) + w[23] + $F6E8DEF7;
  T:= (t7 and (t1 and t2 and t4 xor not t3) xor t1 and t6 xor t2 and t3 xor t4 and t0);
  t5:= ((T shr 7) or (T shl 25)) + ((t5 shr 11) or (t5 shl 21)) + w[16] + $E3FE501A;
  T:= (t6 and (t0 and t1 and t3 xor not t2) xor t0 and t5 xor t1 and t2 xor t3 and t7);
  t4:= ((T shr 7) or (T shl 25)) + ((t4 shr 11) or (t4 shl 21)) + w[22] + $B6794C3B;
  T:= (t5 and (t7 and t0 and t2 xor not t1) xor t7 and t4 xor t0 and t1 xor t2 and t6);
  t3:= ((T shr 7) or (T shl 25)) + ((t3 shr 11) or (t3 shl 21)) + w[ 4] + $976CE0BD;
  T:= (t4 and (t6 and t7 and t1 xor not t0) xor t6 and t3 xor t7 and t0 xor t1 and t5);
  t2:= ((T shr 7) or (T shl 25)) + ((t2 shr 11) or (t2 shl 21)) + w[ 1] + $04C006BA;
  T:= (t3 and (t5 and t6 and t0 xor not t7) xor t5 and t2 xor t6 and t7 xor t0 and t4);
  t1:= ((T shr 7) or (T shl 25)) + ((t1 shr 11) or (t1 shl 21)) + w[25] + $C1A94FB6;
  T:= (t2 and (t4 and t5 and t7 xor not t6) xor t4 and t1 xor t5 and t6 xor t7 and t3);
  t0:= ((T shr 7) or (T shl 25)) + ((t0 shr 11) or (t0 shl 21)) + w[15] + $409F60C4;

  Inc(m_hash[0],t0);
  Inc(m_hash[1],t1);
  Inc(m_hash[2],t2);
  Inc(m_hash[3],t3);
  Inc(m_hash[4],t4);
  Inc(m_hash[5],t5);
  Inc(m_hash[6],t6);
  Inc(m_hash[7],t7);
end;

constructor TrhlHAVAL5.Create;
begin
  inherited Create;
  FRounds := 5;
end;

{ TrhlHAVAL }

procedure TrhlHAVAL.Compress(var ADigest);
var
  T: DWord;
begin
  if FHashSize = 16 then
  begin
    T:= (m_hash[7] and $000000FF) or
           (m_hash[6] and $FF000000) or
           (m_hash[5] and $00FF0000) or
           (m_hash[4] and $0000FF00);
    Inc(m_hash[0],(T shr 8) or (T shl 24));
    T:= (m_hash[7] and $0000FF00) or
           (m_hash[6] and $000000FF) or
           (m_hash[5] and $FF000000) or
           (m_hash[4] and $00FF0000);
    Inc(m_hash[1],(T shr 16) or (T shl 16));
    T:= (m_hash[7] and $00FF0000) or
           (m_hash[6] and $0000FF00) or
           (m_hash[5] and $000000FF) or
           (m_hash[4] and $FF000000);
    Inc(m_hash[2],(T shr 24) or (T shl 8));
    T:= (m_hash[7] and $FF000000) or
           (m_hash[6] and $00FF0000) or
           (m_hash[5] and $0000FF00) or
           (m_hash[4] and $000000FF);
    Inc(m_hash[3],T);
    Move(m_hash, ADigest, HashSize);
  end
  else
  if FHashSize = 20 then
  begin
    T:= (m_hash[7] and $3F) or
           (m_hash[6] and ($7F shl 25)) or
           (m_hash[5] and ($3F shl 19));
    Inc(m_hash[0],(T shr 19) or (T shl 13));
    T:= (m_hash[7] and ($3F shl 6)) or
           (m_hash[6] and $3F) or
           (m_hash[5] and ($7F shl 25));
    Inc(m_hash[1],(T shr 25) or (T shl 7));
    T:= (m_hash[7] and ($7F shl 12)) or
           (m_hash[6] and ($3F shl 6)) or
           (m_hash[5] and $3F);
    Inc(m_hash[2],T);
    T:= (m_hash[7] and ($3F shl 19)) or
           (m_hash[6] and ($7F shl 12)) or
           (m_hash[5] and ($3F shl 6));
    Inc(m_hash[3],T shr 6);
    T:= (m_hash[7] and ($7F shl 25)) or
           (m_hash[6] and ($3F shl 19)) or
           (m_hash[5] and ($7F shl 12));
    Inc(m_hash[4],T shr 12);
    Move(m_hash, ADigest, HashSize);
  end
  else
  if FHashSize = 24 then
  begin
    T := (m_hash[7] and $1F) or (m_hash[6] and ($3F shl 26));
    Inc(m_hash[0],(T shr 26) or (T shl 6));
    T := (m_hash[7] and ($1F shl 5)) or (m_hash[6] and $1F);
    Inc(m_hash[1],T);
    T := (m_hash[7] and ($3F shl 10)) or (m_hash[6] and ($1F shl 5));
    Inc(m_hash[2],T shr 5);
    T := (m_hash[7] and ($1F shl 16)) or (m_hash[6] and ($3F shl 10));
    Inc(m_hash[3],T shr 10);
    T := (m_hash[7] and ($1F shl 21)) or (m_hash[6] and ($1F shl 16));
    Inc(m_hash[4],T shr 16);
    T := (m_hash[7] and ($3F shl 26)) or (m_hash[6] and ($1F shl 21));
    Inc(m_hash[5],T shr 21);
    Move(m_hash, ADigest, HashSize);
  end
  else
  if FHashSize = 28 then
  begin
    Inc(m_hash[0],(m_hash[7] shr 27) and $1F);
    Inc(m_hash[1],(m_hash[7] shr 22) and $1F);
    Inc(m_hash[2],(m_hash[7] shr 18) and $F);
    Inc(m_hash[3],(m_hash[7] shr 13) and $1F);
    Inc(m_hash[4],(m_hash[7] shr 9) and $F);
    Inc(m_hash[5],(m_hash[7] shr 4) and $1F);
    Inc(m_hash[6],m_hash[7] and $F);
    Move(m_hash, ADigest, HashSize);
  end
  else
    Move(m_hash, ADigest, HashSize);
end;

constructor TrhlHAVAL.Create;
begin
  BlockSize := 128;
  FPadding := $01;
end;

procedure TrhlHAVAL.Init;
begin
  inherited Init;
  m_hash[0] := $243F6A88;
  m_hash[1] := $85A308D3;
  m_hash[2] := $13198A2E;
  m_hash[3] := $03707344;
  m_hash[4] := $A4093822;
  m_hash[5] := $299F31D0;
  m_hash[6] := $082EFA98;
  m_hash[7] := $EC4E6C89;
end;

procedure TrhlHAVAL.Final(var ADigest);
const
  HAVAL_VERSION = 1;
var
  bits: QWord;
  pad: TBytes;
  padIndex: DWord;
begin
  bits := QWord(FProcessedBytes) * 8;
  if FBuffer.Pos < 118 then
    padIndex := 118 - FBuffer.Pos
  else
    padIndex := 246 - FBuffer.Pos;

  SetLength(pad, padIndex + 10);
  pad[0] := FPadding;

  pad[padindex] := ((FRounds shl 3) or (HAVAL_VERSION and $07));
  Inc(padIndex);
  pad[padindex] := (HashSize shl 1);
  Inc(padIndex);

  Move(bits, pad[padIndex], SizeOf(bits));
  Inc(padIndex, 8);

  UpdateBytes(pad[0], padIndex);
  Compress(ADigest);
end;

end.
