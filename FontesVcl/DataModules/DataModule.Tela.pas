unit DataModule.Tela;

interface

uses
  System.SysUtils, System.Classes,
  FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  DataSet.Serialize.Config,
  RestRequest4D,
  DataSet.Serialize.Adapter.RESTRequest4D,
  System.JSON,
  Vcl.Config;


type
  TDmTela = class(TDataModule)
    memTable: TFDMemTable;
    procedure DataModuleCreate(Sender: TObject);
  private
  public
    procedure Listar(memTable: TFDMemTable; filtro: string);
    procedure ListarId(memTable: TFDMemTable; id_tela: integer);
    procedure Inserir(ordem: integer; nome_tela, modulo, ativo:string);
    procedure Editar(id_tela, ordem: integer; nome_tela, modulo, ativo:string);
    procedure Excluir(id_tela: integer);
  end;

var
  DmTela: TDmTela;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDmTela.DataModuleCreate(Sender: TObject);
begin
  TDataSetSerializeConfig.GetInstance.CaseNameDefinition := cndLower;
  TDataSetSerializeConfig.GetInstance.Import.DecimalSeparator := '.';
end;

procedure TDmTela.Editar(id_tela, ordem: integer; nome_tela, modulo, ativo:string);
var
  json: TJSONOBject;
  resp: IResponse;
begin
  try
    // 1. criar um object JSON com os parametros recebidos da procedure
    json := TJSONOBject.Create;
    json.AddPair('ordem',ordem);
    json.AddPair('nome_tela',nome_tela);
    json.AddPair('modulo',modulo);
    json.AddPair('ativo',ativo);

    // 2. criar a requisição ao servidor: http//:localhost:3000/tela
    resp := TRequest.New.BaseURL(URL_BASE)
                        .Resource('/tela')
                        .ResourceSuffix(id_tela.ToString)
                        .AddBody(json.ToJSON)
                        .Accept('application/json')
                        .Put;

      //3. trata erro se houver
    if resp.StatusCode <> 200 then
      raise Exception.Create(resp.content);

  finally
    // 4. destruir o json criado
    json.Free;
  end;
end;

procedure TDmTela.Excluir(id_tela: integer);
var
  resp :IResponse;
begin
  resp := TRequest.New.BaseURL(URL_BASE)
                      .Resource('/tela')
                      .ResourceSuffix(id_tela.ToString)
                      .Accept('application/json')
                      .Delete;

  // 3. tratar erro se houver
  if resp.StatusCode <> 200 then
    raise Exception.Create(resp.content);
end;

procedure TDmTela.Inserir(ordem: integer; nome_tela, modulo, ativo:string);
var
  json :TJSONOBject;
  resp :IResponse;
begin
  try
    // 1.criar json
    json := TJSONOBject.Create;
    json.AddPair('nome_tela', nome_tela);
    json.AddPair('modulo', modulo);
    json.AddPair('ordem', ordem);
    json.AddPair('ativo', ativo);

    // 2.criar requisição
    resp := TRequest.New.BaseURL(URL_BASE)
                        .Resource('/tela')
                        .AddBody(json.ToJSON)
                        .Accept('application/json')
                        .Post;

    // 3. tratar erro se houver
    if resp.StatusCode <> 201 then
      raise Exception.Create(resp.content);

  finally
    // destruir json
    json.Free;
  end;

end;

procedure TDmTela.Listar(memTable: TFDMemTable; filtro: string);
var
  resp : IResponse;
begin
  resp := TRequest.New.BaseURL(URL_BASE)
                      .Resource('/tela')
                      .AddParam('filtro',filtro)
                      .Accept('application/json')
                      .Adapters(TDataSetSerializeAdapter.New(memTable))
                      .Get;
  if resp.StatusCode <> 200 then
    raise Exception.Create(resp.content);

end;

procedure TDmTela.ListarId(memTable: TFDMemTable; id_tela: integer);
var
  resp : IResponse;
begin
  resp := TRequest.New.BaseURL(URL_BASE)
                      .Resource('/tela')
                      .ResourceSuffix(id_tela.ToString)
                      .Accept('application/json')
                      .Adapters(TDataSetSerializeAdapter.New(memTable))
                      .Get;
  // trata erro se houver
  if resp.StatusCode <> 200 then
    raise Exception.Create(resp.content);
end;

end.
