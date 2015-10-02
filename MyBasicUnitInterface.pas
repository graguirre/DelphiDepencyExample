unit MyBasicUnitInterface;

interface

type
  IMyUnit = interface
  ['{82D4D138-9003-445A-AA2C-887F6C5C7647}']
    function getMessage : String;
    procedure setMessage(pMsg : String);
  end;

implementation

end.
