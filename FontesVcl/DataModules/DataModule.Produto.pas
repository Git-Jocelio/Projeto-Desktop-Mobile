unit DataModule.Produto;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  DataSet.Serialize.Config,
  RestRequest4D,
  DataSet.Serialize.Adapter.RESTRequest4D,
  System.JSON ;

type
  TDmProduto = class(TDataModule)
    tabProduto: TFDMemTable;
  private
  public
    procedure ListarProduto(memTable: TFDMemTable; filtro: string);
    procedure Excluir(produtoId: integer);
  end;

var
  DmProduto: TDmProduto;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}


procedure TDmProduto.ListarProduto(memTable: TFDMemTable; filtro : string);
var
  resp : IResponse;
begin
  resp := TRequest.New.BaseURL('http://localhost:3000')
                      .Resource('/produto')
                      .AddParam('filtro',filtro)
                      .Accept('application/json')
                      .Adapters(TDataSetSerializeAdapter.New(memTable))
                      .Get;
  if resp.StatusCode <> 200 then
    raise Exception.Create(resp.content);

end;


procedure TDmProduto.Excluir(produtoId: integer);
var
  resp : IResponse;
begin

    resp := TRequest.New.BaseURL('http://localhost:3000')
                        .Resource('/produto')
                        .ResourceSuffix(produtoId.ToString)
                        .Accept('application/json')
                        .delete;
    if resp.StatusCode <> 200 then
      raise Exception.Create(resp.content);
end;



end.
