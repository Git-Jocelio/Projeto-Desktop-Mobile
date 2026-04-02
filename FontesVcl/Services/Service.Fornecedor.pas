unit Service.Fornecedor;

interface

uses DataModule.Fornecedor,
     System.SysUtils;

type
  TServiceFornecedor = class
  public
    class procedure Salvar(pessoa_id: Integer; nome, cpf_cnpj, email, telefone, contato, telefone_contato: string);
  end;

implementation



class procedure TServiceFornecedor.Salvar(pessoa_id: Integer; nome, cpf_cnpj, email, telefone, contato, telefone_contato: string);
begin

  // validações
  if Trim(nome) = '' then
     raise Exception.Create('Informe o nome da empresa');

  if Trim(cpf_cnpj) = '' then
     raise Exception.Create('CPF ou CNPJ é obrigatório');

  if Trim(email) = '' then
     raise Exception.Create('e-mail é obrigatório');

  if Trim(telefone) = '' then
     raise Exception.Create('Telefone da empresa é obrigatório');

  if Trim(contato) = '' then
     raise Exception.Create('Contato é obrigatório');

  if Trim(telefone_contato) = '' then
     raise Exception.Create('Telefone do contato é obrigatório');


  // decide se insere ou edita
  if pessoa_id > 0 then
     DmFornecedor.Editar(pessoa_id, nome, email, telefone, contato, telefone_contato)
  else
     DmFornecedor.Inserir( nome, email, telefone, contato, telefone_contato);

end;



end.
