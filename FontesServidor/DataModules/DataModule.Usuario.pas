unit DataModule.Usuario;


interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.PG,
  FireDAC.Phys.PGDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.Phys.IBBase, fireDac.Stan.Param,
  dialogs,
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
    function InserirUsuario(nome, telefone, email, senha: string;
                            pessoaid, setorid: integer): TJSONObject;
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
  qry.SQL.Add('  pessoaid, usuarioid, nome, login ');
  qry.SQL.Add('from ');
  qry.SQL.Add('  usuario ');
  qry.SQL.Add('where ');
  qry.SQL.Add('  login = :login and senha = :senha');
  qry.ParamByName('login').AsString := login;
  qry.ParamByName('senha').AsString := senha ;
  qry.Open;

  if not qry.IsEmpty then
    result := qry.ToJSONObject;

end;

function TDmUsuario.InserirUsuario(nome, telefone, email, senha: string; pessoaid, setorid: integer): TJSONObject;
var
  novaPessoa, novoUsuario: integer;
begin

  result := nil;
  DmServidor.Conn.open;

  try
    DmServidor.Conn.StartTransaction;

    if pessoaid <= 0 then
    begin
      qry.SQL.clear;
      qry.SQL.Add('insert into pessoa ');
      qry.SQL.Add('  (nome, telefone, email) ');
      qry.SQL.Add('values ');
      qry.SQL.Add('  (:nome, :telefone, :email) ');
      qry.SQL.Add('returning pessoaid ');
      qry.ParamByName('nome').AsString := nome;
      qry.ParamByName('telefone').AsString := telefone;
      qry.ParamByName('email').AsString := email ;
      qry.active := true;
      novaPessoa:= qry.FieldByName('pessoaid').AsInteger;
    end;

    qry.SQL.clear;
    qry.SQL.Add('insert into usuario ');
    qry.SQL.Add('  (login, senha, nome, pessoaid, setorid) ');
    qry.SQL.Add('values ');
    qry.SQL.Add('  (:login, :senha, :nome, :pessoaid, :setorid) ');
    qry.SQL.Add('returning usuarioid ');
    qry.ParamByName('login').AsString := email;
    qry.ParamByName('senha').AsString := senha;
    qry.ParamByName('nome').AsString := nome ;
    if pessoaid <= 0 then
      qry.ParamByName('pessoaid').AsInteger := novaPessoa
    else
      qry.ParamByName('pessoaid').AsInteger := pessoaid;
    qry.ParamByName('setorid').AsInteger := setorid ;
    qry.active := true;
    novoUsuario:= qry.FieldByName('usuarioid').AsInteger;

    if DmServidor.Conn.InTransaction then
        DmServidor.Conn.Commit;

    Result := TJSONObject.Create;
    Result.AddPair('usuarioid', TJSONNumber.Create(novoUsuario));


  except
    DmServidor.Conn.Rollback;
    raise;

  end;
end;



end.
