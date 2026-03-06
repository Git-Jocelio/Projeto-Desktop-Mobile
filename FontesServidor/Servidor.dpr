program Servidor;

uses
  Vcl.Forms,
  UnitPrincipal in 'UnitPrincipal.pas' {FormPrincipal},
  Controllers.Cliente in 'Controllers\Controllers.Cliente.pas',
  Controllers.Usuario in 'Controllers\Controllers.Usuario.pas',
  DataModule.Pessoa in 'DataModules\DataModule.Pessoa.pas' {DmPessoa: TDataModule},
  Service.Pessoa in 'Service\Service.Pessoa.pas',
  Env.Conf in 'Config\Env.Conf.pas',
  DataModule.Servidor in 'DataModules\DataModule.Servidor.pas' {DmServidor: TDataModule},
  DataModule.Usuario in 'DataModules\DataModule.Usuario.pas' {dmUsuario: TDataModule},
  uMD5 in 'Utils\uMD5.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormPrincipal, FormPrincipal);
  Application.Run;
end.
