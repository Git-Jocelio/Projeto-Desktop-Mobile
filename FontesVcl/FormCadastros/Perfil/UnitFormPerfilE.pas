unit UnitFormPerfilE;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UnitFormBaseEdicao, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.Buttons, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Loading, Vcl.Navigation,
  Vcl.Session;

type
  TFormPerfilE = class(TFormBaseEdicao)
    Nome: TLabel;
    Email: TLabel;
    edtNome: TEdit;
    edtEmail: TEdit;
    Label2: TLabel;
    edtNovaSenha: TEdit;
    Label3: TLabel;
    edtConfirmarSenha: TEdit;
    procedure FormShow(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
  private
    procedure CarregarDadosPerfil;
    procedure TerminateCarregarDadosPerfil(Sender: TObject);
    procedure TerminateSalvar(Sender: TObject);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormPerfilE: TFormPerfilE;

implementation

{$R *.dfm}

uses Service.Usuario;


procedure TFormPerfilE.FormShow(Sender: TObject);
begin
  inherited;
  CarregarDadosPerfil;
end;

procedure TFormPerfilE.TerminateCarregarDadosPerfil(Sender: TObject);
begin
  TLoading.Hide;

  if (Sender is TThread) then
    if Assigned(TThread(Sender).FatalException) then
    begin
      ShowMessage( Exception(TThread(Sender).FatalException).Message );
      exit;
    end;

  // carregar edits
  edtNome.Text := TSession.NOME;
  edtEmail.Text := TSession.EMAIL;

end;

procedure TFormPerfilE.TerminateSalvar(Sender: TObject);
begin
  TLoading.Hide;

  if (Sender is TThread) then
    if Assigned(TThread(Sender).FatalException) then
    begin
      ShowMessage( Exception(TThread(Sender).FatalException).Message );
      exit;
    end;

  ShowMessage('Senha alterada com sucesso!');

  TNavigation.Close(self);
end;


procedure TFormPerfilE.btnSalvarClick(Sender: TObject);
begin
    TLoading.Show;

    TLoading.ExecuteThread(
    procedure
    begin
        sleep(500);
        TServiceUsuario.SalvarSenha( edtNovaSenha.Text );
    end,
    TerminateSalvar
    );
end;

procedure TFormPerfilE.CarregarDadosPerfil;
begin
  TLoading.Show(FormPerfilE);

  TLoading.ExecuteThread(procedure
  begin
    sleep(500);
    // posso buscar no banco ou carregar da session... neste caso
    //preferi carregar da session
  end,
  TerminateCarregarDadosPerfil
  )

end;

end.
