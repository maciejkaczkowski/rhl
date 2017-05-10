unit rhlGrindahl512;

interface

uses
  rhlCore;

type

  { TrhlGrindahl512 }

  TrhlGrindahl512 = class(TrhlHash)
  private
    const
      ROWS = 8;
      COLUMNS = 13;
      BLANK_ROUNDS = 8;
      SIZE = (ROWS * COLUMNS) div 8;
      s_master_table: array[0..255] of QWord = (
        $c6636397633551a2,$f87c7ceb7ccd1326,$ee7777c777952952,$f67b7bf77bf50102,
        $fff2f2e5f2d11a34,$d66b6bb76b7561c2,$de6f6fa76f5579f2,$91c5c539c572a84b,
        $603030c0309ba05b,$020101040108060c,$ce67678767154992,$562b2bac2b43faef,
        $e7fefed5feb13264,$b5d7d771d7e2c493,$4dabab9aab2fd7b5,$ec7676c3769d2f5e,
        $8fcaca05ca0a8a0f,$1f82823e827c2142,$89c9c909c912801b,$fa7d7def7dc5152a,
        $effafac5fa912a54,$b259597f59fecd81,$8e474707470e8909,$fbf0f0edf0c1162c,
        $41adad82ad1fc39d,$b3d4d47dd4face87,$5fa2a2bea267e1d9,$45afaf8aaf0fcf85,
        $239c9c469c8c65ca,$53a4a4a6a457f5f1,$e47272d372bd376e,$9bc0c02dc05ab677,
        $75b7b7eab7cf9f25,$e1fdfdd9fda93870,$3d93937a93f4478e,$4c262698262bd4b3,
        $6c3636d836abb473,$7e3f3ffc3fe3821f,$f5f7f7f1f7f90408,$83cccc1dcc3a9e27,
        $683434d034bbb86b,$51a5a5a2a55ff3fd,$d1e5e5b9e56968d0,$f9f1f1e9f1c91020,
        $e27171df71a53d7a,$abd8d84dd89ae6d7,$623131c43193a657,$2a15155415a87efc,
        $0804041004201830,$95c7c731c762a453,$4623238c2303ca8f,$9dc3c321c342bc63,
        $3018186018c050a0,$3796966e96dc59b2,$0a05051405281e3c,$2f9a9a5e9abc71e2,
        $0e07071c07381224,$2412124812906cd8,$1b808036806c2d5a,$dfe2e2a5e2517af4,
        $cdebeb81eb194c98,$4e27279c2723d2bf,$7fb2b2feb2e78119,$ea7575cf7585254a,
        $120909240948366c,$1d83833a8374274e,$582c2cb02c7be8cb,$341a1a681ad05cb8,
        $361b1b6c1bd85ab4,$dc6e6ea36e5d7ffe,$b45a5a735ae6c795,$5ba0a0b6a077edc1,
        $a452525352a6f7f5,$763b3bec3bc39a2f,$b7d6d675d6eac29f,$7db3b3fab3ef8715,
        $522929a42953f6f7,$dde3e3a1e3597cf8,$5e2f2fbc2f63e2df,$13848426844c356a,
        $a653535753aef1f9,$b9d1d169d1d2d0bb,$0000000000000000,$c1eded99ed2958b0,
        $40202080201bc09b,$e3fcfcddfca13e7c,$79b1b1f2b1ff8b0d,$b65b5b775beec199,
        $d46a6ab36a7d67ce,$8dcbcb01cb028c03,$67bebecebe87a949,$723939e439d39637,
        $944a4a334a66a755,$984c4c2b4c56b37d,$b058587b58f6cb8d,$85cfcf11cf229433,
        $bbd0d06dd0dad6b7,$c5efef91ef3954a8,$4faaaa9eaa27d1b9,$edfbfbc1fb992c58,
        $86434317432e9139,$9a4d4d2f4d5eb571,$663333cc3383aa4f,$1185852285443366,
        $8a45450f451e8511,$e9f9f9c9f9892040,$0402020802100c18,$fe7f7fe77fd51932,
        $a050505b50b6fbed,$783c3cf03cfb880b,$259f9f4a9f946fde,$4ba8a896a837dda1,
        $a251515f51befde1,$5da3a3baa36fe7d5,$8040401b40369b2d,$058f8f0a8f140f1e,
        $3f92927e92fc4182,$219d9d429d8463c6,$703838e038db903b,$f1f5f5f9f5e90810,
        $63bcbcc6bc97a551,$77b6b6eeb6c79929,$afdada45da8aeacf,$422121842113c697,
        $20101040108060c0,$e5ffffd1ffb93468,$fdf3f3e1f3d91c38,$bfd2d265d2cadaaf,
        $81cdcd19cd32982b,$180c0c300c602850,$2613134c13986ad4,$c3ecec9dec215ebc,
        $be5f5f675fced9a9,$3597976a97d45fbe,$8844440b4416831d,$2e17175c17b872e4,
        $93c4c43dc47aae47,$55a7a7aaa74fffe5,$fc7e7ee37edd1f3e,$7a3d3df43df38e07,
        $c864648b640d4386,$ba5d5d6f5dded5b1,$3219196419c856ac,$e67373d773b53162,
        $c060609b602d5bb6,$1981813281642b56,$9e4f4f274f4eb969,$a3dcdc5ddcbafee7,
        $44222288220bcc83,$542a2aa82a4bfce3,$3b90907690ec4d9a,$0b888816882c1d3a,
        $8c46460346068f05,$c7eeee95ee3152a4,$6bb8b8d6b8b7bd61,$2814145014a078f0,
        $a7dede55deaaf2ff,$bc5e5e635ec6dfa5,$160b0b2c0b583a74,$addbdb41db82ecc3,
        $dbe0e0ade04176ec,$643232c8328bac43,$743a3ae83acb9c23,$140a0a280a503c78,
        $9249493f497ead41,$0c06061806301428,$48242490243bd8ab,$b85c5c6b5cd6d3bd,
        $9fc2c225c24aba6f,$bdd3d361d3c2dca3,$43acac86ac17c591,$c4626293623d57ae,
        $3991917291e44b96,$3195956295c453a6,$d3e4e4bde4616edc,$f27979ff79e50d1a,
        $d5e7e7b1e77964c8,$8bc8c80dc81a8617,$6e3737dc37a3b27f,$da6d6daf6d4575ea,
        $018d8d028d040306,$b1d5d579d5f2c88b,$9c4e4e234e46bf65,$49a9a992a93fdbad,
        $d86c6cab6c4d73e6,$ac5656435686efc5,$f3f4f4fdf4e10e1c,$cfeaea85ea114a94,
        $ca65658f6505458a,$f47a7af37afd070e,$47aeae8eae07c989,$1008082008403060,
        $6fbabadebaa7b179,$f07878fb78ed0b16,$4a2525942533dea7,$5c2e2eb82e6be4d3,
        $381c1c701ce04890,$57a6a6aea647f9e9,$73b4b4e6b4d79531,$97c6c635c66aa25f,
        $cbe8e88de801468c,$a1dddd59ddb2f8eb,$e87474cb748d2346,$3e1f1f7c1ff84284,
        $964b4b374b6ea159,$61bdbdc2bd9fa35d,$0d8b8b1a8b34172e,$0f8a8a1e8a3c1122,
        $e07070db70ad3b76,$7c3e3ef83eeb8413,$71b5b5e2b5df933d,$cc666683661d4f9e,
        $9048483b4876ab4d,$0603030c03180a14,$f7f6f6f5f6f10204,$1c0e0e380e702448,
        $c261619f61255dba,$6a3535d435b3be67,$ae575747578ee9c9,$69b9b9d2b9bfbb6d,
        $1786862e865c3972,$99c1c129c152b07b,$3a1d1d741de84e9c,$279e9e4e9e9c69d2,
        $d9e1e1a9e14970e0,$ebf8f8cdf881264c,$2b98985698ac7dfa,$22111144118866cc,
        $d26969bf69656dda,$a9d9d949d992e0db,$078e8e0e8e1c0912,$3394946694cc55aa,
        $2d9b9b5a9bb477ee,$3c1e1e781ef04488,$1587872a87543f7e,$c9e9e989e9094080,
        $87cece15ce2a923f,$aa55554f559ee5d1,$502828a0285bf0fb,$a5dfdf51dfa2f4f3,
        $038c8c068c0c050a,$59a1a1b2a17febcd,$0989891289241b36,$1a0d0d340d682e5c,
        $65bfbfcabf8faf45,$d7e6e6b5e67162c4,$8442421342269735,$d06868bb686d6bd6,
        $8241411f413e9d21,$2999995299a47bf6,$5a2d2db42d73eec7,$1e0f0f3c0f782244,
        $7bb0b0f6b0f78d01,$a854544b5496e3dd,$6dbbbbdabbafb775,$2c16165816b074e8
      );
    var
      s_table_0,
      s_table_1,
      s_table_2,
      s_table_3,
      s_table_4,
      s_table_5,
      s_table_6,
      s_table_7: array[0..255] of QWord;
      m_state: array[0..SIZE - 1] of QWord;
      m_temp: array[0..SIZE - 1] of QWord;
    procedure InjectMsg(a_full_process: Boolean);
  protected
    procedure UpdateBlock(const AData); override;
  public
    constructor Create; override;
    procedure Init; override;
    procedure Final(var ADigest); override;
  end;

implementation

{ TrhlGrindahl512 }

procedure TrhlGrindahl512.InjectMsg(a_full_process: Boolean);
var
  u: array[0..SIZE - 1] of QWord;
begin
  m_state[SIZE - 1] := m_state[SIZE - 1] xor $01;

  if (a_full_process) then
  begin
      m_temp[0] :=
          s_table_0[Byte(m_state[12] shr 56)] xor
          s_table_1[Byte(m_state[11] shr 48)] xor
          s_table_2[Byte(m_state[10] shr 40)] xor
          s_table_3[Byte(m_state[9] shr 32)] xor
          s_table_4[Byte(m_state[8] shr 24)] xor
          s_table_5[Byte(m_state[7] shr 16)] xor
          s_table_6[Byte(m_state[6] shr 8)] xor
          s_table_7[Byte(m_state[5])];
  end;

  m_temp[1] :=
    s_table_0[Byte(m_state[0] shr 56)] xor
    s_table_1[Byte(m_state[12] shr 48)] xor
    s_table_2[Byte(m_state[11] shr 40)] xor
    s_table_3[Byte(m_state[10] shr 32)] xor
    s_table_4[Byte(m_state[9] shr 24)] xor
    s_table_5[Byte(m_state[8] shr 16)] xor
    s_table_6[Byte(m_state[7] shr 8)] xor
    s_table_7[Byte(m_state[6])];

  m_temp[2] :=
    s_table_0[Byte(m_state[1] shr 56)] xor
    s_table_1[Byte(m_state[0] shr 48)] xor
    s_table_2[Byte(m_state[12] shr 40)] xor
    s_table_3[Byte(m_state[11] shr 32)] xor
    s_table_4[Byte(m_state[10] shr 24)] xor
    s_table_5[Byte(m_state[9] shr 16)] xor
    s_table_6[Byte(m_state[8] shr 8)] xor
    s_table_7[Byte(m_state[7])];

  m_temp[3] :=
    s_table_0[Byte(m_state[2] shr 56)] xor
    s_table_1[Byte(m_state[1] shr 48)] xor
    s_table_2[Byte(m_state[0] shr 40)] xor
    s_table_3[Byte(m_state[12] shr 32)] xor
    s_table_4[Byte(m_state[11] shr 24)] xor
    s_table_5[Byte(m_state[10] shr 16)] xor
    s_table_6[Byte(m_state[9] shr 8)] xor
    s_table_7[Byte(m_state[8])];

  m_temp[4] :=
    s_table_0[Byte(m_state[3] shr 56)] xor
    s_table_1[Byte(m_state[2] shr 48)] xor
    s_table_2[Byte(m_state[1] shr 40)] xor
    s_table_3[Byte(m_state[0] shr 32)] xor
    s_table_4[Byte(m_state[12] shr 24)] xor
    s_table_5[Byte(m_state[11] shr 16)] xor
    s_table_6[Byte(m_state[10] shr 8)] xor
    s_table_7[Byte(m_state[9])];

  m_temp[5] :=
    s_table_0[Byte(m_state[4] shr 56)] xor
    s_table_1[Byte(m_state[3] shr 48)] xor
    s_table_2[Byte(m_state[2] shr 40)] xor
    s_table_3[Byte(m_state[1] shr 32)] xor
    s_table_4[Byte(m_state[0] shr 24)] xor
    s_table_5[Byte(m_state[12] shr 16)] xor
    s_table_6[Byte(m_state[11] shr 8)] xor
    s_table_7[Byte(m_state[10])];

  m_temp[6] :=
    s_table_0[Byte(m_state[5] shr 56)] xor
    s_table_1[Byte(m_state[4] shr 48)] xor
    s_table_2[Byte(m_state[3] shr 40)] xor
    s_table_3[Byte(m_state[2] shr 32)] xor
    s_table_4[Byte(m_state[1] shr 24)] xor
    s_table_5[Byte(m_state[0] shr 16)] xor
    s_table_6[Byte(m_state[12] shr 8)] xor
    s_table_7[Byte(m_state[11])];

  m_temp[7] :=
    s_table_0[Byte(m_state[6] shr 56)] xor
    s_table_1[Byte(m_state[5] shr 48)] xor
    s_table_2[Byte(m_state[4] shr 40)] xor
    s_table_3[Byte(m_state[3] shr 32)] xor
    s_table_4[Byte(m_state[2] shr 24)] xor
    s_table_5[Byte(m_state[1] shr 16)] xor
    s_table_6[Byte(m_state[0] shr 8)] xor
    s_table_7[Byte(m_state[12])];

  m_temp[8] :=
    s_table_0[Byte(m_state[7] shr 56)] xor
    s_table_1[Byte(m_state[6] shr 48)] xor
    s_table_2[Byte(m_state[5] shr 40)] xor
    s_table_3[Byte(m_state[4] shr 32)] xor
    s_table_4[Byte(m_state[3] shr 24)] xor
    s_table_5[Byte(m_state[2] shr 16)] xor
    s_table_6[Byte(m_state[1] shr 8)] xor
    s_table_7[Byte(m_state[0])];

  m_temp[9] :=
    s_table_0[Byte(m_state[8] shr 56)] xor
    s_table_1[Byte(m_state[7] shr 48)] xor
    s_table_2[Byte(m_state[6] shr 40)] xor
    s_table_3[Byte(m_state[5] shr 32)] xor
    s_table_4[Byte(m_state[4] shr 24)] xor
    s_table_5[Byte(m_state[3] shr 16)] xor
    s_table_6[Byte(m_state[2] shr 8)] xor
    s_table_7[Byte(m_state[1])];

  m_temp[10] :=
    s_table_0[Byte(m_state[9] shr 56)] xor
    s_table_1[Byte(m_state[8] shr 48)] xor
    s_table_2[Byte(m_state[7] shr 40)] xor
    s_table_3[Byte(m_state[6] shr 32)] xor
    s_table_4[Byte(m_state[5] shr 24)] xor
    s_table_5[Byte(m_state[4] shr 16)] xor
    s_table_6[Byte(m_state[3] shr 8)] xor
    s_table_7[Byte(m_state[2])];

  m_temp[11] :=
    s_table_0[Byte(m_state[10] shr 56)] xor
    s_table_1[Byte(m_state[9] shr 48)] xor
    s_table_2[Byte(m_state[8] shr 40)] xor
    s_table_3[Byte(m_state[7] shr 32)] xor
    s_table_4[Byte(m_state[6] shr 24)] xor
    s_table_5[Byte(m_state[5] shr 16)] xor
    s_table_6[Byte(m_state[4] shr 8)] xor
    s_table_7[Byte(m_state[3])];

  m_temp[12] :=
    s_table_0[Byte(m_state[11] shr 56)] xor
    s_table_1[Byte(m_state[10] shr 48)] xor
    s_table_2[Byte(m_state[9] shr 40)] xor
    s_table_3[Byte(m_state[8] shr 32)] xor
    s_table_4[Byte(m_state[7] shr 24)] xor
    s_table_5[Byte(m_state[6] shr 16)] xor
    s_table_6[Byte(m_state[5] shr 8)] xor
    s_table_7[Byte(m_state[4])];

  Move(m_temp, u, SizeOf(m_temp));
  Move(m_state, m_temp, SizeOf(m_state));
  Move(u, m_state, SizeOf(u));
end;

procedure TrhlGrindahl512.UpdateBlock(const AData);
var
  x: QWord absolute AData;
begin
  m_state[0] := SwapEndian(x);
  InjectMsg(false);
end;

constructor TrhlGrindahl512.Create;

  procedure CalcTable(i: Integer; var tab);
  var
    atab: array[0..0] of QWord absolute tab;
    j: Integer;
  begin
    for j := 0 to 255 do
      atab[j] := RorQWord(s_master_table[j], i*8);
  end;

begin
  HashSize := 64;
  BlockSize := 8;

  Move(s_master_table, s_table_0, SizeOf(s_master_table));

  CalcTable(1, s_table_1);
  CalcTable(2, s_table_2);
  CalcTable(3, s_table_3);
  CalcTable(4, s_table_4);
  CalcTable(5, s_table_5);
  CalcTable(6, s_table_6);
  CalcTable(7, s_table_7);
end;

procedure TrhlGrindahl512.Init;
begin
  inherited Init;
  FillChar(m_state, SizeOf(m_state), 0);
  FillChar(m_temp, SizeOf(m_temp), 0);
end;

procedure TrhlGrindahl512.Final(var ADigest);
var
  padding_size: DWord;
  msg_length: QWord;
  pad: TBytes;
  i: Integer;
begin
  padding_size := 2 * BlockSize - (FProcessedBytes mod BlockSize);
  msg_length := (FProcessedBytes div ROWS) + 1;

  SetLength(pad, padding_size);
  pad[0] := $80;

  msg_length := SwapEndian(msg_length);
  Move(msg_length, pad[padding_size-8], SizeOf(msg_length));
  UpdateBytes(pad[0], padding_size - BlockSize);

  Move(pad[padding_size - BlockSize], m_state[0], 8);
  m_state[0] := SwapEndian(m_state[0]);

  for i := 0 to BLANK_ROUNDS do
    InjectMsg(true);

  i := HashSize div ROWS;
  ConvertQWordsToBytesSwapOrder(m_state[COLUMNS - i], i, ADigest);
end;

end.
