unit DataModule.Usuario;

interface

uses
  System.SysUtils, System.Classes,
  DataSet.Serialize.Config,  // transforma json em dataset
  RestRequest4D,             // usado para receber respostas do servidor
  DataSet.Serialize.Adapter.RESTRequest4D, //json para dataset
  System.JSON,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Config,
  FireDAC.Stan.Async, FireDAC.DApt;

type
  TdmUsuario = class(TDataModule)
    MemTable: TFDMemTable;
    TabColaboradores: TFDMemTable;
    procedure DataModuleCreate(Sender: TObject);
  private
  public
    //endpoints para usuários
    procedure Login(email, senha: string);
    procedure CriarConta(login, senha, ativo, primeiro_acesso: string;
                         pessoaid:integer);
    procedure AlterarSenha( senha: string);
    procedure AlterarUsuario(login, ativo: string; usuarioid:integer);
    procedure ListarTodos;
    procedure ListarId(memTable: TFDMemTable; pessoaId: integer);

    // colaborador
    procedure ListarColaboradores;
  end;

var
  dmUsuario: TdmUsuario;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses Vcl.Session;

{$R *.dfm}

procedure TdmUsuario.DataModuleCreate(Sender: TObject);
begin
  TDataSetSerializeConfig.GetInstance.CaseNameDefinition := cndLower;
  TDataSetSerializeConfig.GetInstance.Import.DecimalSeparator := '.';
end;

procedure TdmUsuario.Login(email, senha: string);
var
  Res : IResponse;
  json : TJSONObject;
begin
  // limpar o dataset
  if MemTable.Active then
    MemTable.emptydataset;

  MemTable.FieldDefs.Clear;

  try
    //criar um objeto json com os dados do cliente
    json := TJSONObject.Create;

    json.AddPair('login', email);
    json.AddPair('senha', senha);

    Res := TRequest.New.BaseURL(URL_BASE)             // criando uma requisição do servidor
                   .Resource('/usuario/login')        // nessa rota
                   .AddBody(json.ToJSON)              // passando um json como string com dados da pessoa
                   .Accept('application/json')        // trabalhar com json
                   .Adapters(TDataSetSerializeAdapter.New(MemTable)) // popula a memtable dados do json recebido
                   .Post;                             // passando um Post

    if Res.StatusCode <> 200 then
      raise Exception.Create(Res.content);

  finally
    freeandnil(json);
  end;
end;

procedure TdmUsuario.AlterarSenha(senha: string);
var
  Res : IResponse;
  json : TJSONObject;
begin
  // limpar o dataset
  if MemTable.Active then
    MemTable.emptydataset;

  MemTable.FieldDefs.Clear;

  try
    //criar um objeto json com os dados do cliente
    json := TJSONObject.Create;

    json.AddPair('senha', senha);
    json.AddPair('usuarioid', TSession.ID_USUARIO);

    Res := TRequest.New.BaseURL(URL_BASE)
                       .Resource('/usuario/password')
                       .AddBody(json.ToJSON)
                       .TokenBearer(TSession.TOKEN)
                       .Accept('application/json')
                       .Adapters(TDataSetSerializeAdapter.New(MemTable))
                       .Post;

    if Res.StatusCode <> 200 then
      raise Exception.Create(Res.content);

  finally
    freeandnil(json);
  end;
end;

procedure TdmUsuario.AlterarUsuario(login, ativo: string; usuarioid: integer);
var
  Res : IResponse;
  json : TJSONObject;
begin
  try
    //criar um objeto json com os dados do usuario
    json := TJSONObject.Create;

    json.AddPair('login', login);
    json.AddPair('ativo', ativo);
    json.AddPair('usuarioid', usuarioid.ToString);

    Res := TRequest.New.BaseURL(URL_BASE)
                       .Resource('/usuario')
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

procedure TdmUsuario.CriarConta(login, senha, ativo, primeiro_acesso: string;
                                pessoaid:integer);
var
  Res : IResponse;
  json : TJSONObject;
begin
  try
    //criar um objeto json com os dados do usuario
    json := TJSONObject.Create;

    json.AddPair('login', login);
    json.AddPair('senha', senha);
    json.AddPair('ativo', ativo);
    json.AddPair('primeiro_acesso', primeiro_acesso);
    json.AddPair('pessoaid', pessoaid.ToString);

    Res := TRequest.New.BaseURL(URL_BASE)                 // criando uma requisição do servidor
                       .Resource('/usuario/cadastro')     // nessa rota
                       .AddBody(json.ToJSON)              // passando o json criado acima com dados da requisição
                       .Accept('application/json')        // trabalhar com json
                     //  .Adapters(TDataSetSerializeAdapter.New(MemTable)) // popula a memtable dados do json recebido
                       .Post;                             // passando um Post

    if Res.StatusCode <> 201 then
      raise Exception.Create(Res.content);

  finally
    freeandnil(json);
  end;
end;

procedure TdmUsuario.ListarColaboradores;
var
  Res : IResponse;
begin
  // limpar o dataset
  if TabColaboradores.Active then
    TabColaboradores.emptydataset;

  TabColaboradores.FieldDefs.Clear;

  Res := TRequest.New.BaseURL(URL_BASE)
                 .Resource('/colaborador')
                 .TokenBearer(TSession.TOKEN)
                 .Accept('application/json')
                 .Adapters(TDataSetSerializeAdapter.New(TabColaboradores))
                 .Get;
  if Res.StatusCode <> 200 then
    raise Exception.Create(Res.content);

end;

procedure TdmUsuario.ListarTodos;
var
  Res : IResponse;
begin
  // limpar o dataset
  if MemTable.Active then
    MemTable.emptydataset;

  MemTable.FieldDefs.Clear;

  Res := TRequest.New.BaseURL(URL_BASE)
                 .Resource('/usuario')
                 .TokenBearer(TSession.TOKEN)
                 .Accept('application/json')
                 .Adapters(TDataSetSerializeAdapter.New(MemTable))
                 .Get;

  if Res.StatusCode <> 200 then
    raise Exception.Create(Res.content);
end;

procedure TdmUsuario.ListarId(memTable: TFDMemTable; pessoaId: integer);
var
  resp : IResponse;
begin
  resp := TRequest.New.BaseURL(URL_BASE)
                      .Resource('/usuario/' + pessoaId.ToString)
                      .TokenBearer(TSession.TOKEN)
                      .Accept('application/json')
                      .Adapters(TDataSetSerializeAdapter.New(memTable))
                      .Get;
  // trata erro se houver
  if resp.StatusCode <> 200 then
    raise Exception.Create(resp.content);
end;

end.
