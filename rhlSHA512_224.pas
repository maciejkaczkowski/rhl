unit rhlSHA512_224;

interface

uses
  rhlSHA512Base;

type

  { TrhlSHA512_224 }

  TrhlSHA512_224 = class(TrhlSHA512Base)
  public
    constructor Create; override;
    procedure Init; override;
  end;

implementation

constructor TrhlSHA512_224.Create;
begin
  inherited;
  HashSize := 28;
end;

procedure TrhlSHA512_224.Init;
begin
  inherited;
  m_state[0] := $8C3D37C819544DA2;
  m_state[1] := $73E1996689DCD4D6;
  m_state[2] := $1DFAB7AE32FF9C82;
  m_state[3] := $679DD514582F9FCF;
  m_state[4] := $0F6D2B697BD44DA8;
  m_state[5] := $77E36F7304C48942;
  m_state[6] := $3F9D85A86A1D36C8;
  m_state[7] := $1112E6AD91D692A1;
end;

end.
