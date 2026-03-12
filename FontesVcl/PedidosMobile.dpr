program PedidosMobile;

uses
  Vcl.Forms,
  UnitLogin in 'UnitLogin.pas' {frmLogin},
  UnitFrmPrincipal in 'UnitFrmPrincipal.pas' {FormPrincipal},
  Vcl.Loading in 'Utils\Vcl.Loading.pas',
  Vcl.Session in 'Utils\Vcl.Session.pas',
  UnitFormPedidos in 'UnitFormPedidos.pas' {FormPedidos},
  Vcl.Navigation in 'Utils\Vcl.Navigation.pas',
  UnitFormCliente in 'UnitFormCliente.pas' {FormCliente},
  UnitFormClienteE in 'UnitFormClienteE.pas' {FormClienteE},
  DataModele.Pessoa in 'DataModules\DataModele.Pessoa.pas' {DmPessoa: TDataModule},
  DataModule.Usuario in 'DataModules\DataModule.Usuario.pas' {dmUsuario: TDataModule},
  UnitFormBaseGrade in 'FormBaseGrade\UnitFormBaseGrade.pas' {FormBaseGrade},
  Service.Pessoa in 'Services\Service.Pessoa.pas',
  UnitFormBaseEdicao in 'FormBaseEdicao\UnitFormBaseEdicao.pas' {FormBaseEdicao},
  UnitFormProduto in 'FormCadastros\Produtos\UnitFormProduto.pas' {FormProduto},
  DataModule.Produto in 'DataModules\DataModule.Produto.pas' {DmProduto: TDataModule};

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := true;

  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmLogin, frmLogin);
  Application.Run;
end.
