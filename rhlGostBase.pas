unit rhlGostBase;

interface

uses
  rhlCore;

type

  { TrhlGostBase }

  TrhlGostBase = class(TrhlHash)
  protected
    sbox: array[0..7, 0..15] of DWord;
    s_sbox1, s_sbox2, s_sbox3, s_sbox4: array[0..255] of DWord;
    m_state, m_hash: array[0..7] of DWord;
    procedure Compress(var a);
    procedure UpdateBlock(const AData); override;
  public
    constructor Create; override;
    procedure Init; override;
    procedure Final(var ADigest); override;
  end;

implementation

{ TrhlGostBase }

procedure TrhlGostBase.UpdateBlock(const AData);
var
  m: array[0..7] of DWord;
  a, b, c: DWord;
  i: integer;
  Data: array[0..0] of DWord absolute AData;
begin
  c := 0;

  for i := 0 to 7 do
  begin
    a := Data[i];
    m[i] := a;
    b := m_state[i];
    c := a + c + m_state[i];
    m_state[i] := c;
    if ((a = $FFFFFFFF) and (b = $FFFFFFFF)) then
    begin
      c := 1;
    end
    else
    begin
      if c < a then
        c := 1
      else
        c := 0;
    end;
  end;

  Compress(m);
end;

constructor TrhlGostBase.Create;
var
  i, a, b: integer;
  ax, bx, cx, dx: DWord;
begin
  HashSize := 32;
  BlockSize := 32;
  i := 0;
  for a := 0 to 15 do
  begin
    ax := sbox[1, a] shl 15;
    bx := sbox[3, a] shl 23;
    cx := sbox[5, a];
    cx := RorDWord(cx, 1);// (cx shr 1) or (cx shl 31);
    dx := sbox[7, a] shl 7;

    for b := 0 to 15 do
    begin
      s_sbox1[i] := ax or (sbox[0, b] shl 11);
      s_sbox2[i] := bx or (sbox[2, b] shl 19);
      s_sbox3[i] := cx or (sbox[4, b] shl 27);
      s_sbox4[i] := dx or (sbox[6, b] shl 3);
      Inc(i);
    end;
  end;
end;

procedure TrhlGostBase.Compress(var a);

  procedure g_round(var l, r: DWord; k1, k2: DWord);
  var
    t: DWord;
  begin
    t := k1 + r;
    l := l xor (s_sbox1[Byte(t)] xor s_sbox2[Byte(t shr 8)] xor
                s_sbox3[Byte(t shr 16)] xor s_sbox4[t shr 24]);
    t := k2 + l;
    r := r xor (s_sbox1[Byte(t)] xor s_sbox2[Byte(t shr 8)] xor
                s_sbox3[Byte(t shr 16)] xor s_sbox4[t shr 24]);
  end;

  procedure g_encrypt(var l, r: DWord; const key);
  var
    akey: array[0..0] of DWord absolute key;
    t: DWord;
  begin
    g_round(l, r, akey[0], akey[1]);
    g_round(l, r, akey[2], akey[3]);
    g_round(l, r, akey[4], akey[5]);
    g_round(l, r, akey[6], akey[7]);
    g_round(l, r, akey[0], akey[1]);
    g_round(l, r, akey[2], akey[3]);
    g_round(l, r, akey[4], akey[5]);
    g_round(l, r, akey[6], akey[7]);
    g_round(l, r, akey[0], akey[1]);
    g_round(l, r, akey[2], akey[3]);
    g_round(l, r, akey[4], akey[5]);
    g_round(l, r, akey[6], akey[7]);
    g_round(l, r, akey[7], akey[6]);
    g_round(l, r, akey[5], akey[4]);
    g_round(l, r, akey[3], akey[2]);
    g_round(l, r, akey[1], akey[0]);
    t := r;
    r := l;
    l := t;
  end;

var
  s, u, v, w, key: array[0..7] of DWord;
  i: integer;
  j: integer;
  r, l: DWord;
  a_m: array[0..0] of DWord absolute a;
begin
  Move(m_hash, u, SizeOf(u));
  Move(a, v, SizeOf(v));

  i := 0;
  while i < 8 do
  begin
    for j := 0 to 7 do
      w[j] := u[j] xor v[j];

    key[0] := (w[0] and $000000ff) or ((w[2] and $000000ff) shl 8) or
      ((w[4] and $000000ff) shl 16) or ((w[6] and $000000ff) shl 24);
    key[1] := ((w[0] and $0000ff00) shr 8) or (w[2] and $0000ff00) or
      ((w[4] and $0000ff00) shl 8) or ((w[6] and $0000ff00) shl 16);
    key[2] := ((w[0] and $00ff0000) shr 16) or ((w[2] and $00ff0000) shr 8) or
      (w[4] and $00ff0000) or ((w[6] and $00ff0000) shl 8);
    key[3] := ((w[0] and $ff000000) shr 24) or ((w[2] and $ff000000) shr 16) or
      ((w[4] and $ff000000) shr 8) or (w[6] and $ff000000);
    key[4] := (w[1] and $000000ff) or ((w[3] and $000000ff) shl 8) or
      ((w[5] and $000000ff) shl 16) or ((w[7] and $000000ff) shl 24);
    key[5] := ((w[1] and $0000ff00) shr 8) or (w[3] and $0000ff00) or
      ((w[5] and $0000ff00) shl 8) or ((w[7] and $0000ff00) shl 16);
    key[6] := ((w[1] and $00ff0000) shr 16) or ((w[3] and $00ff0000) shr 8) or
      (w[5] and $00ff0000) or ((w[7] and $00ff0000) shl 8);
    key[7] := ((w[1] and $ff000000) shr 24) or ((w[3] and $ff000000) shr 16) or
      ((w[5] and $ff000000) shr 8) or (w[7] and $ff000000);

    r := m_hash[i];
    l := m_hash[i + 1];
    g_encrypt(l, r, key);
    s[i] := r;
    s[i + 1] := l;

    if (i = 6) then
      break;

    l := u[0] xor u[2];
    r := u[1] xor u[3];
    u[0] := u[2];
    u[1] := u[3];
    u[2] := u[4];
    u[3] := u[5];
    u[4] := u[6];
    u[5] := u[7];
    u[6] := l;
    u[7] := r;

    if (i = 2) then
    begin
      u[0] := u[0] xor $ff00ff00;
      u[1] := u[1] xor $ff00ff00;
      u[2] := u[2] xor $00ff00ff;
      u[3] := u[3] xor $00ff00ff;
      u[4] := u[4] xor $00ffff00;
      u[5] := u[5] xor $ff0000ff;
      u[6] := u[6] xor $000000ff;
      u[7] := u[7] xor $ff00ffff;
    end;

    l := v[0];
    r := v[2];
    v[0] := v[4];
    v[2] := v[6];
    v[4] := l xor r;
    v[6] := v[0] xor r;
    l := v[1];
    r := v[3];
    v[1] := v[5];
    v[3] := v[7];
    v[5] := l xor r;
    v[7] := v[1] xor r;
    Inc(i, 2);
  end;

  u[0] := a_m[0] xor s[6];
  u[1] := a_m[1] xor s[7];
  u[2] := a_m[2] xor (s[0] shl 16) xor (s[0] shr 16) xor (s[0] and $ffff) xor
    (s[1] and $ffff) xor (s[1] shr 16) xor (s[2] shl 16) xor s[6] xor
    (s[6] shl 16) xor (s[7] and $ffff0000) xor (s[7] shr 16);
  u[3] := a_m[3] xor (s[0] and $ffff) xor (s[0] shl 16) xor (s[1] and $ffff) xor
    (s[1] shl
    16) xor (s[1] shr 16) xor (s[2] shl 16) xor (s[2] shr 16) xor
    (s[3] shl 16) xor s[6] xor (s[6] shl 16) xor (s[6] shr 16) xor
    (s[7] and $ffff) xor (s[7] shl 16) xor (s[7] shr 16);
  u[4] := a_m[4] xor (s[0] and $ffff0000) xor (s[0] shl 16) xor
    (s[0] shr 16) xor (s[1] and $ffff0000) xor (s[1] shr 16) xor
    (s[2] shl 16) xor (s[2] shr 16) xor (s[3] shl 16) xor (s[3] shr 16) xor
    (s[4] shl 16) xor (s[6] shl 16) xor (s[6] shr 16) xor (s[7] and $ffff) xor
    (s[7] shl 16) xor (s[7] shr 16);
  u[5] := a_m[5] xor (s[0] shl 16) xor (s[0] shr 16) xor (s[0] and $ffff0000) xor
    (s[1] and $ffff) xor s[2] xor (s[2] shr 16) xor (s[3] shl 16) xor
    (s[3] shr 16) xor
    (s[4] shl 16) xor (s[4] shr 16) xor (s[5] shl 16) xor (s[6] shl 16) xor
    (s[6] shr 16) xor (s[7] and $ffff0000) xor (s[7] shl 16) xor (s[7] shr 16);
  u[6] := a_m[6] xor s[0] xor (s[1] shr 16) xor (s[2] shl 16) xor
    s[3] xor (s[3] shr 16) xor (s[4] shl 16) xor (s[4] shr 16) xor
    (s[5] shl 16) xor (s[5] shr 16) xor s[6] xor (s[6] shl 16) xor
    (s[6] shr 16) xor (s[7] shl 16);
  u[7] := a_m[7] xor (s[0] and $ffff0000) xor (s[0] shl 16) xor
    (s[1] and $ffff) xor (s[1] shl 16) xor (s[2] shr 16) xor (s[3] shl 16) xor
    s[4] xor (s[4] shr 16) xor (s[5] shl 16) xor (s[5] shr 16) xor
    (s[6] shr 16) xor (s[7] and $ffff) xor (s[7] shl 16) xor (s[7] shr 16);

  {16 * 1 round of the LFSR and xor in H}

  v[0] := m_hash[0] xor (u[1] shl 16) xor (u[0] shr 16);
  v[1] := m_hash[1] xor (u[2] shl 16) xor (u[1] shr 16);
  v[2] := m_hash[2] xor (u[3] shl 16) xor (u[2] shr 16);
  v[3] := m_hash[3] xor (u[4] shl 16) xor (u[3] shr 16);
  v[4] := m_hash[4] xor (u[5] shl 16) xor (u[4] shr 16);
  v[5] := m_hash[5] xor (u[6] shl 16) xor (u[5] shr 16);
  v[6] := m_hash[6] xor (u[7] shl 16) xor (u[6] shr 16);
  v[7] := m_hash[7] xor (u[0] and $ffff0000) xor (u[0] shl 16) xor
    (u[7] shr 16) xor (u[1] and $ffff0000) xor (u[1] shl 16) xor
    (u[6] shl 16) xor (u[7] and $ffff0000);

  {61 rounds of LFSR, mixing m_hash (computed from a product matrix)}

  m_hash[0] := (v[0] and $ffff0000) xor (v[0] shl 16) xor (v[0] shr 16) xor
    (v[1] shr 16) xor (v[1] and $ffff0000) xor (v[2] shl 16) xor
    (v[3] shr 16) xor (v[4] shl 16) xor (v[5] shr 16) xor v[5] xor
    (v[6] shr 16) xor (v[7] shl 16) xor (v[7] shr 16) xor (v[7] and $ffff);
  m_hash[1] := (v[0] shl 16) xor (v[0] shr 16) xor (v[0] and $ffff0000) xor
    (v[1] and $ffff) xor v[2] xor (v[2] shr 16) xor (v[3] shl 16) xor
    (v[4] shr 16) xor (v[5] shl 16) xor (v[6] shl 16) xor v[6] xor
    (v[7] and $ffff0000) xor (v[7] shr 16);
  m_hash[2] := (v[0] and $ffff) xor (v[0] shl 16) xor (v[1] shl 16) xor
    (v[1] shr 16) xor (v[1] and $ffff0000) xor (v[2] shl 16) xor
    (v[3] shr 16) xor v[3] xor (v[4] shl 16) xor (v[5] shr 16) xor v[6] xor
    (v[6] shr 16) xor (v[7] and $ffff) xor (v[7] shl 16) xor (v[7] shr 16);
  m_hash[3] := (v[0] shl 16) xor (v[0] shr 16) xor (v[0] and $ffff0000) xor
    (v[1] and $ffff0000) xor (v[1] shr 16) xor (v[2] shl 16) xor
    (v[2] shr 16) xor v[2] xor (v[3] shl 16) xor (v[4] shr 16) xor v[4] xor
    (v[5] shl 16) xor (v[6] shl 16) xor (v[7] and $ffff) xor (v[7] shr 16);
  m_hash[4] := (v[0] shr 16) xor (v[1] shl 16) xor v[1] xor (v[2] shr 16) xor
    v[2] xor (v[3] shl 16) xor (v[3] shr 16) xor v[3] xor (v[4] shl 16) xor
    (v[5] shr 16) xor v[5] xor (v[6] shl 16) xor (v[6] shr 16) xor (v[7] shl 16);
  m_hash[5] := (v[0] shl 16) xor (v[0] and $ffff0000) xor (v[1] shl 16) xor
    (v[1] shr 16) xor (v[1] and $ffff0000) xor (v[2] shl 16) xor v[2] xor
    (v[3] shr 16) xor v[3] xor (v[4] shl 16) xor (v[4] shr 16) xor
    v[4] xor (v[5] shl 16) xor (v[6] shl 16) xor (v[6] shr 16) xor v[6] xor
    (v[7] shl 16) xor (v[7] shr 16) xor (v[7] and $ffff0000);
  m_hash[6] := v[0] xor v[2] xor (v[2] shr 16) xor v[3] xor (v[3] shl 16) xor
    v[4] xor (v[4] shr 16) xor (v[5] shl 16) xor (v[5] shr 16) xor
    v[5] xor (v[6] shl 16) xor (v[6] shr 16) xor v[6] xor (v[7] shl 16) xor v[7];
  m_hash[7] := v[0] xor (v[0] shr 16) xor (v[1] shl 16) xor (v[1] shr 16) xor
    (v[2] shl 16) xor (v[3] shr 16) xor v[3] xor (v[4] shl 16) xor v[4] xor
    (v[5] shr 16) xor v[5] xor (v[6] shl 16) xor (v[6] shr 16) xor
    (v[7] shl 16) xor v[7];
end;


procedure TrhlGostBase.Init;
begin
  inherited Init;
  FillChar(m_state, SizeOf(m_state), 0);
  FillChar(m_hash, SizeOf(m_hash), 0);
end;

procedure TrhlGostBase.Final(var ADigest);
var
  pad: TBytes;
  m_length: array[0..7] of DWord;
  x: DWord;
  bits: QWord;
begin
  bits := QWord(FProcessedBytes) * 8;

  if (FBuffer.Pos > 0) then
  begin
    x := 32 - FBuffer.Pos;
    SetLength(pad, x);
    FillChar(pad[0], x, 0);
    UpdateBytes(pad[0], x);
  end;


  FillChar(m_length, SizeOf(m_length), 0);
  move(bits, m_length[0], SizeOf(bits));

  Compress(m_length);
  Compress(m_state);

  Move(m_hash, ADigest, SizeOf(m_hash));
end;

end.
