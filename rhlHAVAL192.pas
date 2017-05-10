unit rhlHAVAL192;

interface

uses
  rhlHAVAL;

type

  { TrhlHAVAL192r3p1 }

  TrhlHAVAL192r3p1 = class(TrhlHAVAL3)
  public
    constructor Create; override;
  end;

  { TrhlHAVAL192r3p128 }

  TrhlHAVAL192r3p128 = class(TrhlHAVAL192r3p1)
  public
    constructor Create; override;
  end;

  { TrhlHAVAL192r4p1 }

  TrhlHAVAL192r4p1 = class(TrhlHAVAL4)
  public
    constructor Create; override;
  end;

  { TrhlHAVAL192r4p128 }

  TrhlHAVAL192r4p128 = class(TrhlHAVAL192r4p1)
  public
    constructor Create; override;
  end;

  { TrhlHAVAL192r5p1 }

  TrhlHAVAL192r5p1 = class(TrhlHAVAL5)
  public
    constructor Create; override;
  end;

  { TrhlHAVAL192r5p128 }

  TrhlHAVAL192r5p128 = class(TrhlHAVAL192r5p1)
  public
    constructor Create; override;
  end;


implementation

const
  HASH_SIZE = 192 div 8;

{ TrhlHAVAL192r5p128 }

constructor TrhlHAVAL192r5p128.Create;
begin
  inherited Create;
  FPadding := $80;
end;

{ TrhlHAVAL192r5p1 }

constructor TrhlHAVAL192r5p1.Create;
begin
  inherited Create;
  HashSize := HASH_SIZE;
end;

{ TrhlHAVAL192r4p128 }

constructor TrhlHAVAL192r4p128.Create;
begin
  inherited Create;
  FPadding := $80;
end;

{ TrhlHAVAL192r4p1 }

constructor TrhlHAVAL192r4p1.Create;
begin
  inherited Create;
  FHashSize := HASH_SIZE;
end;

{ TrhlHAVAL192r3p1 }

constructor TrhlHAVAL192r3p1.Create;
begin
  inherited Create;
  HashSize := HASH_SIZE;
end;

{ TrhlHAVAL192r3p128 }

constructor TrhlHAVAL192r3p128.Create;
begin
  inherited Create;
  FPadding := $80;
end;

end.
