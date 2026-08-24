
unit Controllers.Usuario;

interface

uses Horse,
     DataModule.Pessoa, System.SysUtils,System.JSON,Service.Usuario,
     dialogs, Controllers.JWT, Horse.JWT;

procedure RegistrarRotas;
procedure Login(req: THorseRequest; res: THorseResponse; Next: TProc);
procedure InserirUsuario(req: THorseRequest; res: THorseResponse; Next: TProc);
procedure EditarSenha(req: THorseRequest; res: THorseResponse; Next: TProc);
procedure EditarUsuario(req: THorseRequest; res: THorseResponse; Next: TProc);
procedure listarUsuarioId(req: THorseRequest; res: THorseResponse; Next: TProc);
procedure listarTodos(req: THorseRequest; res: THorseResponse; Next: TProc);
procedure AtivarConta(req: THorseRequest; res: THorseResponse; Next: TProc);

implementation

procedure RegistrarRotas;
begin
  // rotas abertas
  THorse.Post('/usuario/login', Login);
  THorse.Post('/usuario/cadastro', InserirUsuario);

  // rotas protejidas
  THorse.AddCallback(HorseJWT( Controllers.JWT.SECRET,
                     THorseJWTConfig.New.SessionClass(TMyClaims)))
        .Post('/usuario/password', EditarSenha);

  THorse.AddCallback(HorseJWT( Controllers.JWT.SECRET,
                     THorseJWTConfig.New.SessionClass(TMyClaims)))
        .Post('/usuario/ativar', AtivarConta);


  THorse.AddCallback(HorseJWT( Controllers.JWT.SECRET,
                     THorseJWTConfig.New.SessionClass(TMyClaims)))
        .Get('/usuario/:id', listarUsuarioId);

  THorse.AddCallback(HorseJWT( Controllers.JWT.SECRET,
                     THorseJWTConfig.New.SessionClass(TMyClaims)))
        .Get('/usuario', listarTodos);


  THorse.AddCallback(HorseJWT( Controllers.JWT.SECRET,
                     THorseJWTConfig.New.SessionClass(TMyClaims)))
        .Put('/usuario', EditarUsuario);
end;

procedure Login(req: THorseRequest; res: THorseResponse; Next: TProc);
var
  body: TJSONObject;
  jsonRetorno: TJSONObject;
  login, senha: string;
begin


  jsonRetorno := nil;
  try
    body := req.Body<TJSONObject>;
    if not Assigned(body) then
    begin
      res.Send('JSON inválido ou vazio').Status(400);
      Exit;
    end;
    login := body.GetValue<string>('login', '');
    senha := body.GetValue<string>('senha', '');
    jsonRetorno := Service.Usuario.Login(login, senha);

    //if jsonRetorno.Count = 0 then --> assim se usuario digitou email ou senha errado não funciona
    if not Assigned(jsonRetorno) then
    begin
      res.Status(401).Send('Login ou senha inválido');
      FreeAndNil(jsonRetorno);
    end
    else
    begin
      // gerar token JWT.. curso Poupei, aula 04, miunuto 31"25
      // gera o token e acrescenta no json
      jsonRetorno.AddPair('token',
                      Criar_Token(jsonRetorno.GetValue<integer>('usuarioid')));
      res.Send<TJSONObject>(jsonRetorno).Status(200);
    end;
  except
    on E: Exception do
      res.Send(E.Message).Status(500);
  end;
end;

//15/05/2026
//gerar um usuário para um colaborador
procedure InserirUsuario(req: THorseRequest; res: THorseResponse; Next: TProc);
var
  body: TJSONObject;
  login, senha, ativo, primeiro_acesso: string;
  pessoaid: integer;
  jsonRetorno: TJSONObject;
begin
  jsonRetorno := nil;
  try
    body := req.Body<TJSONObject>;
    if not Assigned(body) then
    begin
      res.Send('JSON inválido ou vazio').Status(400);
      Exit;
    end;

    pessoaid := body.GetValue<integer>('pessoaid', 0);
    login := body.GetValue<string>('login', '');
    senha := body.GetValue<string>('senha', '');
    ativo := body.GetValue<string>('ativo', 'N');
    primeiro_acesso := body.GetValue<string>('primeiro_acesso', '');
    jsonRetorno := Service.Usuario.InserirUsuario(login, senha, primeiro_acesso,
                                                  pessoaid);
    // gerar token JWT.. curso Poupei, aula 04, miunuto 31"25
    jsonRetorno.AddPair('token',
                      Criar_Token(jsonRetorno.GetValue<integer>('usuarioid')));
    res.Send<TJSONObject>(jsonRetorno).Status(201);
  except
    on E: Exception do
      res.Send(E.Message).Status(500);
  end;
end;

procedure EditarSenha(req: THorseRequest; res: THorseResponse; Next: TProc);
var
  body: TJSONObject;
  usuarioid: integer;
  senha: string;
begin
  try
    body := req.Body<TJSONObject>;
    if not Assigned(body) then
    begin
      res.Send('JSON inválido ou vazio').Status(400);
      Exit;
    end;
    senha := body.GetValue<string>('senha', '');
    // pega o id do usuario contido dentro do json
    usuarioid := Get_Usuario_Request(req);
    Service.Usuario.EditarSenha( usuarioid, senha );

    res.Send('OK');
  except
    on E: Exception do
      res.Send(E.Message).Status(500);
  end;
end;


procedure AtivarConta(req: THorseRequest; res: THorseResponse; Next: TProc);
var
  body: TJSONObject;
  usuarioid: integer;
  senha: string;
begin
  try
    body := req.Body<TJSONObject>;
    if not Assigned(body) then
    begin
      res.Send('JSON inválido ou vazio').Status(400);
      Exit;
    end;
    senha := body.GetValue<string>('senha', '');
    // pega o id do usuario contido dentro do json
    usuarioid := Get_Usuario_Request(req);
    Service.Usuario.AtivarConta( usuarioid, senha );

    res.Send('Ok');
  except
    on E: Exception do
      res.Send(E.Message).Status(500);
  end;
end;



procedure listarUsuarioId(req: THorseRequest; res: THorseResponse; Next: TProc);
var
  usuarioid: integer;
begin
  try
    // vai pegar o usuario que esta no token(o que fez o login)
    usuarioid := Get_Usuario_Request(req);
    res.Send<TJSONObject>( Service.Usuario.listarUsuarioId( usuarioid ));
  except
    on E: Exception do
      res.Send(E.Message).Status(500);
  end;
end;

procedure listarTodos(req: THorseRequest; res: THorseResponse; Next: TProc);
begin
  try
    res.Send<TJSONArray>( Service.Usuario.listarTodos );
  except
    on E: Exception do
      res.Send(E.Message).Status(500);
  end;
end;

procedure EditarUsuario(req: THorseRequest; res: THorseResponse; Next: TProc);
var
  body: TJSONObject;
  usuarioid: integer;
  login, ativo: string;
begin
  try
    body := req.Body<TJSONObject>;
    if not Assigned(body) then
    begin
      res.Send('JSON inválido ou vazio').Status(400);
      Exit;
    end;


    usuarioid := Get_Usuario_Request(req);
    login := body.GetValue<string>('login', '');
    ativo := body.GetValue<string>('ativo', '');
    Service.Usuario.EditarUsuario( usuarioid, login, ativo );
    res.Send('OK');
  except
    on E: Exception do
      res.Send(E.Message).Status(500);
  end;
end;

end.
