unit rhlGrindahl256;

interface

uses
  rhlCore;

type

  { TrhlGrindahl256 }

  TrhlGrindahl256 = class(TrhlHash)
  private
    const
      ROWS = 4;
      COLUMNS = 13;
      BLANK_ROUNDS = 8;
      SIZE = (ROWS * COLUMNS) div 4;
      s_master_table: array[0..255] of DWord = (
        $c66363a5,$f87c7c84,$ee777799,$f67b7b8d,$fff2f20d,$d66b6bbd,$de6f6fb1,$91c5c554,
        $60303050,$02010103,$ce6767a9,$562b2b7d,$e7fefe19,$b5d7d762,$4dababe6,$ec76769a,
        $8fcaca45,$1f82829d,$89c9c940,$fa7d7d87,$effafa15,$b25959eb,$8e4747c9,$fbf0f00b,
        $41adadec,$b3d4d467,$5fa2a2fd,$45afafea,$239c9cbf,$53a4a4f7,$e4727296,$9bc0c05b,
        $75b7b7c2,$e1fdfd1c,$3d9393ae,$4c26266a,$6c36365a,$7e3f3f41,$f5f7f702,$83cccc4f,
        $6834345c,$51a5a5f4,$d1e5e534,$f9f1f108,$e2717193,$abd8d873,$62313153,$2a15153f,
        $0804040c,$95c7c752,$46232365,$9dc3c35e,$30181828,$379696a1,$0a05050f,$2f9a9ab5,
        $0e070709,$24121236,$1b80809b,$dfe2e23d,$cdebeb26,$4e272769,$7fb2b2cd,$ea75759f,
        $1209091b,$1d83839e,$582c2c74,$341a1a2e,$361b1b2d,$dc6e6eb2,$b45a5aee,$5ba0a0fb,
        $a45252f6,$763b3b4d,$b7d6d661,$7db3b3ce,$5229297b,$dde3e33e,$5e2f2f71,$13848497,
        $a65353f5,$b9d1d168,$00000000,$c1eded2c,$40202060,$e3fcfc1f,$79b1b1c8,$b65b5bed,
        $d46a6abe,$8dcbcb46,$67bebed9,$7239394b,$944a4ade,$984c4cd4,$b05858e8,$85cfcf4a,
        $bbd0d06b,$c5efef2a,$4faaaae5,$edfbfb16,$864343c5,$9a4d4dd7,$66333355,$11858594,
        $8a4545cf,$e9f9f910,$04020206,$fe7f7f81,$a05050f0,$783c3c44,$259f9fba,$4ba8a8e3,
        $a25151f3,$5da3a3fe,$804040c0,$058f8f8a,$3f9292ad,$219d9dbc,$70383848,$f1f5f504,
        $63bcbcdf,$77b6b6c1,$afdada75,$42212163,$20101030,$e5ffff1a,$fdf3f30e,$bfd2d26d,
        $81cdcd4c,$180c0c14,$26131335,$c3ecec2f,$be5f5fe1,$359797a2,$884444cc,$2e171739,
        $93c4c457,$55a7a7f2,$fc7e7e82,$7a3d3d47,$c86464ac,$ba5d5de7,$3219192b,$e6737395,
        $c06060a0,$19818198,$9e4f4fd1,$a3dcdc7f,$44222266,$542a2a7e,$3b9090ab,$0b888883,
        $8c4646ca,$c7eeee29,$6bb8b8d3,$2814143c,$a7dede79,$bc5e5ee2,$160b0b1d,$addbdb76,
        $dbe0e03b,$64323256,$743a3a4e,$140a0a1e,$924949db,$0c06060a,$4824246c,$b85c5ce4,
        $9fc2c25d,$bdd3d36e,$43acacef,$c46262a6,$399191a8,$319595a4,$d3e4e437,$f279798b,
        $d5e7e732,$8bc8c843,$6e373759,$da6d6db7,$018d8d8c,$b1d5d564,$9c4e4ed2,$49a9a9e0,
        $d86c6cb4,$ac5656fa,$f3f4f407,$cfeaea25,$ca6565af,$f47a7a8e,$47aeaee9,$10080818,
        $6fbabad5,$f0787888,$4a25256f,$5c2e2e72,$381c1c24,$57a6a6f1,$73b4b4c7,$97c6c651,
        $cbe8e823,$a1dddd7c,$e874749c,$3e1f1f21,$964b4bdd,$61bdbddc,$0d8b8b86,$0f8a8a85,
        $e0707090,$7c3e3e42,$71b5b5c4,$cc6666aa,$904848d8,$06030305,$f7f6f601,$1c0e0e12,
        $c26161a3,$6a35355f,$ae5757f9,$69b9b9d0,$17868691,$99c1c158,$3a1d1d27,$279e9eb9,
        $d9e1e138,$ebf8f813,$2b9898b3,$22111133,$d26969bb,$a9d9d970,$078e8e89,$339494a7,
        $2d9b9bb6,$3c1e1e22,$15878792,$c9e9e920,$87cece49,$aa5555ff,$50282878,$a5dfdf7a,
        $038c8c8f,$59a1a1f8,$09898980,$1a0d0d17,$65bfbfda,$d7e6e631,$844242c6,$d06868b8,
        $824141c3,$299999b0,$5a2d2d77,$1e0f0f11,$7bb0b0cb,$a85454fc,$6dbbbbd6,$2c16163a
      );
    var
      s_table_0,
      s_table_1,
      s_table_2,
      s_table_3: array[0..255] of DWord;
      m_state: array[0..SIZE - 1] of DWord;
      m_temp: array[0..SIZE - 1] of DWord;
    procedure InjectMsg(a_full_process: Boolean);
  protected
    procedure UpdateBlock(const AData); override;
  public
    constructor Create; override;
    procedure Init; override;
    procedure Final(var ADigest); override;
  end;

implementation

{ TrhlGrindahl256 }

procedure TrhlGrindahl256.InjectMsg(a_full_process: Boolean);
var
  u: array[0..SIZE - 1] of DWord;
begin
  m_state[SIZE - 1] := m_state[SIZE - 1] xor $01;

  if (a_full_process) then
  begin
    m_temp[0] :=
      s_table_0[Byte(m_state[12] shr 24)] xor
      s_table_1[Byte(m_state[11] shr 16)] xor
      s_table_2[Byte(m_state[9] shr 8)] xor
      s_table_3[Byte(m_state[3])];
  end;

  m_temp[1] :=
    s_table_0[Byte(m_state[0] shr 24)] xor
    s_table_1[Byte(m_state[12] shr 16)] xor
    s_table_2[Byte(m_state[10] shr 8)] xor
    s_table_3[Byte(m_state[4])];

  m_temp[2] :=
    s_table_0[Byte(m_state[1] shr 24)] xor
    s_table_1[Byte(m_state[0] shr 16)] xor
    s_table_2[Byte(m_state[11] shr 8)] xor
    s_table_3[Byte(m_state[5])];

  m_temp[3] :=
    s_table_0[Byte(m_state[2] shr 24)] xor
    s_table_1[Byte(m_state[1] shr 16)] xor
    s_table_2[Byte(m_state[12] shr 8)] xor
    s_table_3[Byte(m_state[6])];

  m_temp[4] :=
    s_table_0[Byte(m_state[3] shr 24)] xor
    s_table_1[Byte(m_state[2] shr 16)] xor
    s_table_2[Byte(m_state[0] shr 8)] xor
    s_table_3[Byte(m_state[7])];

  m_temp[5] :=
    s_table_0[Byte(m_state[4] shr 24)] xor
    s_table_1[Byte(m_state[3] shr 16)] xor
    s_table_2[Byte(m_state[1] shr 8)] xor
    s_table_3[Byte(m_state[8])];

  m_temp[6] :=
    s_table_0[Byte(m_state[5] shr 24)] xor
    s_table_1[Byte(m_state[4] shr 16)] xor
    s_table_2[Byte(m_state[2] shr 8)] xor
    s_table_3[Byte(m_state[9])];

  m_temp[7] :=
    s_table_0[Byte(m_state[6] shr 24)] xor
    s_table_1[Byte(m_state[5] shr 16)] xor
    s_table_2[Byte(m_state[3] shr 8)] xor
    s_table_3[Byte(m_state[10])];

  m_temp[8] :=
    s_table_0[Byte(m_state[7] shr 24)] xor
    s_table_1[Byte(m_state[6] shr 16)] xor
    s_table_2[Byte(m_state[4] shr 8)] xor
    s_table_3[Byte(m_state[11])];

  m_temp[9] :=
    s_table_0[Byte(m_state[8] shr 24)] xor
    s_table_1[Byte(m_state[7] shr 16)] xor
    s_table_2[Byte(m_state[5] shr 8)] xor
    s_table_3[Byte(m_state[12])];

  m_temp[10] :=
    s_table_0[Byte(m_state[9] shr 24)] xor
    s_table_1[Byte(m_state[8] shr 16)] xor
    s_table_2[Byte(m_state[6] shr 8)] xor
    s_table_3[Byte(m_state[0])];

  m_temp[11] :=
    s_table_0[Byte(m_state[10] shr 24)] xor
    s_table_1[Byte(m_state[9] shr 16)] xor
    s_table_2[Byte(m_state[7] shr 8)] xor
    s_table_3[Byte(m_state[1])];

  m_temp[12] :=
    s_table_0[Byte(m_state[11] shr 24)] xor
    s_table_1[Byte(m_state[10] shr 16)] xor
    s_table_2[Byte(m_state[8] shr 8)] xor
    s_table_3[Byte(m_state[2])];

  Move(m_temp, u, SizeOf(m_temp));
  Move(m_state, m_temp, SizeOf(m_state));
  Move(u, m_state, SizeOf(u));
end;

procedure TrhlGrindahl256.UpdateBlock(const AData);
var
  x: DWord absolute AData;
begin
  m_state[0] := SwapEndian(x);
  InjectMsg(false);
end;

constructor TrhlGrindahl256.Create;

  procedure CalcTable(i: Integer; var tab);
  var
    atab: array[0..0] of DWord absolute tab;
    j: Integer;
  begin
    for j := 0 to 255 do
      atab[j] := RorDWord(s_master_table[j], i*8);
  end;

begin
  HashSize := 32;
  BlockSize := 4;
  Move(s_master_table, s_table_0, SizeOf(s_master_table));

  CalcTable(1, s_table_1);
  CalcTable(2, s_table_2);
  CalcTable(3, s_table_3);
end;

procedure TrhlGrindahl256.Init;
begin
  inherited Init;
  FillChar(m_state, SizeOf(m_state), 0);
  FillChar(m_temp, SizeOf(m_temp), 0);
end;

procedure TrhlGrindahl256.Final(var ADigest);
var
  padding_size: DWord;
  msg_length: QWord;
  pad: TBytes;
  i: Integer;
begin
  padding_size := 3 * BlockSize - (FProcessedBytes mod BlockSize);
  msg_length := (FProcessedBytes div ROWS) + 1;

  SetLength(pad, padding_size);
  pad[0] := $80;

  msg_length := SwapEndian(msg_length);
  Move(msg_length, pad[padding_size-8], SizeOf(msg_length));
  UpdateBytes(pad[0], padding_size - BlockSize);

  Move(pad[padding_size - BlockSize], m_state[0], 4);
  m_state[0] := SwapEndian(m_state[0]);

  for i := 0 to BLANK_ROUNDS do
    InjectMsg(true);

  i := HashSize div ROWS;
  ConvertDWordsToBytesSwapOrder(m_state[COLUMNS - i], i, ADigest);
end;

end.
