unit DataModule.Usuario;


interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.PG,
  FireDAC.Phys.PGDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.Phys.IBBase, fireDac.Stan.Param,
  dialogs,
  DataSet.Serialize.Config, // necessário para tratar varaveis de consulta
  DataSet.Serialize,        // necessário para por transformar um dataset em um array JSON
  System.JSON,              // necessario para retorno do JSON
  FireDac.Dapt,             // necessario para trabalhar com qry dinanmicas
  Env.Conf,
  DataModule.Servidor,
  uMD5, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.Comp.DataSet;

type
  TDmUsuario = class(TDataModule)
    qry: TFDQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure ConnBeforeConnect(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
  public
    function usuarioLogin(login, senha: string): TJSONObject;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDmUsuario.ConnBeforeConnect(Sender: TObject);
begin
  // configura a TFDConnection através arquivo .env
  // TEnvConfig.ConfigurarConexao(DmServidor.Conn);
  TEnvConfig.ConfigurarConexao(TFDConnection(Sender));
end;

procedure TDmUsuario.DataModuleCreate(Sender: TObject);
begin
  dmServidor := TDmServidor.Create(nil);
  ConnBeforeConnect(DmServidor.Conn);
  qry.Connection := DmServidor.Conn;

  {esta duas linha dizem ao serialize como tratar as variaveis nas consultas sql}
  TDataSetSerializeConfig.GetInstance.CaseNameDefinition := cndLower;
  TDataSetSerializeConfig.GetInstance.Import.DecimalSeparator := '.';
end;

procedure TDmUsuario.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(DmServidor);
end;

function TDmUsuario.usuarioLogin(login, senha: string): TJSONObject;
begin

  result := nil; // Inicializa o result para evitar lixo de memória

  DmServidor.Conn.open;

  qry.SQL.clear;
  qry.SQL.Add('select ');
  qry.SQL.Add('  pessoaid, usuarioid, nome, login ');
  qry.SQL.Add('from ');
  qry.SQL.Add('  usuario ');
  qry.SQL.Add('where ');
  qry.SQL.Add('  login = :login and senha = :senha');
  qry.ParamByName('login').AsString := login;
  qry.ParamByName('senha').AsString := senha ;
  qry.Open;

  if not qry.IsEmpty then
    result := qry.ToJSONObject;

end;




end.
