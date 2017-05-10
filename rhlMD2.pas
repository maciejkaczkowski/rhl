unit rhlMD2;

interface

uses
  rhlCore, SysUtils;

type

  { TrhlMD2 }

  TrhlMD2 = class(TrhlHash)
  private
    FStates: TBytes;
    FChecksum: TBytes;
  protected
    procedure UpdateBlock(const AData); override;
  public
    constructor Create; override;
    procedure Init; override;
    procedure Final(var ADigest); override;
  end;

implementation

{ TrhlMD2 }

const
  PI_TAB: array[0..255] of byte = (
    $29,$2E,$43,$C9,$A2,$D8,$7C,$01,$3D,$36,$54,$A1,$EC,$F0,$06,$13,
    $62,$A7,$05,$F3,$C0,$C7,$73,$8C,$98,$93,$2B,$D9,$BC,$4C,$82,$CA,
    $1E,$9B,$57,$3C,$FD,$D4,$E0,$16,$67,$42,$6F,$18,$8A,$17,$E5,$12,
    $BE,$4E,$C4,$D6,$DA,$9E,$DE,$49,$A0,$FB,$F5,$8E,$BB,$2F,$EE,$7A,
    $A9,$68,$79,$91,$15,$B2,$07,$3F,$94,$C2,$10,$89,$0B,$22,$5F,$21,
    $80,$7F,$5D,$9A,$5A,$90,$32,$27,$35,$3E,$CC,$E7,$BF,$F7,$97,$03,
    $FF,$19,$30,$B3,$48,$A5,$B5,$D1,$D7,$5E,$92,$2A,$AC,$56,$AA,$C6,
    $4F,$B8,$38,$D2,$96,$A4,$7D,$B6,$76,$FC,$6B,$E2,$9C,$74,$04,$F1,
    $45,$9D,$70,$59,$64,$71,$87,$20,$86,$5B,$CF,$65,$E6,$2D,$A8,$02,
    $1B,$60,$25,$AD,$AE,$B0,$B9,$F6,$1C,$46,$61,$69,$34,$40,$7E,$0F,
    $55,$47,$A3,$23,$DD,$51,$AF,$3A,$C3,$5C,$F9,$CE,$BA,$C5,$EA,$26,
    $2C,$53,$0D,$6E,$85,$28,$84,$09,$D3,$DF,$CD,$F4,$41,$81,$4D,$52,
    $6A,$DC,$37,$C8,$6C,$C1,$AB,$FA,$24,$E1,$7B,$08,$0C,$BD,$B1,$4A,
    $78,$88,$95,$8B,$E3,$63,$E8,$6D,$E9,$CB,$D5,$FE,$3B,$00,$1D,$39,
    $F2,$EF,$B7,$0E,$66,$58,$D0,$E4,$A6,$77,$72,$F8,$EB,$75,$4B,$0A,
    $31,$44,$50,$B4,$8F,$ED,$1F,$1A,$DB,$99,$8D,$33,$9F,$11,$83,$14);

procedure TrhlMD2.UpdateBlock(const AData);
var
  Data: array[0..15] of byte absolute AData;
  temp: TBytes;
  i, j, t: DWord;
begin
  SetLength(temp, 48);

  Move(FStates[0], temp[0], 16);
  Move(Data[0], temp[16], 16);

  for i := 0 to 15 do
    temp[i + 32] := FStates[i] xor Data[i];

  t := 0;
  for i := 0 to 17 do
  begin
    for j := 0 to 47 do
    begin
      temp[j] := temp[j] xor PI_TAB[t];
      t := temp[j];
    end;
    t := (t + DWord(i)) and $FF;
  end;

  Move(temp[0], FStates[0], 16);

  t := FChecksum[15];
  for i := 0 to BlockSize - 1 do
  begin
    FChecksum[i] := FChecksum[i] xor PI_TAB[Data[i] xor t];
    t := FChecksum[i];
  end;
end;

constructor TrhlMD2.Create;
begin
  HashSize := 16;
  BlockSize := 16;
  SetLength(FStates, 16);
  SetLength(FChecksum, 16);
end;

procedure TrhlMD2.Init;
begin
  inherited Init;
  FillChar(FStates[0], Length(FStates), 0);
  FillChar(FChecksum[0], Length(FChecksum), 0);
end;

procedure TrhlMD2.Final(var ADigest);
var
  padLen: DWord;
  pad: TBytes;
  i: integer;
begin
  padLen := 16 - FBuffer.Pos;
  SetLength(pad, padLen);

  for i := 0 to padLen - 1 do
    pad[i] := padLen;

  UpdateBytes(pad[0], padLen);
  UpdateBytes(FChecksum[0], 16);

  Move(FStates[0], ADigest, Length(FStates));
end;

end.
