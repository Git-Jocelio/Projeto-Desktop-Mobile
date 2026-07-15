unit Service.Usuario;

interface

uses
  System.SysUtils,       dialogs,
  System.JSON,
  datamodule.Usuario, uMD5;

  function Login(Login, Senha : string): TJSONObject;
  function InserirUsuario(nome, telefone, email, senha: string; pessoaId,
                            setorId: integer): TJSONObject;
  procedure EditarSenha(usuarioid: integer; senha: string);

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


function InserirUsuario(nome, telefone, email, senha: string; pessoaId, setorId: integer): TJSONObject;
var
  dm : TDmUsuario;
begin

  try
    dm := TDmUsuario.Create(nil);

    Result := dm.InserirUsuario(nome, telefone, email, SaltPassword(Senha), pessoaId, setorId);
  finally
    FreeAndNil(dm);
  end;
end;

procedure EditarSenha(usuarioid: integer; senha: string);
var
  dm : TDmUsuario;
begin

  try
    dm := TDmUsuario.Create(nil);

    dm.EditarSenha(usuarioid, SaltPassword(Senha));
  finally
    FreeAndNil(dm);
  end;
end;

end.

