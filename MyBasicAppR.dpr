program MyBasicAppR;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  Spring.Services,
  MyBasicUnitInterface,
  MyBasicUnit
  ;

var
  FUnit : IMyUnit;
begin
  try
    FUnit :=  ServiceLocator.GetService<IMyUnit>;

    Writeln(FUnit.getMessage);
    FUnit.setMessage('another message');
    Writeln(FUnit.getMessage);


  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
  Readln;
end.
