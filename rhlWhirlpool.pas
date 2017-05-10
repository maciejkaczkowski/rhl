unit rhlWhirlpool;

interface

uses
  rhlCore;

type

  { TrhlWhirlpool }

  TrhlWhirlpool = class(TrhlHash)
  private
    const ROUNDS = 10;
    const REDUCTION_POLYNOMIAL = $11d;
    const s_SBOX: array[0..255] of Byte = (
      $18,$23,$c6,$e8,$87,$b8,$01,$4f,$36,$a6,$d2,$f5,$79,$6f,$91,$52,
      $60,$bc,$9b,$8e,$a3,$0c,$7b,$35,$1d,$e0,$d7,$c2,$2e,$4b,$fe,$57,
      $15,$77,$37,$e5,$9f,$f0,$4a,$da,$58,$c9,$29,$0a,$b1,$a0,$6b,$85,
      $bd,$5d,$10,$f4,$cb,$3e,$05,$67,$e4,$27,$41,$8b,$a7,$7d,$95,$d8,
      $fb,$ee,$7c,$66,$dd,$17,$47,$9e,$ca,$2d,$bf,$07,$ad,$5a,$83,$33,
      $63,$02,$aa,$71,$c8,$19,$49,$d9,$f2,$e3,$5b,$88,$9a,$26,$32,$b0,
      $e9,$0f,$d5,$80,$be,$cd,$34,$48,$ff,$7a,$90,$5f,$20,$68,$1a,$ae,
      $b4,$54,$93,$22,$64,$f1,$73,$12,$40,$08,$c3,$ec,$db,$a1,$8d,$3d,
      $97,$00,$cf,$2b,$76,$82,$d6,$1b,$b5,$af,$6a,$50,$45,$f3,$30,$ef,
      $3f,$55,$a2,$ea,$65,$ba,$2f,$c0,$de,$1c,$fd,$4d,$92,$75,$06,$8a,
      $b2,$e6,$0e,$1f,$62,$d4,$a8,$96,$f9,$c5,$25,$59,$84,$72,$39,$4c,
      $5e,$78,$38,$8c,$d1,$a5,$e2,$61,$b3,$21,$9c,$1e,$43,$c7,$fc,$04,
      $51,$99,$6d,$0d,$fa,$df,$7e,$24,$3b,$ab,$ce,$11,$8f,$4e,$b7,$eb,
      $3c,$81,$94,$f7,$b9,$13,$2c,$d3,$e7,$6e,$c4,$03,$56,$44,$7f,$a9,
      $2a,$bb,$c1,$53,$dc,$0b,$9d,$6c,$31,$74,$f6,$46,$ac,$89,$14,$e1,
      $16,$3a,$69,$09,$70,$b6,$d0,$ed,$cc,$42,$98,$a4,$28,$5c,$f8,$86
    );
    var s_C0,s_C1,s_C2,s_C3,s_C4,s_C5,s_C6,s_C7: array[0..255] of QWord;
    var s_rc: array[0..ROUNDS] of QWord;
    var m_hash: array[0..7] of QWord;
    function maskWithReductionPolynomial(const input: DWord): DWord;
    function packIntoULong(b7, b6, b5, b4, b3, b2, b1, b0: QWord): QWord;
  protected
    procedure UpdateBlock(const AData); override;
  public
    constructor Create; override;
    procedure Init; override;
    procedure Final(var ADigest); override;
  end;

implementation

{ TrhlWhirlpool }

function TrhlWhirlpool.maskWithReductionPolynomial(const input: DWord): DWord;
begin
  if (input >= $100) then
    Result := input xor REDUCTION_POLYNOMIAL
  else
    Result := input;
end;

function TrhlWhirlpool.packIntoULong(b7, b6, b5, b4, b3, b2, b1, b0: QWord
  ): QWord;
begin
  Result := (b7 shl 56) xor
            (b6 shl 48) xor
            (b5 shl 40) xor
            (b4 shl 32) xor
            (b3 shl 24) xor
            (b2 shl 16) xor
            (b1 shl 8)  xor
             b0;
end;

procedure TrhlWhirlpool.UpdateBlock(const AData);
var
  data, temp, k, m: array[0..7] of QWord;
  round, i: Integer;
begin
  ConvertBytesToQWordsSwapOrder(AData, BlockSize, data);
  //ulong[] k = new ulong[8];
  //ulong[] m = new ulong[8];
  //
  //ulong[] temp = new ulong[8];
  //ulong[] data =  Converters.ConvertBytesToULongsSwapOrder(a_data, a_index, BlockSize);

  for i := 0 to 7 do
  begin
    k[i] := m_hash[i];
    temp[i] := data[i] xor k[i];
  end;

  for round := 1 to ROUNDS do
  begin
      for i := 0 to 7 do
      begin
          m[i] := 0;
          m[i] := m[i] xor s_C0[byte(k[(i - 0) and 7] shr 56)];
          m[i] := m[i] xor s_C1[byte(k[(i - 1) and 7] shr 48)];
          m[i] := m[i] xor s_C2[byte(k[(i - 2) and 7] shr 40)];
          m[i] := m[i] xor s_C3[byte(k[(i - 3) and 7] shr 32)];
          m[i] := m[i] xor s_C4[byte(k[(i - 4) and 7] shr 24)];
          m[i] := m[i] xor s_C5[byte(k[(i - 5) and 7] shr 16)];
          m[i] := m[i] xor s_C6[byte(k[(i - 6) and 7] shr 8)];
          m[i] := m[i] xor s_C7[byte(k[(i - 7) and 7])];
      end;

      Move(m, k, SizeOf(k));

      k[0] := k[0] xor s_rc[round];

      for i := 0 to 7 do
      begin
        m[i] := k[i];

        m[i] := m[i] xor s_C0[byte(temp[(i - 0) and 7] shr 56)];
        m[i] := m[i] xor s_C1[byte(temp[(i - 1) and 7] shr 48)];
        m[i] := m[i] xor s_C2[byte(temp[(i - 2) and 7] shr 40)];
        m[i] := m[i] xor s_C3[byte(temp[(i - 3) and 7] shr 32)];
        m[i] := m[i] xor s_C4[byte(temp[(i - 4) and 7] shr 24)];
        m[i] := m[i] xor s_C5[byte(temp[(i - 5) and 7] shr 16)];
        m[i] := m[i] xor s_C6[byte(temp[(i - 6) and 7] shr 8)];
        m[i] := m[i] xor s_C7[byte(temp[(i - 7) and 7])];
      end;

      Move(m, temp, SizeOf(temp));
  end;

  for i := 0 to 7 do
    m_hash[i] := m_hash[i] xor temp[i] xor data[i];
end;

constructor TrhlWhirlpool.Create;
var
  v1, v2, v4, v5, v8, v9: DWord;
  i, r: Integer;
begin
  HashSize := 64;
  BlockSize := 64;

  for i := 0 to 255 do
  begin
    v1 := s_SBOX[i];
    v2 := maskWithReductionPolynomial(v1 shl 1);
    v4 := maskWithReductionPolynomial(v2 shl 1);
    v5 := v4 xor v1;
    v8 := maskWithReductionPolynomial(v4 shl 1);
    v9 := v8 xor v1;

    s_C0[i] := packIntoULong(v1, v1, v4, v1, v8, v5, v2, v9);
    s_C1[i] := packIntoULong(v9, v1, v1, v4, v1, v8, v5, v2);
    s_C2[i] := packIntoULong(v2, v9, v1, v1, v4, v1, v8, v5);
    s_C3[i] := packIntoULong(v5, v2, v9, v1, v1, v4, v1, v8);
    s_C4[i] := packIntoULong(v8, v5, v2, v9, v1, v1, v4, v1);
    s_C5[i] := packIntoULong(v1, v8, v5, v2, v9, v1, v1, v4);
    s_C6[i] := packIntoULong(v4, v1, v8, v5, v2, v9, v1, v1);
    s_C7[i] := packIntoULong(v1, v4, v1, v8, v5, v2, v9, v1);
  end;

  s_rc[0] := 0;

  for r := 1 to ROUNDS do
  begin
    i := 8 * (r - 1);
    s_rc[r] := (s_C0[i + 0] and $ff00000000000000) xor
               (s_C1[i + 1] and $00ff000000000000) xor
               (s_C2[i + 2] and $0000ff0000000000) xor
               (s_C3[i + 3] and $000000ff00000000) xor
               (s_C4[i + 4] and $00000000ff000000) xor
               (s_C5[i + 5] and $0000000000ff0000) xor
               (s_C6[i + 6] and $000000000000ff00) xor
               (s_C7[i + 7] and $00000000000000ff);
  end;

end;

procedure TrhlWhirlpool.Init;
begin
  inherited Init;
  FillChar(m_hash, SizeOf(m_hash), 0);
end;

procedure TrhlWhirlpool.Final(var ADigest);
var
  bits: QWord;
  padIndex: Integer;
  pad: TBytes;
begin
  bits := QWord(FProcessedBytes) * 8;

  if FBuffer.Pos > 31 then
    padIndex := 120 - FBuffer.Pos
  else
    padIndex := 56 - FBuffer.Pos;

  SetLength(pad, padIndex + 8);

  pad[0] := $80;

  bits := SwapEndian(bits);
  Move(bits, pad[padIndex], SizeOf(bits));
  Inc(padIndex, 8);

  UpdateBytes(pad[0], padIndex);
  ConvertQWordsToBytesSwapOrder(m_hash, Length(m_hash), ADigest);
end;

end.
