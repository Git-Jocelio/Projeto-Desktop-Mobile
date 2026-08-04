unit Service.Usuario;

interface

uses
  System.SysUtils,       dialogs,
  System.JSON,
  datamodule.Usuario, uMD5;

  function Login(Login, Senha : string): TJSONObject;

  function InserirUsuario(email, senha, primeiro_acesso, alterar_senha: string;
                           pessoaId: integer): TJSONObject;


  procedure EditarSenha(usuarioid: integer; senha: string);
  function listarUsuarioId(usuarioid: integer): TJSONObject;
  procedure EditarUsuario(usuarioid: integer; login, nome: string);

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

//function InserirUsuario(nome, cpf, telefone, email, senha, primeiro_acesso,
function InserirUsuario(email, senha, primeiro_acesso, alterar_senha: string;
                         pessoaId: integer): TJSONObject;
var
  dm : TDmUsuario;
  json_retorno: TJSONObject;
begin
  dm := nil;
  json_Retorno:= nil;

  if (email='') or (senha='') then
    raise Exception.Create('Informe todos os campos: Email, Senha ');

  try
    dm := TDmUsuario.Create(nil);
    json_retorno := dm.listarUsuarioByEmail(email);

    if Assigned(json_Retorno) then
      raise Exception.Create('Já existe um email cadastrado para essa conta');

    Result := dm.InserirUsuario( email, SaltPassword(Senha), pessoaId);
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

procedure EditarUsuario(usuarioid: integer; login, nome: string);
var
  dm : TDmUsuario;
begin

  try
    dm := TDmUsuario.Create(nil);

    dm.EditarUsuario(usuarioid, login, nome);
  finally
    FreeAndNil(dm);
  end;
end;


end.

