unit rhlSHA224;

interface

uses
  rhlSHA256Base;

type

  { TrhlSHA224 }

  TrhlSHA224 = class(TrhlSHA256Base)
  public
    constructor Create; override;
    procedure Init; override;
  end;

implementation

constructor TrhlSHA224.Create;
begin
  inherited;
  HashSize := 28;
end;

procedure TrhlSHA224.Init;
begin
  inherited;
  m_state[0] := $c1059ed8;
  m_state[1] := $367cd507;
  m_state[2] := $3070dd17;
  m_state[3] := $f70e5939;
  m_state[4] := $ffc00b31;
  m_state[5] := $68581511;
  m_state[6] := $64f98fa7;
  m_state[7] := $befa4fa4;
end;

end.
