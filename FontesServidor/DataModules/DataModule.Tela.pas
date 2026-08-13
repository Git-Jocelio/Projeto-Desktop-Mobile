unit DataModule.Tela;

interface

uses
  System.SysUtils, System.Classes,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  DataModule.Servidor,
  Env.Conf,
  DataSet.Serialize.Config, // tratar varaveis de consulta
  DataSet.Serialize,
  System.JSON;       // transformar um dataset em um array JSON

type
  TdmTela = class(TDataModule)
    qry: TFDQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    procedure ConnBeforeConnect(Sender: TObject);
    { Private declarations }
  public
    function Listar(filtro: string): TJSONArray;
    function ListarId(id_tela: integer): TJSONObject;
    function Inserir(nome_tela, modulo, ativo: string; ordem: integer): TJSONObject;
    function Editar( nome_tela, modulo, ativo: string; id_tela, ordem: integer): TJSONObject;
    function Excluir(id_tela: integer): TJSONObject;
  end;

var
  dmTela: TdmTela;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}


procedure TdmTela.ConnBeforeConnect(Sender: TObject);
begin
  //TEnvConfig.ConfigurarConexao(DmServidor.Conn);
  TEnvConfig.ConfigurarConexao(TFDConnection(Sender));
end;

procedure TdmTela.DataModuleCreate(Sender: TObject);
begin
  // antes de abrir a conexão, configura os parametros no onBeforeconnect
  dmServidor := TDmServidor.Create(nil);
  ConnBeforeConnect(DmServidor.Conn);
  qry.Connection := dmServidor.Conn;

  {esta duas linha dizem ao serialize como tratar as variaveis nas consultas sql}
  TDataSetSerializeConfig.GetInstance.CaseNameDefinition := cndLower;
  TDataSetSerializeConfig.GetInstance.Import.DecimalSeparator := '.';
end;

procedure TdmTela.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil( dmServidor );
end;

function TdmTela.Editar(nome_tela, modulo, ativo: string; id_tela,
  ordem: integer): TJSONObject;
begin

end;

function TdmTela.Excluir(id_tela: integer): TJSONObject;
begin

end;

function TdmTela.Inserir(nome_tela, modulo, ativo: string;
  ordem: integer): TJSONObject;
begin

end;

function TdmTela.Listar(filtro: string): TJSONArray;
begin
  result := nil;
  dmServidor.Conn.Open;

  qry.SQL.Clear;
  qry.SQL.Add('select id_tela, nome_tela, modulo, ordem, ativo from tela ');
  qry.SQL.Add('where id_tela > 0 ');
  if filtro <> '' then
  begin
    qry.SQL.Add('and upper(nome_tela) like :nome_tela ');
    qry.ParamByName('nome_tela').value := '%' + uppercase(filtro) + '%';
  end;
  qry.SQL.Add('order by nome_tela');
  qry.open;
  result := qry.toJSONArray;
end;

function TdmTela.ListarId(id_tela: integer): TJSONObject;
begin

end;

end.
