unit DataModele.Pessoa;

interface

uses
  System.SysUtils, System.Classes,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FireDAC.Stan.Intf,
  DataSet.Serialize.Config,  // transforma json em dataset
  RestRequest4D, // usado para receber respostas do servidor
  DataSet.Serialize.Adapter.RESTRequest4D,
  System.JSON ;

type
  TDmPessoa = class(TDataModule)
    TabPessoa: TFDMemTable;
    procedure DataModuleCreate(Sender: TObject);
  private
  public
    procedure ListarPessoa(memTable: TFDMemTable; filtro: string);
    procedure ListarPessoaID(memTable: TFDMemTable; pessoaId: integer);
    //CRUD
    procedure Inserir(nome, telefone, email: string);
    procedure Editar(pessoaId: integer; nome, telefone, email: string);
    procedure Excluir(pessoaId: integer);
  end;

var
  DmPessoa: TDmPessoa;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDmPessoa.DataModuleCreate(Sender: TObject);
begin

  TDataSetSerializeConfig.GetInstance.CaseNameDefinition := cndLower;
  TDataSetSerializeConfig.GetInstance.Import.DecimalSeparator := '.';

end;

procedure TDmPessoa.ListarPessoa(memTable: TFDMemTable; filtro : string);
var
  resp : IResponse; // usado para receber respostas do servidor
begin
  resp := TRequest.New.BaseURL('http://localhost:3000') // criando uma requisição do servidor
                      .Resource('/pessoa')              // nessa rota
                      .AddParam('filtro',filtro)        // nesse filtro
                      .Accept('application/json')       // trabalhar com json
                      .Adapters(TDataSetSerializeAdapter.New(memTable)) // qdo a requisicao voltar vai pegar o json e jogar dentro do memtable
                      .Get;                             // passando um Get


  // trata erro se houver
  if resp.StatusCode <> 200 then
    raise Exception.Create(resp.content);

end;

procedure TDmPessoa.ListarPessoaID(memTable: TFDMemTable; pessoaId: integer);
var
  resp : IResponse; // usado para receber respostas do servidor
begin
  resp := TRequest.New.BaseURL('http://localhost:3000')   // criando uma requisição do servidor
                      .Resource('/pessoa')               // nessa rota
                      .ResourceSuffix(pessoaId.ToString)// acrescenta /id da pessoa
                      .Accept('application/json')        // trabalhar com json
                      .Adapters(TDataSetSerializeAdapter.New(memTable)) // qdo a requisicao voltar vai pega o json e jogar dentro do memtable
                      .Get;                             // passando um Get
  // trata erro se houver
  if resp.StatusCode <> 200 then
    raise Exception.Create(resp.content);
end;

procedure TDmPessoa.Inserir(nome, telefone, email: string);
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


procedure TDmPessoa.Editar(pessoaId: integer; nome, telefone, email: string);
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

    resp := TRequest.New.BaseURL('http://localhost:3000') // criando uma requisição do servidor
                        .Resource('/pessoa')              // nessa rota
                        .ResourceSuffix(pessoaId.ToString) // acrescenta o parametro pessoa_id recebido na url
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

procedure TDmPessoa.Excluir(pessoaId: integer);
var
  resp : IResponse;   // usado para receber respostas do servidor
begin

    resp := TRequest.New.BaseURL('http://localhost:3000')  // criando uma requisição do servidor
                        .Resource('/pessoa')               // nessa rota
                        .ResourceSuffix(pessoaId.ToString) // acrescenta o parametro pessoa_id recebido na url
                        .Accept('application/json')        // trabalhar com json
                        .delete;                              // passando um Post
    // trata erro se houver
    if resp.StatusCode <> 200 then
      raise Exception.Create(resp.content);
end;



end.
