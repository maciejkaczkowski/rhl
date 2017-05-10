unit rhlHAVAL128;

interface

uses
  rhlHAVAL;

type

  { TrhlHAVAL128r3p1 }

  TrhlHAVAL128r3p1 = class(TrhlHAVAL3)
  public
    constructor Create; override;
  end;

  { TrhlHAVAL128r3p128 }

  TrhlHAVAL128r3p128 = class(TrhlHAVAL128r3p1)
  public
    constructor Create; override;
  end;

  { TrhlHAVAL128r4p1 }

  TrhlHAVAL128r4p1 = class(TrhlHAVAL4)
  public
    constructor Create; override;
  end;

  { TrhlHAVAL128r4p128 }

  TrhlHAVAL128r4p128 = class(TrhlHAVAL128r4p1)
  public
    constructor Create; override;
  end;

  { TrhlHAVAL128r5p1 }

  TrhlHAVAL128r5p1 = class(TrhlHAVAL5)
  public
    constructor Create; override;
  end;

  { TrhlHAVAL128r5p128 }

  TrhlHAVAL128r5p128 = class(TrhlHAVAL128r5p1)
  public
    constructor Create; override;
  end;


implementation

const
  HASH_SIZE = 128 div 8;

{ TrhlHAVAL128r5p128 }

constructor TrhlHAVAL128r5p128.Create;
begin
  inherited Create;
  FPadding := $80;
end;

{ TrhlHAVAL128r5p1 }

constructor TrhlHAVAL128r5p1.Create;
begin
  inherited Create;
  HashSize := HASH_SIZE;
end;

{ TrhlHAVAL128r4p128 }

constructor TrhlHAVAL128r4p128.Create;
begin
  inherited Create;
  FPadding := $80;
end;

{ TrhlHAVAL128r4p1 }

constructor TrhlHAVAL128r4p1.Create;
begin
  inherited Create;
  FHashSize := HASH_SIZE;
end;

{ TrhlHAVAL128r3p1 }

constructor TrhlHAVAL128r3p1.Create;
begin
  inherited Create;
  HashSize := HASH_SIZE;
end;

{ TrhlHAVAL128r3p128 }

constructor TrhlHAVAL128r3p128.Create;
begin
  inherited Create;
  FPadding := $80;
end;

end.
