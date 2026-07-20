unit Service.Usuario;

interface

uses  System.SysUtils, dialogs;

type
  TServiceUsuario = class
  public
    class procedure SalvarSenha( senha: string);
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

end.
