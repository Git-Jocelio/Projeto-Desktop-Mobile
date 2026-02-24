unit UnitLogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Imaging.pngimage ,
  Vcl.Loading, // unit que carrega um loandin na tela
  Vcl.Session; // unit com uma classe global para pegar os dados de acesso do usuario
type
  TfrmLogin = class(TForm)
    ImgFundo: TImage;
    pnLogin: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    PnlBotaoAcessar: TPanel;
    Senha: TLabel;
    Panel2: TPanel;
    EdtEmail: TEdit;
    Panel3: TPanel;
    EdtSenha: TEdit;
    BtnAcessar: TSpeedButton;
    procedure BtnAcessarClick(Sender: TObject);
  private
    procedure TerminateLogin(Sender: TObject);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLogin: TfrmLogin;

implementation

{$R *.dfm}

uses UnitFrmPrincipal;

procedure TfrmLogin.TerminateLogin(Sender: TObject);
begin
   // esconde o loading
   TLoading.Hide;

   { tratamento de erro de dentro da thread
     verifica se houve algum erro dentro thread da requisicao do servidor,
     se houver mostra o erro e para a aplicação }
   if (Sender is TThread) then
     if Assigned(TThread(Sender).FatalException) then
     begin
       ShowMessage( Exception(TThread(Sender).FatalException).Message );
       exit;
     end;

   // pegar dados de acesso do usuario... buscar no servidor
   TSession.ID_USUARIO := 1;
   TSession.EMAIL := 'jocelio@teste.com.br';
   TSession.NOME := 'JOCELIO GOME DA SILVA';

   // cria o form principal se não existir na memória
   if NOT Assigned(FormPrincipal) then
    Application.CreateForm(TFormPrincipal, FormPrincipal);

   // chama o form principal
   FormPrincipal.show;
end;

procedure TfrmLogin.BtnAcessarClick(Sender: TObject);
begin
   // mostra um loading na tela
   TLoading.show(Self);

   { fazer requisição para o servidor dentro de uma thred paralela.
    senão o loading fica rodando e qdo o usuario tentar mudar de foco
    da impressão de tela travada(tela branca) }

   TLoading.ExecuteThread(procedure
   begin
      // aqui faremos a requisao ao servidor
      sleep(1500); // simula tempo de resposta o servidor

      // simular erro na requisição
      // raise Exception.Create('usuario inválido');
   end,
   TerminateLogin
   );


end;

end.
