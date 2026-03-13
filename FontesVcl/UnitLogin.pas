unit UnitLogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Imaging.pngimage ,
  Vcl.Loading, // unit que carrega um loandin na tela
  Vcl.Session, // unit com uma classe global para pegar os dados de acesso do usuario
  System.Net.HttpClient,
  System.Net.URLClient,
  System.Net.HttpClientComponent;
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
    EdtLogin: TEdit;
    Panel3: TPanel;
    EdtSenha: TEdit;
    BtnAcessar: TSpeedButton;
    procedure BtnAcessarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    procedure TerminateLogin(Sender: TObject);
    function ServidorOnline: Boolean;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLogin: TfrmLogin;

implementation

{$R *.dfm}

uses UnitFrmPrincipal, DataModule.Usuario;

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
       ShowMessage(Exception(TThread(Sender).FatalException).Message );
       exit;
     end;

   // pegar dados de acesso do usuario... devolvidos pelo servidor
   TSession.ID_USUARIO := dmUsuario.MemTable.fieldbyname('usuarioId').AsInteger;
   TSession.EMAIL      := dmUsuario.MemTable.fieldbyname('login').AsString;
   TSession.NOME       := dmUsuario.MemTable.fieldbyname('nome').AsString;

   if NOT Assigned(FormPrincipal) then
     Application.CreateForm(TFormPrincipal, FormPrincipal);

   // chama o form principal
   FormPrincipal.show;

   FreeAndNil(dmUsuario);

end;

procedure TfrmLogin.BtnAcessarClick(Sender: TObject);

begin

   // mostra um loading na tela
   TLoading.show(Self);

   if not Assigned(dmUsuario) then
      dmUsuario := TdmUsuario.Create(nil);

   { fazer requisição para o servidor dentro de uma thred paralela.
    senão o loading fica rodando e qdo o usuario tentar mudar de foco
    da impressão de tela travada(tela branca) }
   TLoading.ExecuteThread(procedure
   begin
      sleep(600); // simula tempo de resposta o servidor

      if not ServidorOnline then
            raise Exception.Create('Servidor não está disponível.');

      dmUsuario.Login(dmUsuario.MemTable, EdtLogin.Text, EdtSenha.Text);

   end,
   TerminateLogin
   );


end;

procedure TfrmLogin.FormClose(Sender: TObject; var Action: TCloseAction);
begin

  FreeAndNil(dmUsuario);
  Action := caFree ;
end;

function TfrmLogin.ServidorOnline: Boolean;
var
  Http: TNetHTTPClient;
  Resp: IHTTPResponse;
begin
  Result := False;

  Http := TNetHTTPClient.Create(nil);
  try
    Http.ConnectionTimeout := 1500; // 2 segundos
    Http.ResponseTimeout   := 1500;

    try
      Resp := Http.Get('http://localhost:3000/health');
      Result := Resp.StatusCode = 200;
    except
      Result := False;
    end;

  finally
    Http.Free;
  end;
end;

end.
