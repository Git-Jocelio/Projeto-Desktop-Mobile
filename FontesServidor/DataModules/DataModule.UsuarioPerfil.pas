unit DataModule.UsuarioPerfil;

interface

uses
  System.SysUtils, System.Classes,
  DataModule.Servidor,
  Env.Conf,
  DataSet.Serialize.Config,
  DataSet.Serialize,
  System.JSON, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, dialogs,
  FireDAC.Comp.Client;

type
  TDmUsuarioPerfil = class(TDataModule)
    qry: TFDQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    procedure ConnBeforeConnect(Sender: TObject);
  public
    function Listar(filtro: string): TJSONArray;
    function ListarId(id: integer): TJSONObject;
    function Inserir(id_usuario, id_perfil: integer): TJSONObject;
    function Editar(id, id_usuario, id_perfil: integer): TJSONObject;
    function Excluir(id: integer): TJSONObject;
  end;

var
  DmUsuarioPerfil: TDmUsuarioPerfil;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDmUsuarioPerfil.ConnBeforeConnect(Sender: TObject);
begin
  //TEnvConfig.ConfigurarConexao(DmServidor.Conn);
  TEnvConfig.ConfigurarConexao(TFDConnection(Sender));
end;


procedure TDmUsuarioPerfil.DataModuleCreate(Sender: TObject);
begin
  // antes de abrir a conexão, configura os parametros no onBeforeconnect
  dmServidor := TDmServidor.Create(nil);
  ConnBeforeConnect(DmServidor.Conn);
  qry.Connection := dmServidor.Conn;

  {esta duas linha dizem ao serialize como tratar as variaveis nas consultas sql}
  TDataSetSerializeConfig.GetInstance.CaseNameDefinition := cndLower;
  TDataSetSerializeConfig.GetInstance.Import.DecimalSeparator := '.';

end;

procedure TDmUsuarioPerfil.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil( dmServidor );
end;

function TDmUsuarioPerfil.Inserir(id_usuario, id_perfil: integer): TJSONObject;
begin
   result := nil;
   qry.SQL.clear;
   qry.SQL.Add('insert into usuario_perfil (id_usuario, id_perfil) values (:id_usuario, :id_perfil) ');
   qry.SQL.Add('returning id, id_usuario, id_perfil ');
   qry.ParamByName('id_usuario').AsInteger := id_usuario;
   qry.ParamByName('id_perfil').AsInteger := id_perfil;
   qry.Active := true;

   Result := qry.ToJSONObject;
   qry.Active := false;
end;

function TDmUsuarioPerfil.Editar(id, id_usuario, id_perfil: integer): TJSONObject;
begin
   result := nil;
   qry.SQL.clear;
   qry.SQL.Add('update usuario_perfil set id_usuario = :id_usuario, id_perfil= :id_perfil ');
   qry.SQL.Add('where id =:id ');
   qry.SQL.Add('returning id, id_usuario, id_perfil');
   qry.ParamByName('id_usuario').AsInteger := id_usuario;
   qry.ParamByName('id_perfil').AsInteger := id_perfil;
   qry.ParamByName('id').AsInteger := id;
   qry.active := true;

   Result := qry.ToJSONObject;
   qry.Active := false;
end;


function TDmUsuarioPerfil.Excluir(id: integer): TJSONObject;
begin

   result := nil;
   qry.SQL.clear;
   qry.SQL.Add('delete from usuario_perfil where id =:id ');
   qry.ParamByName('id').AsInteger := id;
   qry.ExecSQL;

   Result := TJSONObject.Create;
   Result.AddPair('id', TJSONNumber.Create(id));
end;

function TDmUsuarioPerfil.Listar(filtro: string): TJSONArray;
begin
  result := nil;
  dmServidor.Conn.Open;

  qry.SQL.Clear;
  qry.SQL.Add('select ');
  qry.SQL.Add('    up.id,');
  qry.SQL.Add('    p.nome,');
  qry.SQL.Add('    up.id_perfil,');
  qry.SQL.Add('    pf.descricao');
  qry.SQL.Add('from usuario_perfil up ');
  qry.SQL.Add('inner join usuario u ');
  qry.SQL.Add('    on u.usuarioid = up.id_usuario ');
  qry.SQL.Add('inner join pessoa p ');
  qry.SQL.Add('    on p.pessoaid = u.pessoaid ');
  qry.SQL.Add('inner join perfil pf ');
  qry.SQL.Add('    on pf.id_perfil = up.id_perfil ');

  if filtro <> '' then
  begin
    qry.SQL.Add('and upper(nome) like :nome ');
    qry.ParamByName('nome').value := '%' + uppercase(filtro) + '%';
  end;
  qry.open;

  result := qry.toJSONArray;
end;

function TDmUsuarioPerfil.ListarId(id: integer): TJSONObject;
begin
  result := nil;
  dmServidor.Conn.Open;

  qry.SQL.Clear;
  qry.SQL.Add('select ');
  qry.SQL.Add('    up.id, ');
  qry.SQL.Add('    p.nome, ');
  qry.SQL.Add('    up.id_perfil, ');
  qry.SQL.Add('    pf.descricao ');
  qry.SQL.Add('from usuario_perfil up ');
  qry.SQL.Add('inner join usuario u ');
  qry.SQL.Add('    on u.usuarioid = up.id_usuario ');
  qry.SQL.Add('inner join pessoa p ');
  qry.SQL.Add('    on p.pessoaid = u.pessoaid ');
  qry.SQL.Add('inner join perfil pf ');
  qry.SQL.Add('    on pf.id_perfil = up.id_perfil ');
  qry.SQL.Add('where up.id = :id');
  qry.ParamByName('id').value := id;
  qry.open;

  result := qry.toJSONObject;
end;



end.
