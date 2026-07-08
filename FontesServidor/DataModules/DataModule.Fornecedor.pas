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
  DataModule.Servidor, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.Comp.DataSet;


type
  TDmFornecedor = class(TDataModule)
    qry: TFDQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure ConnBeforeConnect(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);

  private

  public
    function fornecedorListar(filtro: string): TJSONArray;
    function fornecedorListarId(pessoaId: integer): TJSONObject;
    function fornecedorInserir(nome, telefone, email, contato,
                                     telefone_contato: string): TJSONObject;
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
  dmServidor:= TDmServidor.Create(nil);
  ConnBeforeConnect(DmServidor.Conn);
  qry.Connection := dmServidor.Conn;

  TDataSetSerializeConfig.GetInstance.CaseNameDefinition := cndLower;
  TDataSetSerializeConfig.GetInstance.Import.DecimalSeparator := '.';
end;

procedure TDmFornecedor.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil( dmServidor );
end;

procedure TDmFornecedor.ConnBeforeConnect(Sender: TObject);
begin
  TEnvConfig.ConfigurarConexao(TFDConnection(Sender));
end;

function TDmFornecedor.fornecedorListar(filtro: string): TJSONArray;
begin

  result := nil;
  DmServidor.Conn.open;

  qry.SQL.Clear;
  qry.SQL.Text := 'select '+
                  '  p.pessoaId, p.nome, f.contato, f.telefone_contato '+
                  'from '+
                  '  fornecedor f, pessoa p '+
                  'where '+
                  '  p.pessoaId = f.pessoaId';

  if filtro <> '' then
  begin
    qry.SQL.Add(' and upper(p.nome) like :nome');
    qry.ParamByName('nome').asstring := '%' + uppercase(filtro) + '%';
  end;

  qry.SQL.Add('order by nome');
  qry.Open;

  Result := qry.ToJSONArray;

end;

function TDmFornecedor.fornecedorListarId(pessoaId: integer): TJSONObject;
begin

  result := nil;
  DmServidor.Conn.open;

  qry.SQL.Clear;
  qry.Connection := DmServidor.Conn;
  qry.SQL.Text := 'select '+
                  '  p.*, f.contato, f.telefone_contato ' +
                  'from '+
                  '  fornecedor f, pessoa p '+
                  'where '+
                  '  p.pessoaId = f.pessoaId and p.pessoaid =:pessoaid';

  qry.ParamByName('pessoaId').AsInteger := pessoaId;

  qry.Open;

  Result := qry.ToJSONObject;
end;



function TDmFornecedor.fornecedorInserir(nome, telefone, email, contato,
                                     telefone_contato: string): TJSONObject;
var
  novaPessoa :integer;
begin

  result := nil;
  DmServidor.Conn.open;
  try
    //pessoa
    dmServidor.Conn.StartTransaction;
    qry.SQL.Clear;
    qry.SQL.Add('INSERT INTO pessoa (nome, telefone, email)');
    qry.SQL.Add('VALUES (:nome, :telefone, :email)');
    qry.SQL.Add('RETURNING pessoaId');

    qry.ParamByName('nome').AsString := nome;
    qry.ParamByName('telefone').AsString := telefone;
    qry.ParamByName('email').Asstring  := email;
    qry.Open;
    novaPessoa := qry.fieldByName('pessoaId').Asinteger;

    //fornecedor
    qry.SQL.clear;
    qry.SQL.Add('INSERT INTO fornecedor (pessoaId, contato, telefone_contato)');
    qry.SQL.Add('VALUES (:pessoaId, :contato, :telefone_contato)');

    qry.ParamByName('pessoaId').Asinteger := novaPessoa;
    qry.ParamByName('contato').AsString := contato;
    qry.ParamByName('telefone_contato').AsString := telefone_contato;
    qry.execSQl;

    if DmServidor.Conn.InTransaction then
        DmServidor.Conn.Commit;


    Result := TJSONObject.Create;
    Result.AddPair('pessoaId', TJSONNumber.Create(novaPessoa));

  except
    DmServidor.Conn.Rollback;
    raise;
  end;

end;



function TDmFornecedor.fornecedorEditar(pessoaId: integer; nome,
  telefone, email, contato, telefone_contato: string): TJSONObject;
begin
  result := nil;
  DmServidor.Conn.open;
  try
    //pessoa
    dmServidor.Conn.StartTransaction;
    qry.SQL.Clear;
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
    qry.SQL.Add(' set contato=:contato, telefone_contato=:telefone_contato');
    qry.SQL.Add('where pessoaId =:pessoaId');
    qry.ParamByName('pessoaId').AsInteger := pessoaId;
    qry.ParamByName('contato').AsString := contato;
    qry.ParamByName('telefone_contato').AsString := telefone_contato;
    qry.ExecSQL;

    if DmServidor.Conn.InTransaction then
        DmServidor.Conn.Commit;

    // devolve um array contendo um pessoaId
    Result := TJSONObject.Create;
    Result.AddPair('pessoaId', TJSONNumber.Create(pessoaId));
  except
    DmServidor.Conn.Rollback;
    raise;
  end;
end;

function TDmFornecedor.fornecedorExcluir(pessoaId: integer): TJSONObject;
begin
  result := nil;
  DmServidor.Conn.open;

  qry.SQL.Clear;
  qry.Connection := DmServidor.conn;

  qry.SQL.Add('delete from fornecedor');
  qry.SQL.Add('where pessoaId =:pessoaId');
  qry.ParamByName('pessoaId').AsInteger := pessoaId;
  qry.ExecSQL;

  // devolve um array contendo uma pessoaId
  Result := TJSONObject.Create;
  Result.AddPair('pessoaId', TJSONNumber.Create(pessoaId));
end;

end.
