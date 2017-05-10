unit rhlSHA384;

interface

uses
  rhlSHA512Base;

type

  { TrhlSHA384 }

  TrhlSHA384 = class(TrhlSHA512Base)
  public
    constructor Create; override;
    procedure Init; override;
  end;

implementation

constructor TrhlSHA384.Create;
begin
  inherited;
  HashSize := 48;
end;

procedure TrhlSHA384.Init;
begin
  inherited;
  m_state[0] := $cbbb9d5dc1059ed8;
  m_state[1] := $629a292a367cd507;
  m_state[2] := $9159015a3070dd17;
  m_state[3] := $152fecd8f70e5939;
  m_state[4] := $67332667ffc00b31;
  m_state[5] := $8eb44a8768581511;
  m_state[6] := $db0c2e0d64f98fa7;
  m_state[7] := $47b5481dbefa4fa4;
end;

end.
