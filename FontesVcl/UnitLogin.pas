unit UnitLogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Imaging.pngimage,
  Vcl.Loading,
  Vcl.Session,
  System.Net.HttpClient,
  System.Net.URLClient,
  System.Net.HttpClientComponent,
  Vcl.Imaging.jpeg,
  Vcl.ComCtrls;
type
  TfrmLogin = class(TForm)
    PageControl: TPageControl;
    tbsBoasVindas: TTabSheet;
    TabLogin: TTabSheet;
    tbsAtivarConta: TTabSheet;
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
    btnAtivarConta: TSpeedButton;
    Panel4: TPanel;
    btnAcessarLogin: TSpeedButton;
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
    Panel17: TPanel;
    edtNovaSenha: TEdit;
    Panel18: TPanel;
    edtConfirmarNovaSenha: TEdit;
    btnAtivarAcesso: TSpeedButton;
    lblLogin: TLabel;
    Label2: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    procedure BtnAcessarClick(Sender: TObject);
    procedure btnAcessarLoginClick(Sender: TObject);
    procedure btnAtivarContaClick(Sender: TObject);
    procedure Label6Click(Sender: TObject);
    procedure edtVoltarParaLoginClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnAtivarAcessoClick(Sender: TObject);
  private
    procedure TerminateLogin(Sender: TObject);
    function ServidorOnline: Boolean;
    procedure TerminateAtivarConta(Sender: TObject);
    function ValidarDados: boolean;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLogin: TfrmLogin;

implementation

{$R *.dfm}

uses UnitFrmPrincipal, DataModule.Usuario, Vcl.Config, Service.Usuario;



procedure TfrmLogin.TerminateLogin(Sender: TObject);
//var
//  I: Integer;
//  Permissao: TPermissaoTela;
//  Texto: string;
begin
   TLoading.Hide;

   if (Sender is TThread) then
     if Assigned(TThread(Sender).FatalException) then
     begin
       ShowMessage(Exception(TThread(Sender).FatalException).Message );
       FreeAndNil(dmUsuario);
       Exit;
     end;

   //pegar dados de acesso do usuario... devolvidos pelo servidor
   TSession.ID_USUARIO := dmUsuario.MemTable.fieldbyname('usuarioId').AsInteger;
   TSession.NOME := dmUsuario.MemTable.fieldbyname('nome').AsString;
   TSession.EMAIL := dmUsuario.MemTable.fieldbyname('login').AsString;
   TSession.PRIMEIRO_ACESSO := dmUsuario.MemTable.fieldbyname('primeiro_acesso').AsString;
   TSession.TOKEN := dmUsuario.MemTable.fieldbyname('token').AsString;
   TSession.STATUS := 'TESTE';

   // carrega as permissões do usuário
   dmUsuario.ListarPermissoesUsuario;

  (*
  //TESTE
  Texto := '';

  for I := 0 to TSession.QuantidadePermissoes - 1 do
  begin
    Permissao := TSession.ObterPermissao(I);

    Texto := Texto +
      'ID: ' + Permissao.ID_TELA.ToString +
      ' | Pai: ' + Permissao.TELA_PAI_ID.ToString +
      ' | Tela: ' + Permissao.NOME_TELA +
      ' | Ver: ' + BoolToStr(Permissao.VER, True) +
      ' | Inserir: ' + BoolToStr(Permissao.INSERIR, True) +
      sLineBreak;
  end;

  ShowMessage(Texto);
  //FIM TESTE
  *)

   FreeAndNil(dmUsuario);

   // Primeiro acesso?
   if TSession.PRIMEIRO_ACESSO = 'S' then
   begin
     PageControl.ActivePage := tbsAtivarConta;
     lblLogin.Caption := EdtLogin.Text;

     Exit;
   end;

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
  PageControl.ActivePageIndex := 0;
end;

procedure TfrmLogin.Label6Click(Sender: TObject);
begin
  PageControl.TabIndex := 2;
end;

procedure TfrmLogin.TerminateAtivarConta(Sender: TObject);
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
   TSession.PRIMEIRO_ACESSO := 'N';
   FreeAndNil(dmUsuario);
   ShowMessage('Conta ativada com sucesso!');
   ModalResult := mrOk;
end;

function TfrmLogin.ValidarDados: boolean;
begin
  result := false;

  if (edtNovaSenha.Text = '') or (edtConfirmarNovaSenha.Text = '') then
  begin
    ShowMessage('Informe todos dados : Senha provisória, nova senha e confirmação da nova senha' );
    exit;
  end;

  if (edtNovaSenha.Text) <> (edtConfirmarNovaSenha.Text) then
  begin
    ShowMessage('As senhas informadas não conferem... ');
    edtNovaSenha.SetFocus;
    exit;
  end;

  result := true;
end;

procedure TfrmLogin.btnAtivarAcessoClick(Sender: TObject);
begin
  if not ValidarDados then exit;
  TLoading.show(frmLogin);
  if not Assigned(dmUsuario) then
      dmUsuario := TdmUsuario.Create(nil);
  TLoading.ExecuteThread(procedure
  begin
    sleep(600);
    if not ServidorOnline then
      raise Exception.Create('Servidor não está disponível.');
    TServiceUsuario.AtivarConta(EdtSenha.Text);
  end,
  TerminateAtivarConta
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
      Resp := Http.Get( URL_BASE +'/health' );
      Result := Resp.StatusCode = 200;
    except
      Result := False;
    end;

  finally
    Http.Free;
  end;

end;

procedure TfrmLogin.btnAtivarContaClick(Sender: TObject);
begin
  PageControl.TabIndex := 2;
end;

procedure TfrmLogin.btnAcessarLoginClick(Sender: TObject);
begin
  PageControl.TabIndex := 1;
end;

end.
