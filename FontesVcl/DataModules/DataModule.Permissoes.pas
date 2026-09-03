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
    procedure InserirPermissoes(MemTable: TFDMemtable; perfilId: integer);
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

procedure TDmPermissoes.InserirPermissoes(MemTable: TFDMemtable; perfilId: integer);
var
  json: TJSONObject;     //json principal que será enviado ao back(perfil e sua permissoes)
  item: TJSONObject;     //json de uma permissao
  permissoes: TJSONArray;//coleção de item(permissoes)
  resp: IResponse;
begin

  (*
        json principal a ser montado

        "perfil_id": 2,
        "permissoes": [
          {
            "tela_id": 1,
            "ver": "S",
            "inserir": "S",
            "editar": "S",
            "excluir": "N",
            "imprimir": "S"
          }

  *)

  json := TJSONObject.Create;      //json principal (perfil e suas permissoes)
  permissoes := TJSONArray.Create; // coleção de permissões para um perfil


  // montar json com as permissoes...
  try
    MemTable.First;

    while not MemTable.Eof do
    begin
        item := TJSONObject.Create;

        item.AddPair('tela_id', MemTable.FieldByName('id_tela').AsInteger);
        item.AddPair('ver',     MemTable.FieldByName('ver').AsString);
        item.AddPair('inserir', MemTable.FieldByName('inserir').AsString);
        item.AddPair('editar',  MemTable.FieldByName('editar').AsString);
        item.AddPair('excluir', MemTable.FieldByName('excluir').AsString);
        item.AddPair('imprimir',MemTable.FieldByName('imprimir').AsString);
        // array com as permissoes
        permissoes.AddElement(item);

      MemTable.Next;
    end;

    // montar o json principal, ja temos o json com as permissoes, então...juntar tudo em um único json
    json.AddPair('perfil_id',TJSONNumber.Create(perfilId));
    json.AddPair('permissoes', permissoes);

    // montar requisição
    resp := TRequest.New
                    .BaseURL(URL_BASE)
                    .Resource('/permissoes')
                    .TokenBearer(TSession.TOKEN)
                    .ContentType('application/json')
                    .AddBody(json.ToJSON)
                    .Post;

    if resp.StatusCode <> 201 then
      raise Exception.Create(resp.Content);

    ShowMessage('Permissões salvas com sucesso!');

  finally
    json.Free;
  end;
end;


end.
