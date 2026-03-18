unit DataModule.Produto;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  DataSet.Serialize.Config,
  RestRequest4D,
  DataSet.Serialize.Adapter.RESTRequest4D,
  System.JSON ;

type
  TDmProduto = class(TDataModule)
    tabProduto: TFDMemTable;
  private
  public
    procedure ListarProdutoID(memTable: TFDMemTable; produtoId: integer);
    procedure ListarProduto(memTable: TFDMemTable; filtro: string);
    procedure Editar(produtoId: integer; descricao, unidade: string;
      estoque: integer);
    procedure Inserir(descricao, unidade: string; estoque: integer);
    procedure Excluir(produtoId: integer);
  end;

var
  DmProduto: TDmProduto;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDmProduto.ListarProdutoID(memTable: TFDMemTable; produtoId: integer);
var
  resp : IResponse;
begin
  resp := TRequest.New.BaseURL('http://localhost:3000')
                      .Resource('/pessoa')
                      .ResourceSuffix(produtoId.ToString)
                      .Accept('application/json')
                      .Adapters(TDataSetSerializeAdapter.New(memTable))
                      .Get;
  // trata erro se houver
  if resp.StatusCode <> 200 then
    raise Exception.Create(resp.content);
end;


procedure TDmProduto.ListarProduto(memTable: TFDMemTable; filtro : string);
var
  resp : IResponse;
begin
  resp := TRequest.New.BaseURL('http://localhost:3000')
                      .Resource('/produto')
                      .AddParam('filtro',filtro)
                      .Accept('application/json')
                      .Adapters(TDataSetSerializeAdapter.New(memTable))
                      .Get;
  if resp.StatusCode <> 200 then
    raise Exception.Create(resp.content);

end;

procedure TDmProduto.Inserir(descricao, unidade: string; estoque: integer);
var
  resp : IResponse; // usado para receber respostas do servidor
  json : TJSONObject; // usado para criar um objeto json com os dados da pessoa
begin

  try
    // criar um objeto json com os dados do cliente
    json := TJSONObject.Create;
    json.AddPair('descricao',descricao);
    json.AddPair('unidade',unidade);
    json.AddPair('estoque',estoque);

    resp := TRequest.New.BaseURL('http://localhost:3000')   // criando uma requisição do servidor
                        .Resource('/pessoa')               // nessa rota
                        .AddBody(json.ToJSON)              // passando um json como string com dados da pessoa
                        .Accept('application/json')        // trabalhar com json
                        .Post;                             // passando um Post
    // trata erro se houver
    if resp.StatusCode <> 201 then
      raise Exception.Create(resp.content);

  finally
    freeandnil(json);
  end;
end;


procedure TDmProduto.Editar(produtoId: integer; descricao, unidade: string; estoque: integer);
var
  resp : IResponse; // usado para receber respostas do servidor
  json : TJSONObject; // usado para criar um objeto json com os dados da pessoa
begin

  try
    // criar um objeto json com os dados do cliente
    json := TJSONObject.Create;
    json.AddPair('descricao',descricao);
    json.AddPair('unidade',unidade);
    json.AddPair('estoque',estoque);

    resp := TRequest.New.BaseURL('http://localhost:3000') // criando uma requisição do servidor
                        .Resource('/pessoa')              // nessa rota
                        .ResourceSuffix(produtoId.ToString) // acrescenta o parametro pessoa_id recebido na url
                        .AddBody(json.ToJSON)             // passando um json como string com dados da pessoa
                        .Accept('application/json')       // trabalhar com json
                        .Put;                             // passando um Post
    // trata erro se houver
    if resp.StatusCode <> 200 then
      raise Exception.Create(resp.content);

  finally
    freeandnil(json);
  end;
end;



procedure TDmProduto.Excluir(produtoId: integer);
var
  resp : IResponse;
begin

    resp := TRequest.New.BaseURL('http://localhost:3000')
                        .Resource('/produto')
                        .ResourceSuffix(produtoId.ToString)
                        .Accept('application/json')
                        .delete;
    if resp.StatusCode <> 200 then
      raise Exception.Create(resp.content);
end;





end.
