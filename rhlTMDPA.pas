unit rhlTMDPA;

interface

uses
  rhlCore;

type

  { TrhlTMDPA }

  TrhlTMDPA = class(TrhlHash)
  private
    type
      T128Bit = array[0..3] of DWord;
      T256Bit = array[0..7] of DWord;
      TBlock1024 = array[0..127] of Byte;
      TKeys = record
        idx: Integer;
        case Byte of
          0: (KeyAsDWord: array[0..3] of DWord);
          1: (Key: array[0..15] of Byte);
      end;
    var
      DigestIndex: longint;
      Digest: array[0..255] of Byte;
      FKeys: TKeys;
    procedure calc_tab_ebx(const key_128: T128Bit; var o: TBlock1024);
    procedure Mix256xR(R: LongInt; var X: T256Bit);
    procedure PAMix(const Key: TBlock1024; R: LongInt; var X);
  protected
    procedure UpdateBytes(const ABuffer; ASize: LongWord); override;
  public
    constructor Create; override;
    procedure Init; override;
    procedure Final(var ADigest); override;
  end;

implementation

const
  Pi2048: array [0..255] of byte = (
    $24,$3F,$6A,$88,$85,$A3,$08,$D3,$13,$19,$8A,$2E,$03,$70,$73,$44,
    $A4,$09,$38,$22,$29,$9F,$31,$D0,$08,$2E,$FA,$98,$EC,$4E,$6C,$89,
    $45,$28,$21,$E6,$38,$D0,$13,$77,$BE,$54,$66,$CF,$34,$E9,$0C,$6C,
    $C0,$AC,$29,$B7,$C9,$7C,$50,$DD,$3F,$84,$D5,$B5,$B5,$47,$09,$17,
    $92,$16,$D5,$D9,$89,$79,$FB,$1B,$D1,$31,$0B,$A6,$98,$DF,$B5,$AC,
    $2F,$FD,$72,$DB,$D0,$1A,$DF,$B7,$B8,$E1,$AF,$ED,$6A,$26,$7E,$96,
    $BA,$7C,$90,$45,$F1,$2C,$7F,$99,$24,$A1,$99,$47,$B3,$91,$6C,$F7,
    $08,$01,$F2,$E2,$85,$8E,$FC,$16,$63,$69,$20,$D8,$71,$57,$4E,$69,
    $A4,$58,$FE,$A3,$F4,$93,$3D,$7E,$0D,$95,$74,$8F,$72,$8E,$B6,$58,
    $71,$8B,$CD,$58,$82,$15,$4A,$EE,$7B,$54,$A4,$1D,$C2,$5A,$59,$B5,
    $9C,$30,$D5,$39,$2A,$F2,$60,$13,$C5,$D1,$B0,$23,$28,$60,$85,$F0,
    $CA,$41,$79,$18,$B8,$DB,$38,$EF,$8E,$79,$DC,$B0,$60,$3A,$18,$0E,
    $6C,$9E,$0E,$8B,$B0,$1E,$8A,$3E,$D7,$15,$77,$C1,$BD,$31,$4B,$27,
    $78,$AF,$2F,$DA,$55,$60,$5C,$60,$E6,$55,$25,$F3,$AA,$55,$AB,$94,
    $57,$48,$98,$62,$63,$E8,$14,$40,$55,$CA,$39,$6A,$2A,$AB,$10,$B6,
    $B4,$CC,$5C,$34,$11,$41,$E8,$CE,$A1,$54,$86,$AF,$7C,$72,$E9,$93);

{ TrhlTMDPA }

procedure TrhlTMDPA.UpdateBytes(const ABuffer; ASize: LongWord);
var
  BufBytes: array[0..0] of Byte absolute ABuffer;
  AA, BB: longint;
  CC, DD: longint;
  I, R: longint;
begin
  for I := 0 to ASize - 1 do
    begin
      {update Digest}
      Digest[DigestIndex] := Digest[DigestIndex] xor BufBytes[I];
      Inc(DigestIndex);
      if (DigestIndex = SizeOf(Digest)) then
        DigestIndex := 0;
      {update BlockKey}
      FKeys.key[FKeys.idx] := FKeys.key[FKeys.idx] xor BufBytes[I];
      Inc(FKeys.idx);
      if (FKeys.idx = SizeOf(FKeys.key) div 2) then
      begin
        AA := FKeys.KeyAsDWord[3];
        BB := FKeys.KeyAsDWord[2];
        CC := FKeys.KeyAsDWord[1];
        DD := FKeys.KeyAsDWord[0];
        {mix all the bits around for 4 rounds}
        {achieves avalanche and eliminates funnels}
        for R := 0 to 3 do
        begin
          AA := AA + DD;
          DD := DD + AA;
          AA := AA xor (AA shr 7);
          BB := BB + AA;
          AA := AA + BB;
          BB := BB xor (BB shl 13);
          CC := CC + BB;
          BB := BB + CC;
          CC := CC xor (CC shr 17);
          DD := DD + CC;
          CC := CC + DD;
          DD := DD xor (DD shl 9);
          AA := AA + DD;
          DD := DD + AA;
          AA := AA xor (AA shr 3);
          BB := BB + AA;
          AA := AA + BB;
          BB := BB xor (BB shl 7);
          CC := CC + BB;
          BB := BB + CC;
          CC := CC xor (DD shr 15);
          DD := DD + CC;
          CC := CC + DD;
          DD := DD xor (DD shl 11);
        end;
        FKeys.KeyAsDWord[0] := AA;
        FKeys.KeyAsDWord[1] := BB;
        FKeys.KeyAsDWord[2] := CC;
        FKeys.KeyAsDWord[3] := DD;
        FKeys.idx := 0;
      end;
    end;
end;

constructor TrhlTMDPA.Create;
begin
  HashSize := 16;
  BlockSize := 256;
end;

procedure TrhlTMDPA.Init;
begin
  inherited Init;
  DigestIndex := 0;
  Move(Pi2048, Digest, SizeOf(Digest));
  FKeys.idx := 0;
  FillChar(FKeys.key, SizeOf(FKeys.key), $55);
end;

procedure TrhlTMDPA.calc_tab_ebx(const key_128: T128Bit; var o: TBlock1024);
const
  key_const: T128Bit = ($55555555, $aaaaaaaa, $33333333, $cccccccc);
var
  key_256: T256Bit;
  i, j: Integer;
begin
  j := 0;
  for i := 0 to 3 do
  begin
    key_256[0] := key_128[0];
    key_256[2] := key_128[1];
    key_256[4] := key_128[2];
    key_256[6] := key_128[3];
    key_256[1] := key_const[i];
    key_256[3] := key_const[i];
    key_256[5] := key_const[i];
    key_256[7] := key_const[i];
    Mix256xR(8, key_256);
    Move(key_256, o[j], 32);
    Inc(j, 32);
  end;
(*
  $34,$8B,$4E,$EB,$13,$75,$F1,$3B,$ED,$7D,$FA,$BA,$09,$8C,$1D,$0A,
  $D1,$B7,$7D,$D9,$88,$E8,$75,$E4,$03,$81,$CF,$41,$3C,$E6,$98,$9D,

  $C9,$76,$55,$9A,$0C,$E1,$55,$83,$30,$02,$D2,$32,$9B,$BC,$A2,$5A,
  $B5,$73,$4F,$54,$F8,$36,$CF,$43,$5A,$D8,$30,$D7,$61,$2F,$55,$52,

  $F0,$9A,$74,$99,$24,$30,$04,$E4,$9E,$E8,$D4,$81,$5D,$E7,$C2,$CA,
  $74,$D0,$A0,$BA,$BF,$5A,$4D,$63,$FE,$34,$F6,$4C,$8E,$B6,$F4,$E0,

  $F8,$B9,$88,$34,$6F,$3C,$34,$AF,$B5,$72,$3C,$A9,$16,$BA,$F2,$C9,
  $D4,$8B,$C7,$93,$4D,$F5,$E9,$D8,$E3,$54,$B8,$A1,$9A,$28,$65,$85
*)
end;

procedure TrhlTMDPA.Mix256xR(R : LongInt; var X : T256Bit);
var
  I              : LongInt;
  AA, BB, CC, DD : LongInt;
  EE, FF, GG, HH : LongInt;
begin
  AA := X[0];  BB := X[1];  CC := X[2];  DD := X[3];
  EE := X[4];  FF := X[5];  GG := X[6];  HH := X[7];

  //5b 0a e5 a9 55 55 55 55
  //AC 11 90 37 55 55 55 55
  //e3 c9 3a 34 55 55 55 55
  //1e 57 98 2a 55 55 55 55

  for I := 0 to R - 1 do
  begin
    AA := AA xor (BB shl 11); // BB=55 55 55 55 xor AA=5b 0a e5 a9
    DD := DD + AA;            // DD=55 55 55 55
    BB := BB + CC;
    BB := BB xor (CC shr 2);  // CC=AC 11 90 37
    EE := EE + BB;            // EE=e3 c9 3a 34
    CC := CC + DD;
    CC := CC xor (DD shl 8);
    FF := FF + CC;            // FF=55 55 55 55
    DD := DD + EE;
    DD := DD xor (EE shr 16);
    GG := GG + DD;            // GG=1e 57 98 2a
    EE := EE + FF;
    EE := EE xor (FF shl 10);
    HH := HH + EE;            // HH=55 55 55 55
    FF := FF + GG;
    FF := FF xor (GG shr 4);
    AA := AA + FF;
    GG := GG + HH;
    GG := GG xor (HH shl 8);
    BB := BB + GG;
    HH := HH + AA;
    HH := HH xor (AA shr 9);
    CC := CC + HH;
    AA := AA + BB;
  end;

  X[0] := AA;  X[1] := BB;  X[2] := CC;  X[3] := DD;
  X[4] := EE;  X[5] := FF;  X[6] := GG;  X[7] := HH;
end;

procedure TrhlTMDPA.PAMix(const Key: TBlock1024; R: LongInt; var X);
var
  XX: array[0..0] of DWord absolute X;
  KK: array[0..0] of DWord absolute Key;
  AA, BB, CC, DD: DWord;
  edx, ecx, eax: DWord;
  edi, esi: DWord;
  i, j: Integer;
begin
  AA := XX[0];
  BB := XX[1];
  CC := XX[2];
  DD := XX[3];
  j := 0;
  repeat
    edx := AA;
    ecx := KK[j];
    esi := BB;
    eax := KK[j+1];
    for i := 0 to 1 do
    begin
      Inc(edx, eax);
      Inc(eax, edx);
      edx := edx xor (edx shr 7);
      Inc(ecx, edx);
      Inc(edx, ecx);
      ecx := ecx xor (ecx shl 13);
      Inc(esi, ecx);
      Inc(ecx, esi);
      esi := esi xor (esi shr 17);
      Inc(eax, esi);
      Inc(esi, eax);
      eax := eax xor (eax shl 9);
      Inc(edx, eax);
      Inc(eax, edx);
      edx := edx xor (edx shr 3);
      Inc(ecx, edx);
      Inc(edx, ecx);
      ecx := ecx xor (ecx shl 7);
      Inc(esi, ecx);
      Inc(ecx, esi);
      esi := esi xor (eax shr 15);
      Inc(eax, esi);
      Inc(esi, eax);
      if (i = 0) then
      begin
        edi := edx;
        edx := esi;
        esi := edi;
        edi := ecx;
        ecx := eax xor (eax shl 11);
        eax := edi;
      end
      else
      begin
        edx := ecx xor (edx xor CC);
        esi := (eax xor (eax shl 11)) xor (esi xor DD);
        CC := AA;
        DD := BB;
        AA := edx;
        BB := esi;
      end;
    end;
    Inc(j, 2);
    Dec(R);
  until R = 0;
  XX[0] := CC;
  XX[1] := DD;
  XX[2] := AA;
  XX[3] := BB;
end;

procedure TrhlTMDPA.Final(var ADigest);
const
  Padding: array [0..7] of Byte = (1, 0, 0, 0, 0, 0, 0, 0);
var
  I: Integer;
  key: T128Bit;
  block: TBlock1024;
begin
  {pad with "1", followed by as many "0"s as needed to fill the block}
  UpdateBytes(Padding, SizeOf(Padding) - FKeys.idx);

  Move(FKeys.key[0], key, SizeOf(FKeys.key));
  calc_tab_ebx(key, block);

  {mix each block within Context with the key}
  for I := 0 to (SizeOf(Digest) div 16) - 1 do
    PAMix(block, 8, PByte(@Digest[I * 16])^);

  i := SizeOf(Digest);
  if HashSize < i then
    i := HashSize;

  {return Digest of requested DigestSize}
  {max digest is 2048-bit, although it could be greater if Pi2048 was larger}
  Move(Digest, ADigest, i);
end;

end.
