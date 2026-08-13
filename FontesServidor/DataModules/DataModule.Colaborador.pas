unit DataModule.Colaborador;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  DataSet.Serialize.Config, // tratar varaveis de consulta
  DataSet.Serialize,        // transformar um dataset em um array JSON
  System.JSON,              //  retorno do JSON
  Env.Conf,  dialogs,
  DataModule.Servidor;


type
  TDmColaborador = class(TDataModule)
    qry: TFDQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    procedure ConnBeforeConnect(Sender: TObject);
  public
    function Listar(filtro: string): TJSONArray;
    function ListarId(pessoaid: integer): TJSONObject;
    function Inserir(nome, email, telefone: string; setorId: integer): TJSONObject;
    function Editar(pessoaId: integer; nome, email, telefone: string;
                                 setorId: integer): TJSONObject;
    function Excluir(pessoaid: integer): TJSONObject;
  end;

var
  DmColaborador: TDmColaborador;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDmColaborador.ConnBeforeConnect(Sender: TObject);
begin
  //TEnvConfig.ConfigurarConexao(DmServidor.Conn);
  TEnvConfig.ConfigurarConexao(TFDConnection(Sender));
end;


procedure TDmColaborador.DataModuleCreate(Sender: TObject);
begin
  // antes de abrir a conexão, configura os parametros no onBeforeconnect
  dmServidor := TDmServidor.Create(nil);
  ConnBeforeConnect(DmServidor.Conn);
  qry.Connection := dmServidor.Conn;

  {esta duas linha dizem ao serialize como tratar as variaveis nas consultas sql}
  TDataSetSerializeConfig.GetInstance.CaseNameDefinition := cndLower;
  TDataSetSerializeConfig.GetInstance.Import.DecimalSeparator := '.';
end;


procedure TDmColaborador.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil( dmServidor );
end;

function TDmColaborador.Listar(filtro: string): TJSONArray;
begin
  result := nil;

  DmServidor.Conn.open;

  qry.SQL.Clear;
  qry.SQL.Text := 'select ' +
                  '  p.*, s.nome as setor '+
                  'from ' +
                  '  pessoa p, colaborador c, setor s ' +
                  'where p.pessoaid = c.pessoaid and c.setorid = s.setorid ';
  if filtro <> '' then
  begin
    qry.SQL.Add('and upper(p.nome) like :nome');
    qry.ParamByName('nome').value := '%' + uppercase(filtro) + '%';
  end;

  qry.SQL.Add('order by p.nome');

  qry.Open;
  //showmessage(qry.FieldByName('setor').AsString);
  Result := qry.ToJSONArray;
end;

function TDmColaborador.ListarId(pessoaid: integer): TJSONObject;
begin

  result := nil;

  DmServidor.Conn.open;
  qry.Connection := DmServidor.Conn;
  qry.SQL.Clear;
  qry.SQL.Text := 'select ' +
                  '  p.*, s.setorid, s.nome as setor '+
                  'from ' +
                  '  pessoa p, colaborador c, setor s ' +
                  'where ' +
                  '  p.pessoaid = c.pessoaid and c.setorid = s.setorid and p.pessoaid = :pessoaid';

  qry.ParamByName('pessoaid').value := pessoaid;
  qry.Open;

  Result := qry.ToJSONObject;

end;

function TDmColaborador.Inserir(nome, email, telefone: string; setorId: integer): TJSONObject;
var
  novaPessoa: integer;
begin

  result := nil;
  DmServidor.Conn.open;
  try
    DmServidor.Conn.StartTransaction;
    //pessoa
    qry.SQL.Clear;
    qry.SQL.Add('INSERT INTO pessoa (nome, email, telefone)');
    qry.SQL.Add('VALUES (:nome, :email, :telefone)');
    qry.SQL.Add('RETURNING pessoaId');

    qry.ParamByName('nome').AsString     := nome;
    qry.ParamByName('email').AsString    := email;
    qry.ParamByName('telefone').AsString := telefone;
    qry.Open;
    novaPessoa:= qry.fieldbyname('pessoaId').AsInteger;

    //colaborador
    qry.SQL.Clear;
    qry.SQL.Add('INSERT INTO colaborador (pessoaId, setorId)');
    qry.SQL.Add('VALUES (:pessoaId, :setorId)');

    qry.ParamByName('pessoaId').Value := novaPessoa;
    qry.ParamByName('setorId').Value  := setorId;
    qry.ExecSQL;

    if DmServidor.Conn.InTransaction then
        DmServidor.Conn.Commit;

    Result := TJSONObject.Create;
    Result.AddPair('colaboradorId', TJSONNumber.Create(novaPessoa));

  except
    DmServidor.Conn.Rollback;
    raise;
  end;

end;


function TDmColaborador.Editar(pessoaId:integer; nome, email, telefone: string;
                                 setorId: integer): TJSONObject;
begin

  result := nil; // Inicializa o resultado para evitar lixo de memória
  DmServidor.Conn.open;
  try
    DmServidor.Conn.StartTransaction;
    //pessoa
    qry.SQL.Clear;
    qry.SQL.Add('update pessoa');
    qry.SQL.Add('  set nome=:nome, telefone=:telefone, email=:email');
    qry.SQL.Add('where pessoaId =:pessoaId');

    qry.ParamByName('pessoaId').Value := pessoaId;
    qry.ParamByName('nome').Value := nome;
    qry.ParamByName('telefone').Value := telefone;
    qry.ParamByName('email').Value := email;
    qry.ExecSQL;

    qry.SQL.Clear;
    qry.SQL.Add('update colaborador set setorId =:setorId');
    qry.SQL.Add('where pessoaId =:pessoaId');
    qry.ParamByName('pessoaId').Value := pessoaId;
    qry.ParamByName('setorId').Value := setorId;
    qry.ExecSQL;
    DmServidor.Conn.Commit;

    Result := TJSONObject.Create;
    Result.AddPair('pessoaId', TJSONNumber.Create(pessoaId));
  except
    DmServidor.Conn.Rollback;
     raise;
  end;
end;

function TDmColaborador.Excluir(pessoaId: integer): TJSONObject;
begin

  result := nil; // Inicializa o resultado para evitar lixo de memória
  DmServidor.Conn.open;

  qry.SQL.Clear;
  qry.SQL.Add('delete from colaborador');
  qry.SQL.Add('where pessoaId =:pessoaId');
  qry.ParamByName('pessoaId').AsInteger := pessoaId;
  qry.ExecSQL;

  Result := TJSONObject.Create;
  Result.AddPair('pessoaId', TJSONNumber.Create(pessoaId));

end;


end.
