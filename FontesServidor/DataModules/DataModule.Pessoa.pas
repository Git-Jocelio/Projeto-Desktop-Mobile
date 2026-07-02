unit DataModule.Pessoa;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.PG,
  FireDAC.Phys.PGDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.Phys.IBBase, fireDac.Stan.Param,

  DataSet.Serialize.Config, // necessário para tratar varaveis de consulta
  DataSet.Serialize,        // necessário para por transformar um dataset em um array JSON
  System.JSON,              // necessario para retorno do JSON
  FireDac.Dapt,             // necessario para trabalhar com qry dinanmicas
  Env.Conf,
  DataModule.Servidor, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.Comp.DataSet, dialogs;

type
  TDmPessoa = class(TDataModule)
    qry: TFDQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure ConnBeforeConnect(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
  public
    function pessoaListar(filtro: string): TJSONArray;
    function pessoaListarId(pessoaId: integer): TJSONObject;
    function pessoaInserir(nome, telefone, email: string): TJSONObject;
    function pessoaEditar(pessoaId: integer;
                          nome, telefone, email  : string): TJSONObject;

    function pessoaExcluir(pessoaId: integer): TJSONObject;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDmPessoa.ConnBeforeConnect(Sender: TObject);
begin

  //TEnvConfig.ConfigurarConexao(DmServidor.Conn);
  TEnvConfig.ConfigurarConexao(TFDConnection(Sender));

end;

procedure TDmPessoa.DataModuleCreate(Sender: TObject);
begin
  // antes de abrir a conexão, configura os parametros no onBeforeconnect
  dmServidor := TDmServidor.Create(nil);
  ConnBeforeConnect(DmServidor.Conn);
  qry.Connection := dmServidor.Conn;

  {esta duas linha dizem ao serialize como tratar as variaveis nas consultas sql}
  TDataSetSerializeConfig.GetInstance.CaseNameDefinition := cndLower;
  TDataSetSerializeConfig.GetInstance.Import.DecimalSeparator := '.';

end;

procedure TDmPessoa.DataModuleDestroy(Sender: TObject);
begin
  freeandnil(dmServidor);
end;

function TDmPessoa.pessoaListar(filtro: string): TJSONArray;
begin

  result := nil;

  DmServidor.Conn.open;

  qry.SQL.Text := 'select * from pessoa';

  if filtro <> '' then
  begin
    qry.SQL.Add('where upper(nome) like :nome');
    qry.ParamByName('nome').asstring := '%' + uppercase(filtro) + '%';
  end;

  qry.SQL.Add('order by nome');

  qry.Open;

  Result := qry.ToJSONArray;
end;

function TDmPessoa.pessoaListarId(pessoaId: integer): TJSONObject;
begin

  result := nil;

  DmServidor.Conn.open;
  qry.Connection := DmServidor.Conn;
  qry.SQL.Text :=
    'select * from pessoa where pessoaId = :pessoaId';

  qry.ParamByName('pessoaId').AsInteger := pessoaId;
  qry.Open;

  Result := qry.ToJSONObject;

end;

function TDmPessoa.pessoaInserir(nome, telefone, email: string): TJSONObject;
begin

  result := nil; // Inicializa o resultado para evitar lixo de memória
  DmServidor.Conn.open;

  qry.SQL.Add('INSERT INTO pessoa (nome, email, telefone)');
  qry.SQL.Add('VALUES (:nome, :email, :telefone)');
  qry.SQL.Add('RETURNING pessoaId');

  qry.ParamByName('nome').AsString     := nome;
  qry.ParamByName('email').AsString    := email;
  qry.ParamByName('telefone').AsString := telefone;

  qry.Open;

  Result := TJSONObject.Create;
  Result.AddPair('pessoaId', TJSONNumber.Create(qry.FieldByName('pessoaId').AsString));
end;


function TDmPessoa.pessoaEditar(pessoaId: integer;
                                 nome, telefone, email: string): TJSONObject;
begin

  result := nil; // Inicializa o resultado para evitar lixo de memória
  DmServidor.Conn.open;

  qry.SQL.Add('update pessoa');
  qry.SQL.Add(' set nome=:nome, telefone=:telefone, email=:email');
  qry.SQL.Add('where pessoaId =:pessoaId');
  qry.ParamByName('pessoaId').AsInteger := pessoaId;
  qry.ParamByName('nome').AsString := nome;
  qry.ParamByName('telefone').AsString := telefone;
  qry.ParamByName('email').AsString := email;
  qry.ExecSQL;

  Result := TJSONObject.Create;
  Result.AddPair('pessoaId', TJSONNumber.Create(pessoaId));
end;

function TDmPessoa.pessoaExcluir(pessoaId: integer): TJSONObject;
begin

  result := nil; // Inicializa o resultado para evitar lixo de memória
  DmServidor.Conn.open;

  qry.SQL.Add('delete from pessoa');
  qry.SQL.Add('where pessoaId =:pessoaId');
  qry.ParamByName('pessoaId').AsInteger := pessoaId;
  qry.ExecSQL;

  // devolve um array contendo uma  pessoas com id
  //result := TJSONObject.create(TJSONPair.create('pessoa_id', pessoa_id));
  Result := TJSONObject.Create;
  Result.AddPair('pessoaId', TJSONNumber.Create(pessoaId));

end;



end.
