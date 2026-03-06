unit DataModule.Usuario;

interface

uses
  System.SysUtils, System.Classes,
  DataSet.Serialize.Config,  // transforma json em dataset
  RestRequest4D,             // usado para receber respostas do servidor
  DataSet.Serialize.Adapter.RESTRequest4D,
  System.JSON, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TdmUsuario = class(TDataModule)
    MemTable: TFDMemTable;
    procedure DataModuleCreate(Sender: TObject);
  private
  public
    procedure Login(MemTable: TFDMemTable;email, senha: string);
  end;

var
  dmUsuario: TdmUsuario;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TdmUsuario.DataModuleCreate(Sender: TObject);
begin
  TDataSetSerializeConfig.GetInstance.CaseNameDefinition := cndLower;
  TDataSetSerializeConfig.GetInstance.Import.DecimalSeparator := '.';
end;


procedure TdmUsuario.Login(MemTable: TFDMemTable; email, senha: string);
var
  resp : IResponse;   // usado para receber respostas do servidor
  json : TJSONObject; // usado para criar um objeto json com os dados da pessoa
begin

  try
    // criar um objeto json com os dados do cliente
    json := TJSONObject.Create;

    json.AddPair('email', email);
    json.AddPair('senha', senha);

    resp := TRequest.New.BaseURL('http://localhost:3000')  // criando uma requisição do servidor
                        .Resource('/usuario/login')       // nessa rota
                        .AddBody(json.ToJSON)              // passando um json como string com dados da pessoa
                        .Accept('application/json')        // trabalhar com json
                        .Adapters(TDataSetSerializeAdapter.New(MemTable)) // popula a memtable dados do json recebido
                        .Post;                             // passando um Post

    // trata erro se houver
    if resp.StatusCode <> 200 then
      raise Exception.Create(resp.content);

  finally
    freeandnil(json);
  end;
end;


end.
