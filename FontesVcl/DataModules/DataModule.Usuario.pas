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
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Config;

type
  TdmUsuario = class(TDataModule)
    MemTable: TFDMemTable;
    procedure DataModuleCreate(Sender: TObject);
  private
  public
    procedure Login(email, senha: string);
    procedure CriarConta(nome, email, senha: string);
    procedure AlterarSenha( senha: string);
    procedure ListarTodos;
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

procedure TdmUsuario.CriarConta(nome, email, senha: string);
var
  Res : IResponse;
  json : TJSONObject;
  pessoaid: integer;
begin

  try
    pessoaid:= 0; // novo usuario

    //criar um objeto json com os dados do cliente
    json := TJSONObject.Create;

    json.AddPair('nome', nome);
    json.AddPair('email', email);
    json.AddPair('senha', senha);
    json.AddPair('pessoaid', pessoaid.ToString);

    Res := TRequest.New.BaseURL(URL_BASE)                 // criando uma requisição do servidor
                       .Resource('/usuario/cadastro')     // nessa rota
                       .AddBody(json.ToJSON)              // passando um json como string com dados da pessoa
                       .Accept('application/json')        // trabalhar com json
                       .Adapters(TDataSetSerializeAdapter.New(MemTable)) // popula a memtable dados do json recebido
                       .Post;                             // passando um Post

    if Res.StatusCode <> 201 then
      raise Exception.Create(Res.content);

  finally
    freeandnil(json);
  end;
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


end.
