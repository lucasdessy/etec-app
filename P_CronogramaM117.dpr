program P_CronogramaM117;

uses
  System.StartUpCopy,
  FMX.Forms,
  U_Principal in 'U_Principal.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
