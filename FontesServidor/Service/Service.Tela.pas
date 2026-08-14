unit Service.Tela;

interface

uses DataModule.Tela, System.JSON, System.SysUtils,
 dialogs;

type
   //Classe responsável por:
   // -instanciar e destruir o datamodule
   // -inserir/alterar na tabela "Tela"
   TServiceTela = class
   private
     FDmTela : TdmTela;
   public
     constructor Create;
     destructor Destroy; override;
     function InserirEditar(id_tela, ordem: integer; nome_tela, modulo, ativo:string):TJSONObject;
     function Excluir(id_tela: integer):TJSONObject;
   end;

implementation

{ TServiceTela }

constructor TServiceTela.Create;
begin
  FDmTela := TdmTela.Create(nil)
end;

destructor TServiceTela.Destroy;
begin
  FDmTela.Free;
  inherited;
end;

function TServiceTela.InserirEditar(id_tela, ordem: integer; nome_tela,
                                      modulo, ativo: string): TJSONObject;
begin

  // validações...
  if id_tela < 0  then
    raise Exception.Create('ID inválido.');

  if nome_tela = ''  then
    raise Exception.Create('Informe o nome da tela.');

  if modulo = ''  then
    raise Exception.Create('Informe o modulo em que a tela será visualizada.');

  if ordem < 0  then
    raise Exception.Create('Informe a nivel em que a tela deve aparecer. ex.: 1, 2, 3 ...');

  if ativo = ''  then
    raise Exception.Create('Informe se a tela esta ativa ou inativa. ex.: "S" ou "N"');

  // inserir ou alterar
  if id_tela > 0 then
    result := FdmTela.Editar(nome_tela, modulo, ativo, id_tela, ordem )
  else
    result := FdmTela.Inserir(nome_tela, modulo, ativo, ordem )
end;

function TServiceTela.Excluir(id_tela: integer): TJSONObject;
begin
  // validações...
  if id_tela < 0  then
    raise Exception.Create('ID inválido.');

  result := FdmTela.Excluir(id_tela)
end;

end.
