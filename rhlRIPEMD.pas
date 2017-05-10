unit rhlRIPEMD;

interface

uses
  rhlMDBase;

type

  { TrhlRIPEMD }

  TrhlRIPEMD = class(TrhlMDBase)
  protected
    procedure UpdateBlock(const AData); override;
  end;

implementation

{ TrhlRIPEMD }

procedure TrhlRIPEMD.UpdateBlock(const AData);

  function P1(a, b, c: DWord): DWord;
  begin
    Result := (a and b) or (not a and c);
  end;

  function P2(a, b, c: DWord): DWord;
  begin
    Result := (a and b) or (a and c) or (b and c);
  end;

  function P3(a, b, c: DWord): DWord;
  begin
    Result := a xor b xor c;
  end;

var
  data: array[0..15] of DWord absolute AData;
  a, b, c, d, aa, bb, cc, dd: DWord;
begin
  a := FH[0];
  b := FH[1];
  c := FH[2];
  d := FH[3];
  aa := a;
  bb := b;
  cc := c;
  dd := d;

  a := RolDWord(P1(b, c, d) + a + data[0], 11);
  d := RolDWord(P1(a, b, c) + d + data[1], 14);
  c := RolDWord(P1(d, a, b) + c + data[2], 15);
  b := RolDWord(P1(c, d, a) + b + data[3], 12);
  a := RolDWord(P1(b, c, d) + a + data[4], 5);
  d := RolDWord(P1(a, b, c) + d + data[5], 8);
  c := RolDWord(P1(d, a, b) + c + data[6], 7);
  b := RolDWord(P1(c, d, a) + b + data[7], 9);
  a := RolDWord(P1(b, c, d) + a + data[8], 11);
  d := RolDWord(P1(a, b, c) + d + data[9], 13);
  c := RolDWord(P1(d, a, b) + c + data[10], 14);
  b := RolDWord(P1(c, d, a) + b + data[11], 15);
  a := RolDWord(P1(b, c, d) + a + data[12], 6);
  d := RolDWord(P1(a, b, c) + d + data[13], 7);
  c := RolDWord(P1(d, a, b) + c + data[14], 9);
  b := RolDWord(P1(c, d, a) + b + data[15], 8);

  a := RolDWord(P2(b, c, d) + a + data[7] + FC[2], 7);
  d := RolDWord(P2(a, b, c) + d + data[4] + FC[2], 6);
  c := RolDWord(P2(d, a, b) + c + data[13] + FC[2], 8);
  b := RolDWord(P2(c, d, a) + b + data[1] + FC[2], 13);
  a := RolDWord(P2(b, c, d) + a + data[10] + FC[2], 11);
  d := RolDWord(P2(a, b, c) + d + data[6] + FC[2], 9);
  c := RolDWord(P2(d, a, b) + c + data[15] + FC[2], 7);
  b := RolDWord(P2(c, d, a) + b + data[3] + FC[2], 15);
  a := RolDWord(P2(b, c, d) + a + data[12] + FC[2], 7);
  d := RolDWord(P2(a, b, c) + d + data[0] + FC[2], 12);
  c := RolDWord(P2(d, a, b) + c + data[9] + FC[2], 15);
  b := RolDWord(P2(c, d, a) + b + data[5] + FC[2], 9);
  a := RolDWord(P2(b, c, d) + a + data[14] + FC[2], 7);
  d := RolDWord(P2(a, b, c) + d + data[2] + FC[2], 11);
  c := RolDWord(P2(d, a, b) + c + data[11] + FC[2], 13);
  b := RolDWord(P2(c, d, a) + b + data[8] + FC[2], 12);

  a := RolDWord(P3(b, c, d) + a + data[3] + FC[4], 11);
  d := RolDWord(P3(a, b, c) + d + data[10] + FC[4], 13);
  c := RolDWord(P3(d, a, b) + c + data[2] + FC[4], 14);
  b := RolDWord(P3(c, d, a) + b + data[4] + FC[4], 7);
  a := RolDWord(P3(b, c, d) + a + data[9] + FC[4], 14);
  d := RolDWord(P3(a, b, c) + d + data[15] + FC[4], 9);
  c := RolDWord(P3(d, a, b) + c + data[8] + FC[4], 13);
  b := RolDWord(P3(c, d, a) + b + data[1] + FC[4], 15);
  a := RolDWord(P3(b, c, d) + a + data[14] + FC[4], 6);
  d := RolDWord(P3(a, b, c) + d + data[7] + FC[4], 8);
  c := RolDWord(P3(d, a, b) + c + data[0] + FC[4], 13);
  b := RolDWord(P3(c, d, a) + b + data[6] + FC[4], 6);
  a := RolDWord(P3(b, c, d) + a + data[11] + FC[4], 12);
  d := RolDWord(P3(a, b, c) + d + data[13] + FC[4], 5);
  c := RolDWord(P3(d, a, b) + c + data[5] + FC[4], 7);
  b := RolDWord(P3(c, d, a) + b + data[12] + FC[4], 5);

  aa := RolDWord(P1(bb, cc, dd) + aa + data[0] + FC[1], 11);
  dd := RolDWord(P1(aa, bb, cc) + dd + data[1] + FC[1], 14);
  cc := RolDWord(P1(dd, aa, bb) + cc + data[2] + FC[1], 15);
  bb := RolDWord(P1(cc, dd, aa) + bb + data[3] + FC[1], 12);
  aa := RolDWord(P1(bb, cc, dd) + aa + data[4] + FC[1], 5);
  dd := RolDWord(P1(aa, bb, cc) + dd + data[5] + FC[1], 8);
  cc := RolDWord(P1(dd, aa, bb) + cc + data[6] + FC[1], 7);
  bb := RolDWord(P1(cc, dd, aa) + bb + data[7] + FC[1], 9);
  aa := RolDWord(P1(bb, cc, dd) + aa + data[8] + FC[1], 11);
  dd := RolDWord(P1(aa, bb, cc) + dd + data[9] + FC[1], 13);
  cc := RolDWord(P1(dd, aa, bb) + cc + data[10] + FC[1], 14);
  bb := RolDWord(P1(cc, dd, aa) + bb + data[11] + FC[1], 15);
  aa := RolDWord(P1(bb, cc, dd) + aa + data[12] + FC[1], 6);
  dd := RolDWord(P1(aa, bb, cc) + dd + data[13] + FC[1], 7);
  cc := RolDWord(P1(dd, aa, bb) + cc + data[14] + FC[1], 9);
  bb := RolDWord(P1(cc, dd, aa) + bb + data[15] + FC[1], 8);

  aa := RolDWord(P2(bb, cc, dd) + aa + data[7], 7);
  dd := RolDWord(P2(aa, bb, cc) + dd + data[4], 6);
  cc := RolDWord(P2(dd, aa, bb) + cc + data[13], 8);
  bb := RolDWord(P2(cc, dd, aa) + bb + data[1], 13);
  aa := RolDWord(P2(bb, cc, dd) + aa + data[10], 11);
  dd := RolDWord(P2(aa, bb, cc) + dd + data[6], 9);
  cc := RolDWord(P2(dd, aa, bb) + cc + data[15], 7);
  bb := RolDWord(P2(cc, dd, aa) + bb + data[3], 15);
  aa := RolDWord(P2(bb, cc, dd) + aa + data[12], 7);
  dd := RolDWord(P2(aa, bb, cc) + dd + data[0], 12);
  cc := RolDWord(P2(dd, aa, bb) + cc + data[9], 15);
  bb := RolDWord(P2(cc, dd, aa) + bb + data[5], 9);
  aa := RolDWord(P2(bb, cc, dd) + aa + data[14], 7);
  dd := RolDWord(P2(aa, bb, cc) + dd + data[2], 11);
  cc := RolDWord(P2(dd, aa, bb) + cc + data[11], 13);
  bb := RolDWord(P2(cc, dd, aa) + bb + data[8], 12);

  aa := RolDWord(P3(bb, cc, dd) + aa + data[3] + FC[3], 11);
  dd := RolDWord(P3(aa, bb, cc) + dd + data[10] + FC[3], 13);
  cc := RolDWord(P3(dd, aa, bb) + cc + data[2] + FC[3], 14);
  bb := RolDWord(P3(cc, dd, aa) + bb + data[4] + FC[3], 7);
  aa := RolDWord(P3(bb, cc, dd) + aa + data[9] + FC[3], 14);
  dd := RolDWord(P3(aa, bb, cc) + dd + data[15] + FC[3], 9);
  cc := RolDWord(P3(dd, aa, bb) + cc + data[8] + FC[3], 13);
  bb := RolDWord(P3(cc, dd, aa) + bb + data[1] + FC[3], 15);
  aa := RolDWord(P3(bb, cc, dd) + aa + data[14] + FC[3], 6);
  dd := RolDWord(P3(aa, bb, cc) + dd + data[7] + FC[3], 8);
  cc := RolDWord(P3(dd, aa, bb) + cc + data[0] + FC[3], 13);
  bb := RolDWord(P3(cc, dd, aa) + bb + data[6] + FC[3], 6);
  aa := RolDWord(P3(bb, cc, dd) + aa + data[11] + FC[3], 12);
  dd := RolDWord(P3(aa, bb, cc) + dd + data[13] + FC[3], 5);
  cc := RolDWord(P3(dd, aa, bb) + cc + data[5] + FC[3], 7);
  bb := RolDWord(P3(cc, dd, aa) + bb + data[12] + FC[3], 5);

  cc := FH[0] + b + cc;
  FH[0] := FH[1] + c + dd;
  FH[1] := FH[2] + d + aa;
  FH[2] := FH[3] + a + bb;
  FH[3] := cc;
end;

end.
