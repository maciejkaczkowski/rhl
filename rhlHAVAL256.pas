unit rhlHAVAL256;

interface

uses
  rhlHAVAL;

type

  { TrhlHAVAL256r3p1 }

  TrhlHAVAL256r3p1 = class(TrhlHAVAL3)
  public
    constructor Create; override;
  end;

  { TrhlHAVAL256r3p128 }

  TrhlHAVAL256r3p128 = class(TrhlHAVAL256r3p1)
  public
    constructor Create; override;
  end;

  { TrhlHAVAL256r4p1 }

  TrhlHAVAL256r4p1 = class(TrhlHAVAL4)
  public
    constructor Create; override;
  end;

  { TrhlHAVAL256r4p128 }

  TrhlHAVAL256r4p128 = class(TrhlHAVAL256r4p1)
  public
    constructor Create; override;
  end;

  { TrhlHAVAL256r5p1 }

  TrhlHAVAL256r5p1 = class(TrhlHAVAL5)
  public
    constructor Create; override;
  end;

  { TrhlHAVAL256r5p128 }

  TrhlHAVAL256r5p128 = class(TrhlHAVAL256r5p1)
  public
    constructor Create; override;
  end;


implementation

const
  HASH_SIZE = 256 div 8;

{ TrhlHAVAL256r5p128 }

constructor TrhlHAVAL256r5p128.Create;
begin
  inherited Create;
  FPadding := $80;
end;

{ TrhlHAVAL256r5p1 }

constructor TrhlHAVAL256r5p1.Create;
begin
  inherited Create;
  HashSize := HASH_SIZE;
end;

{ TrhlHAVAL256r4p128 }

constructor TrhlHAVAL256r4p128.Create;
begin
  inherited Create;
  FPadding := $80;
end;

{ TrhlHAVAL256r4p1 }

constructor TrhlHAVAL256r4p1.Create;
begin
  inherited Create;
  FHashSize := HASH_SIZE;
end;

{ TrhlHAVAL256r3p1 }

constructor TrhlHAVAL256r3p1.Create;
begin
  inherited Create;
  HashSize := HASH_SIZE;
end;

{ TrhlHAVAL256r3p128 }

constructor TrhlHAVAL256r3p128.Create;
begin
  inherited Create;
  FPadding := $80;
end;

end.
