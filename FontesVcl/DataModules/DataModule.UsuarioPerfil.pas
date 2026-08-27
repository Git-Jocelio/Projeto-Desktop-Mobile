unit DataModule.UsuarioPerfil;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  DataSet.Serialize.Config,
  RestRequest4D,
  DataSet.Serialize.Adapter.RESTRequest4D,   dialogs,
  System.JSON,
  Vcl.Config, Vcl.Session;

type
  TDmUsuarioPerfil = class(TDataModule)
    MemTable: TFDMemTable;
  private
  public
    procedure Listar(memTable: TFDMemTable; filtro: string);
    procedure ListarId(memTable: TFDMemTable; usuarioid: integer);
    procedure VincularPerfis(MemTable: TFDMemtable; usuarioid: integer);
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

procedure TDmUsuarioPerfil.ListarId(memTable: TFDMemTable; usuarioid: integer);
var
  resp : IResponse;
begin
  // limpar o dataset
  if MemTable.Active then
    MemTable.emptydataset;


  // lista os perfis do usuario logado, preciso criar um end poit para listar os perfis para a manutenção
  resp := TRequest.New.BaseURL(URL_BASE)
                      .Resource('/usuario/perfil')
                      .ResourceSuffix(usuarioid.ToString)
                      .Accept('application/json')
                      .TokenBearer(TSession.TOKEN)
                      .Adapters(TDataSetSerializeAdapter.New(MemTable))
                      .Get;
  // trata erro se houver
  if resp.StatusCode <> 200 then
    raise Exception.Create(resp.content);
end;

procedure TDmUsuarioPerfil.VincularPerfis(MemTable: TFDMemtable; usuarioid: integer);
var
  json: TJSONObject;
  perfis: TJSONArray;
  item: TJSONObject;
  resp: IResponse;
begin

  json := TJSONObject.Create;
  perfis := TJSONArray.Create;

  try
    MemTable.First;

    while not MemTable.Eof do
    begin
      if MemTable.FieldByName('VINCULADO').AsString = 'S' then
      begin
        item := TJSONObject.Create;

        item.AddPair(
          'id_perfil',
          TJSONNumber.Create(
            MemTable.FieldByName('ID_PERFIL').AsInteger
          )
        );

        perfis.AddElement(item);
      end;

      MemTable.Next;
    end;

    json.AddPair(
      'id_usuario',
      TJSONNumber.Create(usuarioid)
    );

    json.AddPair('perfis', perfis);

    resp := TRequest.New
                   .BaseURL(URL_BASE)
                   .Resource('/usuario/perfil')
                   .TokenBearer(TSession.TOKEN)
                   .ContentType('application/json')
                   .AddBody(json.ToJSON)
                   .Post;

    if resp.StatusCode <> 201 then
      raise Exception.Create(resp.Content);

    ShowMessage('Perfis salvos com sucesso!');

  finally
    json.Free;
  end;
end;

end.
