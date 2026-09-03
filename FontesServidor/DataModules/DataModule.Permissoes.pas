// dm modelo para mestre detalhe
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
    function InserirPermissoes(perfilID: integer; permissoes: TJSONArray): TJSONObject;
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


function TDmPermissoes.InserirPermissoes(perfilID: integer; permissoes: TJSONArray): TJSONObject;
var
  i : integer;
begin

   result := nil;
   try

     DmServidor.Conn.StartTransaction;

     // não haverá edição de permissoes por enquanto... então vou deletar todo o perfil e incluir novamente
     qry.close;
     qry.SQL.clear;
     qry.SQL.Add('delete from permissoes where perfil_id =:perfil_id ');
     qry.ParamByName('perfil_id').AsInteger := perfilID;
     qry.ExecSQL;

     // incluir novamente
     qry.close;
     qry.SQL.clear;
     qry.SQL.Add(
                 'insert into permissoes ' +
                 '(perfil_id, tela_id, ver, inserir, editar, excluir, imprimir) ');
     qry.SQL.Add('values ' +
                '(:perfil_id, :tela_id, :ver, :inserir, :editar, :excluir, :imprimir)');

     // curso easy  pedido, aula 4, momento 14:21
     for i := 0 to permissoes.Size -1 do
     begin
       qry.ParamByName('perfil_id').AsInteger := perfilID;
       qry.ParamByName('tela_id').AsInteger   := permissoes[i].GetValue<integer>('tela_id',0);
       qry.ParamByName('ver').AsString        := permissoes[i].GetValue<string>('ver','N');
       qry.ParamByName('inserir').AsString    := permissoes[i].GetValue<string>('inserir','N');
       qry.ParamByName('editar').AsString     := permissoes[i].GetValue<string>('editar','N');
       qry.ParamByName('excluir').AsString    := permissoes[i].GetValue<string>('excluir','N');
       qry.ParamByName('imprimir').AsString   := permissoes[i].GetValue<string>('imprimir','N');
       qry.ExecSQL;
     end;

     DmServidor.Conn.Commit;

     Result := TJSONObject.Create;
     Result.AddPair('perfil_id', TJSONNumber.Create(perfilID));
     Result.AddPair('mensagem', 'Permissões inseridas com sucesso');
   except
     on E: Exception do
     begin
       if DmServidor.Conn.InTransaction then
         DmServidor.Conn.Rollback;
       raise;
     end;
   end;

end;

end.
