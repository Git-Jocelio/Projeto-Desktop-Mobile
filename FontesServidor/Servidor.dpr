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
  uMD5 in 'Utils\uMD5.pas',
  Controllers.Produto in 'Controllers\Controllers.Produto.pas',
  DataModule.Produto in 'DataModules\DataModule.Produto.pas' {dmProduto: TDataModule},
  Service.Produto in 'Service\Service.Produto.pas',
  DataModule.Fornecedor in 'DataModules\DataModule.Fornecedor.pas' {DmFornecedor: TDataModule},
  Service.Fornecedor in 'Service\Service.Fornecedor.pas',
  Controllers.Fornecedor in 'Controllers\Controllers.Fornecedor.pas',
  Controllers.Colaborador in 'Controllers\Controllers.Colaborador.pas',
  DataModule.Colaborador in 'DataModules\DataModule.Colaborador.pas' {DmColaborador: TDataModule},
  Service.Colaborador in 'Service\Service.Colaborador.pas',
  Servidor.Startup in 'Server\Servidor.Startup.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormPrincipal, FormPrincipal);
  Application.CreateForm(TDmColaborador, DmColaborador);
  Application.Run;
end.
