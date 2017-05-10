unit rhlPanama;

interface

uses
  rhlCore;

type

  { TrhlPanama }

  TrhlPanama = class(TrhlHash)
  private
    const COLUMNS = 17;
    var m_state: array[0..COLUMNS - 1] of DWord;
    var m_stages: array[0..31, 0..7] of DWord;
    var m_tap: Integer;
    procedure GPT(var atheta);
  protected
    procedure UpdateBlock(const AData); override;
  public
    constructor Create; override;
    procedure Init; override;
    procedure Final(var ADigest); override;
  end;

implementation

{ TrhlPanama }

procedure TrhlPanama.GPT(var atheta);
var
  theta: array[0..0] of DWord absolute atheta;
  gamma: array[0..COLUMNS - 1] of DWord;
  pi: array[0..COLUMNS - 1] of DWord;
begin
  gamma[0] := m_state[0] xor (m_state[1] or not m_state[2]);
  gamma[1] := m_state[1] xor (m_state[2] or not m_state[3]);
  gamma[2] := m_state[2] xor (m_state[3] or not m_state[4]);
  gamma[3] := m_state[3] xor (m_state[4] or not m_state[5]);
  gamma[4] := m_state[4] xor (m_state[5] or not m_state[6]);
  gamma[5] := m_state[5] xor (m_state[6] or not m_state[7]);
  gamma[6] := m_state[6] xor (m_state[7] or not m_state[8]);
  gamma[7] := m_state[7] xor (m_state[8] or not m_state[9]);
  gamma[8] := m_state[8] xor (m_state[9] or not m_state[10]);
  gamma[9] := m_state[9] xor (m_state[10] or not m_state[11]);
  gamma[10] := m_state[10] xor (m_state[11] or not m_state[12]);
  gamma[11] := m_state[11] xor (m_state[12] or not m_state[13]);
  gamma[12] := m_state[12] xor (m_state[13] or not m_state[14]);
  gamma[13] := m_state[13] xor (m_state[14] or not m_state[15]);
  gamma[14] := m_state[14] xor (m_state[15] or not m_state[16]);
  gamma[15] := m_state[15] xor (m_state[16] or not m_state[0]);
  gamma[16] := m_state[16] xor (m_state[0] or not m_state[1]);

  pi[0] := gamma[0];
  pi[1] := RolDWord(gamma[7], 1);
  pi[2] := RolDWord(gamma[14], 3);
  pi[3] := RolDWord(gamma[4], 6);
  pi[4] := RolDWord(gamma[11], 10);
  pi[5] := RolDWord(gamma[1], 15);
  pi[6] := RolDWord(gamma[8], 21);
  pi[7] := RolDWord(gamma[15], 28);
  pi[8] := RolDWord(gamma[5], 4);
  pi[9] := RolDWord(gamma[12], 13);
  pi[10] := RolDWord(gamma[2], 23);
  pi[11] := RolDWord(gamma[9], 2);
  pi[12] := RolDWord(gamma[16], 14);
  pi[13] := RolDWord(gamma[6], 27);
  pi[14] := RolDWord(gamma[13], 9);
  pi[15] := RolDWord(gamma[3], 24);
  pi[16] := RolDWord(gamma[10], 8);

  theta[0] := pi[0] xor pi[1] xor pi[4];
  theta[1] := pi[1] xor pi[2] xor pi[5];
  theta[2] := pi[2] xor pi[3] xor pi[6];
  theta[3] := pi[3] xor pi[4] xor pi[7];
  theta[4] := pi[4] xor pi[5] xor pi[8];
  theta[5] := pi[5] xor pi[6] xor pi[9];
  theta[6] := pi[6] xor pi[7] xor pi[10];
  theta[7] := pi[7] xor pi[8] xor pi[11];
  theta[8] := pi[8] xor pi[9] xor pi[12];
  theta[9] := pi[9] xor pi[10] xor pi[13];
  theta[10] := pi[10] xor pi[11] xor pi[14];
  theta[11] := pi[11] xor pi[12] xor pi[15];
  theta[12] := pi[12] xor pi[13] xor pi[16];
  theta[13] := pi[13] xor pi[14] xor pi[0];
  theta[14] := pi[14] xor pi[15] xor pi[1];
  theta[15] := pi[15] xor pi[16] xor pi[2];
  theta[16] := pi[16] xor pi[0] xor pi[3];
end;

procedure TrhlPanama.UpdateBlock(const AData);
var
  work_buffer: array[0..0] of DWord absolute AData;
  theta: array[0..COLUMNS - 1] of DWord;
  tap16, tap25: Integer;
begin
  tap16 := (m_tap + 16) and $1F;

  m_tap := (m_tap - 1) and $1F;
  tap25 := (m_tap + 25) and $1F;

  GPT(theta);

  m_stages[tap25, 0] := m_stages[tap25, 0] xor m_stages[m_tap, 2];
  m_stages[tap25, 1] := m_stages[tap25, 1] xor m_stages[m_tap, 3];
  m_stages[tap25, 2] := m_stages[tap25, 2] xor m_stages[m_tap, 4];
  m_stages[tap25, 3] := m_stages[tap25, 3] xor m_stages[m_tap, 5];
  m_stages[tap25, 4] := m_stages[tap25, 4] xor m_stages[m_tap, 6];
  m_stages[tap25, 5] := m_stages[tap25, 5] xor m_stages[m_tap, 7];
  m_stages[tap25, 6] := m_stages[tap25, 6] xor m_stages[m_tap, 0];
  m_stages[tap25, 7] := m_stages[tap25, 7] xor m_stages[m_tap, 1];
  m_stages[m_tap, 0] := m_stages[m_tap, 0] xor work_buffer[0];
  m_stages[m_tap, 1] := m_stages[m_tap, 1] xor work_buffer[1];
  m_stages[m_tap, 2] := m_stages[m_tap, 2] xor work_buffer[2];
  m_stages[m_tap, 3] := m_stages[m_tap, 3] xor work_buffer[3];
  m_stages[m_tap, 4] := m_stages[m_tap, 4] xor work_buffer[4];
  m_stages[m_tap, 5] := m_stages[m_tap, 5] xor work_buffer[5];
  m_stages[m_tap, 6] := m_stages[m_tap, 6] xor work_buffer[6];
  m_stages[m_tap, 7] := m_stages[m_tap, 7] xor work_buffer[7];

  m_state[0] := theta[0] xor $01;
  m_state[1] := theta[1] xor work_buffer[0];
  m_state[2] := theta[2] xor work_buffer[1];
  m_state[3] := theta[3] xor work_buffer[2];
  m_state[4] := theta[4] xor work_buffer[3];
  m_state[5] := theta[5] xor work_buffer[4];
  m_state[6] := theta[6] xor work_buffer[5];
  m_state[7] := theta[7] xor work_buffer[6];
  m_state[8] := theta[8] xor work_buffer[7];
  m_state[9] := theta[9] xor m_stages[tap16, 0];
  m_state[10] := theta[10] xor m_stages[tap16, 1];
  m_state[11] := theta[11] xor m_stages[tap16, 2];
  m_state[12] := theta[12] xor m_stages[tap16, 3];
  m_state[13] := theta[13] xor m_stages[tap16, 4];
  m_state[14] := theta[14] xor m_stages[tap16, 5];
  m_state[15] := theta[15] xor m_stages[tap16, 6];
  m_state[16] := theta[16] xor m_stages[tap16, 7];
end;

constructor TrhlPanama.Create;
begin
  HashSize := 32;
  BlockSize := 32;
end;

procedure TrhlPanama.Init;
begin
  inherited Init;
  FillChar(m_stages, SizeOf(m_stages), 0);
  FillChar(m_state, SizeOf(m_state), 0);
  m_tap := 0;
end;

procedure TrhlPanama.Final(var ADigest);
var
  padding_size: Integer;
  pad: TBytes;
  theta: array[0..COLUMNS - 1] of DWord;
  tap4, tap16, tap25: Integer;
  i: Integer;
begin
  padding_size := BlockSize - (FProcessedBytes mod BlockSize);

  SetLength(pad, padding_size);
  pad[0] := $01;
  UpdateBytes(pad[0], padding_size);

  for i := 0 to 31 do
  begin
    tap4 := (m_tap + 4) and $1F;
    tap16 := (m_tap + 16) and $1F;

    m_tap := (m_tap - 1) and $1F;
    tap25 := (m_tap + 25) and $1F;

    GPT(theta);

    m_stages[tap25, 0] := m_stages[tap25, 0] xor m_stages[m_tap, 2];
    m_stages[tap25, 1] := m_stages[tap25, 1] xor m_stages[m_tap, 3];
    m_stages[tap25, 2] := m_stages[tap25, 2] xor m_stages[m_tap, 4];
    m_stages[tap25, 3] := m_stages[tap25, 3] xor m_stages[m_tap, 5];
    m_stages[tap25, 4] := m_stages[tap25, 4] xor m_stages[m_tap, 6];
    m_stages[tap25, 5] := m_stages[tap25, 5] xor m_stages[m_tap, 7];
    m_stages[tap25, 6] := m_stages[tap25, 6] xor m_stages[m_tap, 0];
    m_stages[tap25, 7] := m_stages[tap25, 7] xor m_stages[m_tap, 1];
    m_stages[m_tap, 0] := m_stages[m_tap, 0] xor m_state[1];
    m_stages[m_tap, 1] := m_stages[m_tap, 1] xor m_state[2];
    m_stages[m_tap, 2] := m_stages[m_tap, 2] xor m_state[3];
    m_stages[m_tap, 3] := m_stages[m_tap, 3] xor m_state[4];
    m_stages[m_tap, 4] := m_stages[m_tap, 4] xor m_state[5];
    m_stages[m_tap, 5] := m_stages[m_tap, 5] xor m_state[6];
    m_stages[m_tap, 6] := m_stages[m_tap, 6] xor m_state[7];
    m_stages[m_tap, 7] := m_stages[m_tap, 7] xor m_state[8];

    m_state[0] := theta[0] xor $01;
    m_state[1] := theta[1] xor m_stages[tap4, 0];
    m_state[2] := theta[2] xor m_stages[tap4, 1];
    m_state[3] := theta[3] xor m_stages[tap4, 2];
    m_state[4] := theta[4] xor m_stages[tap4, 3];
    m_state[5] := theta[5] xor m_stages[tap4, 4];
    m_state[6] := theta[6] xor m_stages[tap4, 5];
    m_state[7] := theta[7] xor m_stages[tap4, 6];
    m_state[8] := theta[8] xor m_stages[tap4, 7];
    m_state[9] := theta[9] xor m_stages[tap16, 0];
    m_state[10] := theta[10] xor m_stages[tap16, 1];
    m_state[11] := theta[11] xor m_stages[tap16, 2];
    m_state[12] := theta[12] xor m_stages[tap16, 3];
    m_state[13] := theta[13] xor m_stages[tap16, 4];
    m_state[14] := theta[14] xor m_stages[tap16, 5];
    m_state[15] := theta[15] xor m_stages[tap16, 6];
    m_state[16] := theta[16] xor m_stages[tap16, 7];
  end;
  Move(m_state[9], ADigest, 8*SizeOf(DWord));
end;

end.
