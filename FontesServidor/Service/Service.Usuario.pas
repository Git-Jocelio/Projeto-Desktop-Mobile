unit Service.Usuario;

interface

uses
  System.SysUtils,       dialogs,
  System.JSON,
  datamodule.Usuario, uMD5;

  function Login(Login, Senha : string): TJSONObject;

implementation


function Login(Login, Senha: string): TJSONObject;
var
  dm : TDmUsuario;
begin

  try
    dm := TDmUsuario.Create(nil);

    Result :=  dm.usuarioLogin(Login, SaltPassword(Senha));
  finally
    FreeAndNil(dm);
  end;
end;

end.

