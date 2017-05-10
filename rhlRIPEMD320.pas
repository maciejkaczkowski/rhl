unit rhlRIPEMD320;

interface

uses
  rhlMDBase;

type

  { TrhlRIPEMD320 }

  TrhlRIPEMD320 = class(TrhlMDBase)
  protected
    procedure UpdateBlock(const AData); override;
  public
    constructor Create; override;
    procedure Init; override;
  end;

implementation

{ TrhlRIPEMD320 }

procedure TrhlRIPEMD320.UpdateBlock(const AData);
var
  data: array[0..15] of DWord absolute AData;
  a, b, c, d, e, aa, bb, cc, dd, ee: DWord;
begin
  a := FH[0];
  b := FH[1];
  c := FH[2];
  d := FH[3];
  e := FH[4];
  aa := FH[5];
  bb := FH[6];
  cc := FH[7];
  dd := FH[8];
  ee := FH[9];

  a += data[0] + (b xor c xor d);
  a := ((a shl 11) or (a shr (32 - 11))) + e;
  c := (c shl 10) or (c shr (32 - 10));
  e += data[1] + (a xor b xor c);
  e := ((e shl 14) or (e shr (32 - 14))) + d;
  b := (b shl 10) or (b shr (32 - 10));
  d += data[2] + (e xor a xor b);
  d := ((d shl 15) or (d shr (32 - 15))) + c;
  a := (a shl 10) or (a shr (32 - 10));
  c += data[3] + (d xor e xor a);
  c := ((c shl 12) or (c shr (32 - 12))) + b;
  e := (e shl 10) or (e shr (32 - 10));
  b += data[4] + (c xor d xor e);
  b := ((b shl 5) or (b shr (32 - 5))) + a;
  d := (d shl 10) or (d shr (32 - 10));
  a += data[5] + (b xor c xor d);
  a := ((a shl 8) or (a shr (32 - 8))) + e;
  c := (c shl 10) or (c shr (32 - 10));
  e += data[6] + (a xor b xor c);
  e := ((e shl 7) or (e shr (32 - 7))) + d;
  b := (b shl 10) or (b shr (32 - 10));
  d += data[7] + (e xor a xor b);
  d := ((d shl 9) or (d shr (32 - 9))) + c;
  a := (a shl 10) or (a shr (32 - 10));
  c += data[8] + (d xor e xor a);
  c := ((c shl 11) or (c shr (32 - 11))) + b;
  e := (e shl 10) or (e shr (32 - 10));
  b += data[9] + (c xor d xor e);
  b := ((b shl 13) or (b shr (32 - 13))) + a;
  d := (d shl 10) or (d shr (32 - 10));
  a += data[10] + (b xor c xor d);
  a := ((a shl 14) or (a shr (32 - 14))) + e;
  c := (c shl 10) or (c shr (32 - 10));
  e += data[11] + (a xor b xor c);
  e := ((e shl 15) or (e shr (32 - 15))) + d;
  b := (b shl 10) or (b shr (32 - 10));
  d += data[12] + (e xor a xor b);
  d := ((d shl 6) or (d shr (32 - 6))) + c;
  a := (a shl 10) or (a shr (32 - 10));
  c += data[13] + (d xor e xor a);
  c := ((c shl 7) or (c shr (32 - 7))) + b;
  e := (e shl 10) or (e shr (32 - 10));
  b += data[14] + (c xor d xor e);
  b := ((b shl 9) or (b shr (32 - 9))) + a;
  d := (d shl 10) or (d shr (32 - 10));
  a += data[15] + (b xor c xor d);
  a := ((a shl 8) or (a shr (32 - 8))) + e;
  c := (c shl 10) or (c shr (32 - 10));

  aa += data[5] + FC[1] + (bb xor (cc or not dd));
  aa := ((aa shl 8) or (aa shr (32 - 8))) + ee;
  cc := (cc shl 10) or (cc shr (32 - 10));
  ee += data[14] + FC[1] + (aa xor (bb or not cc));
  ee := ((ee shl 9) or (ee shr (32 - 9))) + dd;
  bb := (bb shl 10) or (bb shr (32 - 10));
  dd += data[7] + FC[1] + (ee xor (aa or not bb));
  dd := ((dd shl 9) or (dd shr (32 - 9))) + cc;
  aa := (aa shl 10) or (aa shr (32 - 10));
  cc += data[0] + FC[1] + (dd xor (ee or not aa));
  cc := ((cc shl 11) or (cc shr (32 - 11))) + bb;
  ee := (ee shl 10) or (ee shr (32 - 10));
  bb += data[9] + FC[1] + (cc xor (dd or not ee));
  bb := ((bb shl 13) or (bb shr (32 - 13))) + aa;
  dd := (dd shl 10) or (dd shr (32 - 10));
  aa += data[2] + FC[1] + (bb xor (cc or not dd));
  aa := ((aa shl 15) or (aa shr (32 - 15))) + ee;
  cc := (cc shl 10) or (cc shr (32 - 10));
  ee += data[11] + FC[1] + (aa xor (bb or not cc));
  ee := ((ee shl 15) or (ee shr (32 - 15))) + dd;
  bb := (bb shl 10) or (bb shr (32 - 10));
  dd += data[4] + FC[1] + (ee xor (aa or not bb));
  dd := ((dd shl 5) or (dd shr (32 - 5))) + cc;
  aa := (aa shl 10) or (aa shr (32 - 10));
  cc += data[13] + FC[1] + (dd xor (ee or not aa));
  cc := ((cc shl 7) or (cc shr (32 - 7))) + bb;
  ee := (ee shl 10) or (ee shr (32 - 10));
  bb += data[6] + FC[1] + (cc xor (dd or not ee));
  bb := ((bb shl 7) or (bb shr (32 - 7))) + aa;
  dd := (dd shl 10) or (dd shr (32 - 10));
  aa += data[15] + FC[1] + (bb xor (cc or not dd));
  aa := ((aa shl 8) or (aa shr (32 - 8))) + ee;
  cc := (cc shl 10) or (cc shr (32 - 10));
  ee += data[8] + FC[1] + (aa xor (bb or not cc));
  ee := ((ee shl 11) or (ee shr (32 - 11))) + dd;
  bb := (bb shl 10) or (bb shr (32 - 10));
  dd += data[1] + FC[1] + (ee xor (aa or not bb));
  dd := ((dd shl 14) or (dd shr (32 - 14))) + cc;
  aa := (aa shl 10) or (aa shr (32 - 10));
  cc += data[10] + FC[1] + (dd xor (ee or not aa));
  cc := ((cc shl 14) or (cc shr (32 - 14))) + bb;
  ee := (ee shl 10) or (ee shr (32 - 10));
  bb += data[3] + FC[1] + (cc xor (dd or not ee));
  bb := ((bb shl 12) or (bb shr (32 - 12))) + aa;
  dd := (dd shl 10) or (dd shr (32 - 10));
  aa += data[12] + FC[1] + (bb xor (cc or not dd));
  aa := ((aa shl 6) or (aa shr (32 - 6))) + ee;
  cc := (cc shl 10) or (cc shr (32 - 10));

  e += data[7] + FC[2] + ((aa and b) or (not aa and c));
  e := ((e shl 7) or (e shr (32 - 7))) + d;
  b := (b shl 10) or (b shr (32 - 10));
  d += data[4] + FC[2] + ((e and aa) or (not e and b));
  d := ((d shl 6) or (d shr (32 - 6))) + c;
  aa := (aa shl 10) or (aa shr (32 - 10));
  c += data[13] + FC[2] + ((d and e) or (not d and aa));
  c := ((c shl 8) or (c shr (32 - 8))) + b;
  e := (e shl 10) or (e shr (32 - 10));
  b += data[1] + FC[2] + ((c and d) or (not c and e));
  b := ((b shl 13) or (b shr (32 - 13))) + aa;
  d := (d shl 10) or (d shr (32 - 10));
  aa += data[10] + FC[2] + ((b and c) or (not b and d));
  aa := ((aa shl 11) or (aa shr (32 - 11))) + e;
  c := (c shl 10) or (c shr (32 - 10));
  e += data[6] + FC[2] + ((aa and b) or (not aa and c));
  e := ((e shl 9) or (e shr (32 - 9))) + d;
  b := (b shl 10) or (b shr (32 - 10));
  d += data[15] + FC[2] + ((e and aa) or (not e and b));
  d := ((d shl 7) or (d shr (32 - 7))) + c;
  aa := (aa shl 10) or (aa shr (32 - 10));
  c += data[3] + FC[2] + ((d and e) or (not d and aa));
  c := ((c shl 15) or (c shr (32 - 15))) + b;
  e := (e shl 10) or (e shr (32 - 10));
  b += data[12] + FC[2] + ((c and d) or (not c and e));
  b := ((b shl 7) or (b shr (32 - 7))) + aa;
  d := (d shl 10) or (d shr (32 - 10));
  aa += data[0] + FC[2] + ((b and c) or (not b and d));
  aa := ((aa shl 12) or (aa shr (32 - 12))) + e;
  c := (c shl 10) or (c shr (32 - 10));
  e += data[9] + FC[2] + ((aa and b) or (not aa and c));
  e := ((e shl 15) or (e shr (32 - 15))) + d;
  b := (b shl 10) or (b shr (32 - 10));
  d += data[5] + FC[2] + ((e and aa) or (not e and b));
  d := ((d shl 9) or (d shr (32 - 9))) + c;
  aa := (aa shl 10) or (aa shr (32 - 10));
  c += data[2] + FC[2] + ((d and e) or (not d and aa));
  c := ((c shl 11) or (c shr (32 - 11))) + b;
  e := (e shl 10) or (e shr (32 - 10));
  b += data[14] + FC[2] + ((c and d) or (not c and e));
  b := ((b shl 7) or (b shr (32 - 7))) + aa;
  d := (d shl 10) or (d shr (32 - 10));
  aa += data[11] + FC[2] + ((b and c) or (not b and d));
  aa := ((aa shl 13) or (aa shr (32 - 13))) + e;
  c := (c shl 10) or (c shr (32 - 10));
  e += data[8] + FC[2] + ((aa and b) or (not aa and c));
  e := ((e shl 12) or (e shr (32 - 12))) + d;
  b := (b shl 10) or (b shr (32 - 10));

  ee += data[6] + FC[3] + ((a and cc) or (bb and not cc));
  ee := ((ee shl 9) or (ee shr (32 - 9))) + dd;
  bb := (bb shl 10) or (bb shr (32 - 10));
  dd += data[11] + FC[3] + ((ee and bb) or (a and not bb));
  dd := ((dd shl 13) or (dd shr (32 - 13))) + cc;
  a := (a shl 10) or (a shr (32 - 10));
  cc += data[3] + FC[3] + ((dd and a) or (ee and not a));
  cc := ((cc shl 15) or (cc shr (32 - 15))) + bb;
  ee := (ee shl 10) or (ee shr (32 - 10));
  bb += data[7] + FC[3] + ((cc and ee) or (dd and not ee));
  bb := ((bb shl 7) or (bb shr (32 - 7))) + a;
  dd := (dd shl 10) or (dd shr (32 - 10));
  a += data[0] + FC[3] + ((bb and dd) or (cc and not dd));
  a := ((a shl 12) or (a shr (32 - 12))) + ee;
  cc := (cc shl 10) or (cc shr (32 - 10));
  ee += data[13] + FC[3] + ((a and cc) or (bb and not cc));
  ee := ((ee shl 8) or (ee shr (32 - 8))) + dd;
  bb := (bb shl 10) or (bb shr (32 - 10));
  dd += data[5] + FC[3] + ((ee and bb) or (a and not bb));
  dd := ((dd shl 9) or (dd shr (32 - 9))) + cc;
  a := (a shl 10) or (a shr (32 - 10));
  cc += data[10] + FC[3] + ((dd and a) or (ee and not a));
  cc := ((cc shl 11) or (cc shr (32 - 11))) + bb;
  ee := (ee shl 10) or (ee shr (32 - 10));
  bb += data[14] + FC[3] + ((cc and ee) or (dd and not ee));
  bb := ((bb shl 7) or (bb shr (32 - 7))) + a;
  dd := (dd shl 10) or (dd shr (32 - 10));
  a += data[15] + FC[3] + ((bb and dd) or (cc and not dd));
  a := ((a shl 7) or (a shr (32 - 7))) + ee;
  cc := (cc shl 10) or (cc shr (32 - 10));
  ee += data[8] + FC[3] + ((a and cc) or (bb and not cc));
  ee := ((ee shl 12) or (ee shr (32 - 12))) + dd;
  bb := (bb shl 10) or (bb shr (32 - 10));
  dd += data[12] + FC[3] + ((ee and bb) or (a and not bb));
  dd := ((dd shl 7) or (dd shr (32 - 7))) + cc;
  a := (a shl 10) or (a shr (32 - 10));
  cc += data[4] + FC[3] + ((dd and a) or (ee and not a));
  cc := ((cc shl 6) or (cc shr (32 - 6))) + bb;
  ee := (ee shl 10) or (ee shr (32 - 10));
  bb += data[9] + FC[3] + ((cc and ee) or (dd and not ee));
  bb := ((bb shl 15) or (bb shr (32 - 15))) + a;
  dd := (dd shl 10) or (dd shr (32 - 10));
  a += data[1] + FC[3] + ((bb and dd) or (cc and not dd));
  a := ((a shl 13) or (a shr (32 - 13))) + ee;
  cc := (cc shl 10) or (cc shr (32 - 10));
  ee += data[2] + FC[3] + ((a and cc) or (bb and not cc));
  ee := ((ee shl 11) or (ee shr (32 - 11))) + dd;
  bb := (bb shl 10) or (bb shr (32 - 10));

  d += data[3] + FC[4] + ((e or not aa) xor bb);
  d := ((d shl 11) or (d shr (32 - 11))) + c;
  aa := (aa shl 10) or (aa shr (32 - 10));
  c += data[10] + FC[4] + ((d or not e) xor aa);
  c := ((c shl 13) or (c shr (32 - 13))) + bb;
  e := (e shl 10) or (e shr (32 - 10));
  bb += data[14] + FC[4] + ((c or not d) xor e);
  bb := ((bb shl 6) or (bb shr (32 - 6))) + aa;
  d := (d shl 10) or (d shr (32 - 10));
  aa += data[4] + FC[4] + ((bb or not c) xor d);
  aa := ((aa shl 7) or (aa shr (32 - 7))) + e;
  c := (c shl 10) or (c shr (32 - 10));
  e += data[9] + FC[4] + ((aa or not bb) xor c);
  e := ((e shl 14) or (e shr (32 - 14))) + d;
  bb := (bb shl 10) or (bb shr (32 - 10));
  d += data[15] + FC[4] + ((e or not aa) xor bb);
  d := ((d shl 9) or (d shr (32 - 9))) + c;
  aa := (aa shl 10) or (aa shr (32 - 10));
  c += data[8] + FC[4] + ((d or not e) xor aa);
  c := ((c shl 13) or (c shr (32 - 13))) + bb;
  e := (e shl 10) or (e shr (32 - 10));
  bb += data[1] + FC[4] + ((c or not d) xor e);
  bb := ((bb shl 15) or (bb shr (32 - 15))) + aa;
  d := (d shl 10) or (d shr (32 - 10));
  aa += data[2] + FC[4] + ((bb or not c) xor d);
  aa := ((aa shl 14) or (aa shr (32 - 14))) + e;
  c := (c shl 10) or (c shr (32 - 10));
  e += data[7] + FC[4] + ((aa or not bb) xor c);
  e := ((e shl 8) or (e shr (32 - 8))) + d;
  bb := (bb shl 10) or (bb shr (32 - 10));
  d += data[0] + FC[4] + ((e or not aa) xor bb);
  d := ((d shl 13) or (d shr (32 - 13))) + c;
  aa := (aa shl 10) or (aa shr (32 - 10));
  c += data[6] + FC[4] + ((d or not e) xor aa);
  c := ((c shl 6) or (c shr (32 - 6))) + bb;
  e := (e shl 10) or (e shr (32 - 10));
  bb += data[13] + FC[4] + ((c or not d) xor e);
  bb := ((bb shl 5) or (bb shr (32 - 5))) + aa;
  d := (d shl 10) or (d shr (32 - 10));
  aa += data[11] + FC[4] + ((bb or not c) xor d);
  aa := ((aa shl 12) or (aa shr (32 - 12))) + e;
  c := (c shl 10) or (c shr (32 - 10));
  e += data[5] + FC[4] + ((aa or not bb) xor c);
  e := ((e shl 7) or (e shr (32 - 7))) + d;
  bb := (bb shl 10) or (bb shr (32 - 10));
  d += data[12] + FC[4] + ((e or not aa) xor bb);
  d := ((d shl 5) or (d shr (32 - 5))) + c;
  aa := (aa shl 10) or (aa shr (32 - 10));

  dd += data[15] + FC[5] + ((ee or not a) xor b);
  dd := ((dd shl 9) or (dd shr (32 - 9))) + cc;
  a := (a shl 10) or (a shr (32 - 10));
  cc += data[5] + FC[5] + ((dd or not ee) xor a);
  cc := ((cc shl 7) or (cc shr (32 - 7))) + b;
  ee := (ee shl 10) or (ee shr (32 - 10));
  b += data[1] + FC[5] + ((cc or not dd) xor ee);
  b := ((b shl 15) or (b shr (32 - 15))) + a;
  dd := (dd shl 10) or (dd shr (32 - 10));
  a += data[3] + FC[5] + ((b or not cc) xor dd);
  a := ((a shl 11) or (a shr (32 - 11))) + ee;
  cc := (cc shl 10) or (cc shr (32 - 10));
  ee += data[7] + FC[5] + ((a or not b) xor cc);
  ee := ((ee shl 8) or (ee shr (32 - 8))) + dd;
  b := (b shl 10) or (b shr (32 - 10));
  dd += data[14] + FC[5] + ((ee or not a) xor b);
  dd := ((dd shl 6) or (dd shr (32 - 6))) + cc;
  a := (a shl 10) or (a shr (32 - 10));
  cc += data[6] + FC[5] + ((dd or not ee) xor a);
  cc := ((cc shl 6) or (cc shr (32 - 6))) + b;
  ee := (ee shl 10) or (ee shr (32 - 10));
  b += data[9] + FC[5] + ((cc or not dd) xor ee);
  b := ((b shl 14) or (b shr (32 - 14))) + a;
  dd := (dd shl 10) or (dd shr (32 - 10));
  a += data[11] + FC[5] + ((b or not cc) xor dd);
  a := ((a shl 12) or (a shr (32 - 12))) + ee;
  cc := (cc shl 10) or (cc shr (32 - 10));
  ee += data[8] + FC[5] + ((a or not b) xor cc);
  ee := ((ee shl 13) or (ee shr (32 - 13))) + dd;
  b := (b shl 10) or (b shr (32 - 10));
  dd += data[12] + FC[5] + ((ee or not a) xor b);
  dd := ((dd shl 5) or (dd shr (32 - 5))) + cc;
  a := (a shl 10) or (a shr (32 - 10));
  cc += data[2] + FC[5] + ((dd or not ee) xor a);
  cc := ((cc shl 14) or (cc shr (32 - 14))) + b;
  ee := (ee shl 10) or (ee shr (32 - 10));
  b += data[10] + FC[5] + ((cc or not dd) xor ee);
  b := ((b shl 13) or (b shr (32 - 13))) + a;
  dd := (dd shl 10) or (dd shr (32 - 10));
  a += data[0] + FC[5] + ((b or not cc) xor dd);
  a := ((a shl 13) or (a shr (32 - 13))) + ee;
  cc := (cc shl 10) or (cc shr (32 - 10));
  ee += data[4] + FC[5] + ((a or not b) xor cc);
  ee := ((ee shl 7) or (ee shr (32 - 7))) + dd;
  b := (b shl 10) or (b shr (32 - 10));
  dd += data[13] + FC[5] + ((ee or not a) xor b);
  dd := ((dd shl 5) or (dd shr (32 - 5))) + cc;
  a := (a shl 10) or (a shr (32 - 10));

  cc += data[1] + FC[6] + ((d and aa) or (e and not aa));
  cc := ((cc shl 11) or (cc shr (32 - 11))) + bb;
  e := (e shl 10) or (e shr (32 - 10));
  bb += data[9] + FC[6] + ((cc and e) or (d and not e));
  bb := ((bb shl 12) or (bb shr (32 - 12))) + aa;
  d := (d shl 10) or (d shr (32 - 10));
  aa += data[11] + FC[6] + ((bb and d) or (cc and not d));
  aa := ((aa shl 14) or (aa shr (32 - 14))) + e;
  cc := (cc shl 10) or (cc shr (32 - 10));
  e += data[10] + FC[6] + ((aa and cc) or (bb and not cc));
  e := ((e shl 15) or (e shr (32 - 15))) + d;
  bb := (bb shl 10) or (bb shr (32 - 10));
  d += data[0] + FC[6] + ((e and bb) or (aa and not bb));
  d := ((d shl 14) or (d shr (32 - 14))) + cc;
  aa := (aa shl 10) or (aa shr (32 - 10));
  cc += data[8] + FC[6] + ((d and aa) or (e and not aa));
  cc := ((cc shl 15) or (cc shr (32 - 15))) + bb;
  e := (e shl 10) or (e shr (32 - 10));
  bb += data[12] + FC[6] + ((cc and e) or (d and not e));
  bb := ((bb shl 9) or (bb shr (32 - 9))) + aa;
  d := (d shl 10) or (d shr (32 - 10));
  aa += data[4] + FC[6] + ((bb and d) or (cc and not d));
  aa := ((aa shl 8) or (aa shr (32 - 8))) + e;
  cc := (cc shl 10) or (cc shr (32 - 10));
  e += data[13] + FC[6] + ((aa and cc) or (bb and not cc));
  e := ((e shl 9) or (e shr (32 - 9))) + d;
  bb := (bb shl 10) or (bb shr (32 - 10));
  d += data[3] + FC[6] + ((e and bb) or (aa and not bb));
  d := ((d shl 14) or (d shr (32 - 14))) + cc;
  aa := (aa shl 10) or (aa shr (32 - 10));
  cc += data[7] + FC[6] + ((d and aa) or (e and not aa));
  cc := ((cc shl 5) or (cc shr (32 - 5))) + bb;
  e := (e shl 10) or (e shr (32 - 10));
  bb += data[15] + FC[6] + ((cc and e) or (d and not e));
  bb := ((bb shl 6) or (bb shr (32 - 6))) + aa;
  d := (d shl 10) or (d shr (32 - 10));
  aa += data[14] + FC[6] + ((bb and d) or (cc and not d));
  aa := ((aa shl 8) or (aa shr (32 - 8))) + e;
  cc := (cc shl 10) or (cc shr (32 - 10));
  e += data[5] + FC[6] + ((aa and cc) or (bb and not cc));
  e := ((e shl 6) or (e shr (32 - 6))) + d;
  bb := (bb shl 10) or (bb shr (32 - 10));
  d += data[6] + FC[6] + ((e and bb) or (aa and not bb));
  d := ((d shl 5) or (d shr (32 - 5))) + cc;
  aa := (aa shl 10) or (aa shr (32 - 10));
  cc += data[2] + FC[6] + ((d and aa) or (e and not aa));
  cc := ((cc shl 12) or (cc shr (32 - 12))) + bb;
  e := (e shl 10) or (e shr (32 - 10));

  c += data[8] + FC[7] + ((dd and ee) or (not dd and a));
  c := ((c shl 15) or (c shr (32 - 15))) + b;
  ee := (ee shl 10) or (ee shr (32 - 10));
  b += data[6] + FC[7] + ((c and dd) or (not c and ee));
  b := ((b shl 5) or (b shr (32 - 5))) + a;
  dd := (dd shl 10) or (dd shr (32 - 10));
  a += data[4] + FC[7] + ((b and c) or (not b and dd));
  a := ((a shl 8) or (a shr (32 - 8))) + ee;
  c := (c shl 10) or (c shr (32 - 10));
  ee += data[1] + FC[7] + ((a and b) or (not a and c));
  ee := ((ee shl 11) or (ee shr (32 - 11))) + dd;
  b := (b shl 10) or (b shr (32 - 10));
  dd += data[3] + FC[7] + ((ee and a) or (not ee and b));
  dd := ((dd shl 14) or (dd shr (32 - 14))) + c;
  a := (a shl 10) or (a shr (32 - 10));
  c += data[11] + FC[7] + ((dd and ee) or (not dd and a));
  c := ((c shl 14) or (c shr (32 - 14))) + b;
  ee := (ee shl 10) or (ee shr (32 - 10));
  b += data[15] + FC[7] + ((c and dd) or (not c and ee));
  b := ((b shl 6) or (b shr (32 - 6))) + a;
  dd := (dd shl 10) or (dd shr (32 - 10));
  a += data[0] + FC[7] + ((b and c) or (not b and dd));
  a := ((a shl 14) or (a shr (32 - 14))) + ee;
  c := (c shl 10) or (c shr (32 - 10));
  ee += data[5] + FC[7] + ((a and b) or (not a and c));
  ee := ((ee shl 6) or (ee shr (32 - 6))) + dd;
  b := (b shl 10) or (b shr (32 - 10));
  dd += data[12] + FC[7] + ((ee and a) or (not ee and b));
  dd := ((dd shl 9) or (dd shr (32 - 9))) + c;
  a := (a shl 10) or (a shr (32 - 10));
  c += data[2] + FC[7] + ((dd and ee) or (not dd and a));
  c := ((c shl 12) or (c shr (32 - 12))) + b;
  ee := (ee shl 10) or (ee shr (32 - 10));
  b += data[13] + FC[7] + ((c and dd) or (not c and ee));
  b := ((b shl 9) or (b shr (32 - 9))) + a;
  dd := (dd shl 10) or (dd shr (32 - 10));
  a += data[9] + FC[7] + ((b and c) or (not b and dd));
  a := ((a shl 12) or (a shr (32 - 12))) + ee;
  c := (c shl 10) or (c shr (32 - 10));
  ee += data[7] + FC[7] + ((a and b) or (not a and c));
  ee := ((ee shl 5) or (ee shr (32 - 5))) + dd;
  b := (b shl 10) or (b shr (32 - 10));
  dd += data[10] + FC[7] + ((ee and a) or (not ee and b));
  dd := ((dd shl 15) or (dd shr (32 - 15))) + c;
  a := (a shl 10) or (a shr (32 - 10));
  c += data[14] + FC[7] + ((dd and ee) or (not dd and a));
  c := ((c shl 8) or (c shr (32 - 8))) + b;
  ee := (ee shl 10) or (ee shr (32 - 10));

  bb += data[4] + FC[8] + (cc xor (dd or not e));
  bb := ((bb shl 9) or (bb shr (32 - 9))) + aa;
  dd := (dd shl 10) or (dd shr (32 - 10));
  aa += data[0] + FC[8] + (bb xor (cc or not dd));
  aa := ((aa shl 15) or (aa shr (32 - 15))) + e;
  cc := (cc shl 10) or (cc shr (32 - 10));
  e += data[5] + FC[8] + (aa xor (bb or not cc));
  e := ((e shl 5) or (e shr (32 - 5))) + dd;
  bb := (bb shl 10) or (bb shr (32 - 10));
  dd += data[9] + FC[8] + (e xor (aa or not bb));
  dd := ((dd shl 11) or (dd shr (32 - 11))) + cc;
  aa := (aa shl 10) or (aa shr (32 - 10));
  cc += data[7] + FC[8] + (dd xor (e or not aa));
  cc := ((cc shl 6) or (cc shr (32 - 6))) + bb;
  e := (e shl 10) or (e shr (32 - 10));
  bb += data[12] + FC[8] + (cc xor (dd or not e));
  bb := ((bb shl 8) or (bb shr (32 - 8))) + aa;
  dd := (dd shl 10) or (dd shr (32 - 10));
  aa += data[2] + FC[8] + (bb xor (cc or not dd));
  aa := ((aa shl 13) or (aa shr (32 - 13))) + e;
  cc := (cc shl 10) or (cc shr (32 - 10));
  e += data[10] + FC[8] + (aa xor (bb or not cc));
  e := ((e shl 12) or (e shr (32 - 12))) + dd;
  bb := (bb shl 10) or (bb shr (32 - 10));
  dd += data[14] + FC[8] + (e xor (aa or not bb));
  dd := ((dd shl 5) or (dd shr (32 - 5))) + cc;
  aa := (aa shl 10) or (aa shr (32 - 10));
  cc += data[1] + FC[8] + (dd xor (e or not aa));
  cc := ((cc shl 12) or (cc shr (32 - 12))) + bb;
  e := (e shl 10) or (e shr (32 - 10));
  bb += data[3] + FC[8] + (cc xor (dd or not e));
  bb := ((bb shl 13) or (bb shr (32 - 13))) + aa;
  dd := (dd shl 10) or (dd shr (32 - 10));
  aa += data[8] + FC[8] + (bb xor (cc or not dd));
  aa := ((aa shl 14) or (aa shr (32 - 14))) + e;
  cc := (cc shl 10) or (cc shr (32 - 10));
  e += data[11] + FC[8] + (aa xor (bb or not cc));
  e := ((e shl 11) or (e shr (32 - 11))) + dd;
  bb := (bb shl 10) or (bb shr (32 - 10));
  dd += data[6] + FC[8] + (e xor (aa or not bb));
  dd := ((dd shl 8) or (dd shr (32 - 8))) + cc;
  aa := (aa shl 10) or (aa shr (32 - 10));
  cc += data[15] + FC[8] + (dd xor (e or not aa));
  cc := ((cc shl 5) or (cc shr (32 - 5))) + bb;
  e := (e shl 10) or (e shr (32 - 10));
  bb += data[13] + FC[8] + (cc xor (dd or not e));
  bb := ((bb shl 6) or (bb shr (32 - 6))) + aa;
  dd := (dd shl 10) or (dd shr (32 - 10));

  b += data[12] + (c xor d xor ee);
  b := ((b shl 8) or (b shr (32 - 8))) + a;
  d := (d shl 10) or (d shr (32 - 10));
  a += data[15] + (b xor c xor d);
  a := ((a shl 5) or (a shr (32 - 5))) + ee;
  c := (c shl 10) or (c shr (32 - 10));
  ee += data[10] + (a xor b xor c);
  ee := ((ee shl 12) or (ee shr (32 - 12))) + d;
  b := (b shl 10) or (b shr (32 - 10));
  d += data[4] + (ee xor a xor b);
  d := ((d shl 9) or (d shr (32 - 9))) + c;
  a := (a shl 10) or (a shr (32 - 10));
  c += data[1] + (d xor ee xor a);
  c := ((c shl 12) or (c shr (32 - 12))) + b;
  ee := (ee shl 10) or (ee shr (32 - 10));
  b += data[5] + (c xor d xor ee);
  b := ((b shl 5) or (b shr (32 - 5))) + a;
  d := (d shl 10) or (d shr (32 - 10));
  a += data[8] + (b xor c xor d);
  a := ((a shl 14) or (a shr (32 - 14))) + ee;
  c := (c shl 10) or (c shr (32 - 10));
  ee += data[7] + (a xor b xor c);
  ee := ((ee shl 6) or (ee shr (32 - 6))) + d;
  b := (b shl 10) or (b shr (32 - 10));
  d += data[6] + (ee xor a xor b);
  d := ((d shl 8) or (d shr (32 - 8))) + c;
  a := (a shl 10) or (a shr (32 - 10));
  c += data[2] + (d xor ee xor a);
  c := ((c shl 13) or (c shr (32 - 13))) + b;
  ee := (ee shl 10) or (ee shr (32 - 10));
  b += data[13] + (c xor d xor ee);
  b := ((b shl 6) or (b shr (32 - 6))) + a;
  d := (d shl 10) or (d shr (32 - 10));
  a += data[14] + (b xor c xor d);
  a := ((a shl 5) or (a shr (32 - 5))) + ee;
  c := (c shl 10) or (c shr (32 - 10));
  ee += data[0] + (a xor b xor c);
  ee := ((ee shl 15) or (ee shr (32 - 15))) + d;
  b := (b shl 10) or (b shr (32 - 10));
  d += data[3] + (ee xor a xor b);
  d := ((d shl 13) or (d shr (32 - 13))) + c;
  a := (a shl 10) or (a shr (32 - 10));
  c += data[9] + (d xor ee xor a);
  c := ((c shl 11) or (c shr (32 - 11))) + b;
  ee := (ee shl 10) or (ee shr (32 - 10));
  b += data[11] + (c xor d xor ee);
  b := ((b shl 11) or (b shr (32 - 11))) + a;
  d := (d shl 10) or (d shr (32 - 10));

  FH[0] += aa;
  FH[1] += bb;
  FH[2] += cc;
  FH[3] += dd;
  FH[4] += ee;
  FH[5] += a;
  FH[6] += b;
  FH[7] += c;
  FH[8] += d;
  FH[9] += e;
end;

constructor TrhlRIPEMD320.Create;
begin
  inherited Create;
  HashSize := 40;
end;

procedure TrhlRIPEMD320.Init;
begin
  inherited Init;
  FH[4] := $c3d2e1f0;
  FH[5] := $76543210;
  FH[6] := $FEDCBA98;
  FH[7] := $89ABCDEF;
  FH[8] := $01234567;
  FH[9] := $3C2D1E0F;
end;

end.
