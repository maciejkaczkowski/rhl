unit rhlRadioGatun64;

interface

uses
  rhlCore;

type

  { TrhlRadioGatun64 }

  TrhlRadioGatun64 = class(TrhlHash)
  private
    const
      MILL_SIZE = 19;
      BELT_WIDTH = 3;
      BELT_LENGTH = 13;
      NUMBER_OF_BLANK_ITERATIONS = 16;
    var
      m_mill: array[0..MILL_SIZE - 1] of QWord;
      m_belt: array[0..BELT_LENGTH - 1, 0..BELT_WIDTH - 1] of QWord;
    procedure RoundFunction;
  protected
    procedure UpdateBlock(const AData); override;
  public
    constructor Create; override;
    procedure Init; override;
    procedure Final(var ADigest); override;
  end;

implementation

{ TrhlRadioGatun64 }

procedure TrhlRadioGatun64.RoundFunction;
var
  i: Integer;
  q: array[0..BELT_WIDTH - 1] of QWord;
  a: array[0..MILL_SIZE - 1] of QWord;
begin
  Move(m_belt[BELT_LENGTH - 1], q, SizeOf(q));
  for i := BELT_LENGTH - 1 downto 0 do
    Move(m_belt[i - 1], m_belt[i], SizeOf(q));
  Move(q, m_belt[0], SizeOf(q));

  for i := 0 to 11 do
    m_belt[i + 1][i mod BELT_WIDTH] := m_belt[i + 1][i mod BELT_WIDTH] xor m_mill[i + 1];

  for i := 0 to MILL_SIZE - 1 do
    a[i] := m_mill[i] xor (m_mill[(i + 1) mod MILL_SIZE] or not m_mill[(i + 2) mod MILL_SIZE]);

  for i := 0 to MILL_SIZE - 1 do
    m_mill[i] := RorQWord(a[(7 * i) mod MILL_SIZE], i * (i + 1) div 2);

  for i := 0 to MILL_SIZE - 1 do
    a[i] := m_mill[i] xor m_mill[(i + 1) mod MILL_SIZE] xor m_mill[(i + 4) mod MILL_SIZE];

  a[0] := a[0] xor 1;
  for i := 0 to MILL_SIZE - 1 do
    m_mill[i] := a[i];

  for i := 0 to BELT_WIDTH - 1 do
    m_mill[i + 13] := m_mill[i + 13] xor q[i];
end;

procedure TrhlRadioGatun64.UpdateBlock(const AData);
var
  data: array[0..0] of QWord absolute AData;
  i: Integer;
begin
  for i := 0 to BELT_WIDTH - 1 do
  begin
    m_mill[i + 16] := m_mill[i + 16] xor data[i];
    m_belt[0][i] := m_belt[0][i] xor data[i];
  end;

  RoundFunction();
end;

constructor TrhlRadioGatun64.Create;
begin
  HashSize := 32;
  BlockSize := 8 * BELT_WIDTH;
end;

procedure TrhlRadioGatun64.Init;
begin
  inherited Init;
  FillChar(m_mill, SizeOf(m_mill), 0);
  FillChar(m_belt, SizeOf(m_belt), 0);
end;

procedure TrhlRadioGatun64.Final(var ADigest);
var
  padding_size: DWord;
  pad: TBytes;
  i: Integer;
begin
  padding_size := BlockSize - (FProcessedBytes mod BlockSize);

  SetLength(pad, padding_size);
  pad[0] := $01;
  UpdateBytes(pad[0], padding_size);

  for i := 0 to NUMBER_OF_BLANK_ITERATIONS - 1 do
    RoundFunction;

  SetLength(pad, HashSize);
  for i := 0 to (HashSize div 16) - 1 do
  begin
    RoundFunction();
    Move(m_mill[1], pad[i * 16], 16);
  end;
  Move(pad[0], ADigest, HashSize);
end;

end.
