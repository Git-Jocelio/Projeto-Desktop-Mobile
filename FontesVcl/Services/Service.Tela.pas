unit Service.Tela;

interface

uses System.SysUtils;

type
  TServiceTela = class
  public
    class procedure Salvar(id_tela, ordem: Integer; nome_tela, modulo, ativo: string);
  end;


implementation

uses DataModule.Tela;

class procedure TServiceTela.Salvar(id_tela, ordem: Integer; nome_tela, modulo, ativo: string);
begin
  // validações
  if Trim(nome_tela) = '' then
     raise Exception.Create('Informe o nome da tela');

  if Trim(modulo) = '' then
     raise Exception.Create('Informe o módulo');

  if ordem <= 0 then
     raise Exception.Create('Informe a ordem no menu');

  // decide se insere ou edita
  if id_tela > 0 then
     DmTela.Editar(id_tela, ordem, nome_tela, modulo, ativo)
  else
     DmTela.Inserir(ordem, nome_tela, modulo, ativo);

end;


end.
