unit Service.Usuario;

interface

uses  System.SysUtils, dialogs;

type
  TServiceUsuario = class
  private
  public
    class procedure CriarConta(login, senha, ativo, primeiro_acesso: string;
                                pessoaid: integer);
    class procedure SalvarSenha( senha: string);
    class procedure AtivarConta(senha: string);
    class procedure AlterarUsuario(login, ativo: string; usuarioid: integer);

  end;

implementation

{ TServiceUsuario }

uses DataModule.Usuario;

class procedure TServiceUsuario.AlterarUsuario(login, ativo: string;
                                                usuarioid: integer);
var
  dmUsuario : TdmUsuario;
begin
  // validações
  if Trim(login) = '' then
     raise Exception.Create('Informe umlogin');
  dmUsuario := TdmUsuario.Create(nil);
  try
    dmUsuario.AlterarUsuario(login, ativo, usuarioid);
  finally
    dmUsuario.Free;
  end;

end;

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


class procedure TServiceUsuario.AtivarConta(senha: string);
var
  dmUsuario : TdmUsuario;
begin
  // validações
  if Trim(senha) = '' then
     raise Exception.Create('Informe uma senha válida');
  dmUsuario := TdmUsuario.Create(nil);
  try
    //dmUsuario.AtivarConta(senha, pessoaid);
    dmUsuario.AtivarConta(senha);
  finally
    dmUsuario.Free;
  end;
end;

class procedure TServiceUsuario.CriarConta(login, senha, ativo,
                                   primeiro_acesso: string; pessoaid: integer );
var
  dmUsuario : TdmUsuario;
begin
  // validações
  if Trim(senha) = '' then
     raise Exception.Create('Informe uma senha válida');
  dmUsuario := TdmUsuario.Create(nil);
  try
    dmUsuario.CriarConta(login, senha, ativo, primeiro_acesso, pessoaid);
  finally
    dmUsuario.Free;
  end;
end;



end.
