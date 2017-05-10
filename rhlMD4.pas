unit rhlMD4;

interface

uses
  rhlMDBase;

type

  { TrhlMD4 }

  TrhlMD4 = class(TrhlMDBase)
  protected
    procedure UpdateBlock(const AData); override;
  end;

implementation

{ TrhlMD4 }

procedure TrhlMD4.UpdateBlock(const AData);

  procedure R1(var a: Cardinal; b,c,d,x: Cardinal; s: Byte);
  // F(x,y,z) = (x and y) or ((not x) and z)
  begin
    a := roldword(dword(a + {F(b,c,d)}((b and c) or ((not b) and d)) + x), s);
  end;

  procedure R2(var a: Cardinal; b,c,d,x: Cardinal; s: Byte);
  // G(x,y,z) = (x and y) or (x and z) or (y and z);
  begin
    a := roldword(dword(a + {G(b,c,d)}((b and c) or (b and d) or (c and d)) + x + $5A827999), s);
  end;

  procedure R3(var a: Cardinal; b,c,d,x: Cardinal; s: Byte);
  // H(x,y,z) = x xor y xor z
  begin
    a := roldword(dword(a + {H(b,c,d)}(b xor c xor d) + x + $6ED9EBA1), s);
  end;

var
  Data: array[0..15] of DWord absolute AData;
  A, B, C, D: DWord;
  i: Byte;
  r: Byte;
begin
  A:= FH[0];
  B:= FH[1];
  C:= FH[2];
  D:= FH[3];

  for i := 0 to 3 do
  begin
    R1(a,b,c,d,Data[4*i+0],  3); // 0
    R1(d,a,b,c,Data[4*i+1],  7); // 1
    R1(c,d,a,b,Data[4*i+2], 11); // 2
    R1(b,c,d,a,Data[4*i+3], 19); // 3
  end;

  for i := 0 to 3 do
  begin
    R2(a,b,c,d,Data[i+0],  3); // 0
    R2(d,a,b,c,Data[i+4],  5); // 4
    R2(c,d,a,b,Data[i+8],  9); // 8
    R2(b,c,d,a,Data[i+12],13); // 12
  end;

  for i := 0 to 3 do
  begin
    r := ((i and 2) shr 1) or ((i and 1) shl 1);
    R3(a,b,c,d,Data[r+0],  3); // 0
    R3(d,a,b,c,Data[r+8],  9); // 2
    R3(c,d,a,b,Data[r+4], 11); // 1
    R3(b,c,d,a,Data[r+12],15); // 3
  end;

  Inc(FH[0],A);
  Inc(FH[1],B);
  Inc(FH[2],C);
  Inc(FH[3],D);
end;

end.
