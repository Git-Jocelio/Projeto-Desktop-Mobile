program Servidor;

uses
  Vcl.Forms,
  UnitPrincipal in 'UnitPrincipal.pas' {FormPrincipal},
  Controllers.Cliente in 'Controllers\Controllers.Cliente.pas',
  Controllers.Usuario in 'Controllers\Controllers.Usuario.pas',
  DataModule.Pessoa in 'DataModules\DataModule.Pessoa.pas' {DmPessoa: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormPrincipal, FormPrincipal);
  Application.Run;
end.
