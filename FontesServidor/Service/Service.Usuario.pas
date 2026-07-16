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
  function listarUsuarioId(usuarioid: integer): TJSONObject;
  procedure EditarUsuario(usuarioid: integer; login, nome: string; setorid:integer);

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
  json_retorno : TJSONObject;
begin

  if (nome='') or (telefone='') or (email='') or (senha='') then
    raise Exception.Create('Informe todos os campos: Nome, Telefone, Email, Senha ');

  try
    dm := TDmUsuario.Create(nil);

    json_retorno := dm.listarUsuarioByEmail(email);

    if json_retorno.Count  > 0 then
      raise Exception.Create('Já existe um email cadastrado para essa conta');


    Result := dm.InserirUsuario(nome, telefone, email, SaltPassword(Senha), pessoaId, setorId);
  finally
    FreeAndNil(json_retorno);
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

function listarUsuarioId(usuarioid: integer): TJSONObject;
var
  dm : TDmUsuario;
begin

  try
    dm := TDmUsuario.Create(nil);

    result := dm.listarUsuarioId(usuarioid);
  finally
    FreeAndNil(dm);
  end;
end;

procedure EditarUsuario(usuarioid: integer; login, nome: string; setorid:integer);
var
  dm : TDmUsuario;
begin

  try
    dm := TDmUsuario.Create(nil);

    dm.EditarUsuario(usuarioid, login, nome, setorid);
  finally
    FreeAndNil(dm);
  end;
end;


end.

