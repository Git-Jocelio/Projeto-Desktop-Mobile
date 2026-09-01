unit DataModule.Permissoes;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  DataSet.Serialize.Config,                // transforma json em dataset
  RestRequest4D,                           // usado para receber respostas do servidor
  DataSet.Serialize.Adapter.RESTRequest4D, //json para dataset
  System.JSON,
  Vcl.Config,
  Vcl.Session;

type
  TDmPermissoes = class(TDataModule)
    TabPerfis: TFDMemTable;
    procedure DataModuleCreate(Sender: TObject);
  private
    procedure ListarTodos;
  public
    { Public declarations }
  end;

var
  DmPermissoes: TDmPermissoes;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDmPermissoes.DataModuleCreate(Sender: TObject);
begin
  TDataSetSerializeConfig.GetInstance.CaseNameDefinition := cndLower;
  TDataSetSerializeConfig.GetInstance.Import.DecimalSeparator := '.';
end;

procedure TDmPermissoes.ListarTodos;
var
  Res : IResponse;
begin
  // limpar o dataset
  if TabPerfis.Active then
    TabPerfis.emptydataset;

  TabPerfis.FieldDefs.Clear;

  Res := TRequest.New.BaseURL(URL_BASE)
                 .Resource('/perfil')
                 .TokenBearer(TSession.TOKEN)
                 .Accept('application/json')
                 .Adapters(TDataSetSerializeAdapter.New(TabPerfis))
                 .Get;

  if Res.StatusCode <> 200 then
    raise Exception.Create(Res.content);
end;


end.
