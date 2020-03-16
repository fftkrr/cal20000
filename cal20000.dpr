program cal20000;

uses
  Forms,
  cal20000_f in 'cal20000_f.pas' {Form1},
  calendar_unit in 'calendar_unit.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
