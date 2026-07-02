unit UnitLogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Imaging.pngimage,
  Vcl.Loading, // unit que carrega um loandin na tela
  Vcl.Session, // unit com uma classe global para pegar os dados de acesso do usuario
  System.Net.HttpClient,
  System.Net.URLClient,
  System.Net.HttpClientComponent,
  Vcl.Imaging.jpeg;
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
   TLoading.Hide;

   if (Sender is TThread) then
     if Assigned(TThread(Sender).FatalException) then
     begin
       ShowMessage(Exception(TThread(Sender).FatalException).Message );
       //dmUsuario.Free;
       FreeAndNil(dmUsuario);
       ModalResult := mrOk;
       Exit;
     end;

   // pegar dados de acesso do usuario... devolvidos pelo servidor
   TSession.ID_USUARIO := dmUsuario.MemTable.fieldbyname('usuarioId').AsInteger;
   TSession.EMAIL      := dmUsuario.MemTable.fieldbyname('login').AsString;
   TSession.NOME       := dmUsuario.MemTable.fieldbyname('nome').AsString;


   // FormPrincipal is already created automatically, so there is no need to create it again.

   (*
     if NOT Assigned(FormPrincipal) then
       Application.CreateForm(TFormPrincipal, FormPrincipal);

    chama o form principal
     FormPrincipal.show;
   *)

   FreeAndNil(dmUsuario);

   ModalResult := mrOk;

end;

procedure TfrmLogin.BtnAcessarClick(Sender: TObject);
begin

   TLoading.show(Self);

   if not Assigned(dmUsuario) then
      dmUsuario := TdmUsuario.Create(nil);

   TLoading.ExecuteThread(procedure
   begin
      sleep(600);

      if not ServidorOnline then
            raise Exception.Create('Servidor não está disponível.');

      dmUsuario.Login(dmUsuario.MemTable, EdtLogin.Text, EdtSenha.Text);

   end,
   TerminateLogin
   );

end;



function TfrmLogin.ServidorOnline: Boolean;
var
  Http: TNetHTTPClient;
  Resp: IHTTPResponse;
begin
  Result := False;

  Http := TNetHTTPClient.Create(nil);
  try
    Http.ConnectionTimeout := 1500; // 1,5 segundos
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
