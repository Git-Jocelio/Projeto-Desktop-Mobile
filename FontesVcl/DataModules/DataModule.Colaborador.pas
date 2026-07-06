unit DataModule.Colaborador;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  DataSet.Serialize.Config,
  RestRequest4D,
  DataSet.Serialize.Adapter.RESTRequest4D,
  System.JSON;

type
  TDmColaborador = class(TDataModule)
    TabColaborador: TFDMemTable;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    procedure Listar(memTable: TFDMemTable; filtro: string);
    procedure ListarId(memTable: TFDMemTable; pessoaId: integer);
    procedure Inserir(nome, email, telefone:string; setorID: integer);
    procedure Editar(pessoaId: integer; nome, email, telefone: string; setorID: integer);
    procedure Excluir(pessoaId: integer);

  end;

var
  DmColaborador: TDmColaborador;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDataModule1 }

procedure TDmColaborador.DataModuleCreate(Sender: TObject);
begin
  TDataSetSerializeConfig.GetInstance.CaseNameDefinition := cndLower;
  TDataSetSerializeConfig.GetInstance.Import.DecimalSeparator := '.';

end;

procedure TDmColaborador.Editar(pessoaId: integer; nome, email, telefone: string;
  setorID: integer);
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


procedure TDmColaborador.Excluir(pessoaId: integer);
var
  resp : IResponse;
begin

    resp := TRequest.New.BaseURL('http://localhost:3000')
                        .Resource('/pessoa')
                        .ResourceSuffix(pessoaId.ToString)
                        .Accept('application/json')
                        .delete;
    // trata erro se houver
    if resp.StatusCode <> 200 then
      raise Exception.Create(resp.content);
end;

procedure TDmColaborador.Inserir(nome, email, telefone:string; setorID: integer);
var
  resp : IResponse;
  json : TJSONObject;
begin

  try
    // pega os dados da tela, coloca tudo dentro de um objeto json e envia ao servidor
    json := TJSONObject.Create;
    json.AddPair('nome',nome);
    json.AddPair('telefone',telefone);
    json.AddPair('email',email);
    json.AddPair('setorID',setorID);

    resp := TRequest.New.BaseURL('http://localhost:3000')
                        .Resource('/colaborador')
                        .AddBody(json.ToJSON)
                        .Accept('application/json')
                        .Post;
    // trata erro se houver
    if resp.StatusCode <> 201 then
      raise Exception.Create(resp.content);

  finally
    freeandnil(json);
  end;
end;


procedure TDmColaborador.Listar(memTable: TFDMemTable; filtro: string);
var
  resp : IResponse;
begin
  resp := TRequest.New.BaseURL('http://localhost:3000')
                      .Resource('/colaborador')
                      .AddParam('filtro',filtro)
                      .Accept('application/json')
                      .Adapters(TDataSetSerializeAdapter.New(memTable))
                      .Get;
  if resp.StatusCode <> 200 then
    raise Exception.Create(resp.content);

end;


procedure TDmColaborador.ListarId(memTable: TFDMemTable; pessoaId: integer);
var
  resp : IResponse;
begin
  resp := TRequest.New.BaseURL('http://localhost:3000')
                      .Resource('/colaborador')
                      .ResourceSuffix(pessoaId.ToString)
                      .Accept('application/json')
                      .Adapters(TDataSetSerializeAdapter.New(memTable))
                      .Get;
  // trata erro se houver
  if resp.StatusCode <> 200 then
    raise Exception.Create(resp.content);
end;


end.
