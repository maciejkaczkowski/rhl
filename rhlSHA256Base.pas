unit rhlSHA256Base;

interface

uses
  rhlCore, sysutils;

type

  { TrhlSHA256Base }

  TrhlSHA256Base = class abstract(TrhlHash)
  private
    const s_K: array[0..63] of DWord = (
      $428a2f98, $71374491, $b5c0fbcf, $e9b5dba5, $3956c25b, $59f111f1, $923f82a4, $ab1c5ed5,
      $d807aa98, $12835b01, $243185be, $550c7dc3, $72be5d74, $80deb1fe, $9bdc06a7, $c19bf174,
      $e49b69c1, $efbe4786, $0fc19dc6, $240ca1cc, $2de92c6f, $4a7484aa, $5cb0a9dc, $76f988da,
      $983e5152, $a831c66d, $b00327c8, $bf597fc7, $c6e00bf3, $d5a79147, $06ca6351, $14292967,
      $27b70a85, $2e1b2138, $4d2c6dfc, $53380d13, $650a7354, $766a0abb, $81c2c92e, $92722c85,
      $a2bfe8a1, $a81a664b, $c24b8b70, $c76c51a3, $d192e819, $d6990624, $f40e3585, $106aa070,
      $19a4c116, $1e376c08, $2748774c, $34b0bcb5, $391c0cb3, $4ed8aa4a, $5b9cca4f, $682e6ff3,
      $748f82ee, $78a5636f, $84c87814, $8cc70208, $90befffa, $a4506ceb, $bef9a3f7, $c67178f2);
  protected
    m_state: array[0..7] of DWord;
    procedure UpdateBlock(const AData); override;
  public
    constructor Create; override;
    procedure Final(var ADigest); override;
  end;

implementation

{ TrhlSHA256Base  }

procedure TrhlSHA256Base.UpdateBlock(const AData);
var
  A, B, C, D, E, F, G, H, T, T2: DWord;
  data: array[0..63] of DWord;
  r: Integer;
begin
  ConvertBytesToDWordsSwapOrder(AData, BlockSize, data);

  A := m_state[0];
  B := m_state[1];
  C := m_state[2];
  D := m_state[3];
  E := m_state[4];
  F := m_state[5];
  G := m_state[6];
  H := m_state[7];

  for r := 16 to 63 do
  begin
    T := data[r - 2];
    T2 := data[r - 15];
    data[r] := (((T shr 17) or (T shl 15)) xor ((T shr 19) or (T shl 13)) xor (T shr 10)) + data[r - 7] +
             (((T2 shr 7) or (T2 shl 25)) xor ((T2 shr 18) or (T2 shl 14)) xor (T2 shr 3)) + data[r - 16];
  end;

  for r := 0 to 63 do
  begin
    T := s_K[r] + data[r] + H + (((E shr 6) or (E shl 26)) xor ((E shr 11) or (E shl 21)) xor ((E shr 25) or
               (E shl 7))) + ((E and F) xor (not E and G));
    T2 := (((A shr 2) or (A shl 30)) xor ((A shr 13) or (A shl 19)) xor
                ((A shr 22) or (A shl 10))) + ((A and B) xor (A and C) xor (B and C));
    H := G;
    G := F;
    F := E;
    E := D + T;
    D := C;
    C := B;
    B := A;
    A := T + T2;
  end;

  Inc(m_state[0], A);
  Inc(m_state[1], B);
  Inc(m_state[2], C);
  Inc(m_state[3], D);
  Inc(m_state[4], E);
  Inc(m_state[5], F);
  Inc(m_state[6], G);
  Inc(m_state[7], H);
end;

constructor TrhlSHA256Base.Create;
begin
  BlockSize := 64;
end;

procedure TrhlSHA256Base.Final(var ADigest);
var
  bits: QWord;
  pad: TBytes;
  padIndex: QWord;
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

  ConvertDWordsToBytesSwapOrder(m_state, HashSize div SizeOf(DWord), ADigest);
end;

end.
