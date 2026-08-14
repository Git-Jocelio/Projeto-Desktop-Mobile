unit UnitFrmPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.WinXCtrls,
  Vcl.Imaging.pngimage, Vcl.Buttons, System.ImageList, Vcl.ImgList,
  Vcl.CategoryButtons, Vcl.StdCtrls,
  Vcl.Session,
  Vcl.Navigation;

type
  TFormPrincipal = class(TForm)
    svMenu: TSplitView;
    Panel1: TPanel;
    btnMenuRetratil: TSpeedButton;
    Image1: TImage;
    ImageList: TImageList;
    CategoryButtons: TCategoryButtons;
    svSubMenuCadastros: TSplitView;
    Panel2: TPanel;
    CategorySubMenuButtons: TCategoryButtons;
    Label1: TLabel;
    btnFecharSubMenu: TSpeedButton;
    pnTela: TPanel;
    pnNavBar: TPanel;
    pnUsuario: TPanel;
    lblEmail: TLabel;
    lblNome: TLabel;
    imgUsuario: TImage;
    ImgNotificacoes: TImage;
    PnlContainer: TPanel;
    Label2: TLabel;
    svSubMenuSeguranca: TSplitView;
    Panel3: TPanel;
    Label3: TLabel;
    SpeedButton1: TSpeedButton;
    CategorysubMenuSeguranca: TCategoryButtons;

    procedure btnMenuRetratilClick(Sender: TObject);
    procedure btnFecharSubMenuClick(Sender: TObject);
    procedure CategoryButtonsCategories0Items1Click(Sender: TObject);//solicitação de compra
    procedure CategoryButtonsCategories0Items2Click(Sender: TObject);//abre pedido de compra
    procedure CategoryButtonsCategories0Items3Click(Sender: TObject);//abre menu cadastros
    procedure CategoryButtonsCategories0Items4Click(Sender: TObject);//abre meu perfil
    procedure CategoryButtonsCategories0Items5Click(Sender: TObject);//submenu segurança
    procedure CategoryButtonsCategories0Items6Click(Sender: TObject);//fechar aplicação

    //sub menu cadastros
    procedure CategorySubMenuButtonsCategories0Items0Click(Sender: TObject);//cad pessoas
    procedure CategorySubMenuButtonsCategories0Items1Click(Sender: TObject);//cad Produtos
    procedure CategorySubMenuButtonsCategories0Items2Click(Sender: TObject);//cad fornecedores
    procedure CategorySubMenuButtonsCategories0Items3Click(Sender: TObject);//cad colaboradores

    procedure FormShow(Sender: TObject);
    procedure CategorysubMenuSegurancaCategories0Items0Click(Sender: TObject);//cad usuario
    procedure CategorysubMenuSegurancaCategories0Items1Click(Sender: TObject);
    procedure CategorysubMenuSegurancaCategories0Items3Click(Sender: TObject);//cad perfil

  private
    procedure CloseSubMenu;
    procedure fecharAplicacao;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormPrincipal: TFormPrincipal;

implementation

{$R *.dfm}

uses UnitFormPedidos, UnitFormProduto, UnitFormPessoa, UnitFormFornecedor,
     UnitFormSolicitacaoCompras, UnitFormColaborador, UnitFormPerfilE,
     UnitFormUsuario, UnitFormPerfil, UnitFormTela;

procedure TFormPrincipal.CategoryButtonsCategories0Items1Click(Sender: TObject);
begin
  svSubMenuCadastros.Opened := FALSE;
  TNavigation.Open(TFormSolicitacaoCompras, FormSolicitacaoCompras, PnlContainer);
end;

procedure TFormPrincipal.CategoryButtonsCategories0Items2Click(Sender: TObject);
begin
     //pedido de compra

  svSubMenuCadastros.Opened := FALSE;
  TNavigation.Open(TFormPedidos, FormPedidos, PnlContainer);

end;

procedure TFormPrincipal.CategoryButtonsCategories0Items3Click(Sender: TObject);
begin
  svSubMenuSeguranca.Visible := false;
  svSubMenuCadastros.Visible := true;
  svSubMenuCadastros.Opened := TRUE;

end;

procedure TFormPrincipal.CategoryButtonsCategories0Items4Click(Sender: TObject);
begin
  svSubMenuCadastros.Opened := FALSE;
  TNavigation.OpenModal(TFormPerfilE, FormPerfilE);
end;

procedure TFormPrincipal.CategoryButtonsCategories0Items5Click(Sender: TObject);
begin
  //submenu segurança
  svSubMenuCadastros.Visible := false;
  svSubMenuSeguranca.Visible := true;
  svSubMenuSeguranca.Opened := TRUE;

end;

procedure TFormPrincipal.CategoryButtonsCategories0Items6Click(Sender: TObject);
begin
  fecharAplicacao;
end;

procedure TFormPrincipal.CategorySubMenuButtonsCategories0Items0Click(
  Sender: TObject);
begin
  CloseSubMenu;
  TNavigation.Open(TFormPessoa, FormPessoa, PnlContainer);

end;

procedure TFormPrincipal.CategorySubMenuButtonsCategories0Items1Click(
  Sender: TObject);
begin

  CloseSubMenu;
  TNavigation.Open(TFormProduto, FormProduto, PnlContainer);

end;

procedure TFormPrincipal.CategorySubMenuButtonsCategories0Items2Click(
  Sender: TObject);
begin


  CloseSubMenu;
  TNavigation.Open(TFormFornecedor, FormFornecedor, PnlContainer);

end;

procedure TFormPrincipal.fecharAplicacao;
begin
  Application.Terminate;
end;

procedure TFormPrincipal.CategorySubMenuButtonsCategories0Items3Click(
  Sender: TObject);
begin
  CloseSubMenu;
  TNavigation.Open(TFormColaborador, FormColaborador, PnlContainer);
end;

procedure TFormPrincipal.CategorysubMenuSegurancaCategories0Items0Click(
  Sender: TObject);
begin
  CloseSubMenu;
  TNavigation.Open(TFormUsuario, FormUsuario, PnlContainer);
end;

procedure TFormPrincipal.CategorysubMenuSegurancaCategories0Items1Click(
  Sender: TObject);
begin
  CloseSubMenu;
  TNavigation.Open(TFormPerfil, FormPerfil, PnlContainer);
end;

procedure TFormPrincipal.CategorysubMenuSegurancaCategories0Items3Click(
  Sender: TObject);
begin
  CloseSubMenu;
  TNavigation.Open(TFormTela, FormTela, PnlContainer);
end;

procedure TFormPrincipal.CloseSubMenu;
begin
  svSubMenuCadastros.Opened := NOT svSubMenuCadastros.Opened;
  svSubMenuSeguranca.Opened := NOT svSubMenuSeguranca.Opened;

  CategoryButtons.SelectedItem := nil;
  svMenu.SetFocus;
end;


procedure TFormPrincipal.FormShow(Sender: TObject);
begin
  svSubMenuCadastros.Opened := false;
  svSubMenuSeguranca.Opened := false;

  lblNome.Caption  := TSession.NOME;
  lblEmail.Caption := TSession.EMAIL;
end;

procedure TFormPrincipal.btnMenuRetratilClick(Sender: TObject);
begin
  svMenu.opened := not svMenu.opened;
end;

procedure TFormPrincipal.btnFecharSubMenuClick(Sender: TObject);
begin
  CloseSubMenu;
end;

end.
