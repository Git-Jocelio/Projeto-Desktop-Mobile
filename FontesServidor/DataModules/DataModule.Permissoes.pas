unit DataModule.Permissoes;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  DataModule.Servidor,
  Env.Conf,
  DataSet.Serialize.Config,         dialogs,
  DataSet.Serialize,
  System.JSON;

type
  TDmPermissoes = class(TDataModule)
    qry: TFDQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    procedure ConnBeforeConnect(Sender: TObject);
  public
    function ListarPermissoesId(perfilId: integer): TJSONArray;
  end;

var
  DmPermissoes: TDmPermissoes;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}


procedure TDmPermissoes.ConnBeforeConnect(Sender: TObject);
begin
  //TEnvConfig.ConfigurarConexao(DmServidor.Conn);
  TEnvConfig.ConfigurarConexao(TFDConnection(Sender));
end;

procedure TDmPermissoes.DataModuleCreate(Sender: TObject);
begin
  // antes de abrir a conexão, configura os parametros no onBeforeconnect
  DmServidor := TDmServidor.Create(nil);
  ConnBeforeConnect(DmServidor.Conn);
  qry.Connection := dmServidor.Conn;

  {esta duas linha dizem ao serialize como tratar as variaveis nas consultas sql}
  TDataSetSerializeConfig.GetInstance.CaseNameDefinition := cndLower;
  TDataSetSerializeConfig.GetInstance.Import.DecimalSeparator := '.';
end;

procedure TDmPermissoes.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil( DmServidor );
end;

function TDmPermissoes.ListarPermissoesId(perfilId: integer): TJSONArray;
begin
  // lista todas telas cadastradas no sistema
  // com suas respectivas permissoes de um perfil

  result := nil;

  dmServidor.Conn.Open;

  qry.Close;
  qry.SQL.Clear;

  qry.SQL.text :=
  'SELECT ' +
  '    T.ID_TELA, ' +
  '    T.NOME_TELA, ' +
  '    T.MODULO, ' +
  '    T.ORDEM, ' +
  '    COALESCE(P.VER, ' + QuotedStr('N') + ' ) AS VER, ' +
  '    COALESCE(P.INSERIR, ' + QuotedStr('N') + ') AS INSERIR, ' +
  '    COALESCE(P.EDITAR, ' + QuotedStr('N') + ') AS EDITAR, ' +
  '    COALESCE(P.EXCLUIR, ' + QuotedStr('N') + ') AS EXCLUIR, ' +
  '    COALESCE(P.IMPRIMIR, ' + QuotedStr('N') + ') AS IMPRIMIR ' +
  'FROM TELA T ' +
  'LEFT JOIN PERMISSOES P ' +
  '    ON P.TELA_ID = T.ID_TELA ' +
  '    AND P.PERFIL_ID = :PERFIL_ID ' +
  'WHERE T.ATIVO = ' + QuotedStr('S') + ' ' +
  'ORDER BY T.ORDEM';

  qry.ParamByName('PERFIL_ID').AsInteger := perfilId;

  qry.Active := true;

  Result := qry.ToJSONArray;
end;


end.
