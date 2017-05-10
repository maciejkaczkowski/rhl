unit rhlSHA1;

interface

uses
  rhlSHA0;

type

  { TrhlSHA1 }

  TrhlSHA1 = class(TrhlSHA0)
  protected
    procedure Expand(var W: TBF); override;
  end;

implementation

{ TrhlSHA1 }

procedure TrhlSHA1.Expand(var W: TBF);
var
  j: DWord;
begin
  for j:= 16 to 79 do
    W[j]:= ((W[j-3] xor W[j-8] xor W[j-14] xor W[j-16]) shl 1) or
           ((W[j-3] xor W[j-8] xor W[j-14] xor W[j-16]) shr 31);
end;

end.
