unit rhlSuperFast;

interface

uses
  rhlCore;

type

  { TrhlSuperFast }

  TrhlSuperFast = class(TrhlHash)
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

{ TrhlSuperFast }

procedure TrhlSuperFast.UpdateBytes(const ABuffer; ASize: LongWord);
var
  ci: Integer;
  tmp: DWord;
  hash: DWord;
  a_data: array[0..0] of Byte absolute ABuffer;
begin
  if (ASize = 0) then
    Exit;

  hash := ASize;
  ci := 0;

  while (ASize >= 4) do
  begin
    Inc(hash, $ffff and (a_data[ci+0] or a_data[ci+1] shl 8));
    tmp := ((a_data[ci+2] or a_data[ci+3] shl 8) shl 11) xor hash;
    hash := (hash shl 16) xor tmp;
    Inc(hash, hash shr 11);

    Inc(ci, 4);
    Dec(ASize, 4);
  end;

  case ASize of
    3:
      begin
        Inc(hash, $ffff and (a_data[ci+0] or (a_data[ci+1] shl 8)));
        hash := hash xor (hash shl 16);
        hash := hash xor (DWord(a_data[ci+2]) shl 18);
        Inc(hash, hash shr 11);
      end;
    2:
      begin
        Inc(hash, $ffff and (a_data[ci+0] or a_data[ci+1] shl 8));
        hash := hash xor (hash shl 11);
        Inc(hash, hash shr 17);
      end;
    1:
      begin
        Inc(hash, a_data[ci+0]);
        hash := hash xor (hash shl 10);
        Inc(hash, hash shr 1);
      end;
  end;

  hash := hash xor (hash shl 3);
  hash := hash + (hash shr 5);
  hash := hash xor (hash shl 4);
  hash := hash + (hash shr 17);
  hash := hash xor (hash shl 25);
  hash := hash + (hash shr 6);
  m_hash := hash;
end;

constructor TrhlSuperFast.Create;
begin
  HashSize := 4;
  BlockSize := 4;
end;

procedure TrhlSuperFast.Init;
begin
  inherited Init;
  m_hash := 0;
end;

procedure TrhlSuperFast.Final(var ADigest);
begin
  Move(m_hash, ADigest, 4);
end;

end.
