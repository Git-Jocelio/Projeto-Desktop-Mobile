unit DataModule.Global;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.PG,
  FireDAC.Phys.PGDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.Phys.IBBase,

  DataSet.Serialize.Config, // necessário para tratar varaveis de consulta
  DataSet.Serialize,        // necessário para por transformar um dataset em um array JSON
  System.JSON,              // necessario para retorno do JSON
  FireDac.Dapt;             // necessario para trabalhar com qry dinanmicas

type
  TDM = class(TDataModule)
    Conn: TFDConnection;
    FDPhysFBDriverLink1: TFDPhysFBDriverLink;
    procedure DataModuleCreate(Sender: TObject);
    procedure ConnBeforeConnect(Sender: TObject);
  private
    procedure CarregarConfgDB(connection: TFDConnection);
  public
    function pessoaListar(filtro: string): TJSONArray;
    function pessoaListarId(pessoa_id: integer): TJSONObject;
    function pessoaInserir(nome, telefone, setor: string): TJSONObject;
    function pessoaEditar(pessoa_id: integer; nome, telefone,
      setor: string): TJSONObject;
    function pessoaExcluir(pessoa_id: integer): TJSONObject;
  end;

var
  DM: TDM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDM.ConnBeforeConnect(Sender: TObject);
begin
  CarregarConfgDB(Conn);
end;

procedure TDM.DataModuleCreate(Sender: TObject);
begin
  {esta duas linha dizem ao serialize como tratar as variaveis nas consultas sql}
  TDataSetSerializeConfig.GetInstance.CaseNameDefinition := cndLower;
  TDataSetSerializeConfig.GetInstance.Import.DecimalSeparator := '.';

  Conn.Connected := TRUE;

end;

procedure TDM.CarregarConfgDB(connection : TFDConnection);
begin
   connection.Params.Clear;
   connection.Params.DriverID := 'FB';

   connection.Params.Add('Server=localhost');   // ou 127.0.0.1
   connection.Params.Add('Port=3050');          // porta padrão
   connection.Params.Add('Protocol=local');

   connection.Params.Database := 'C:\Users\jgsilva\Documents\Jocelio\desktop_mobile\FontesServidor\DB\BANCO.FDB';
   connection.Params.UserName := 'SYSDBA';
   connection.Params.Password := 'masterkey';

   connection.LoginPrompt := FALSE;
end;

function TDM.pessoaListar(filtro: string): TJSONArray;
var
  qry : TFDquery;
begin
  try
    qry := TFDquery.Create(nil);
    qry.Connection := conn;

    qry.SQL.Add('select * from Pessoa ');

    if filtro <> '' then
    begin
      qry.SQL.Add('where nome like :nome');
      qry.ParamByName('nome').AsString := '%' + filtro + '%';
    end;
    qry.SQL.Add('order by nome');

    // vai no banco de dados, faz a pesquisa ...
    qry.Active := True;

    {o resultado do dataset é convertido em array Json
    contendo uma lista de pessoas e devolvido ao controller}
    result := qry.ToJSONArray;

  finally
    freeandnil(qry);
  end;
end;

function TDM.pessoaListarId(pessoa_id: integer): TJSONObject;
var
  qry : TFDquery;
begin
  try
    qry := TFDquery.Create(nil);
    qry.Connection := conn;

    qry.SQL.Add('select * from Pessoa ');

    if pessoa_id > 0 then
    begin
      qry.SQL.Add('where pessoa_id =:pessoa_id');
      qry.ParamByName('pessoa_id').AsInteger := pessoa_id;
    end;

    qry.Active := True;

    // devolve um array contendo uma  pessoas
    result := qry.toJSONObject;

  finally
    freeandnil(qry);
  end;

end;



function TDM.pessoaInserir(nome, telefone, setor: string): TJSONObject;
var
  qry: TFDQuery;
begin

  result := nil; // Inicializa o resultado para evitar lixo de memória
  qry := TFDQuery.Create(nil);

  try
    qry.Connection := conn;

    qry.SQL.Add('INSERT INTO pessoa (nome, telefone, setor)');
    qry.SQL.Add('VALUES (:nome, :telefone, :setor)');
    qry.SQL.Add('RETURNING pessoa_id');

    qry.ParamByName('nome').AsString     := nome;
    qry.ParamByName('telefone').AsString := telefone;
    qry.ParamByName('setor').AsString    := setor;

    qry.Open;

    if not qry.IsEmpty then
      result := qry.ToJSONObject;

  finally
    FreeAndNil(qry);
  end;
end;

function TDM.pessoaEditar(pessoa_id: integer;
                          nome, telefone, setor: string): TJSONObject;
var
  qry : TFDquery;
begin
  try
    qry := TFDquery.Create(nil);
    qry.Connection := conn;

    qry.SQL.Add('update pessoa');
    qry.SQL.Add(' set nome=:nome, telefone=:telefone, setor=:setor');
    qry.SQL.Add('where pessoa_id =:pessoa_id');
    qry.ParamByName('pessoa_id').AsInteger := pessoa_id;
    qry.ParamByName('nome').AsString := nome;
    qry.ParamByName('telefone').AsString := telefone;
    qry.ParamByName('setor').AsString := setor;
    qry.ExecSQL;

    // devolve um array contendo uma  pessoas com id
    result := TJSONObject.create(TJSONPair.create('pessoa_id', pessoa_id));

  finally
    freeandnil(qry);
  end;
end;

function TDM.pessoaExcluir(pessoa_id: integer): TJSONObject;
var
  qry : TFDquery;
begin
  try
    qry := TFDquery.Create(nil);
    qry.Connection := conn;

    qry.SQL.Add('delete from pessoa');
    qry.SQL.Add('where pessoa_id =:pessoa_id');
    qry.ParamByName('pessoa_id').AsInteger := pessoa_id;
    qry.ExecSQL;

    // devolve um array contendo uma  pessoas com id
    result := TJSONObject.create(TJSONPair.create('pessoa_id', pessoa_id));

  finally
    freeandnil(qry);
  end;
end;



end.
