unit DataModule.UsuarioPerfil;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  DataSet.Serialize.Config,
  RestRequest4D,
  DataSet.Serialize.Adapter.RESTRequest4D,
  System.JSON,
  Vcl.Config;

type
  TDmUsuarioPerfil = class(TDataModule)
    MemTable: TFDMemTable;
  private
  public
    procedure Listar(memTable: TFDMemTable; filtro: string);
  end;

var
  DmUsuarioPerfil: TDmUsuarioPerfil;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDmUsuarioPerfil.Listar(memTable: TFDMemTable; filtro: string);
var
  resp : IResponse;
begin
  resp := TRequest.New.BaseURL(URL_BASE)
                      .Resource('/usuarioPerfil')
                      .AddParam('filtro',filtro)
                      .Accept('application/json')
                      .Adapters(TDataSetSerializeAdapter.New(memTable))
                      .Get;
  if resp.StatusCode <> 200 then
    raise Exception.Create(resp.content);

end;


end.
