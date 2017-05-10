unit rhlSHA0;

interface

uses
  rhlCore;

type

  { TrhlSHA0 }

  TrhlSHA0 = class(TrhlHash)
  private
    FStates: array[0..4] of DWord;
  protected
    type TBF = array[0..79] of DWord;
    procedure Expand(var W: TBF); virtual;
    procedure UpdateBlock(const AData); override;
  public
    constructor Create; override;
    procedure Init; override;
    procedure Final(var ADigest); override;
  end;

implementation

{ TrhlSHA0 }

procedure TrhlSHA0.Expand(var W: TBF);
var
  j: DWord;
begin
  for j := 16 to 79 do
    W[j] := ((W[j - 3] xor W[j - 8]) xor W[j - 14]) xor W[j - $10];
end;

procedure TrhlSHA0.UpdateBlock(const AData);
const
  G: array[1..4] of LongWord = ($5A827999, $6ED9EBA1, $8F1BBCDC, $CA62C1D6);
var
  A, B, C, D, E: DWord;
  W: array[0..79] of DWord;
begin
  FillChar({%H-}W[0], SizeOf(W), 0);
  ConvertBytesToDWordsSwapOrder(AData, 64, W);

  Expand(W);

  A:= FStates[0];
  B:= FStates[1];
  C:= FStates[2];
  D:= FStates[3];
  E:= FStates[4];

  Inc(E,((A shl 5) or (A shr 27)) + (D xor (B and (C xor D))) + G[1] + W[ 0]); B:= (B shl 30) or (B shr 2);
  Inc(D,((E shl 5) or (E shr 27)) + (C xor (A and (B xor C))) + G[1] + W[ 1]); A:= (A shl 30) or (A shr 2);
  Inc(C,((D shl 5) or (D shr 27)) + (B xor (E and (A xor B))) + G[1] + W[ 2]); E:= (E shl 30) or (E shr 2);
  Inc(B,((C shl 5) or (C shr 27)) + (A xor (D and (E xor A))) + G[1] + W[ 3]); D:= (D shl 30) or (D shr 2);
  Inc(A,((B shl 5) or (B shr 27)) + (E xor (C and (D xor E))) + G[1] + W[ 4]); C:= (C shl 30) or (C shr 2);
  Inc(E,((A shl 5) or (A shr 27)) + (D xor (B and (C xor D))) + G[1] + W[ 5]); B:= (B shl 30) or (B shr 2);
  Inc(D,((E shl 5) or (E shr 27)) + (C xor (A and (B xor C))) + G[1] + W[ 6]); A:= (A shl 30) or (A shr 2);
  Inc(C,((D shl 5) or (D shr 27)) + (B xor (E and (A xor B))) + G[1] + W[ 7]); E:= (E shl 30) or (E shr 2);
  Inc(B,((C shl 5) or (C shr 27)) + (A xor (D and (E xor A))) + G[1] + W[ 8]); D:= (D shl 30) or (D shr 2);
  Inc(A,((B shl 5) or (B shr 27)) + (E xor (C and (D xor E))) + G[1] + W[ 9]); C:= (C shl 30) or (C shr 2);
  Inc(E,((A shl 5) or (A shr 27)) + (D xor (B and (C xor D))) + G[1] + W[10]); B:= (B shl 30) or (B shr 2);
  Inc(D,((E shl 5) or (E shr 27)) + (C xor (A and (B xor C))) + G[1] + W[11]); A:= (A shl 30) or (A shr 2);
  Inc(C,((D shl 5) or (D shr 27)) + (B xor (E and (A xor B))) + G[1] + W[12]); E:= (E shl 30) or (E shr 2);
  Inc(B,((C shl 5) or (C shr 27)) + (A xor (D and (E xor A))) + G[1] + W[13]); D:= (D shl 30) or (D shr 2);
  Inc(A,((B shl 5) or (B shr 27)) + (E xor (C and (D xor E))) + G[1] + W[14]); C:= (C shl 30) or (C shr 2);
  Inc(E,((A shl 5) or (A shr 27)) + (D xor (B and (C xor D))) + G[1] + W[15]); B:= (B shl 30) or (B shr 2);
  Inc(D,((E shl 5) or (E shr 27)) + (C xor (A and (B xor C))) + G[1] + W[16]); A:= (A shl 30) or (A shr 2);
  Inc(C,((D shl 5) or (D shr 27)) + (B xor (E and (A xor B))) + G[1] + W[17]); E:= (E shl 30) or (E shr 2);
  Inc(B,((C shl 5) or (C shr 27)) + (A xor (D and (E xor A))) + G[1] + W[18]); D:= (D shl 30) or (D shr 2);
  Inc(A,((B shl 5) or (B shr 27)) + (E xor (C and (D xor E))) + G[1] + W[19]); C:= (C shl 30) or (C shr 2);

  Inc(E,((A shl 5) or (A shr 27)) + (B xor C xor D) + G[2] + W[20]); B:= (B shl 30) or (B shr 2);
  Inc(D,((E shl 5) or (E shr 27)) + (A xor B xor C) + G[2] + W[21]); A:= (A shl 30) or (A shr 2);
  Inc(C,((D shl 5) or (D shr 27)) + (E xor A xor B) + G[2] + W[22]); E:= (E shl 30) or (E shr 2);
  Inc(B,((C shl 5) or (C shr 27)) + (D xor E xor A) + G[2] + W[23]); D:= (D shl 30) or (D shr 2);
  Inc(A,((B shl 5) or (B shr 27)) + (C xor D xor E) + G[2] + W[24]); C:= (C shl 30) or (C shr 2);
  Inc(E,((A shl 5) or (A shr 27)) + (B xor C xor D) + G[2] + W[25]); B:= (B shl 30) or (B shr 2);
  Inc(D,((E shl 5) or (E shr 27)) + (A xor B xor C) + G[2] + W[26]); A:= (A shl 30) or (A shr 2);
  Inc(C,((D shl 5) or (D shr 27)) + (E xor A xor B) + G[2] + W[27]); E:= (E shl 30) or (E shr 2);
  Inc(B,((C shl 5) or (C shr 27)) + (D xor E xor A) + G[2] + W[28]); D:= (D shl 30) or (D shr 2);
  Inc(A,((B shl 5) or (B shr 27)) + (C xor D xor E) + G[2] + W[29]); C:= (C shl 30) or (C shr 2);
  Inc(E,((A shl 5) or (A shr 27)) + (B xor C xor D) + G[2] + W[30]); B:= (B shl 30) or (B shr 2);
  Inc(D,((E shl 5) or (E shr 27)) + (A xor B xor C) + G[2] + W[31]); A:= (A shl 30) or (A shr 2);
  Inc(C,((D shl 5) or (D shr 27)) + (E xor A xor B) + G[2] + W[32]); E:= (E shl 30) or (E shr 2);
  Inc(B,((C shl 5) or (C shr 27)) + (D xor E xor A) + G[2] + W[33]); D:= (D shl 30) or (D shr 2);
  Inc(A,((B shl 5) or (B shr 27)) + (C xor D xor E) + G[2] + W[34]); C:= (C shl 30) or (C shr 2);
  Inc(E,((A shl 5) or (A shr 27)) + (B xor C xor D) + G[2] + W[35]); B:= (B shl 30) or (B shr 2);
  Inc(D,((E shl 5) or (E shr 27)) + (A xor B xor C) + G[2] + W[36]); A:= (A shl 30) or (A shr 2);
  Inc(C,((D shl 5) or (D shr 27)) + (E xor A xor B) + G[2] + W[37]); E:= (E shl 30) or (E shr 2);
  Inc(B,((C shl 5) or (C shr 27)) + (D xor E xor A) + G[2] + W[38]); D:= (D shl 30) or (D shr 2);
  Inc(A,((B shl 5) or (B shr 27)) + (C xor D xor E) + G[2] + W[39]); C:= (C shl 30) or (C shr 2);

  Inc(E,((A shl 5) or (A shr 27)) + ((B and C) or (D and (B or C))) + G[3] + W[40]); B:= (B shl 30) or (B shr 2);
  Inc(D,((E shl 5) or (E shr 27)) + ((A and B) or (C and (A or B))) + G[3] + W[41]); A:= (A shl 30) or (A shr 2);
  Inc(C,((D shl 5) or (D shr 27)) + ((E and A) or (B and (E or A))) + G[3] + W[42]); E:= (E shl 30) or (E shr 2);
  Inc(B,((C shl 5) or (C shr 27)) + ((D and E) or (A and (D or E))) + G[3] + W[43]); D:= (D shl 30) or (D shr 2);
  Inc(A,((B shl 5) or (B shr 27)) + ((C and D) or (E and (C or D))) + G[3] + W[44]); C:= (C shl 30) or (C shr 2);
  Inc(E,((A shl 5) or (A shr 27)) + ((B and C) or (D and (B or C))) + G[3] + W[45]); B:= (B shl 30) or (B shr 2);
  Inc(D,((E shl 5) or (E shr 27)) + ((A and B) or (C and (A or B))) + G[3] + W[46]); A:= (A shl 30) or (A shr 2);
  Inc(C,((D shl 5) or (D shr 27)) + ((E and A) or (B and (E or A))) + G[3] + W[47]); E:= (E shl 30) or (E shr 2);
  Inc(B,((C shl 5) or (C shr 27)) + ((D and E) or (A and (D or E))) + G[3] + W[48]); D:= (D shl 30) or (D shr 2);
  Inc(A,((B shl 5) or (B shr 27)) + ((C and D) or (E and (C or D))) + G[3] + W[49]); C:= (C shl 30) or (C shr 2);
  Inc(E,((A shl 5) or (A shr 27)) + ((B and C) or (D and (B or C))) + G[3] + W[50]); B:= (B shl 30) or (B shr 2);
  Inc(D,((E shl 5) or (E shr 27)) + ((A and B) or (C and (A or B))) + G[3] + W[51]); A:= (A shl 30) or (A shr 2);
  Inc(C,((D shl 5) or (D shr 27)) + ((E and A) or (B and (E or A))) + G[3] + W[52]); E:= (E shl 30) or (E shr 2);
  Inc(B,((C shl 5) or (C shr 27)) + ((D and E) or (A and (D or E))) + G[3] + W[53]); D:= (D shl 30) or (D shr 2);
  Inc(A,((B shl 5) or (B shr 27)) + ((C and D) or (E and (C or D))) + G[3] + W[54]); C:= (C shl 30) or (C shr 2);
  Inc(E,((A shl 5) or (A shr 27)) + ((B and C) or (D and (B or C))) + G[3] + W[55]); B:= (B shl 30) or (B shr 2);
  Inc(D,((E shl 5) or (E shr 27)) + ((A and B) or (C and (A or B))) + G[3] + W[56]); A:= (A shl 30) or (A shr 2);
  Inc(C,((D shl 5) or (D shr 27)) + ((E and A) or (B and (E or A))) + G[3] + W[57]); E:= (E shl 30) or (E shr 2);
  Inc(B,((C shl 5) or (C shr 27)) + ((D and E) or (A and (D or E))) + G[3] + W[58]); D:= (D shl 30) or (D shr 2);
  Inc(A,((B shl 5) or (B shr 27)) + ((C and D) or (E and (C or D))) + G[3] + W[59]); C:= (C shl 30) or (C shr 2);

  Inc(E,((A shl 5) or (A shr 27)) + (B xor C xor D) + G[4] + W[60]); B:= (B shl 30) or (B shr 2);
  Inc(D,((E shl 5) or (E shr 27)) + (A xor B xor C) + G[4] + W[61]); A:= (A shl 30) or (A shr 2);
  Inc(C,((D shl 5) or (D shr 27)) + (E xor A xor B) + G[4] + W[62]); E:= (E shl 30) or (E shr 2);
  Inc(B,((C shl 5) or (C shr 27)) + (D xor E xor A) + G[4] + W[63]); D:= (D shl 30) or (D shr 2);
  Inc(A,((B shl 5) or (B shr 27)) + (C xor D xor E) + G[4] + W[64]); C:= (C shl 30) or (C shr 2);
  Inc(E,((A shl 5) or (A shr 27)) + (B xor C xor D) + G[4] + W[65]); B:= (B shl 30) or (B shr 2);
  Inc(D,((E shl 5) or (E shr 27)) + (A xor B xor C) + G[4] + W[66]); A:= (A shl 30) or (A shr 2);
  Inc(C,((D shl 5) or (D shr 27)) + (E xor A xor B) + G[4] + W[67]); E:= (E shl 30) or (E shr 2);
  Inc(B,((C shl 5) or (C shr 27)) + (D xor E xor A) + G[4] + W[68]); D:= (D shl 30) or (D shr 2);
  Inc(A,((B shl 5) or (B shr 27)) + (C xor D xor E) + G[4] + W[69]); C:= (C shl 30) or (C shr 2);
  Inc(E,((A shl 5) or (A shr 27)) + (B xor C xor D) + G[4] + W[70]); B:= (B shl 30) or (B shr 2);
  Inc(D,((E shl 5) or (E shr 27)) + (A xor B xor C) + G[4] + W[71]); A:= (A shl 30) or (A shr 2);
  Inc(C,((D shl 5) or (D shr 27)) + (E xor A xor B) + G[4] + W[72]); E:= (E shl 30) or (E shr 2);
  Inc(B,((C shl 5) or (C shr 27)) + (D xor E xor A) + G[4] + W[73]); D:= (D shl 30) or (D shr 2);
  Inc(A,((B shl 5) or (B shr 27)) + (C xor D xor E) + G[4] + W[74]); C:= (C shl 30) or (C shr 2);
  Inc(E,((A shl 5) or (A shr 27)) + (B xor C xor D) + G[4] + W[75]); B:= (B shl 30) or (B shr 2);
  Inc(D,((E shl 5) or (E shr 27)) + (A xor B xor C) + G[4] + W[76]); A:= (A shl 30) or (A shr 2);
  Inc(C,((D shl 5) or (D shr 27)) + (E xor A xor B) + G[4] + W[77]); E:= (E shl 30) or (E shr 2);
  Inc(B,((C shl 5) or (C shr 27)) + (D xor E xor A) + G[4] + W[78]); D:= (D shl 30) or (D shr 2);
  Inc(A,((B shl 5) or (B shr 27)) + (C xor D xor E) + G[4] + W[79]); C:= (C shl 30) or (C shr 2);

  Inc(FStates[0], A);
  Inc(FStates[1], B);
  Inc(FStates[2], C);
  Inc(FStates[3], D);
  Inc(FStates[4], E);
end;

constructor TrhlSHA0.Create;
begin
  HashSize := 20;
  BlockSize := 64;
end;

procedure TrhlSHA0.Init;
begin
  inherited Init;
  FStates[0] := $67452301;
  FStates[1] := $EFCDAB89;
  FStates[2] := $98BADCFE;
  FStates[3] := $10325476;
  FStates[4] := $C3D2E1F0;
end;

procedure TrhlSHA0.Final(var ADigest);
var
  bits: QWord;
  pad: TBytes;
  padIndex: DWord;
begin
  bits := QWord(FProcessedBytes) * 8;
  if FBuffer.Pos < 56 then
    padIndex := 56 - FBuffer.Pos
  else
    padIndex := 120 - FBuffer.Pos;

  SetLength(pad, padIndex + 8);
  FillChar(pad[0], Length(pad), 0);
  pad[0] := $80;

  bits := SwapEndian(bits);
  Move(bits, pad[padIndex], SizeOf(bits));
  Inc(padIndex, 8);

  UpdateBytes(pad[0], padIndex);

  ConvertDWordsToBytesSwapOrder(FStates, Length(FStates), ADigest)
end;

end.
