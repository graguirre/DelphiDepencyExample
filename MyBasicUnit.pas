unit MyBasicUnit;

interface

uses
  SysUtils,
  MyBasicUnitInterface
  ;

type

TMyUnit = class
  private
    FMsg : String;
  public
    constructor Create;
    function getMessage : String;
    procedure setMessage(pMsg : String);
end;

implementation

uses
  Spring.Container
  ;

{ TMyUnit }

constructor TMyUnit.Create;
begin
  FMsg := 'this is a single message';
end;

function TMyUnit.getMessage: String;
begin
  result := FMsg;
end;

procedure TMyUnit.setMessage(pMsg: String);
begin
  FMsg := pMsg;
end;

initialization
  GlobalContainer.RegisterType<TMyUnit>.Implements<IMyUnit>;
end.
