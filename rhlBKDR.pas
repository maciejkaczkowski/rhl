unit rhlBKDR;

interface

uses
  rhlCore;

type

  { TrhlBKDR }

  TrhlBKDR = class(TrhlHash)
  private
    m_hash: DWord;
  protected
    procedure UpdateBytes(const ABuffer; ASize: LongWord); override;
  public
    constructor Create; override;
    procedure Init; override;
    procedure Final(var ADigest); override;
  end;

implementation

{ TrhlBKDR }

procedure TrhlBKDR.UpdateBytes(const ABuffer; ASize: LongWord);
var
  b: PByte;
begin
  b := @ABuffer;
  while ASize > 0 do
  begin
    m_hash := (m_hash * 131) + b^;
    Inc(b);
    Dec(ASize);
  end;
end;

constructor TrhlBKDR.Create;
begin
  HashSize := 4;
  BlockSize := 1;
end;

procedure TrhlBKDR.Init;
begin
  inherited Init;
  m_hash := 0;
end;

procedure TrhlBKDR.Final(var ADigest);
begin
  Move(m_hash, ADigest, 4);
end;

end.
