unit MyUnitTester;

interface

uses
  Classes,
  DUnitX.TestFramework,
  SysUtils,
  StrUtils,
  MyBasicUnitInterface,
  MyBasicUnit // register class
  ;

type

 ITestingUnit = interface
 ['{6A63E5AE-812B-45E8-8A2A-7C3B912B4869}']
    procedure Setup;
    procedure TearDown;
    function TestDefaultValue : String;
    function TestMessage1 : String;
 end;

  [TestFixture]
  TTestingUnit = class(TInterfacedObject, ITestingUnit)
    private
      FBasicUnit : IMyUnit;
    public
      [Setup]
      procedure Setup;
      [Teardown]
      procedure TearDown;
      [Test]
      [TestCase('TestDefaultMessage','')]
      function TestDefaultValue : String;
      [TestCase('TestRandomMessage','')]
      function TestMessage1 : String;
  end;

implementation

uses
  Spring.Container,
  Spring.Services
  ;

{ TTestingUnit }

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

function TTestingUnit.TestMessage1 : String;
begin
  FBasicUnit.setMessage('Message 1');
  Result := FBasicUnit.getMessage;
end;

initialization
  GlobalContainer.RegisterType<TTestingUnit>.Implements<ITestingUnit>;
  GlobalContainer.Build;
  TDUnitX.RegisterTestFixture(TTestingUnit);
end.
