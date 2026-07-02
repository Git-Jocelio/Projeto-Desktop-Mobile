
unit Controllers.Usuario;
// vem da unitPrincipaL e vai para dmUsuarios

interface
uses Horse,
     DataModule.Pessoa,
     System.SysUtils,         dialogs,
     System.JSON,
     DataModule.Usuario;

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
  THorse.post('/usuario/cadastro', InserirUsuario);
  THorse.post('/usuario/password', EditarSenha);

  //não passarei o id do usuário pq ele será passado dentro do token JWT
  THorse.get('/usuario', listarUsuarioId);
  THorse.put('/usuario', EditarUsuario);
end;

procedure Login(req: THorseRequest; res: THorseResponse; Next: TProc);
var
  dmUsuario: TDmUsuario;
  body: TJSONObject;
  login, senha: string;
  jsonRetorno: TJSONObject;
begin
  dmUsuario := nil;
  jsonRetorno := nil;

  try
    try
      body := req.Body<TJSONObject>;

      if not Assigned(body) then
      begin
        res.Send('JSON inválido ou vazio').Status(400);
        Exit;
      end;

      login := body.GetValue<string>('login', '');
      senha := body.GetValue<string>('senha', '');

      dmUsuario := TDmUsuario.Create(nil);

      jsonRetorno := dmUsuario.usuarioLogin(login, senha);

      if Assigned(jsonRetorno) then
        res.Send<TJSONObject>(jsonRetorno).Status(200)
      else
        res.Send('Login ou senha inválidos').Status(401);

    except
      on E: Exception do
        res.Send(E.Message).Status(500);
    end;

  finally
    // Não liberar jsonRetorno.
    // O Horse/Jhonson assume a propriedade do TJSONObject enviado via Send<TJSONObject>.
    dmUsuario.Free;
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
