unit rhlHAS160;

interface

uses
  rhlCore, SysUtils;

type

  { TrhlHAS160 }

  TrhlHAS160 = class(TrhlHash)
  private
    FStates: array[0..4] of DWord;
  protected
    procedure UpdateBlock(const AData); override;
  public
    constructor Create; override;
    procedure Init; override;
    procedure Final(var ADigest); override;
  end;

implementation

{ TrhlHAS160 }

procedure TrhlHAS160.UpdateBlock(const AData);
const
  s_rot: array[0..19] of byte = (
    5, 11, 7, 15, 6, 13, 8, 14, 7, 12, 9, 11, 8, 15, 6, 12, 9, 14, 5, 13);

  s_tor: array[0..19] of byte = (
    27, 21, 25, 17, 26, 19, 24, 18, 25, 20, 23, 21, 24, 17, 26, 20, 23, 18, 27, 19);

  s_index: array[0..79] of byte = (
    18, 0, 1, 2, 3, 19, 4, 5, 6, 7, 16, 8, 9, 10, 11, 17, 12, 13, 14, 15,
    18, 3, 6, 9, 12, 19, 15, 2, 5, 8, 16, 11, 14, 1, 4, 17, 7, 10, 13, 0,
    18, 12, 5, 14, 7, 19, 0, 9, 2, 11, 16, 4, 13, 6, 15, 17, 8, 1, 10, 3,
    18, 7, 2, 13, 8, 19, 3, 14, 9, 4, 16, 15, 10, 5, 0, 17, 11, 6, 1, 12);
var
  A, B, C, D, E, T: DWord;
  Data: array[0..19] of DWord;
  r: DWord;
begin
  A := FStates[0];
  B := FStates[1];
  C := FStates[2];
  D := FStates[3];
  E := FStates[4];

  FillChar(Data[0], SizeOf(Data), 0);
  Move(AData, Data[0], BlockSize);

  Data[16] := Data[0] xor Data[1] xor Data[2] xor Data[3];
  Data[17] := Data[4] xor Data[5] xor Data[6] xor Data[7];
  Data[18] := Data[8] xor Data[9] xor Data[10] xor Data[11];
  Data[19] := Data[12] xor Data[13] xor Data[14] xor Data[15];

  for r := 0 to 19 do
  begin
    T := Data[s_index[r]] + (A shl s_rot[r] or A shr s_tor[r]) +
      ((B and C) or (not B and D)) + E;
    E := D;
    D := C;
    C := B shl 10 or B shr 22;
    B := A;
    A := T;
  end;

  Data[16] := Data[3] xor Data[6] xor Data[9] xor Data[12];
  Data[17] := Data[2] xor Data[5] xor Data[8] xor Data[15];
  Data[18] := Data[1] xor Data[4] xor Data[11] xor Data[14];
  Data[19] := Data[0] xor Data[7] xor Data[10] xor Data[13];

  for r := 20 to 39 do
  begin
    T := Data[s_index[r]] + $5A827999 + (A shl s_rot[r - 20] or A shr s_tor[r - 20]) +
      (B xor C xor D) + E;
    E := D;
    D := C;
    C := B shl 17 or B shr 15;
    B := A;
    A := T;
  end;

  Data[16] := Data[5] xor Data[7] xor Data[12] xor Data[14];
  Data[17] := Data[0] xor Data[2] xor Data[9] xor Data[11];
  Data[18] := Data[4] xor Data[6] xor Data[13] xor Data[15];
  Data[19] := Data[1] xor Data[3] xor Data[8] xor Data[10];

  for r := 40 to 59 do
  begin
    T := Data[s_index[r]] + $6ED9EBA1 + (A shl s_rot[r - 40] or A shr s_tor[r - 40]) +
      (C xor (B or not D)) + E;
    E := D;
    D := C;
    C := B shl 25 or B shr 7;
    B := A;
    A := T;
  end;

  Data[16] := Data[2] xor Data[7] xor Data[8] xor Data[13];
  Data[17] := Data[3] xor Data[4] xor Data[9] xor Data[14];
  Data[18] := Data[0] xor Data[5] xor Data[10] xor Data[15];
  Data[19] := Data[1] xor Data[6] xor Data[11] xor Data[12];

  for r := 60 to 79 do
  begin
    T := Data[s_index[r]] + $8F1BBCDC + (A shl s_rot[r - 60] or A shr s_tor[r - 60]) +
      (B xor C xor D) + E;
    E := D;
    D := C;
    C := B shl 30 or B shr 2;
    B := A;
    A := T;
  end;

  Inc(FStates[0], A);
  Inc(FStates[1], B);
  Inc(FStates[2], C);
  Inc(FStates[3], D);
  Inc(FStates[4], E);
end;

constructor TrhlHAS160.Create;
begin
  HashSize := 20;
  BlockSize := 64;
end;

procedure TrhlHAS160.Init;
begin
  inherited Init;
  FStates[0] := $67452301;
  FStates[1] := $EFCDAB89;
  FStates[2] := $98BADCFE;
  FStates[3] := $10325476;
  FStates[4] := $C3D2E1F0;
end;

procedure TrhlHAS160.Final(var ADigest);
var
  bits: QWord;
  pad: TBytes;
  padIndex: QWord;
begin
  bits := FProcessedBytes * 8;
  if FBuffer.Pos < 56 then
    padIndex := 56 - FBuffer.Pos
  else
    padIndex := 120 - FBuffer.Pos;

  SetLength(pad, padIndex + 8);
  pad[0] := $80;
  Move(bits, pad[padIndex], SizeOf(bits));
  Inc(padIndex, 8);

  UpdateBytes(pad[0], padindex);
  Move(FStates[0], ADigest, SizeOf(FStates));
end;

end.
