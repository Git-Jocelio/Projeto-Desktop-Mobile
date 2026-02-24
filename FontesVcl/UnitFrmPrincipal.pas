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
    SpeedButton1: TSpeedButton;
    Image1: TImage;
    ImageList: TImageList;
    CategoryButtons: TCategoryButtons;
    svSubMenu: TSplitView;
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
    procedure SpeedButton1Click(Sender: TObject);
    procedure btnFecharSubMenuClick(Sender: TObject);
    procedure CategoryButtonsCategories0Items2Click(Sender: TObject);
    procedure CategoryButtonsCategories0Items5Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CategoryButtonsCategories0Items1Click(Sender: TObject);
    procedure CategorySubMenuButtonsCategories0Items0Click(Sender: TObject);
  private
    procedure CloseSubMenu;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormPrincipal: TFormPrincipal;

implementation

{$R *.dfm}

uses UnitFormPedidos, UnitFormCliente;

procedure TFormPrincipal.CategoryButtonsCategories0Items1Click(Sender: TObject);
begin
  svSubMenu.Opened := FALSE;
  TNavigation.Open(TFormPedidos, FormPedidos, PnlContainer);
end;

procedure TFormPrincipal.CategoryButtonsCategories0Items2Click(Sender: TObject);
begin
  svSubMenu.Opened := TRUE;
end;

procedure TFormPrincipal.CategoryButtonsCategories0Items5Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TFormPrincipal.CategorySubMenuButtonsCategories0Items0Click(
  Sender: TObject);
begin
  CloseSubMenu;
  TNavigation.Open(TFormCliente, FormCliente, PnlContainer);

end;

procedure TFormPrincipal.CloseSubMenu;
begin
  svSubMenu.Opened := NOT svSubMenu.Opened;
  CategoryButtons.SelectedItem := nil;
  svMenu.SetFocus;
end;


procedure TFormPrincipal.FormShow(Sender: TObject);
begin
  lblNome.Caption := TSession.NOME;
  lblEmail.Caption := TSession.EMAIL;
end;

procedure TFormPrincipal.SpeedButton1Click(Sender: TObject);
begin
  svMenu.opened := not svMenu.opened;
end;

procedure TFormPrincipal.btnFecharSubMenuClick(Sender: TObject);
begin
  CloseSubMenu;
end;

end.
