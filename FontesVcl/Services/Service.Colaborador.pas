unit Service.Colaborador;

interface
uses  System.SysUtils;

type
  TServiceColaborador = class
  public
    class procedure Salvar(pessoa_id: Integer; nome, email, telefone: string; setorID: integer);
  end;


implementation

{ TServiceColaborador }

uses DataModule.Colaborador;

class procedure TServiceColaborador.Salvar(pessoa_id: Integer; nome, email,
  telefone: string; setorID: integer);
begin
  // validações
  if Trim(nome) = '' then
     raise Exception.Create('Informe o nome');

  if Trim(email) = '' then
     raise Exception.Create('e-mail é obrigatório');

  if Trim(telefone) = '' then
     raise Exception.Create('Telefone da empresa é obrigatório');


  if setorID <=0 then
     raise Exception.Create('Informe o setor.');



  // decide se insere ou edita
  if pessoa_id > 0 then
     DmColaborador.Editar(pessoa_id, nome, email, telefone, setorID)
  else
     DmColaborador.Inserir( nome, email, telefone, setorID);

end;

end.
