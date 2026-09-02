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
  Vcl.Config,      dialogs,
  Vcl.Session;

type
  TDmPermissoes = class(TDataModule)
    TabPermissoes: TFDMemTable;
    procedure DataModuleCreate(Sender: TObject);
  private
  public
    procedure ListarPermissoes(perfilId: integer);
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

procedure TDmPermissoes.ListarPermissoes(perfilId: integer);
var
  Res : IResponse;
begin
  // limpar o dataset
  if TabPermissoes.Active then
    TabPermissoes.emptydataset;

  TabPermissoes.FieldDefs.Clear;

  Res := TRequest.New.BaseURL(URL_BASE)
                 .Resource('/permissoes/' + perfilId.ToString)
                 .TokenBearer(TSession.TOKEN)
                 .Accept('application/json')
                 .Adapters(TDataSetSerializeAdapter.New(TabPermissoes))
                 .Get;
  if Res.StatusCode <> 200 then
    raise Exception.Create(Res.content);
end;


end.
