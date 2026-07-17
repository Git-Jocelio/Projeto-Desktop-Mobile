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
  Vcl.Imaging.jpeg, Vcl.ComCtrls;
type
  TfrmLogin = class(TForm)
    PageControl: TPageControl;
    tbsBoasVindas: TTabSheet;
    TabLogin: TTabSheet;
    tbsNovaConta: TTabSheet;
    pnLogin: TPanel;
    Label1: TLabel;
    Label3: TLabel;
    Senha: TLabel;
    PnlBotaoAcessar: TPanel;
    BtnAcessar: TSpeedButton;
    Panel2: TPanel;
    EdtLogin: TEdit;
    Panel3: TPanel;
    EdtSenha: TEdit;
    pnlDireito: TPanel;
    pnlTopo: TPanel;
    pnlCentro: TPanel;
    Label4: TLabel;
    Panel6: TPanel;
    pnlRodape: TPanel;
    imgLogoSistema: TImage;
    Panel1: TPanel;
    SpeedButton1: TSpeedButton;
    Panel4: TPanel;
    SpeedButton2: TSpeedButton;
    Panel5: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    Panel9: TPanel;
    Image1: TImage;
    Panel10: TPanel;
    Panel11: TPanel;
    Panel12: TPanel;
    Panel13: TPanel;
    pnlNovaconta: TPanel;
    Label5: TLabel;
    Image2: TImage;
    Panel15: TPanel;
    Label6: TLabel;
    edtVoltarParaLogin: TLabel;
    Panel14: TPanel;
    edtNome: TEdit;
    Panel16: TPanel;
    edtEmail: TEdit;
    Panel17: TPanel;
    edtCriarSenha: TEdit;
    Panel18: TPanel;
    edtCriarSenha2: TEdit;
    btnCriarconta: TSpeedButton;
    procedure BtnAcessarClick(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure Label6Click(Sender: TObject);
    procedure edtVoltarParaLoginClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCriarcontaClick(Sender: TObject);
  private
    procedure TerminateLogin(Sender: TObject);
    function ServidorOnline: Boolean;
    procedure TerminateCriarConta(Sender: TObject);
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
       FreeAndNil(dmUsuario);
       Exit;
     end;

   // pegar dados de acesso do usuario... devolvidos pelo servidor
   TSession.ID_USUARIO := dmUsuario.MemTable.fieldbyname('usuarioId').AsInteger;
   TSession.NOME       := dmUsuario.MemTable.fieldbyname('nome').AsString;
   TSession.EMAIL      := dmUsuario.MemTable.fieldbyname('login').AsString;
   TSession.TOKEN      := dmUsuario.MemTable.fieldbyname('token').AsString;
   TSession.STATUS     := 'TESTE';

   FreeAndNil(dmUsuario);

   ModalResult := mrOk;

end;

procedure TfrmLogin.BtnAcessarClick(Sender: TObject);
begin

   TLoading.show(frmLogin);

   if not Assigned(dmUsuario) then
      dmUsuario := TdmUsuario.Create(nil);

   TLoading.ExecuteThread(procedure
   begin
      sleep(600);

      if not ServidorOnline then
            raise Exception.Create('Servidor não está disponível.');

      dmUsuario.Login(EdtLogin.Text, EdtSenha.Text);

   end,
   TerminateLogin
   );

end;



procedure TfrmLogin.FormShow(Sender: TObject);
begin
  PageControl.ActivePageIndex := 1;
end;

procedure TfrmLogin.Label6Click(Sender: TObject);
begin
  PageControl.TabIndex := 2;
end;

procedure TfrmLogin.TerminateCriarConta(Sender: TObject);
begin
   TLoading.Hide;

   if (Sender is TThread) then
     if Assigned(TThread(Sender).FatalException) then
     begin
       ShowMessage(Exception(TThread(Sender).FatalException).Message );
       FreeAndNil(dmUsuario);
       Exit;
     end;

   // pegar dados de acesso do usuario... devolvidos pelo servidor
   TSession.ID_USUARIO := dmUsuario.MemTable.fieldbyname('usuarioId').AsInteger;
   TSession.EMAIL      := dmUsuario.MemTable.fieldbyname('email').AsString;
   TSession.NOME       := dmUsuario.MemTable.fieldbyname('nome').AsString;
   TSession.TOKEN      := '123';
   TSession.STATUS     := 'TESTE';

   FreeAndNil(dmUsuario);

   ModalResult := mrOk;

end;



procedure TfrmLogin.btnCriarcontaClick(Sender: TObject);
begin

   TLoading.show(frmLogin);

   if not Assigned(dmUsuario) then
      dmUsuario := TdmUsuario.Create(nil);

   TLoading.ExecuteThread(procedure
   begin
      sleep(600);

      if not ServidorOnline then
            raise Exception.Create('Servidor não está disponível.');

      dmUsuario.CriarConta(EdtNome.Text, '11-95936-5875', edtEmail.Text,  EdtSenha.Text);

   end,
   TerminateCriarConta
   );

end;

procedure TfrmLogin.edtVoltarParaLoginClick(Sender: TObject);
begin
  PageControl.TabIndex := 1;
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

procedure TfrmLogin.SpeedButton1Click(Sender: TObject);
begin
  PageControl.TabIndex := 2;
end;

procedure TfrmLogin.SpeedButton2Click(Sender: TObject);
begin
  PageControl.TabIndex := 1;
end;

end.
