unit DataModule.Produto;

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
  TDmProduto = class(TDataModule)
    procedure DataModuleCreate(Sender: TObject);
    procedure ConnBeforeConnect(Sender: TObject);
  private

  public
    function produtoListar(filtro: string): TJSONArray;
    function produtoListarId(produtoId: integer): TJSONObject;
    function produtoInserir(descricao, unidade: string;
      estoque: integer): TJSONObject;
    function produtoEditar(produtoId: integer; descricao, unidade: string;
      estoque: integer): TJSONObject;
    function produtoExcluir(produtoId: integer): TJSONObject;
  end;

var
  DmProduto: TDmProduto;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDmProduto.ConnBeforeConnect(Sender: TObject);
begin
  TEnvConfig.ConfigurarConexao(TFDConnection(Sender));
end;


procedure TDmProduto.DataModuleCreate(Sender: TObject);
begin
  TDataSetSerializeConfig.GetInstance.CaseNameDefinition := cndLower;
  TDataSetSerializeConfig.GetInstance.Import.DecimalSeparator := '.';
end;

function TDmProduto.produtoInserir(descricao, unidade: string; estoque: integer): TJSONObject;
var
  dmServidor: TDMServidor;
  qry: TFDQuery;
begin

  result := nil;

  DmServidor := TDmServidor.Create(nil);
  qry := TFDQuery.Create(nil);

  try
    ConnBeforeConnect(DmServidor.Conn);
    DmServidor.Conn.open;

    qry.Connection := DmServidor.conn;

    qry.SQL.Add('INSERT INTO produto (descricao, unidade, estoque)');
    qry.SQL.Add('VALUES (:descricao, :unidade, :estoque)');
    qry.SQL.Add('RETURNING produtoId');

    qry.ParamByName('descricao').AsString := descricao;
    qry.ParamByName('unidade').AsString := unidade;
    qry.ParamByName('estoque').AsInteger  := estoque;

    qry.Open;

    if not qry.IsEmpty then
      result := qry.ToJSONObject;

  finally
    FreeAndNil(qry);
    dmServidor.Free;
  end;
end;

function TDmProduto.produtoListar(filtro: string): TJSONArray;
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
    qry.SQL.Text := 'select * from produto';

    if filtro <> '' then
    begin
      qry.SQL.Add('where upper(descricao) like :descricao');
      qry.ParamByName('descricao').asstring := '%' + uppercase(filtro) + '%';
    end;

    qry.SQL.Add('order by descricao');
    qry.Open;

    Result := qry.ToJSONArray;
  finally
    qry.Free;
    dmServidor.Free
  end;
end;

function TDmProduto.produtoListarId(produtoId: integer): TJSONObject;
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
      'select * from produto where produtoId = :produtoId';

    qry.ParamByName('produtoId').AsInteger := produtoId;

    qry.Open;

    Result := qry.ToJSONObject;
  finally
    qry.Free;
    dmServidor.Free
  end;
end;

function TDmProduto.produtoEditar(produtoId: integer;
                          descricao, unidade: string; estoque: integer): TJSONObject;
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

    qry.SQL.Add('update produto');
    qry.SQL.Add(' set descricao=:descricao, unidade=:unidade, estoque=:estoque');
    qry.SQL.Add('where produtoId =:produtoId');
    qry.ParamByName('produtoId').AsInteger := produtoId;
    qry.ParamByName('descricao').AsString := descricao;
    qry.ParamByName('unidade').AsString := unidade;
    qry.ParamByName('estoque').AsInteger := estoque;
    qry.ExecSQL;

    // devolve um array contendo um produto com id
    //result := TJSONObject.create(TJSONPair.create('produtoid', produtoid));
    Result := TJSONObject.Create;
    Result.AddPair('produtoId', TJSONNumber.Create(produtoId));
  finally
    freeandnil(qry);
    dmServidor.Free;
  end;
end;

function TDmProduto.produtoExcluir(produtoId: integer): TJSONObject;
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

    qry.SQL.Add('delete from produto');
    qry.SQL.Add('where produtoId =:produtoId');
    qry.ParamByName('produtoId').AsInteger := produtoId;
    qry.ExecSQL;

    // devolve um array contendo um produtoId com id
    //result := TJSONObject.create(TJSONPair.create('produtoId', produtoId));
    Result := TJSONObject.Create;
    Result.AddPair('produtoId', TJSONNumber.Create(produtoId));
  finally
    freeandnil(qry);
    dmServidor.Free;
  end;
end;




end.
