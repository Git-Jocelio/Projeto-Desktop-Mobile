unit UnitFormUsuarioE;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UnitFormBaseEdicao, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.Buttons, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.DBCtrls,
  Vcl.Loading, Vcl.Navigation, System.StrUtils;

type
  TFormUsuarioE = class(TFormBaseEdicao)
    Label4: TLabel;
    Label2: TLabel;
    edtLogin: TEdit;
    cbAtivo: TCheckBox;
    dsColaboradores: TDataSource;
    cbxColaboradores: TDBLookupComboBox;
    procedure FormShow(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
  private
    FOperacao: string;
    procedure ListarColaboradores;
    function Validar: boolean;
    procedure TerminateSalvar(Sender: TObject);
    procedure TerminateUsuarioE(Sender: TObject);
  public
    property Operacao: string read FOperacao write FOperacao;
  end;

var
  FormUsuarioE: TFormUsuarioE;

implementation

{$R *.dfm}

uses DataModule.Usuario, Service.Usuario, Vcl.Session;

procedure TFormUsuarioE.TerminateSalvar(Sender: TObject);
begin
  TLoading.Hide;
  if (Sender is TThread) then
    if Assigned(TThread(Sender).FatalException) then
    begin
      ShowMessage( Exception(TThread(Sender).FatalException).Message );
      exit;
    end;

  TNavigation.Close(self);
end;


procedure TFormUsuarioE.btnSalvarClick(Sender: TObject);

begin
  inherited;
  if not Validar then exit;
  TLoading.Show;
  TLoading.ExecuteThread(
      procedure
      begin
        sleep(500);
        if Operacao = 'opIncluir' then
          TServiceUsuario.CriarConta(
                                 edtLogin.Text,
                                  '12345678',// senha inicial ao criar um usuario
                                 ifThen(cbAtivo.Checked,'S','N'),
                                 'N', //primeiro acesso
                                 cbxColaboradores.KeyValue //pessoaid
                                 )
       else
       if Operacao = 'opAlterar' then
       begin

         TServiceUsuario.AlterarUsuario(
                                 edtLogin.Text,
                                 ifThen(cbAtivo.Checked,'S','N'),
                                 TSession.ID_USUARIO
                                 );
       end;
      end,
      TerminateSalvar
  );
end;

procedure TFormUsuarioE.TerminateUsuarioE(Sender: TObject);
begin
  TLoading.Hide;

  if (Sender is TThread) then
    if Assigned(TThread(Sender).FatalException) then
    begin
      ShowMessage( Exception(TThread(Sender).FatalException).Message );
      exit;
    end;

  // se não der erro, carrega dos edits
  cbxColaboradores.KeyValue := MemTable.FieldByName('pessoaid').AsInteger;
  edtLogin.Text := MemTable.FieldByName('login').AsString;
  cbAtivo.Checked := MemTable.FieldByName('ativo').AsString = 'S';

end;


procedure TFormUsuarioE.FormShow(Sender: TObject);
begin
  inherited;


  // busca colaboradores no banco para listar no combobox
  ListarColaboradores;

  if TNavigation.ParamInt > 0 then
  begin
    Operacao := 'opAlterar';
    lblTitulo.Caption := lblTitulo.Caption + ' - Editar';
    cbxColaboradores.Enabled := false;

    TLoading.Show;
    TLoading.ExecuteThread(procedure
    begin
       sleep(500);
       dmUsuario.ListarId(MemTable, TNavigation.ParamInt);
    end,
    TerminateUsuarioE
    );
  end
  else Operacao := 'opIncluir';

end;

function TFormUsuarioE.Validar: boolean;
begin
  result := false;
  if cbxColaboradores.Text = '' then
  begin
    ShowMessage('Selecione um colaborador.');
    cbxColaboradores.SetFocus;
    exit;
  end;

  if edtLogin.Text = '' then
  begin
    ShowMessage('Informe um Login.');
    edtLogin.SetFocus;
    exit;
  end;

  result := true;
end;


procedure TFormUsuarioE.ListarColaboradores;
begin
  dmUsuario.ListarColaboradores;
end;

end.
