unit rhlMD5;

interface

uses
  rhlMDBase;

type

  { TrhlMD5 }

  TrhlMD5 = class(TrhlMDBase)
  private
    FK: array[0..63] of DWord;
    const gF: array[0..3] of Byte = (1, 5, 3, 7);
    const gO: array[0..3] of Byte = (0, 1, 5, 0);
    const SHIFT: array[0..15] of Byte =
      (7, 12, 17, 22, // R=0
       5,  9, 14, 20, // R=1
       4, 11, 16, 23, // R=2
       6, 10, 15, 21);// R=3
  protected
    procedure UpdateBlock(const AData); override;
  public
    constructor Create; override;
  end;

implementation

{ TrhlMD5 }

procedure TrhlMD5.UpdateBlock(const AData);
var
  DATA: array[0..15] of DWord absolute AData;
  A, B, C, D, F, T: DWord;
  g: Integer;
  j: Byte;
  r: Byte;
begin
  A:= FH[0];
  B:= FH[1];
  C:= FH[2];
  D:= FH[3];

  for j := 0 to 63 do
  begin
    r := j shr 4;
    case r of
      0: F := (B and C) or ((not B) and D);
      1: F := (D and B) or ((not D) and C);
      2: F := B xor C xor D;
      3: F := C xor (B or (not D));
    end;
    g := (gF[r] * j + gO[r]) and $F;
    T := D;
    D := C;
    C := B;
    B := B + roldword(A + F + FK[j] + DATA[g], SHIFT[(r shl 2) or (j and 3)]);
    A := T;
  end;
  Inc(FH[0],A);
  Inc(FH[1],B);
  Inc(FH[2],C);
  Inc(FH[3],D);
end;

constructor TrhlMD5.Create;
var
  i: Byte;
begin
  inherited;
  for i := Low(FK) to High(FK) do
    FK[i] := trunc((1 shl 32) * Abs(Sin(i+1)));
end;

end.
