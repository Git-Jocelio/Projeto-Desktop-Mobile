unit DataModule.Fornecedor;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.PG,
  FireDAC.Phys.PGDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.Phys.IBBase, fireDac.Stan.Param,   dialogs,

  DataSet.Serialize.Config,
  DataSet.Serialize,
  System.JSON,
  FireDac.Dapt,
  Env.Conf,
  DataModule.Servidor;


type
  TDmFornecedor = class(TDataModule)
    procedure DataModuleCreate(Sender: TObject);
    procedure ConnBeforeConnect(Sender: TObject);

  private

  public
    function fornecedorListar(filtro: string): TJSONArray;
    function fornecedorListarId(pessoaId: integer): TJSONObject;
    function fornecedorInserir(nome, telefone, email, contato,
                                     telefone_forcecedor: string): TJSONObject;
    function fornecedorEditar(pessoaId: integer; nome,
      telefone, email, contato, telefone_contato: string): TJSONObject;
    function fornecedorExcluir(pessoaId: integer): TJSONObject;
  end;

var
  DmFornecedor: TDmFornecedor;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDmFornecedor.DataModuleCreate(Sender: TObject);
begin
  TDataSetSerializeConfig.GetInstance.CaseNameDefinition := cndLower;
  TDataSetSerializeConfig.GetInstance.Import.DecimalSeparator := '.';
end;

procedure TDmFornecedor.ConnBeforeConnect(Sender: TObject);
begin
  TEnvConfig.ConfigurarConexao(TFDConnection(Sender));
end;

function TDmFornecedor.fornecedorListar(filtro: string): TJSONArray;
var
  dmServidor: TDMServidor;
  qry : TFDquery;
begin
  qry := TFDQuery.Create(nil);
  DmServidor := TDmServidor.Create(nil);

  try
    ConnBeforeConnect(DmServidor.Conn);
    DmServidor.Conn.open;

    qry.Connection := DmServidor.Conn;
    qry.SQL.Text := 'select p.nome, f.contato, f.telefone from fornecedor f, pessoa p where p.pessoaId = f.pessoaId';

    if filtro <> '' then
    begin
      qry.SQL.Add(' and upper(p.nome) like :nome');
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

function TDmFornecedor.fornecedorListarId(pessoaId: integer): TJSONObject;
var
  dmServidor: TDMServidor;
  qry : TFDquery;
begin
  DmServidor := TDmServidor.Create(nil);
  qry := TFDQuery.Create(nil);

  try
    ConnBeforeConnect(DmServidor.Conn);
    DmServidor.Conn.open;

    qry.Connection := DmServidor.Conn;
    qry.SQL.Text :=
      'select p.*, f.contato, f.telefone from fornecedor f, pessoa p where p.pessoaId = f.pessoaId and p.pessoaid =:pessoaid';

    qry.ParamByName('pessoaId').AsInteger := pessoaId;

    qry.Open;

    Result := qry.ToJSONObject;
  finally
    qry.Free;
    dmServidor.Free
  end;
end;



function TDmFornecedor.fornecedorInserir(nome, telefone, email, contato,
                                     telefone_forcecedor: string): TJSONObject;
var
  dmServidor: TDMServidor;
  qry: TFDQuery;
  newPessoa :integer;
begin

  result := nil;

  DmServidor := TDmServidor.Create(nil);
  qry := TFDQuery.Create(nil);

  try
    ConnBeforeConnect(DmServidor.Conn);
    DmServidor.Conn.open;

    qry.Connection := DmServidor.conn;
    //pessoa
    qry.SQL.Add('INSERT INTO pessoa (nome, telefone, email)');
    qry.SQL.Add('VALUES (:nome, :telefone, :email)');
    qry.SQL.Add('RETURNING pessoaId');

    qry.ParamByName('nome').AsString := nome;
    qry.ParamByName('telefone').AsString := telefone;
    qry.ParamByName('email').Asstring  := email;
    qry.Open;
    newPessoa := qry.fieldByName('pessoaId').Asinteger;

    //fornecedor
    qry.SQL.clear;
    qry.SQL.Add('INSERT INTO fornecedor (pessoaId, contato, telefone)');
    qry.SQL.Add('VALUES (:pessoaId, :contato, :telefone)');

    qry.ParamByName('pessoaId').Asinteger := newPessoa;
    qry.ParamByName('cotato').AsString := contato;
    qry.ParamByName('telefone').AsString := telefone_forcecedor;
    qry.execSQl;


    if not qry.IsEmpty then
      result := qry.ToJSONObject;

  finally
    FreeAndNil(qry);
    dmServidor.Free;
  end;
end;



function TDmFornecedor.fornecedorEditar(pessoaId: integer; nome,
  telefone, email, contato, telefone_contato: string): TJSONObject;
var
  dmServidor: TDMServidor;
  qry : TFDquery;
begin
  dmServidor := TDmServidor.Create(nil);
  qry := TFDquery.Create(nil);
  try
    ConnBeforeConnect(DmServidor.Conn);
    DmServidor.Conn.open;

    qry.Connection := DmServidor.conn;
    //pessoa
    qry.SQL.Add('update pessoa');
    qry.SQL.Add(' set nome=:nome, telefone=:telefone, email=:email');
    qry.SQL.Add('where pessoaId =:pessoaId');
    qry.ParamByName('pessoaId').AsInteger := pessoaId;
    qry.ParamByName('nome').AsString := nome;
    qry.ParamByName('telefone').AsString := telefone;
    qry.ParamByName('email').AsString := email;
    qry.ExecSQL;
    //fornecedor
    qry.SQL.clear;
    qry.SQL.Add('update fornecedor');
    qry.SQL.Add(' set contato=:contato, telefone=:telefone');
    qry.SQL.Add('where pessoaId =:pessoaId');
    qry.ParamByName('pessoaId').AsInteger := pessoaId;
    qry.ParamByName('contato').AsString := contato;
    qry.ParamByName('telefone').AsString := telefone_contato;
    qry.ExecSQL;

    // devolve um array contendo um pessoaId
    Result := TJSONObject.Create;
    Result.AddPair('pessoaId', TJSONNumber.Create(pessoaId));
  finally
    freeandnil(qry);
    dmServidor.Free;
  end;
end;

function TDmFornecedor.fornecedorExcluir(pessoaId: integer): TJSONObject;
var
  dmServidor: TDMServidor;
  qry : TFDquery;
begin
  dmServidor := TDmServidor.Create(nil);
  qry := TFDquery.Create(nil);

  try
    ConnBeforeConnect(DmServidor.Conn);
    DmServidor.Conn.open;

    qry.Connection := DmServidor.conn;

    qry.SQL.Add('delete from fornecedor');
    qry.SQL.Add('where pessoaId =:pessoaId');
    qry.ParamByName('pessoaId').AsInteger := pessoaId;
    qry.ExecSQL;

    // devolve um array contendo uma pessoaId
    Result := TJSONObject.Create;
    Result.AddPair('pessoaId', TJSONNumber.Create(pessoaId));
  finally
    freeandnil(qry);
    dmServidor.Free;
  end;
end;

end.
