
unit Controllers.Usuario;
// vem da unitPrincipaL e vai para dmUsuarios

interface
uses Horse,
     DataModule.Pessoa, dialogs,
     System.SysUtils,
     System.JSON,Service.Usuario,
     Controllers.JWT;

procedure RegistrarRotas;
procedure Login(req: THorseRequest; res: THorseResponse; Next: TProc);
procedure InserirUsuario(req: THorseRequest; res: THorseResponse; Next: TProc);
procedure EditarSenha(req: THorseRequest; res: THorseResponse; Next: TProc);
procedure listarUsuarioId(req: THorseRequest; res: THorseResponse; Next: TProc);
procedure EditarUsuario(req: THorseRequest; res: THorseResponse; Next: TProc);

implementation


procedure RegistrarRotas;
begin
  THorse.Post('/usuario/login', Login);
  THorse.Post('/usuario/cadastro', InserirUsuario);
  THorse.Post('/usuario/password', EditarSenha);

  //não passarei o id do usuário pq ele será passado dentro do token JWT
  THorse.Get('/usuario', listarUsuarioId);
  THorse.Put('/usuario', EditarUsuario);
end;

procedure Login(req: THorseRequest; res: THorseResponse; Next: TProc);
var
  body: TJSONObject;
  login, senha: string;
  jsonRetorno: TJSONObject;
begin
  //dmUsuario := nil;
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
      jsonRetorno.AddPair('token',
                      Criar_Token(jsonRetorno.GetValue<integer>('usuarioid')));
      res.Send<TJSONObject>(jsonRetorno).Status(200);
    end;
  except
    on E: Exception do
      res.Send(E.Message).Status(500);
  end;

end;

procedure InserirUsuario(req: THorseRequest; res: THorseResponse; Next: TProc);
begin

end;

procedure EditarSenha(req: THorseRequest; res: THorseResponse; Next: TProc);
begin

end;

procedure listarUsuarioId(req: THorseRequest; res: THorseResponse; Next: TProc);
begin

end;

procedure EditarUsuario(req: THorseRequest; res: THorseResponse; Next: TProc);
begin

end;

end.
