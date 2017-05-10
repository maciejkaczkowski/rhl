unit rhlMDBase;

interface

uses
  rhlCore, sysutils;

type

  { TrhlMDBase }

  TrhlMDBase = class abstract(TrhlHash)
  protected
    FH: array of DWord;
    const FC: array[1..8] of DWord =
      ($50a28be6, $5a827999, $5c4dd124, $6ed9eba1,
       $6d703ef3, $8f1bbcdc, $7a6d76e9, $a953fd4e);
  public
    constructor Create; override;
    procedure Init; override;
    procedure Final(var ADigest); override;
  end;

implementation

{ TrhlMDBase  }

constructor TrhlMDBase.Create;
begin
  HashSize := 16;
  BlockSize := 64;
end;

procedure TrhlMDBase.Init;
begin
  inherited;
  SetLength(FH, HashSize div SizeOf(DWord));
  FH[0] := $67452301;
  FH[1] := $EFCDAB89;
  FH[2] := $98BADCFE;
  FH[3] := $10325476;
end;

procedure TrhlMDBase.Final(var ADigest);
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
  Move(FH[0], ADigest, Length(FH) * SizeOf(DWord));
end;

end.
