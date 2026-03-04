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
  DataModule.Servidor;

type
  TDmPessoa = class(TDataModule)
    procedure DataModuleCreate(Sender: TObject);
    procedure ConnBeforeConnect(Sender: TObject);
  private
  public
    function pessoaListar(filtro: string): TJSONArray;
    function pessoaListarId(pessoaId: integer): TJSONObject;
    function pessoaInserir(nome, telefone, setor: string): TJSONObject;
    function pessoaEditar(pessoaId: integer; nome, telefone,
      setor: string): TJSONObject;
    function pessoaExcluir(pessoaId: integer): TJSONObject;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDmPessoa.ConnBeforeConnect(Sender: TObject);
begin
  // configura a TFDConnection através arquivo .env
  TEnvConfig.ConfigurarConexao(DmServidor.Conn);
end;

procedure TDmPessoa.DataModuleCreate(Sender: TObject);
begin
  {esta duas linha dizem ao serialize como tratar as variaveis nas consultas sql}
  TDataSetSerializeConfig.GetInstance.CaseNameDefinition := cndLower;
  TDataSetSerializeConfig.GetInstance.Import.DecimalSeparator := '.';

  // antes de abrir a conexão, configura os parametros no onBeforeconnect
  DmServidor.Conn.open;

end;

function TDmPessoa.pessoaListar(filtro: string): TJSONArray;
var
  dmServidor: TDMServidor;
  qry : TFDquery;
begin
  qry := TFDQuery.Create(nil);
  try
    dmServidor := TDmServidor.Create(nil);
    qry.Connection := dmServidor.Conn;
    qry.SQL.Text := 'select * from pessoa';

    if filtro <> '' then
    begin
      qry.SQL.Add('where upper(nome) like :nome');
      qry.ParamByName('nome').asstring := '%' + uppercase(filtro) + '%';
    end;

    qry.SQL.Add('order by nome');

    qry.Open;

    Result := qry.ToJSONArray;
  finally
    qry.Free;
    dmServidor.Free
  end;
end;

function TDmPessoa.pessoaListarId(pessoaId: integer): TJSONObject;
var
  dmServidor: TDMServidor;
  qry : TFDquery;
begin
  qry := TFDQuery.Create(nil);
  try
    dmServidor := TDmServidor.Create(nil);
    qry.Connection := DmServidor.Conn;
    qry.SQL.Text :=
      'select * from pessoa where pessoaId = :pessoaId';

    qry.ParamByName('pessoaId').AsInteger := pessoaId;

    qry.Open;

    Result := qry.ToJSONObject;
  finally
    qry.Free;
    dmServidor.Free;
  end;
end;



function TDmPessoa.pessoaInserir(nome, telefone, setor: string): TJSONObject;
var
  dmServidor: TDMServidor;
  qry: TFDQuery;
begin

  result := nil; // Inicializa o resultado para evitar lixo de memória
  qry := TFDQuery.Create(nil);

  try
    dmServidor := TDmServidor.Create(nil);
    qry.Connection := DmServidor.conn;

    qry.SQL.Add('INSERT INTO pessoa (nome, telefone, setor)');
    qry.SQL.Add('VALUES (:nome, :telefone, :setor)');
    qry.SQL.Add('RETURNING pessoaId');

    qry.ParamByName('nome').AsString     := nome;
    qry.ParamByName('telefone').AsString := telefone;
    qry.ParamByName('setor').AsString    := setor;

    qry.Open;

    if not qry.IsEmpty then
      result := qry.ToJSONObject;

  finally
    FreeAndNil(qry);
    dmServidor.Free;
  end;
end;

function TDmPessoa.pessoaEditar(pessoaId: integer;
                          nome, telefone, setor: string): TJSONObject;
var
  dmServidor: TDMServidor;
  qry : TFDquery;
begin
  try
    dmServidor := TDmServidor.Create(nil);
    qry := TFDquery.Create(nil);
    qry.Connection := DmServidor.conn;

    qry.SQL.Add('update pessoa');
    qry.SQL.Add(' set nome=:nome, telefone=:telefone, setor=:setor');
    qry.SQL.Add('where pessoaId =:pessoaId');
    qry.ParamByName('pessoaId').AsInteger := pessoaId;
    qry.ParamByName('nome').AsString := nome;
    qry.ParamByName('telefone').AsString := telefone;
    qry.ParamByName('setor').AsString := setor;
    qry.ExecSQL;

    // devolve um array contendo uma  pessoas com id
    //result := TJSONObject.create(TJSONPair.create('pessoa_id', pessoa_id));
    Result := TJSONObject.Create;
    Result.AddPair('pessoaId', TJSONNumber.Create(pessoaId));
  finally
    freeandnil(qry);
    dmServidor.Free;
  end;
end;

function TDmPessoa.pessoaExcluir(pessoaId: integer): TJSONObject;
var
  dmServidor: TDMServidor;
  qry : TFDquery;
begin
  try
    dmServidor := TDmServidor.Create(nil);
    qry := TFDquery.Create(nil);
    qry.Connection := DmServidor.conn;

    qry.SQL.Add('delete from pessoa');
    qry.SQL.Add('where pessoaId =:pessoaId');
    qry.ParamByName('pessoaId').AsInteger := pessoaId;
    qry.ExecSQL;

    // devolve um array contendo uma  pessoas com id
    //result := TJSONObject.create(TJSONPair.create('pessoa_id', pessoa_id));
    Result := TJSONObject.Create;
    Result.AddPair('pessoaId', TJSONNumber.Create(pessoaId));
  finally
    freeandnil(qry);
    dmServidor.Free;
  end;
end;



end.
