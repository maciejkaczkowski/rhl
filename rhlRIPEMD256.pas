unit rhlRIPEMD256;

interface

uses
  rhlMDBase;

type

  { TrhlRIPEMD256 }

  TrhlRIPEMD256 = class(TrhlMDBase)
  protected
    procedure UpdateBlock(const AData); override;
  public
    constructor Create; override;
    procedure Init; override;
  end;

implementation

{ TrhlRIPEMD256 }

procedure TrhlRIPEMD256.UpdateBlock(const AData);
var
  data: array[0..15] of DWord absolute AData;
  a, b, c, d, aa, bb, cc, dd: DWord;
begin
  a := FH[0];
  b := FH[1];
  c := FH[2];
  d := FH[3];
  aa := FH[4];
  bb := FH[5];
  cc := FH[6];
  dd := FH[7];

  a += data[0] + (b xor c xor d);
  a := (a shl 11) or (a shr (32 - 11));
  d += data[1] + (a xor b xor c);
  d := (d shl 14) or (d shr (32 - 14));
  c += data[2] + (d xor a xor b);
  c := (c shl 15) or (c shr (32 - 15));
  b += data[3] + (c xor d xor a);
  b := (b shl 12) or (b shr (32 - 12));
  a += data[4] + (b xor c xor d);
  a := (a shl 5) or (a shr (32 - 5));
  d += data[5] + (a xor b xor c);
  d := (d shl 8) or (d shr (32 - 8));
  c += data[6] + (d xor a xor b);
  c := (c shl 7) or (c shr (32 - 7));
  b += data[7] + (c xor d xor a);
  b := (b shl 9) or (b shr (32 - 9));
  a += data[8] + (b xor c xor d);
  a := (a shl 11) or (a shr (32 - 11));
  d += data[9] + (a xor b xor c);
  d := (d shl 13) or (d shr (32 - 13));
  c += data[10] + (d xor a xor b);
  c := (c shl 14) or (c shr (32 - 14));
  b += data[11] + (c xor d xor a);
  b := (b shl 15) or (b shr (32 - 15));
  a += data[12] + (b xor c xor d);
  a := (a shl 6) or (a shr (32 - 6));
  d += data[13] + (a xor b xor c);
  d := (d shl 7) or (d shr (32 - 7));
  c += data[14] + (d xor a xor b);
  c := (c shl 9) or (c shr (32 - 9));
  b += data[15] + (c xor d xor a);
  b := (b shl 8) or (b shr (32 - 8));

  aa += data[5] + FC[1] + ((bb and dd) or (cc and not dd));
  aa := (aa shl 8) or (aa shr (32 - 8));
  dd += data[14] + FC[1] + ((aa and cc) or (bb and not cc));
  dd := (dd shl 9) or (dd shr (32 - 9));
  cc += data[7] + FC[1] + ((dd and bb) or (aa and not bb));
  cc := (cc shl 9) or (cc shr (32 - 9));
  bb += data[0] + FC[1] + ((cc and aa) or (dd and not aa));
  bb := (bb shl 11) or (bb shr (32 - 11));
  aa += data[9] + FC[1] + ((bb and dd) or (cc and not dd));
  aa := (aa shl 13) or (aa shr (32 - 13));
  dd += data[2] + FC[1] + ((aa and cc) or (bb and not cc));
  dd := (dd shl 15) or (dd shr (32 - 15));
  cc += data[11] + FC[1] + ((dd and bb) or (aa and not bb));
  cc := (cc shl 15) or (cc shr (32 - 15));
  bb += data[4] + FC[1] + ((cc and aa) or (dd and not aa));
  bb := (bb shl 5) or (bb shr (32 - 5));
  aa += data[13] + FC[1] + ((bb and dd) or (cc and not dd));
  aa := (aa shl 7) or (aa shr (32 - 7));
  dd += data[6] + FC[1] + ((aa and cc) or (bb and not cc));
  dd := (dd shl 7) or (dd shr (32 - 7));
  cc += data[15] + FC[1] + ((dd and bb) or (aa and not bb));
  cc := (cc shl 8) or (cc shr (32 - 8));
  bb += data[8] + FC[1] + ((cc and aa) or (dd and not aa));
  bb := (bb shl 11) or (bb shr (32 - 11));
  aa += data[1] + FC[1] + ((bb and dd) or (cc and not dd));
  aa := (aa shl 14) or (aa shr (32 - 14));
  dd += data[10] + FC[1] + ((aa and cc) or (bb and not cc));
  dd := (dd shl 14) or (dd shr (32 - 14));
  cc += data[3] + FC[1] + ((dd and bb) or (aa and not bb));
  cc := (cc shl 12) or (cc shr (32 - 12));
  bb += data[12] + FC[1] + ((cc and aa) or (dd and not aa));
  bb := (bb shl 6) or (bb shr (32 - 6));

  aa += data[7] + FC[2] + ((b and c) or (not b and d));
  aa := (aa shl 7) or (aa shr (32 - 7));
  d += data[4] + FC[2] + ((aa and b) or (not aa and c));
  d := (d shl 6) or (d shr (32 - 6));
  c += data[13] + FC[2] + ((d and aa) or (not d and b));
  c := (c shl 8) or (c shr (32 - 8));
  b += data[1] + FC[2] + ((c and d) or (not c and aa));
  b := (b shl 13) or (b shr (32 - 13));
  aa += data[10] + FC[2] + ((b and c) or (not b and d));
  aa := (aa shl 11) or (aa shr (32 - 11));
  d += data[6] + FC[2] + ((aa and b) or (not aa and c));
  d := (d shl 9) or (d shr (32 - 9));
  c += data[15] + FC[2] + ((d and aa) or (not d and b));
  c := (c shl 7) or (c shr (32 - 7));
  b += data[3] + FC[2] + ((c and d) or (not c and aa));
  b := (b shl 15) or (b shr (32 - 15));
  aa += data[12] + FC[2] + ((b and c) or (not b and d));
  aa := (aa shl 7) or (aa shr (32 - 7));
  d += data[0] + FC[2] + ((aa and b) or (not aa and c));
  d := (d shl 12) or (d shr (32 - 12));
  c += data[9] + FC[2] + ((d and aa) or (not d and b));
  c := (c shl 15) or (c shr (32 - 15));
  b += data[5] + FC[2] + ((c and d) or (not c and aa));
  b := (b shl 9) or (b shr (32 - 9));
  aa += data[2] + FC[2] + ((b and c) or (not b and d));
  aa := (aa shl 11) or (aa shr (32 - 11));
  d += data[14] + FC[2] + ((aa and b) or (not aa and c));
  d := (d shl 7) or (d shr (32 - 7));
  c += data[11] + FC[2] + ((d and aa) or (not d and b));
  c := (c shl 13) or (c shr (32 - 13));
  b += data[8] + FC[2] + ((c and d) or (not c and aa));
  b := (b shl 12) or (b shr (32 - 12));

  a += data[6] + FC[3] + ((bb or not cc) xor dd);
  a := (a shl 9) or (a shr (32 - 9));
  dd += data[11] + FC[3] + ((a or not bb) xor cc);
  dd := (dd shl 13) or (dd shr (32 - 13));
  cc += data[3] + FC[3] + ((dd or not a) xor bb);
  cc := (cc shl 15) or (cc shr (32 - 15));
  bb += data[7] + FC[3] + ((cc or not dd) xor a);
  bb := (bb shl 7) or (bb shr (32 - 7));
  a += data[0] + FC[3] + ((bb or not cc) xor dd);
  a := (a shl 12) or (a shr (32 - 12));
  dd += data[13] + FC[3] + ((a or not bb) xor cc);
  dd := (dd shl 8) or (dd shr (32 - 8));
  cc += data[5] + FC[3] + ((dd or not a) xor bb);
  cc := (cc shl 9) or (cc shr (32 - 9));
  bb += data[10] + FC[3] + ((cc or not dd) xor a);
  bb := (bb shl 11) or (bb shr (32 - 11));
  a += data[14] + FC[3] + ((bb or not cc) xor dd);
  a := (a shl 7) or (a shr (32 - 7));
  dd += data[15] + FC[3] + ((a or not bb) xor cc);
  dd := (dd shl 7) or (dd shr (32 - 7));
  cc += data[8] + FC[3] + ((dd or not a) xor bb);
  cc := (cc shl 12) or (cc shr (32 - 12));
  bb += data[12] + FC[3] + ((cc or not dd) xor a);
  bb := (bb shl 7) or (bb shr (32 - 7));
  a += data[4] + FC[3] + ((bb or not cc) xor dd);
  a := (a shl 6) or (a shr (32 - 6));
  dd += data[9] + FC[3] + ((a or not bb) xor cc);
  dd := (dd shl 15) or (dd shr (32 - 15));
  cc += data[1] + FC[3] + ((dd or not a) xor bb);
  cc := (cc shl 13) or (cc shr (32 - 13));
  bb += data[2] + FC[3] + ((cc or not dd) xor a);
  bb := (bb shl 11) or (bb shr (32 - 11));

  aa += data[3] + FC[4] + ((bb or not c) xor d);
  aa := (aa shl 11) or (aa shr (32 - 11));
  d += data[10] + FC[4] + ((aa or not bb) xor c);
  d := (d shl 13) or (d shr (32 - 13));
  c += data[14] + FC[4] + ((d or not aa) xor bb);
  c := (c shl 6) or (c shr (32 - 6));
  bb += data[4] + FC[4] + ((c or not d) xor aa);
  bb := (bb shl 7) or (bb shr (32 - 7));
  aa += data[9] + FC[4] + ((bb or not c) xor d);
  aa := (aa shl 14) or (aa shr (32 - 14));
  d += data[15] + FC[4] + ((aa or not bb) xor c);
  d := (d shl 9) or (d shr (32 - 9));
  c += data[8] + FC[4] + ((d or not aa) xor bb);
  c := (c shl 13) or (c shr (32 - 13));
  bb += data[1] + FC[4] + ((c or not d) xor aa);
  bb := (bb shl 15) or (bb shr (32 - 15));
  aa += data[2] + FC[4] + ((bb or not c) xor d);
  aa := (aa shl 14) or (aa shr (32 - 14));
  d += data[7] + FC[4] + ((aa or not bb) xor c);
  d := (d shl 8) or (d shr (32 - 8));
  c += data[0] + FC[4] + ((d or not aa) xor bb);
  c := (c shl 13) or (c shr (32 - 13));
  bb += data[6] + FC[4] + ((c or not d) xor aa);
  bb := (bb shl 6) or (bb shr (32 - 6));
  aa += data[13] + FC[4] + ((bb or not c) xor d);
  aa := (aa shl 5) or (aa shr (32 - 5));
  d += data[11] + FC[4] + ((aa or not bb) xor c);
  d := (d shl 12) or (d shr (32 - 12));
  c += data[5] + FC[4] + ((d or not aa) xor bb);
  c := (c shl 7) or (c shr (32 - 7));
  bb += data[12] + FC[4] + ((c or not d) xor aa);
  bb := (bb shl 5) or (bb shr (32 - 5));

  a += data[15] + FC[5] + ((b and cc) or (not b and dd));
  a := (a shl 9) or (a shr (32 - 9));
  dd += data[5] + FC[5] + ((a and b) or (not a and cc));
  dd := (dd shl 7) or (dd shr (32 - 7));
  cc += data[1] + FC[5] + ((dd and a) or (not dd and b));
  cc := (cc shl 15) or (cc shr (32 - 15));
  b += data[3] + FC[5] + ((cc and dd) or (not cc and a));
  b := (b shl 11) or (b shr (32 - 11));
  a += data[7] + FC[5] + ((b and cc) or (not b and dd));
  a := (a shl 8) or (a shr (32 - 8));
  dd += data[14] + FC[5] + ((a and b) or (not a and cc));
  dd := (dd shl 6) or (dd shr (32 - 6));
  cc += data[6] + FC[5] + ((dd and a) or (not dd and b));
  cc := (cc shl 6) or (cc shr (32 - 6));
  b += data[9] + FC[5] + ((cc and dd) or (not cc and a));
  b := (b shl 14) or (b shr (32 - 14));
  a += data[11] + FC[5] + ((b and cc) or (not b and dd));
  a := (a shl 12) or (a shr (32 - 12));
  dd += data[8] + FC[5] + ((a and b) or (not a and cc));
  dd := (dd shl 13) or (dd shr (32 - 13));
  cc += data[12] + FC[5] + ((dd and a) or (not dd and b));
  cc := (cc shl 5) or (cc shr (32 - 5));
  b += data[2] + FC[5] + ((cc and dd) or (not cc and a));
  b := (b shl 14) or (b shr (32 - 14));
  a += data[10] + FC[5] + ((b and cc) or (not b and dd));
  a := (a shl 13) or (a shr (32 - 13));
  dd += data[0] + FC[5] + ((a and b) or (not a and cc));
  dd := (dd shl 13) or (dd shr (32 - 13));
  cc += data[4] + FC[5] + ((dd and a) or (not dd and b));
  cc := (cc shl 7) or (cc shr (32 - 7));
  b += data[13] + FC[5] + ((cc and dd) or (not cc and a));
  b := (b shl 5) or (b shr (32 - 5));

  aa += data[1] + FC[6] + ((bb and d) or (cc and not d));
  aa := (aa shl 11) or (aa shr (32 - 11));
  d += data[9] + FC[6] + ((aa and cc) or (bb and not cc));
  d := (d shl 12) or (d shr (32 - 12));
  cc += data[11] + FC[6] + ((d and bb) or (aa and not bb));
  cc := (cc shl 14) or (cc shr (32 - 14));
  bb += data[10] + FC[6] + ((cc and aa) or (d and not aa));
  bb := (bb shl 15) or (bb shr (32 - 15));
  aa += data[0] + FC[6] + ((bb and d) or (cc and not d));
  aa := (aa shl 14) or (aa shr (32 - 14));
  d += data[8] + FC[6] + ((aa and cc) or (bb and not cc));
  d := (d shl 15) or (d shr (32 - 15));
  cc += data[12] + FC[6] + ((d and bb) or (aa and not bb));
  cc := (cc shl 9) or (cc shr (32 - 9));
  bb += data[4] + FC[6] + ((cc and aa) or (d and not aa));
  bb := (bb shl 8) or (bb shr (32 - 8));
  aa += data[13] + FC[6] + ((bb and d) or (cc and not d));
  aa := (aa shl 9) or (aa shr (32 - 9));
  d += data[3] + FC[6] + ((aa and cc) or (bb and not cc));
  d := (d shl 14) or (d shr (32 - 14));
  cc += data[7] + FC[6] + ((d and bb) or (aa and not bb));
  cc := (cc shl 5) or (cc shr (32 - 5));
  bb += data[15] + FC[6] + ((cc and aa) or (d and not aa));
  bb := (bb shl 6) or (bb shr (32 - 6));
  aa += data[14] + FC[6] + ((bb and d) or (cc and not d));
  aa := (aa shl 8) or (aa shr (32 - 8));
  d += data[5] + FC[6] + ((aa and cc) or (bb and not cc));
  d := (d shl 6) or (d shr (32 - 6));
  cc += data[6] + FC[6] + ((d and bb) or (aa and not bb));
  cc := (cc shl 5) or (cc shr (32 - 5));
  bb += data[2] + FC[6] + ((cc and aa) or (d and not aa));
  bb := (bb shl 12) or (bb shr (32 - 12));

  a += data[8] + (b xor c xor dd);
  a := (a shl 15) or (a shr (32 - 15));
  dd += data[6] + (a xor b xor c);
  dd := (dd shl 5) or (dd shr (32 - 5));
  c += data[4] + (dd xor a xor b);
  c := (c shl 8) or (c shr (32 - 8));
  b += data[1] + (c xor dd xor a);
  b := (b shl 11) or (b shr (32 - 11));
  a += data[3] + (b xor c xor dd);
  a := (a shl 14) or (a shr (32 - 14));
  dd += data[11] + (a xor b xor c);
  dd := (dd shl 14) or (dd shr (32 - 14));
  c += data[15] + (dd xor a xor b);
  c := (c shl 6) or (c shr (32 - 6));
  b += data[0] + (c xor dd xor a);
  b := (b shl 14) or (b shr (32 - 14));
  a += data[5] + (b xor c xor dd);
  a := (a shl 6) or (a shr (32 - 6));
  dd += data[12] + (a xor b xor c);
  dd := (dd shl 9) or (dd shr (32 - 9));
  c += data[2] + (dd xor a xor b);
  c := (c shl 12) or (c shr (32 - 12));
  b += data[13] + (c xor dd xor a);
  b := (b shl 9) or (b shr (32 - 9));
  a += data[9] + (b xor c xor dd);
  a := (a shl 12) or (a shr (32 - 12));
  dd += data[7] + (a xor b xor c);
  dd := (dd shl 5) or (dd shr (32 - 5));
  c += data[10] + (dd xor a xor b);
  c := (c shl 15) or (c shr (32 - 15));
  b += data[14] + (c xor dd xor a);
  b := (b shl 8) or (b shr (32 - 8));

  FH[0] += aa;
  FH[1] += bb;
  FH[2] += cc;
  FH[3] += dd;
  FH[4] += a;
  FH[5] += b;
  FH[6] += c;
  FH[7] += d;
end;

constructor TrhlRIPEMD256.Create;
begin
  inherited Create;
  HashSize := 32;
end;

procedure TrhlRIPEMD256.Init;
begin
  inherited Init;
  FH[4] := $76543210;
  FH[5] := $FEDCBA98;
  FH[6] := $89ABCDEF;
  FH[7] := $01234567;
end;

end.
