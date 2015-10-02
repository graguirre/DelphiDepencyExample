program MyBasicApp;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  Spring.Services,
  MyUnitTester
  ;

var
  FTest : TTestingUnit;
begin
  try
    FTest :=  ServiceLocator.GetService<TTestingUnit>;

    FTest.Setup;
    Writeln(FTest.TestDefaultValue);
    FTest.TearDown;

  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
  Readln;
end.
