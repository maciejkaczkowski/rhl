unit rhlCRC64;

interface

uses
  rhlCore;

type

  { TrhlCRC64 }

  TrhlCRC64 = class abstract(TrhlHash)
  private
    m_crc_tab: array[0..255] of QWord;
    m_poly,
    m_hash,
    m_initial_value,
    m_final_xor: QWord;
  protected
    procedure UpdateBytes(const ABuffer; ASize: LongWord); override;
    procedure GenerateCRCTable(poly: QWord);
  public
    constructor Create; override;
    procedure Init; override;
    procedure Final(var ADigest); override;
  end;

  { TrhlCRC64_ISO }

  TrhlCRC64_ISO = class(TrhlCRC64)
  public
    constructor Create; override;
  end;

  { TrhlCRC64_ECMA182 }

  TrhlCRC64_ECMA182 = class(TrhlCRC64)
  public
    constructor Create; override;
  end;

implementation

{ TrhlCRC64_ECMA182 }

constructor TrhlCRC64_ECMA182.Create;
begin
  m_poly := $C96C5795D7870F42;
  inherited Create;
end;

{ TrhlCRC64_ISO }

constructor TrhlCRC64_ISO.Create;
begin
  m_poly := $D800000000000000;
  inherited Create;
end;

{ TrhlCRC64 }

procedure TrhlCRC64.UpdateBytes(const ABuffer; ASize: LongWord);
var
  b: PByte;
begin
  b := @ABuffer;
  while ASize > 0 do
  begin
    m_hash := (m_hash shr 8) xor m_crc_tab[($ff and m_hash) xor b^];
    Inc(b);
    Dec(ASize);
  end;
end;

procedure TrhlCRC64.GenerateCRCTable(poly: QWord);
var
  i, j: DWord;
  crc: QWord;
begin
  for i := 0 to 255 do
  begin
    crc := i;

    for j := 0 to 7 do
    begin
      if ((crc and 1) = 1) then
        crc := (crc shr 1) xor poly
      else
        crc := crc shr 1;
    end;

    m_crc_tab[i] := crc;
  end;
end;

constructor TrhlCRC64.Create;
begin
  HashSize := 8;
  BlockSize := 1;
  m_initial_value := High(QWord);
  m_final_xor := High(QWord);
  GenerateCRCTable(m_poly);
end;

procedure TrhlCRC64.Init;
begin
  inherited Init;
  m_hash := m_initial_value;
end;

procedure TrhlCRC64.Final(var ADigest);
var
  x: QWord;
begin
  x := m_hash xor m_final_xor;
  Move(x, ADigest, 8);
end;

end.
