unit DataModele.Pessoa;

interface

uses
  System.SysUtils, System.Classes,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FireDAC.Stan.Intf,
  DataSet.Serialize.Config,  // transforma json em dataset
  RestRequest4D, // usado para receber respostas do servidor
  DataSet.Serialize.Adapter.RESTRequest4D ;

type
  TDmPessoa = class(TDataModule)
    tabPessoa: TFDMemTable;
    procedure DataModuleCreate(Sender: TObject);
  private
  public
    procedure ListarPessoa(memTable: TFDMemTable; filtro: string);
  end;

var
  DmPessoa: TDmPessoa;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDmPessoa.DataModuleCreate(Sender: TObject);
begin
  TDataSetSerializeConfig.GetInstance.CaseNameDefinition := cndLower;
  TDataSetSerializeConfig.GetInstance.Import.DecimalSeparator := '.';

end;

procedure TDmPessoa.ListarPessoa(memTable: TFDMemTable; filtro : string);
var
  resp : IResponse; // usado para receber respostas do servidor
begin
  resp := TRequest.New.BaseURL('http://localhost:3000') // criando uma requisição do servidor
                      .Resource('/pessoa')               // nessa rota
                      .AddParam('filtro',filtro)        // nesse filtro
                      .Accept('application/json')       // trabalhar com json
                      .Adapters(TDataSetSerializeAdapter.New(memTable)) // qdo a requisicao voltar vai pegar o json e jogar dentro do memtable
                      .Get;                             // passando um Get


  // trata erro se houver
  if resp.StatusCode <> 200 then
    raise Exception.Create(resp.content);

end;


end.
