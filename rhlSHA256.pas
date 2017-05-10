unit rhlSHA256;

interface

uses
  rhlSHA256Base;

type

  { TrhlSHA256 }

  TrhlSHA256 = class(TrhlSHA256Base)
  public
    constructor Create; override;
    procedure Init; override;
  end;

implementation

constructor TrhlSHA256.Create;
begin
  inherited;
  HashSize := 32;
end;

procedure TrhlSHA256.Init;
begin
  inherited;
  m_state[0] := $6a09e667;
  m_state[1] := $bb67ae85;
  m_state[2] := $3c6ef372;
  m_state[3] := $a54ff53a;
  m_state[4] := $510e527f;
  m_state[5] := $9b05688c;
  m_state[6] := $1f83d9ab;
  m_state[7] := $5be0cd19;
end;

end.
