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
  uMD5;

type
  TDmUsuario = class(TDataModule)
    procedure DataModuleCreate(Sender: TObject);
    procedure ConnBeforeConnect(Sender: TObject);
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
  TEnvConfig.ConfigurarConexao(DmServidor.Conn);
end;

procedure TDmUsuario.DataModuleCreate(Sender: TObject);
begin
  {esta duas linha dizem ao serialize como tratar as variaveis nas consultas sql}
  TDataSetSerializeConfig.GetInstance.CaseNameDefinition := cndLower;
  TDataSetSerializeConfig.GetInstance.Import.DecimalSeparator := '.';

  // antes de abrir a conexão, configura os parametros no onBeforeconnect
  DmServidor.Conn.open;

end;

function TDmUsuario.usuarioLogin(login, senha: string): TJSONObject;
var
  dmServidor: TDMServidor;
  qry: TFDQuery;
begin

  result := nil;
  qry := TFDQuery.Create(nil);

  try
    dmServidor := TDmServidor.Create(nil);
    qry.Connection := DmServidor.conn;
    qry.SQL.Add('select usuarioId, nome, login from usuario where login = :login and senha = :senha');

    qry.ParamByName('login').AsString := login;
    qry.ParamByName('senha').AsString :=  senha ;
    qry.Open;


    if not qry.IsEmpty then
      result := qry.ToJSONObject;

  finally
    FreeAndNil(qry);
    FreeAndNil(dmServidor);
  end;

end;




end.
