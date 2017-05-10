unit rhlHAVAL224;

interface

uses
  rhlHAVAL;

type

  { TrhlHAVAL224r3p1 }

  TrhlHAVAL224r3p1 = class(TrhlHAVAL3)
  public
    constructor Create; override;
  end;

  { TrhlHAVAL224r3p128 }

  TrhlHAVAL224r3p128 = class(TrhlHAVAL224r3p1)
  public
    constructor Create; override;
  end;

  { TrhlHAVAL224r4p1 }

  TrhlHAVAL224r4p1 = class(TrhlHAVAL4)
  public
    constructor Create; override;
  end;

  { TrhlHAVAL224r4p128 }

  TrhlHAVAL224r4p128 = class(TrhlHAVAL224r4p1)
  public
    constructor Create; override;
  end;

  { TrhlHAVAL224r5p1 }

  TrhlHAVAL224r5p1 = class(TrhlHAVAL5)
  public
    constructor Create; override;
  end;

  { TrhlHAVAL224r5p128 }

  TrhlHAVAL224r5p128 = class(TrhlHAVAL224r5p1)
  public
    constructor Create; override;
  end;


implementation

const
  HASH_SIZE = 224 div 8;

{ TrhlHAVAL224r5p128 }

constructor TrhlHAVAL224r5p128.Create;
begin
  inherited Create;
  FPadding := $80;
end;

{ TrhlHAVAL224r5p1 }

constructor TrhlHAVAL224r5p1.Create;
begin
  inherited Create;
  HashSize := HASH_SIZE;
end;

{ TrhlHAVAL224r4p128 }

constructor TrhlHAVAL224r4p128.Create;
begin
  inherited Create;
  FPadding := $80;
end;

{ TrhlHAVAL224r4p1 }

constructor TrhlHAVAL224r4p1.Create;
begin
  inherited Create;
  FHashSize := HASH_SIZE;
end;

{ TrhlHAVAL224r3p1 }

constructor TrhlHAVAL224r3p1.Create;
begin
  inherited Create;
  HashSize := HASH_SIZE;
end;

{ TrhlHAVAL224r3p128 }

constructor TrhlHAVAL224r3p128.Create;
begin
  inherited Create;
  FPadding := $80;
end;

end.
