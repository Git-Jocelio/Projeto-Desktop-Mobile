unit Service.Usuario;

interface

uses
  System.SysUtils, dialogs,
  System.JSON,
  datamodule.Usuario, uMD5;

  function Login(Login, Senha : string): TJSONObject;

  function InserirUsuario(login, senha, primeiro_acesso: string;
                           pessoaId: integer): TJSONObject;


  procedure EditarSenha(usuarioid: integer; senha: string);
  function listarUsuarioId(usuarioid: integer): TJSONObject;
  function listarTodos: TJSONArray;
  procedure EditarUsuario(usuarioid: integer; login, ativo: string);
  procedure AtivarConta(usuarioid: integer; senha: string);

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

function InserirUsuario(login, senha, primeiro_acesso: string;
                         pessoaId: integer): TJSONObject;
var
  dm : TDmUsuario;
  json_retorno: TJSONObject;
begin
  dm := nil;
  json_Retorno:= nil;

  if (login='') or (senha='') then
    raise Exception.Create('Informe todos os campos: Email, Senha ');

  try
    dm := TDmUsuario.Create(nil);
    json_retorno := dm.listarUsuarioByLogin(login);

    if Assigned(json_Retorno) then
      raise Exception.Create('Já existe um login cadastrado para essa conta');

    Result := dm.InserirUsuario( login, SaltPassword(Senha), pessoaId);
  finally
    FreeAndNil(json_Retorno);
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


procedure AtivarConta(usuarioid: integer; senha: string);
var
  dm : TDmUsuario;
begin
  try
    dm := TDmUsuario.Create(nil);
    dm.AtivarConta(usuarioid, SaltPassword(Senha));
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


function listarTodos: TJSONArray;
var
  dm : TDmUsuario;
begin
  try
    dm := TDmUsuario.Create(nil);
    result := dm.listarTodos;
  finally
    FreeAndNil(dm);
  end;
end;


procedure EditarUsuario(usuarioid: integer; login, ativo: string);
var
  dm : TDmUsuario;
begin
  if (login='') or (ativo='') then
    raise Exception.Create('Informe todos os campos: Login e ativo ');

  try
    dm := TDmUsuario.Create(nil);
    dm.EditarUsuario(usuarioid, login, ativo);
  finally
    FreeAndNil(dm);
  end;
end;


end.

