unit rhlSHA512Base;

interface

uses
  rhlCore;

type

  { TrhlSHA512Base }

  TrhlSHA512Base = class abstract(TrhlHash)
  private
    const s_K: array[0..79] of QWord = (
     $428a2f98d728ae22, $7137449123ef65cd, $b5c0fbcfec4d3b2f, $e9b5dba58189dbbc,
     $3956c25bf348b538, $59f111f1b605d019, $923f82a4af194f9b, $ab1c5ed5da6d8118,
     $d807aa98a3030242, $12835b0145706fbe, $243185be4ee4b28c, $550c7dc3d5ffb4e2,
     $72be5d74f27b896f, $80deb1fe3b1696b1, $9bdc06a725c71235, $c19bf174cf692694,
     $e49b69c19ef14ad2, $efbe4786384f25e3, $0fc19dc68b8cd5b5, $240ca1cc77ac9c65,
     $2de92c6f592b0275, $4a7484aa6ea6e483, $5cb0a9dcbd41fbd4, $76f988da831153b5,
     $983e5152ee66dfab, $a831c66d2db43210, $b00327c898fb213f, $bf597fc7beef0ee4,
     $c6e00bf33da88fc2, $d5a79147930aa725, $06ca6351e003826f, $142929670a0e6e70,
     $27b70a8546d22ffc, $2e1b21385c26c926, $4d2c6dfc5ac42aed, $53380d139d95b3df,
     $650a73548baf63de, $766a0abb3c77b2a8, $81c2c92e47edaee6, $92722c851482353b,
     $a2bfe8a14cf10364, $a81a664bbc423001, $c24b8b70d0f89791, $c76c51a30654be30,
     $d192e819d6ef5218, $d69906245565a910, $f40e35855771202a, $106aa07032bbd1b8,
     $19a4c116b8d2d0c8, $1e376c085141ab53, $2748774cdf8eeb99, $34b0bcb5e19b48a8,
     $391c0cb3c5c95a63, $4ed8aa4ae3418acb, $5b9cca4f7763e373, $682e6ff3d6b2b8a3,
     $748f82ee5defb2fc, $78a5636f43172f60, $84c87814a1f0ab72, $8cc702081a6439ec,
     $90befffa23631e28, $a4506cebde82bde9, $bef9a3f7b2c67915, $c67178f2e372532b,
     $ca273eceea26619c, $d186b8c721c0c207, $eada7dd6cde0eb1e, $f57d4f7fee6ed178,
     $06f067aa72176fba, $0a637dc5a2c898a6, $113f9804bef90dae, $1b710b35131c471b,
     $28db77f523047d84, $32caab7b40c72493, $3c9ebe0a15c9bebc, $431d67c49c100d4c,
     $4cc5d4becb3e42b6, $597f299cfc657e2a, $5fcb6fab3ad6faec, $6c44198c4a475817);
  protected
    m_state: array[0..7] of QWord;
    procedure UpdateBlock(const AData); override;
  public
    constructor Create; override;
    procedure Final(var ADigest); override;
  end;

implementation

{ TrhlSHA512Base  }

procedure TrhlSHA512Base.UpdateBlock(const AData);
var
  data: array[0..79] of QWord;
  A, B, C, D, E, F, G, H, T0, T1: QWord;
  i, t: Integer;
begin
  ConvertBytesToQWordsSwapOrder(AData, BlockSize, {%H-}data);

  for i := 16 to 79 do
  begin
    T0 := data[i - 15];
    T1 := data[i - 2];
    data[i] := (((T1 shl 45) or (T1 shr 19)) xor ((T1 shl 3) or (T1 shr 61)) xor (T1 shr 6)) + data[i - 7] +
               (((T0 shl 63) or (T0 shr 1)) xor ((T0 shl 56)or (T0 shr 8)) xor (T0 shr 7)) + data[i - 16];
  end;

  a := m_state[0];
  b := m_state[1];
  c := m_state[2];
  d := m_state[3];
  e := m_state[4];
  f := m_state[5];
  g := m_state[6];
  h := m_state[7];

  t := 0;
  for i := 0 to 9 do
  begin
    Inc(h, s_K[t] + data[t] + (((e shl 50) or (e shr 14)) xor ((e shl 46) or (e shr 18)) xor ((e shl 23) or (e shr 41))) + ((e and f) xor (not e and g)));
    Inc(t);
    Inc(d, h);
    Inc(h, (((a shl 36) or (a shr 28)) xor ((a shl 30) or (a shr 34)) xor ((a shl 25) or (a shr 39))) + ((a and b) xor (a and c) xor (b and c)));

    Inc(g, s_K[t] + data[t] + (((d shl 50) or (d shr 14)) xor ((d shl 46) or (d shr 18)) xor ((d shl 23) or (d shr 41))) + ((d and e) xor (not d and f)));
    Inc(t);
    Inc(c, g);
    Inc(g, (((h shl 36) or (h shr 28)) xor ((h shl 30) or (h shr 34)) xor ((h shl 25) or (h shr 39))) + ((h and a) xor (h and b) xor (a and b)));

    Inc(f, s_K[t] + data[t] + (((c shl 50) or (c shr 14)) xor ((c shl 46) or (c shr 18)) xor ((c shl 23) or (c shr 41))) + ((c and d) xor (not c and e)));
    Inc(t);
    Inc(b, f);
    Inc(f, (((g shl 36) or (g shr 28)) xor ((g shl 30) or (g shr 34)) xor ((g shl 25) or (g shr 39))) + ((g and h) xor (g and a) xor (h and a)));

    Inc(e, s_K[t] + data[t] + (((b shl 50) or (b shr 14)) xor ((b shl 46) or (b shr 18)) xor ((b shl 23) or (b shr 41))) + ((b and c) xor (not b and d)));
    Inc(t);
    Inc(a, e);
    Inc(e, (((f shl 36) or (f shr 28)) xor ((f shl 30) or (f shr 34)) xor ((f shl 25) or (f shr 39))) + ((f and g) xor (f and h) xor (g and h)));

    Inc(d, s_K[t] + data[t] + (((a shl 50) or (a shr 14)) xor ((a shl 46) or (a shr 18)) xor ((a shl 23) or (a shr 41))) + ((a and b) xor (not a and c)));
    Inc(t);
    Inc(h, d);
    Inc(d, (((e shl 36) or (e shr 28)) xor ((e shl 30) or (e shr 34)) xor ((e shl 25) or (e shr 39))) + ((e and f) xor (e and g) xor (f and g)));

    Inc(c, s_K[t] + data[t] + (((h shl 50) or (h shr 14)) xor ((h shl 46) or (h shr 18)) xor ((h shl 23) or (h shr 41))) + ((h and a) xor (not h and b)));
    Inc(t);
    Inc(g, c);
    Inc(c, (((d shl 36) or (d shr 28)) xor ((d shl 30) or (d shr 34)) xor ((d shl 25) or (d shr 39))) + ((d and e) xor (d and f) xor (e and f)));

    Inc(b, s_K[t] + data[t] + (((g shl 50) or (g shr 14)) xor ((g shl 46) or (g shr 18)) xor ((g shl 23) or (g shr 41))) + ((g and h) xor (not g and a)));
    Inc(t);
    Inc(f, b);
    Inc(b, (((c shl 36) or (c shr 28)) xor ((c shl 30) or (c shr 34)) xor ((c shl 25) or (c shr 39))) + ((c and d) xor (c and e) xor (d and e)));

    Inc(a, s_K[t] + data[t] + (((f shl 50) or (f shr 14)) xor ((f shl 46) or (f shr 18)) xor ((f shl 23) or (f shr 41))) + ((f and g) xor (not f and h)));
    Inc(t);
    Inc(e, a);
    Inc(a, (((b shl 36) or (b shr 28)) xor ((b shl 30) or (b shr 34)) xor ((b shl 25) or (b shr 39))) + ((b and c) xor (b and d) xor (c and d)));
  end;

  Inc(m_state[0], a);
  Inc(m_state[1], b);
  Inc(m_state[2], c);
  Inc(m_state[3], d);
  Inc(m_state[4], e);
  Inc(m_state[5], f);
  Inc(m_state[6], g);
  Inc(m_state[7], h);
end;

constructor TrhlSHA512Base.Create;
begin
  BlockSize := 128;
end;

procedure TrhlSHA512Base.Final(var ADigest);
var
  lowBits, hiBits: QWord;
  pad: TBytes;
  padIndex: QWord;
  pdigest: PByte;
  pstate: PByte;
begin
  lowBits := FProcessedBytes shl 3;
  hiBits := FProcessedBytes shr 61;

  if FBuffer.Pos < 112 then
    padIndex := 111 - FBuffer.Pos
  else
    padIndex := 239 - FBuffer.Pos;
  Inc(padindex);

  SetLength(pad, padIndex + 16);
  pad[0] := $80;

  lowBits := SwapEndian(lowBits);
  hiBits := SwapEndian(hiBits);

  Move(hiBits, pad[padIndex], SizeOf(hiBits));
  Inc(padIndex, 8);
  Move(lowBits, pad[padIndex], SizeOf(lowBits));
  Inc(padIndex, 8);

  UpdateBytes(pad[0], padIndex);

  ConvertQWordsToBytesSwapOrder(m_state, HashSize div SizeOf(QWord), ADigest);

  padIndex := HashSize mod SizeOf(QWord);

  if padIndex = 4 then // SHA512_224 3*QWord + 1*DWord
  begin
    pdigest := @ADigest;
    pstate := @m_state;
    Inc(pdigest, HashSize - padIndex);
    Inc(pstate, HashSize);
    ConvertDWordsToBytesSwapOrder(pstate^, 1, pdigest^);
  end;
end;

end.
