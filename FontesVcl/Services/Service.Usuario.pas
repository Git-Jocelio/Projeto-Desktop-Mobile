unit Service.Usuario;

interface

uses  System.SysUtils, dialogs;

type
  TServiceUsuario = class
  private
  public
    class procedure SalvarSenha( senha: string);
    class procedure CriarConta(email, senha, ativo, primeiro_acesso,
      alterar_senha: string; pessoaid: integer);
  end;

implementation

{ TServiceUsuario }

uses DataModule.Usuario;

class procedure TServiceUsuario.SalvarSenha( senha: string );
var
  dmUsuario : TdmUsuario;
begin
  // validações
  if Trim(senha) = '' then
     raise Exception.Create('Informe uma senha válida');

  dmUsuario := TdmUsuario.Create(nil);
  try
    dmUsuario.AlterarSenha(senha);
  finally
    dmUsuario.Free;
  end;
end;


class procedure TServiceUsuario.CriarConta( email, senha, ativo, primeiro_acesso, alterar_senha: string; pessoaid: integer );
var
  dmUsuario : TdmUsuario;
begin
  // validações
  if Trim(email) = '' then// trocar por login...
     raise Exception.Create('Informe um email válido');

  if Trim(senha) = '' then
     raise Exception.Create('Informe uma senha válida');

  dmUsuario := TdmUsuario.Create(nil);
  try
    dmUsuario.CriarConta(email, senha, ativo, primeiro_acesso, alterar_senha, pessoaid);
  finally
    dmUsuario.Free;
  end;

end;


end.
