unit Service.Produto;

interface

type
  TServiceProduto = class
  public
    class procedure Salvar(produto_id: Integer; descricao, unidade: string; estoque: integer);
  end;

implementation

uses
  System.SysUtils,
  DataModule.Produto;

class procedure TServiceProduto.Salvar(produto_id: Integer; descricao, unidade: string; estoque: integer);
begin

  // validações
  if Trim(descricao) = '' then
     raise Exception.Create('Informe a descrição do produto');

  if Trim(unidade) = '' then
     raise Exception.Create('Unidade é obrigatório');

  if estoque < 0 then
     raise Exception.Create('Estoque não pode ser menor que zero');

  // decide se insere ou edita
  if produto_id > 0 then
     DmProduto.Editar(produto_id, descricao, unidade, estoque)
  else
     DmProduto.Inserir(descricao, unidade, estoque);

end;

end.
