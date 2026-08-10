unit DataModule.Usuario;


interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.PG,
  FireDAC.Phys.PGDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.Phys.IBBase, fireDac.Stan.Param,
  dialogs, System.Math,
  DataSet.Serialize.Config, // necessário para tratar varaveis de consulta
  DataSet.Serialize,        // necessário para por transformar um dataset em um array JSON
  System.JSON,              // necessario para retorno do JSON
  FireDac.Dapt,             // necessario para trabalhar com qry dinanmicas
  Env.Conf,
  DataModule.Servidor,
  uMD5, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.Comp.DataSet;

type
  TDmUsuario = class(TDataModule)
    qry: TFDQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure ConnBeforeConnect(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
  public
    function usuarioLogin(login, senha: string): TJSONObject;
    function InserirUsuario( login, senha: string; pessoaid: integer): TJSONObject;
    procedure EditarSenha(usuarioid: integer; senha: string);
    procedure EditarUsuario(usuarioid: integer; login, ativo: string);
    function listarUsuarioId(usuarioid: integer): TJSONObject;
    function listarUsuarioByLogin(login: string): TJSONObject;
    function listarTodos: TJSONArray;
    procedure AtivarConta(usuarioid: integer; senha: string);
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDmUsuario.ConnBeforeConnect(Sender: TObject);
begin
  // configura a TFDConnection através arquivo .env
  // TEnvConfig.ConfigurarConexao(DmServidor.Conn);
  TEnvConfig.ConfigurarConexao(TFDConnection(Sender));
end;

procedure TDmUsuario.DataModuleCreate(Sender: TObject);
begin
  dmServidor := TDmServidor.Create(nil);
  ConnBeforeConnect(DmServidor.Conn);
  qry.Connection := DmServidor.Conn;

  {esta duas linha dizem ao serialize como tratar as variaveis nas consultas sql}
  TDataSetSerializeConfig.GetInstance.CaseNameDefinition := cndLower;
  TDataSetSerializeConfig.GetInstance.Import.DecimalSeparator := '.';
end;

procedure TDmUsuario.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(DmServidor);
end;

function TDmUsuario.usuarioLogin(login, senha: string): TJSONObject;
begin

  result := nil; // Inicializa o result para evitar lixo de memória

  DmServidor.Conn.open;

  qry.SQL.clear;
  qry.SQL.Add('select ');
  qry.SQL.Add('  u.pessoaid, u.usuarioid, p.nome, u.login, primeiro_acesso ');
  qry.SQL.Add('from ');
  qry.SQL.Add('  usuario u, pessoa p');
  qry.SQL.Add('where ');
  qry.SQL.Add('  p.pessoaid = u.pessoaid ');
  qry.SQL.Add('  and login = :login and senha = :senha');
  qry.ParamByName('login').AsString := login;
  qry.ParamByName('senha').AsString := senha ;
  qry.Open;

  if not qry.IsEmpty then
    result := qry.ToJSONObject;

end;


// cria um usuário para um colaborador!
function TDmUsuario.InserirUsuario( login, senha: string; pessoaid: integer): TJSONObject;
var
  novoUsuario: integer;
begin

  result := nil;
  DmServidor.Conn.open;

  try
    DmServidor.Conn.StartTransaction;
    qry.SQL.clear;
    qry.SQL.Add('insert into usuario ');
    qry.SQL.Add('  (login, senha, pessoaid, ativo, primeiro_acesso) ');
    qry.SQL.Add('values ');
    qry.SQL.Add('  (:login, :senha, :pessoaid, :ativo, :primeiro_acesso )');
    qry.SQL.Add('returning usuarioid, login, pessoaid ');
    qry.ParamByName('login').AsString := login;
    qry.ParamByName('senha').AsString := senha;
    qry.ParamByName('pessoaid').AsInteger := pessoaid;
    qry.ParamByName('ativo').AsString := 'N' ;
    qry.ParamByName('primeiro_acesso').AsString := 'S' ;
    qry.active := true;
    novoUsuario:= qry.FieldByName('usuarioid').AsInteger;

    if DmServidor.Conn.InTransaction then
        DmServidor.Conn.Commit;

    Result := TJSONObject.Create;
    Result.AddPair('usuarioid', TJSONNumber.Create(novoUsuario));
    Result.AddPair('pessoaid', qry.FieldByName('pessoaid').AsString);
    Result.AddPair('login', qry.FieldByName('login').AsString);

  except
    DmServidor.Conn.Rollback;
    raise;
  end;

end;

procedure TDmUsuario.EditarSenha(usuarioid: integer; senha: string);
begin

  DmServidor.Conn.open;

  qry.SQL.clear;
  qry.SQL.Add('update usuario set senha =:senha where usuarioid =:usuarioid ');
  qry.ParamByName('usuarioid').AsInteger := usuarioid;
  qry.ParamByName('senha').AsString := senha ;
  qry.ExecSQL;

end;

procedure TDmUsuario.AtivarConta(usuarioid: integer; senha: string);
begin

  DmServidor.Conn.open;

  qry.SQL.clear;
  qry.SQL.Add('update usuario set senha =:senha, primeiro_acesso =:primeiro_acesso, ');
  qry.SQL.Add('ativo =:ativo, data_ultima_troca =:data_ultima_troca ');
  qry.SQL.Add('where usuarioid =:usuarioid ');
  qry.ParamByName('usuarioid').AsInteger := usuarioid;
  qry.ParamByName('senha').AsString := senha ;
  qry.ParamByName('primeiro_acesso').AsString := 'N' ;
  qry.ParamByName('ativo').AsString := 'S';
  qry.ParamByName('data_ultima_troca').AsDateTime := now() ;
  qry.ExecSQL;

end;



function TDmUsuario.listarUsuarioId(usuarioid: integer): TJSONObject;
begin

  result := nil; // Inicializa o result para evitar lixo de memória

  DmServidor.Conn.open;

  qry.SQL.clear;
  qry.SQL.Add('select ');
  qry.SQL.Add('  p.pessoaid, p.nome, u.login, ativo, primeiro_acesso ');
  qry.SQL.Add('from ');
  qry.SQL.Add('  pessoa p, usuario u ');
  qry.SQL.Add('where ');
  qry.SQL.Add('  p.pessoaid = u.pessoaid ');
  qry.SQL.Add('  and u.usuarioid = :usuarioid ');
  qry.ParamByName('usuarioid').AsInteger := usuarioid;
  qry.Open;

  if not qry.IsEmpty then
    result := qry.ToJSONObject;

end;

function TDmUsuario.listarUsuarioByLogin(login: string): TJSONObject;
begin
  result := nil;
  DmServidor.Conn.open;
  qry.SQL.clear;
  qry.SQL.Add('select login from usuario where login =:login');
  qry.ParamByName('login').value := login;
  qry.Open;
  if not qry.IsEmpty then
    result := qry.ToJSONObject;
end;

procedure TDmUsuario.EditarUsuario(usuarioid: integer; login, ativo: string);
begin
  DmServidor.Conn.open;
  qry.SQL.clear;
  qry.SQL.Add('update usuario set ');
  qry.SQL.Add('  login =:login, ');
  qry.SQL.Add('  ativo =:ativo, ');
  qry.SQL.Add('  data_ultima_troca =:data_ultima_troca ');
  qry.SQL.Add('where usuarioid =:usuarioid ');
  qry.ParamByName('usuarioid').Value := usuarioid;
  qry.ParamByName('login').Value := login;
  qry.ParamByName('ativo').Value := ativo;
  qry.ParamByName('data_ultima_troca').Value := Now;
  qry.ExecSQL;
end;

function TDmUsuario.listarTodos: TJSONArray;
begin
  result := nil;
  DmServidor.Conn.open;
  qry.SQL.clear;
  qry.SQL.Add('select ');
  qry.SQL.Add('  p.pessoaid, p.nome, p.telefone, p.email, p.cpf, ');
  qry.SQL.Add('  u.login, u.ativo ');
  qry.SQL.Add('from ');
  qry.SQL.Add('  pessoa p, usuario u');
  qry.SQL.Add('where ');
  qry.SQL.Add('  p.pessoaid = u.pessoaid ');
  qry.SQL.Add('order by p.nome ');
  qry.Open;

  if not qry.IsEmpty then
    result := qry.ToJSONArray;
end;


end.
