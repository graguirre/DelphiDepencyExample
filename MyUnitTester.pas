unit MyUnitTester;

interface

uses
  MyBasicUnit, // register class
  MyBasicUnitInterface
  ;

type
  TTestingUnit = class
    private
      FBasicUnit : IMyUnit;
    public
      constructor Create;
      procedure Setup;
      procedure TearDown;
      function TestDefaultValue : String;
  end;

implementation

uses
  Spring.Container,
  Spring.Services
  ;

{ TTestingUnit }

constructor TTestingUnit.Create;
begin
  FBasicUnit := nil;
end;

procedure TTestingUnit.Setup;
begin
  FBasicUnit := ServiceLocator.GetService<IMyUnit>;
end;

procedure TTestingUnit.TearDown;
begin
  FBasicUnit := nil;
end;

function TTestingUnit.TestDefaultValue : String;
begin
  Result := FBasicUnit.getMessage;
end;

initialization
  GlobalContainer.RegisterType<TTestingUnit>;
  GlobalContainer.Build;
end.
