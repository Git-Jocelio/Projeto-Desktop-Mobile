unit DataModule.Fornecedor;

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
  TDmFornecedor = class(TDataModule)
    TabFornecedor: TFDMemTable;
  private
  public
    procedure ListarFornecedor(memTable: TFDMemTable; filtro: string);
    procedure ListarFornecedorId(memTable: TFDMemTable; pessoaId: integer);
    procedure Inserir(nome, telefone, email, contato, telefone_contato: string);
    procedure Editar(pessoaId: integer; nome, telefone, email, contato,
      telefone_contato: string);
    procedure Excluir(pessoaId: integer);
  end;

var
  DmFornecedor: TDmFornecedor;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}


procedure TDmFornecedor.ListarFornecedor(memTable: TFDMemTable; filtro : string);
var
  resp : IResponse;
begin
  resp := TRequest.New.BaseURL('http://localhost:3000')
                      .Resource('/fornecedor')
                      .AddParam('filtro',filtro)
                      .Accept('application/json')
                      .Adapters(TDataSetSerializeAdapter.New(memTable))
                      .Get;
  if resp.StatusCode <> 200 then
    raise Exception.Create(resp.content);

end;

procedure TDmFornecedor.ListarFornecedorId(memTable: TFDMemTable; pessoaId: integer);
var
  resp : IResponse;
begin
  resp := TRequest.New.BaseURL('http://localhost:3000')
                      .Resource('/fornecedor')
                      .ResourceSuffix(pessoaId.ToString)
                      .Accept('application/json')
                      .Adapters(TDataSetSerializeAdapter.New(memTable))
                      .Get;
  if resp.StatusCode <> 200 then
    raise Exception.Create(resp.content);

end;


procedure TDmFornecedor.Inserir(nome, telefone, email, contato, telefone_contato: string );
var
  resp : IResponse;
  json : TJSONObject;
begin

  try
    // criar um objeto json com os dados do fornecedor
    json := TJSONObject.Create;
    json.AddPair('nome',nome);
    json.AddPair('telefone',telefone);
    json.AddPair('email',email);
    json.AddPair('contato',contato);
    json.AddPair('telefone_contato',telefone_contato);

    resp := TRequest.New.BaseURL('http://localhost:3000')   // criando uma requisição do servidor
                        .Resource('/fornecedor')           // nessa rota
                        .AddBody(json.ToJSON)              // passando um json como string com dados do fornecedor
                        .Accept('application/json')        // trabalhar com json
                        .Post;                             // passando um Post
    // trata erro se houver
    if resp.StatusCode <> 201 then
      raise Exception.Create(resp.content);

  finally
    freeandnil(json);
  end;
end;

procedure TDmFornecedor.Editar(pessoaId: integer; nome, telefone, email, contato, telefone_contato: string );
var
  resp : IResponse; // usado para receber respostas do servidor
  json : TJSONObject; // usado para criar um objeto json com os dados da pessoa
begin

  try
    // criar um objeto json com os dados do cliente
    json := TJSONObject.Create;
    json.AddPair('nome',nome);
    json.AddPair('telefone',telefone);
    json.AddPair('email',email);
    json.AddPair('contato',contato);
    json.AddPair('telefone_contato',telefone_contato);

    resp := TRequest.New.BaseURL('http://localhost:3000') // criando uma requisição do servidor
                        .Resource('/fornecedor')           // nessa rota
                        .ResourceSuffix(pessoaId.ToString) // acrescenta o parametro produtoId recebido na url
                        .AddBody(json.ToJSON)             // passando um json como string com dados do produto
                        .Accept('application/json')       // trabalhar com json
                        .Put;                             // passando um Post
    // trata erro se houver
    if resp.StatusCode <> 200 then
      raise Exception.Create(resp.content);

  finally
    freeandnil(json);
  end;
end;

procedure TDmFornecedor.Excluir(pessoaId: integer);
var
  resp : IResponse;
begin

    resp := TRequest.New.BaseURL('http://localhost:3000')
                        .Resource('/fornecedor')
                        .ResourceSuffix(pessoaId.ToString)
                        .Accept('application/json')
                        .delete;
    if resp.StatusCode <> 200 then
      raise Exception.Create(resp.content);
end;


end.
