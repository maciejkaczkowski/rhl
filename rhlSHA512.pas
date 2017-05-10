unit rhlSHA512;

interface

uses
  rhlSHA512Base;

type

  { TrhlSHA512 }

  TrhlSHA512 = class(TrhlSHA512Base)
  public
    constructor Create; override;
    procedure Init; override;
  end;

implementation

constructor TrhlSHA512.Create;
begin
  inherited;
  HashSize := 64;
end;

procedure TrhlSHA512.Init;
begin
  inherited;
  m_state[0] := $6a09e667f3bcc908;
  m_state[1] := $bb67ae8584caa73b;
  m_state[2] := $3c6ef372fe94f82b;
  m_state[3] := $a54ff53a5f1d36f1;
  m_state[4] := $510e527fade682d1;
  m_state[5] := $9b05688c2b3e6c1f;
  m_state[6] := $1f83d9abfb41bd6b;
  m_state[7] := $5be0cd19137e2179;
end;

end.
