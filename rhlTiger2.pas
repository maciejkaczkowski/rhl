unit rhlTiger2;

interface

uses
  rhlCore, rhlTiger;

type

  { TrhlTiger2 }

  TrhlTiger2 = class(TrhlTiger)
  public
    constructor Create; override;
    procedure Final(var ADigest); override;
  end;

implementation


{ TrhlTiger2 }

constructor TrhlTiger2.Create;
begin
  inherited;
  FPadding := $80;
end;

procedure TrhlTiger2.Final(var ADigest);
begin
  inherited;
  Move(m_hash, ADigest, HashSize);
end;

end.
