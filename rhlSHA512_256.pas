unit rhlSHA512_256;

interface

uses
  rhlSHA512Base;

type

  { TrhlSHA512_256 }

  TrhlSHA512_256 = class(TrhlSHA512Base)
  public
    constructor Create; override;
    procedure Init; override;
  end;

implementation

constructor TrhlSHA512_256.Create;
begin
  inherited;
  HashSize := 32;
end;

procedure TrhlSHA512_256.Init;
begin
  inherited;
  m_state[0] := $22312194FC2BF72C;
  m_state[1] := $9F555FA3C84C64C2;
  m_state[2] := $2393B86B6F53B151;
  m_state[3] := $963877195940EABD;
  m_state[4] := $96283EE2A88EFFE3;
  m_state[5] := $BE5E1E2553863992;
  m_state[6] := $2B0199FC2C85B8AA;
  m_state[7] := $0EB72DDC81C52CA2;
end;

end.
