program PedidosMobile;

uses
  System.UITypes,
  Vcl.Forms,
  UnitLogin in 'UnitLogin.pas' {frmLogin},
  UnitFrmPrincipal in 'UnitFrmPrincipal.pas' {FormPrincipal},
  Vcl.Session in 'Utils\Vcl.Session.pas',
  UnitFormPedidos in 'UnitFormPedidos.pas' {FormPedidos},
  Vcl.Navigation in 'Utils\Vcl.Navigation.pas',
  DataModele.Pessoa in 'DataModules\DataModele.Pessoa.pas' {DmPessoa: TDataModule},
  DataModule.Usuario in 'DataModules\DataModule.Usuario.pas' {dmUsuario: TDataModule},
  UnitFormBaseGrade in 'FormBaseGrade\UnitFormBaseGrade.pas' {FormBaseGrade},
  Service.Pessoa in 'Services\Service.Pessoa.pas',
  UnitFormBaseEdicao in 'FormBaseEdicao\UnitFormBaseEdicao.pas' {FormBaseEdicao},
  UnitFormProduto in 'FormCadastros\Produtos\UnitFormProduto.pas' {FormProduto},
  DataModule.Produto in 'DataModules\DataModule.Produto.pas' {DmProduto: TDataModule},
  Vcl.Loading in 'Utils\Vcl.Loading.pas',
  UnitFormProdutoE in 'FormCadastros\Produtos\UnitFormProdutoE.pas' {FormProdutoE},
  Service.Produto in 'Services\Service.Produto.pas',
  UnitFormFornecedor in 'FormCadastros\Fornecedores\UnitFormFornecedor.pas' {FormFornecedor},
  DataModule.Fornecedor in 'DataModules\DataModule.Fornecedor.pas' {DmFornecedor: TDataModule},
  UnitFormFornecedorE in 'FormCadastros\Fornecedores\UnitFormFornecedorE.pas' {FormFornecedorE},
  Service.Fornecedor in 'Services\Service.Fornecedor.pas',
  UnitFormSolicitacaoComprasE in 'FormCadastros\SolicitacaoCompras\UnitFormSolicitacaoComprasE.pas' {FormSolicitacaoComprasE},
  UnitFormSolicitacaoCompras in 'FormCadastros\SolicitacaoCompras\UnitFormSolicitacaoCompras.pas' {FormSolicitacaoCompras},
  UnitFormSolicitacaoItens in 'FormCadastros\SolicitacaoCompras\UnitFormSolicitacaoItens.pas' {FormSolicitacaoItens},
  UnitFormPessoa in 'FormCadastros\Pessoa\UnitFormPessoa.pas' {FormPessoa},
  UnitFormColaborador in 'FormCadastros\Colaboradores\UnitFormColaborador.pas' {FormColaborador},
  DataModule.Colaborador in 'DataModules\DataModule.Colaborador.pas' {DmColaborador: TDataModule},
  Service.Colaborador in 'Services\Service.Colaborador.pas',
  UnitFormColaboradorE in 'FormCadastros\Colaboradores\UnitFormColaboradorE.pas' {FormColaboradorE},
  UnitFormPessoaE in 'FormCadastros\Pessoa\UnitFormPessoaE.pas' {FormPessoaE},
  Vcl.Config in 'Utils\Vcl.Config.pas',
  UnitFormPerfilE in 'FormCadastros\Perfil\UnitFormPerfilE.pas' {FormPerfilE},
  Service.Usuario in 'Services\Service.Usuario.pas',
  UnitFormUsuario in 'FormCadastros\Usuarios\UnitFormUsuario.pas' {FormUsuario},
  UnitFormUsuarioE in 'FormCadastros\Usuarios\UnitFormUsuarioE.pas' {FormUsuarioE},
  UnitFormPerfil in 'FormCadastros\Perfil\UnitFormPerfil.pas' {FormPerfil},
  DataModule.Perfil in 'DataModules\DataModule.Perfil.pas' {DmPerfil: TDataModule},
  UnitFormPerfilEdicao in 'FormCadastros\Perfil\UnitFormPerfilEdicao.pas' {FormPerfilEdicao},
  Service.Perfil in 'Services\Service.Perfil.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := true;

  Application.Initialize;
  Application.MainFormOnTaskbar := True;

  frmLogin := TfrmLogin.Create(nil);

  try
    if frmLogin.ShowModal = mrOk then
    begin
      Application.CreateForm(TFormPrincipal, FormPrincipal);
  Application.Run;
    end;
  finally
    frmLogin.Free;
  end;


end.
