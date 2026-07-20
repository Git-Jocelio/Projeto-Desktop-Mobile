unit DataModele.Pessoa;

interface

uses
  System.SysUtils, System.Classes,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FireDAC.Stan.Intf,
  DataSet.Serialize.Config,  // transforma json em dataset
  RestRequest4D,             // usado para receber respostas do servidor
  DataSet.Serialize.Adapter.RESTRequest4D,
  System.JSON, Vcl.Config ;

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

  // limpar o dataset
  if MemTable.Active then
    MemTable.emptydataset;

  MemTable.FieldDefs.Clear;

  resp := TRequest.New.BaseURL(URL_BASE)
                      .Resource('/pessoa')
                      .AddParam('filtro',filtro)
                      .Accept('application/json')
                      .Adapters(TDataSetSerializeAdapter.New(memTable))
                      .Get;


  // trata erro se houver
  if resp.StatusCode <> 200 then
    raise Exception.Create(resp.content);

end;

procedure TDmPessoa.ListarPessoaID(memTable: TFDMemTable; pessoaId: integer);
var
  resp : IResponse; // usado para receber respostas do servidor
begin

  // limpar o dataset
  if MemTable.Active then
    MemTable.emptydataset;

  MemTable.FieldDefs.Clear;

  resp := TRequest.New.BaseURL(URL_BASE)
                      .Resource('/pessoa')
                      .ResourceSuffix(pessoaId.ToString)
                      .Accept('application/json')
                      .Adapters(TDataSetSerializeAdapter.New(memTable))
                      .Get;
  // trata erro se houver
  if resp.StatusCode <> 200 then
    raise Exception.Create(resp.content);
end;

procedure TDmPessoa.Inserir(nome, telefone, email: string);
var
  resp : IResponse;
  json : TJSONObject;
begin

  try
    // criar um objeto json com os dados do cliente
    json := TJSONObject.Create;
    json.AddPair('nome',nome);
    json.AddPair('telefone',telefone);
    json.AddPair('email',email);

    resp := TRequest.New.BaseURL(URL_BASE)
                        .Resource('/pessoa')
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


procedure TDmPessoa.Editar(pessoaId: integer; nome, telefone, email: string);
var
  resp : IResponse;
  json : TJSONObject;
begin

  try
    // criar um objeto json com os dados do cliente
    json := TJSONObject.Create;
    json.AddPair('nome',nome);
    json.AddPair('telefone',telefone);
    json.AddPair('email',email);

    resp := TRequest.New.BaseURL(URL_BASE)
                        .Resource('/pessoa')
                        .ResourceSuffix(pessoaId.ToString)
                        .AddBody(json.ToJSON)
                        .Accept('application/json')
                        .Put;
    // trata erro se houver
    if resp.StatusCode <> 200 then
      raise Exception.Create(resp.content);

  finally
    freeandnil(json);
  end;
end;

procedure TDmPessoa.Excluir(pessoaId: integer);
var
  resp : IResponse;
begin

    resp := TRequest.New.BaseURL(URL_BASE)
                        .Resource('/pessoa')
                        .ResourceSuffix(pessoaId.ToString)
                        .Accept('application/json')
                        .delete;
    // trata erro se houver
    if resp.StatusCode <> 200 then
      raise Exception.Create(resp.content);
end;



end.
