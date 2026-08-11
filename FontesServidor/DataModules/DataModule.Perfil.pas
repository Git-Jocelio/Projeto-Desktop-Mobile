unit DataModule.Perfil;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, DataSet.Serialize,
  DataSet.Serialize.Config,
  System.JSON;

type
  TDmPerfil = class(TDataModule)
    qry: TFDQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    procedure ConnBeforeConnect(Sender: TObject);
  public
    function listarTodos: TJSONArray;
    function InserirPerfil(descricao, obs: string): TJSONObject;
  end;

var
  DmPerfil: TDmPerfil;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses DataModule.Servidor, Env.Conf;

{$R *.dfm}


procedure TDmPerfil.ConnBeforeConnect(Sender: TObject);
begin
  // configura a TFDConnection através arquivo .env
  // TEnvConfig.ConfigurarConexao(DmServidor.Conn);
  TEnvConfig.ConfigurarConexao(TFDConnection(Sender));
end;

procedure TDmPerfil.DataModuleCreate(Sender: TObject);
begin
  dmServidor := TDmServidor.Create(nil);
  ConnBeforeConnect(DmServidor.Conn);
  qry.Connection := DmServidor.Conn;

  {esta duas linha dizem ao serialize como tratar as variaveis nas consultas sql}
  TDataSetSerializeConfig.GetInstance.CaseNameDefinition := cndLower;
  TDataSetSerializeConfig.GetInstance.Import.DecimalSeparator := '.';
end;

procedure TDmPerfil.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(DmServidor);
end;

function TDmPerfil.InserirPerfil( descricao, obs: string): TJSONObject;
begin
  result := nil;
  DmServidor.Conn.open;
  try
    DmServidor.Conn.StartTransaction;
    qry.SQL.clear;
    qry.SQL.Add('insert into perfil ');
    qry.SQL.Add('  (descricao, obs) ');
    qry.SQL.Add('values ');
    qry.SQL.Add('  (:descricao, :obs )');
    qry.SQL.Add('returning id_perfil, descricao, obs ');
    qry.ParamByName('descricao').AsString := descricao;
    qry.ParamByName('obs').AsString := obs;
    qry.Active := true;

    if DmServidor.Conn.InTransaction then
        DmServidor.Conn.Commit;

    Result := TJSONObject.Create;
    Result.AddPair('id_perfil', TJSONNumber.Create(qry.FieldByName('id_perfil').AsInteger));
    Result.AddPair('descricao', qry.FieldByName('descricao').AsString);
    Result.AddPair('obs', qry.FieldByName('obs').AsString);
  except
    DmServidor.Conn.Rollback;
    raise;
  end;
end;

function TDmPerfil.listarTodos: TJSONArray;
begin
  result := nil;
  DmServidor.Conn.open;
  qry.SQL.clear;
  qry.SQL.Add('select ');
  qry.SQL.Add('  p.id_perfil, p.descricao, p.obs ');
  qry.SQL.Add('from ');
  qry.SQL.Add('  perfil p ');
  qry.SQL.Add('order by p.descricao ');
  qry.Open;

  if not qry.IsEmpty then
    result := qry.ToJSONArray;
end;


end.
