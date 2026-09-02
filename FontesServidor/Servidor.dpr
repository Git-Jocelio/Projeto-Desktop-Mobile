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
  DataModule.Usuario in 'DataModules\DataModule.Usuario.pas' {DmUsuario: TDataModule},
  uMD5 in 'Utils\uMD5.pas',
  Controllers.Produto in 'Controllers\Controllers.Produto.pas',
  DataModule.Produto in 'DataModules\DataModule.Produto.pas' {DmProduto: TDataModule},
  Service.Produto in 'Service\Service.Produto.pas',
  DataModule.Fornecedor in 'DataModules\DataModule.Fornecedor.pas' {DmFornecedor: TDataModule},
  Service.Fornecedor in 'Service\Service.Fornecedor.pas',
  Controllers.Fornecedor in 'Controllers\Controllers.Fornecedor.pas',
  Controllers.Colaborador in 'Controllers\Controllers.Colaborador.pas',
  DataModule.Colaborador in 'DataModules\DataModule.Colaborador.pas' {DmColaborador: TDataModule},
  Service.Colaborador in 'Service\Service.Colaborador.pas',
  Servidor.Startup in 'Server\Servidor.Startup.pas',
  Controllers.JWT in 'Controllers\Controllers.JWT.pas',
  Service.Usuario in 'Service\Service.Usuario.pas',
  DataModule.Perfil in 'DataModules\DataModule.Perfil.pas' {DmPerfil: TDataModule},
  Service.Perfil in 'Service\Service.Perfil.pas',
  Controllers.Perfil in 'Controllers\Controllers.Perfil.pas',
  DataModule.Tela in 'DataModules\DataModule.Tela.pas' {dmTela: TDataModule},
  Service.Tela in 'Service\Service.Tela.pas',
  Controllers.Tela in 'Controllers\Controllers.Tela.pas',
  Controllers.UsuarioPerfil in 'Controllers\Controllers.UsuarioPerfil.pas',
  Service.UsuarioPerfil in 'Service\Service.UsuarioPerfil.pas',
  DataModule.UsuarioPerfil in 'DataModules\DataModule.UsuarioPerfil.pas' {DmUsuarioPerfil: TDataModule},
  DataModule.Permissoes in 'DataModules\DataModule.Permissoes.pas' {DmPermissoes: TDataModule},
  Service.Permissoes in 'Service\Service.Permissoes.pas',
  Controllers.Permissoes in 'Controllers\Controllers.Permissoes.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormPrincipal, FormPrincipal);
  Application.CreateForm(TDmUsuarioPerfil, DmUsuarioPerfil);
  Application.CreateForm(TDmPermissoes, DmPermissoes);
  Application.Run;
end.
