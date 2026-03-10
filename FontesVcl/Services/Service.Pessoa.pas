unit Service.Pessoa;

interface

type
  TServicePessoa = class
  public
    class procedure Salvar(pessoa_id: Integer; nome, telefone, setor: string);
  end;

implementation

uses
  System.SysUtils,
  DataModele.Pessoa;

class procedure TServicePessoa.Salvar(pessoa_id: Integer; nome, telefone, setor: string);
begin

  // validações
  if Trim(nome) = '' then
     raise Exception.Create('Informe o nome da pessoa');

  if Trim(telefone) = '' then
     raise Exception.Create('Telefone é obrigatório');

  if Trim(setor) = '' then
     raise Exception.Create('Setor é obrigatório');


  // decide se insere ou edita
  if pessoa_id > 0 then
     DmPessoa.Editar(pessoa_id, nome, telefone, setor)
  else
     DmPessoa.Inserir(nome, telefone, setor);

end;

end.
