unit DataModule.Perfil;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  DataSet.Serialize.Config,  // transforma json em dataset
  RestRequest4D,             // usado para receber respostas do servidor
  DataSet.Serialize.Adapter.RESTRequest4D, //json para dataset
  System.JSON,
  Vcl.Config,
  Vcl.Session;

type
  TDmPerfil = class(TDataModule)
    MemTable: TFDMemTable;
    procedure DataModuleCreate(Sender: TObject);
  private
  public
    procedure ListarTodos;
  end;

var
  DmPerfil: TDmPerfil;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDmPerfil.DataModuleCreate(Sender: TObject);
begin
  TDataSetSerializeConfig.GetInstance.CaseNameDefinition := cndLower;
  TDataSetSerializeConfig.GetInstance.Import.DecimalSeparator := '.';

end;

procedure TDmPerfil.ListarTodos;
var
  Res : IResponse;
begin
  // limpar o dataset
  if MemTable.Active then
    MemTable.emptydataset;

  MemTable.FieldDefs.Clear;

  Res := TRequest.New.BaseURL(URL_BASE)
                 .Resource('/perfil')
                 .TokenBearer(TSession.TOKEN)
                 .Accept('application/json')
                 .Adapters(TDataSetSerializeAdapter.New(MemTable))
                 .Get;

  if Res.StatusCode <> 200 then
    raise Exception.Create(Res.content);
end;


end.
