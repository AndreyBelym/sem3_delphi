program Lab6Static;

uses
  Forms;

function ShowForm: Integer; external 'LabDLL';
{$R *.res}

begin
  Application.Initialize;
  ShowForm;
end.
