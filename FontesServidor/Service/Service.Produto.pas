unit Service.Produto;

interface

uses
  System.SysUtils, System.JSON, datamodule.Produto;

type
  TServiceProduto = class
  private
    FDM: TDmProduto;
  public
    constructor Create;
    destructor Destroy; override;

    function InserirEditarProduto(const produtoId: integer; const descricao, unidade: string; estoque: integer): TJSONObject;
  end;

implementation

{ TServicePessoa }

constructor TServiceProduto.Create;
begin
  FDM := TDmProduto.Create(nil);
end;

destructor TServiceProduto.Destroy;
begin
  freeandnil(FDM);
end;



function TServiceProduto.InserirEditarProduto(const produtoId: integer; const descricao, unidade: string; estoque: integer ): TJSONObject;
begin
  // Validações da regra de negócio
  if descricao.Trim = '' then
    raise Exception.Create('Informe o nome do produto');

  if unidade.Trim = '' then
    raise Exception.Create('unidade é obrigatório');

  if estoque < 0 then
    raise Exception.Create('Informe o estoque');

  // Aqui chama o DataModule só para persistência
  if ProdutoId = 0 then
     Result := FDM.produtoInserir(descricao, unidade, estoque)
  else
     Result := FDM.produtoEditar(produtoId, descricao, unidade, estoque);
end;




end.

