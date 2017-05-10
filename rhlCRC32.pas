unit rhlCRC32;

interface

uses
  rhlCore;

type

  { TrhlCRC32 }

  TrhlCRC32 = class abstract(TrhlHash)
  private
    m_crc_tab: array[0..255] of DWord;
    m_poly,
    m_hash,
    m_initial_value,
    m_final_xor: DWord;
  protected
    procedure UpdateBytes(const ABuffer; ASize: LongWord); override;
    procedure GenerateCRCTable(poly: DWord);
  public
    constructor Create; override;
    procedure Init; override;
    procedure Final(var ADigest); override;
  end;

  { TrhlCRC32_IEEE_802_3 }

  TrhlCRC32_IEEE_802_3 = class(TrhlCRC32)
  public
    constructor Create; override;
  end;

  { TrhlCRC32_Castagnoli }

  TrhlCRC32_Castagnoli = class(TrhlCRC32)
  public
    constructor Create; override;
  end;

  { TrhlCRC32_Koopman }

  TrhlCRC32_Koopman = class(TrhlCRC32)
  public
    constructor Create; override;
  end;

  { TrhlCRC32_Q }

  TrhlCRC32_Q = class(TrhlCRC32)
  public
    constructor Create; override;
  end;

implementation

{ TrhlCRC32_Q }

constructor TrhlCRC32_Q.Create;
begin
  m_poly := $D5828281;
  inherited Create;
end;

{ TrhlCRC32_Koopman }

constructor TrhlCRC32_Koopman.Create;
begin
  m_poly := $EB31D82E;
  inherited Create;
end;

{ TrhlCRC32_Castagnoli }

constructor TrhlCRC32_Castagnoli.Create;
begin
  m_poly := $82F63B78;
  inherited Create;
end;

{ TrhlCRC32_IEEE_802_3 }

constructor TrhlCRC32_IEEE_802_3.Create;
begin
  m_poly := $EDB88320;
  inherited Create;
end;

{ TrhlCRC32 }

procedure TrhlCRC32.UpdateBytes(const ABuffer; ASize: LongWord);
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

procedure TrhlCRC32.GenerateCRCTable(poly: DWord);
var
  i, j: DWord;
  crc: DWord;
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

constructor TrhlCRC32.Create;
begin
  HashSize := 4;
  BlockSize := 1;
  m_initial_value := High(DWord);
  m_final_xor := High(DWord);
  GenerateCRCTable(m_poly);
end;

procedure TrhlCRC32.Init;
begin
  inherited Init;
  m_hash := m_initial_value;
end;

procedure TrhlCRC32.Final(var ADigest);
var
  x: DWord;
begin
  x := m_hash xor m_final_xor;
  Move(x, ADigest, 4);
end;

end.
