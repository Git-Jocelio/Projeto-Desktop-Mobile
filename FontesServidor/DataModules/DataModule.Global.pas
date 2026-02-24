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

    qry.sql.Add('order by nome');
    qry.Active := True;

    // devolve um array contendo uma lista de pessoas
    result := qry.ToJSONArray;

  finally
    freeandnil(qry);
  end;

end;




end.
