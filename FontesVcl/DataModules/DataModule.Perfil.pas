unit DataModule.Perfil;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  DataSet.Serialize.Config,  // transforma json em dataset
  RestRequest4D,             // usado para receber respostas do servidor
  DataSet.Serialize.Adapter.RESTRequest4D, //json para dataset
  System.JSON,
  Vcl.Config,
  Vcl.Session;

type
  TDmPerfil = class(TDataModule)
    MemTable: TFDMemTable;
    procedure DataModuleCreate(Sender: TObject);
  private
  public
    procedure ListarTodos;
    procedure Listarid(memTable: TFDMemTable; pessoaId: integer);
    procedure InserirPerfil(descricao, obs: string);
    procedure AlterarPerfil(descricao, obs: string; id_perfil:integer);
    procedure excluirPerfil(id_perfil: integer);
  end;

var
  DmPerfil: TDmPerfil;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}



procedure TDmPerfil.DataModuleCreate(Sender: TObject);
begin
  TDataSetSerializeConfig.GetInstance.CaseNameDefinition := cndLower;
  TDataSetSerializeConfig.GetInstance.Import.DecimalSeparator := '.';

end;

procedure TDmPerfil.ListarTodos;
var
  Res : IResponse;
begin
  // limpar o dataset
  if MemTable.Active then
    MemTable.emptydataset;

  MemTable.FieldDefs.Clear;

  Res := TRequest.New.BaseURL(URL_BASE)
                 .Resource('/perfil')
                 .TokenBearer(TSession.TOKEN)
                 .Accept('application/json')
                 .Adapters(TDataSetSerializeAdapter.New(MemTable))
                 .Get;

  if Res.StatusCode <> 200 then
    raise Exception.Create(Res.content);
end;


procedure TDmPerfil.Listarid(memTable: TFDMemTable; pessoaId: integer);
var
  resp : IResponse;
begin
  resp := TRequest.New.BaseURL(URL_BASE)
                      .Resource('/perfil/' + pessoaId.ToString)
                      .TokenBearer(TSession.TOKEN)
                      .Accept('application/json')
                      .Adapters(TDataSetSerializeAdapter.New(memTable))
                      .Get;
  // trata erro se houver
  if resp.StatusCode <> 200 then
    raise Exception.Create(resp.content);
end;

procedure TDmPerfil.InserirPerfil(descricao, obs: string);
var
  Res : IResponse;
  json : TJSONObject;
begin
  try
    //criar um objeto json com os dados do usuario
    json := TJSONObject.Create;

    json.AddPair('descricao', descricao);
    json.AddPair('obs', obs);

    Res := TRequest.New.BaseURL(URL_BASE)
                       .Resource('/perfil')
                       .TokenBearer(TSession.TOKEN)
                       .AddBody(json.ToJSON)
                       .Accept('application/json')
                       .Post;

    if Res.StatusCode <> 201 then
      raise Exception.Create(Res.content);

  finally
    freeandnil(json);
  end;
end;

procedure TDmPerfil.AlterarPerfil(descricao, obs: string; id_perfil:integer);
var
  Res : IResponse;
  json : TJSONObject;
begin
  try
    //criar um objeto json com os dados do usuario
    json := TJSONObject.Create;

    json.AddPair('descricao', descricao);
    json.AddPair('obs', obs);
    json.AddPair('id_perfil', id_perfil.ToString);

    Res := TRequest.New
                       .BaseURL(URL_BASE)
                       .Resource('/perfil')
                       .ResourceSuffix(id_perfil.ToString)
                       .TokenBearer(TSession.TOKEN)
                       .AddBody(json.ToJSON)
                       .Accept('application/json')
                       .Adapters(TDataSetSerializeAdapter.New(MemTable))
                       .Put;

    if Res.StatusCode <> 200 then
      raise Exception.Create(Res.content);

  finally
    freeandnil(json);
  end;
end;

procedure TDmPerfil.excluirPerfil(id_perfil:integer);
var
  res : IResponse;
begin
  Res := TRequest.New.BaseURL(URL_BASE)
              .Resource('/perfil')
              .ResourceSuffix(id_perfil.ToString)
              .Accept('application/json')
              .TokenBearer(TSession.TOKEN)
              .Delete;

  if res.StatusCode <> 204 then
    raise Exception.Create(res.content);
end;



end.
