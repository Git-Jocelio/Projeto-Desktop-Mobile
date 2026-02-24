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
  DataModele.Pessoa in 'DataModules\DataModele.Pessoa.pas' {DmPessoa: TDataModule};

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := true;

  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmLogin, frmLogin);
  Application.CreateForm(TDmPessoa, DmPessoa);
  Application.Run;
end.
