program MyBasicApp;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  Spring.Services,
  MyUnitTester
  ;

var
  FTest : ITestingUnit;
begin
  try
    FTest :=  ServiceLocator.GetService<ITestingUnit>;

    FTest.Setup;
    Writeln(FTest.TestDefaultValue); // asserts or something like that
    FTest.TearDown;

    FTest.Setup;
    Writeln(FTest.TestMessage1); // asserts or something like that
    FTest.TearDown;

  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
  Readln;
end.
