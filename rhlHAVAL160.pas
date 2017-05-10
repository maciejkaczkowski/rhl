unit rhlHAVAL160;

interface

uses
  rhlHAVAL;

type

  { TrhlHAVAL160r3p1 }

  TrhlHAVAL160r3p1 = class(TrhlHAVAL3)
  public
    constructor Create; override;
  end;

  { TrhlHAVAL160r3p160 }

  TrhlHAVAL160r3p128 = class(TrhlHAVAL160r3p1)
  public
    constructor Create; override;
  end;

  { TrhlHAVAL160r4p1 }

  TrhlHAVAL160r4p1 = class(TrhlHAVAL4)
  public
    constructor Create; override;
  end;

  { TrhlHAVAL160r4p160 }

  TrhlHAVAL160r4p128 = class(TrhlHAVAL160r4p1)
  public
    constructor Create; override;
  end;

  { TrhlHAVAL160r5p1 }

  TrhlHAVAL160r5p1 = class(TrhlHAVAL5)
  public
    constructor Create; override;
  end;

  { TrhlHAVAL160r5p160 }

  TrhlHAVAL160r5p128 = class(TrhlHAVAL160r5p1)
  public
    constructor Create; override;
  end;


implementation

const
  HASH_SIZE = 160 div 8;

{ TrhlHAVAL160r5p160 }

constructor TrhlHAVAL160r5p128.Create;
begin
  inherited Create;
  FPadding := $80;
end;

{ TrhlHAVAL160r5p1 }

constructor TrhlHAVAL160r5p1.Create;
begin
  inherited Create;
  HashSize := HASH_SIZE;
end;

{ TrhlHAVAL160r4p160 }

constructor TrhlHAVAL160r4p128.Create;
begin
  inherited Create;
  FPadding := $80;
end;

{ TrhlHAVAL160r4p1 }

constructor TrhlHAVAL160r4p1.Create;
begin
  inherited Create;
  FHashSize := HASH_SIZE;
end;

{ TrhlHAVAL160r3p1 }

constructor TrhlHAVAL160r3p1.Create;
begin
  inherited Create;
  HashSize := HASH_SIZE;
end;

{ TrhlHAVAL160r3p160 }

constructor TrhlHAVAL160r3p128.Create;
begin
  inherited Create;
  FPadding := $80;
end;

end.
