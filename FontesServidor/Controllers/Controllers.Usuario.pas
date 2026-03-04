unit Controllers.Usuario;

interface
uses Horse,
     DataModule.Pessoa,  dialogs,
     System.SysUtils,
     System.JSON,
     DataModule.Usuario;

procedure RegistrarRotas;
procedure Login(req : THorseRequest; res : THorseResponse; Next : TProc);

implementation

procedure RegistrarRotas;
begin
   {o metodo login por segurança é recomendavel usar o metódo Post, assim
   login e senha são enviados  via json e não pela url}
   THorse.Post('/usuario/login', Login);
end;

procedure Login(req : THorseRequest; res : THorseResponse; Next : TProc);
var
  dmUsuario: TDmUsuario;
  body: TJSONObject;
  email, senha: string;
  jsonRetorno: TJSONObject;
begin
  dmUsuario := nil;
  try
    try
      body := req.Body<TJSONObject>;

      if not Assigned(body) then
      begin
        res.Send('JSON inválido ou vazio').Status(400);
        Exit;
      end;

      //dmUsuario := TDmUsuario.Create(nil);

      email := body.GetValue<string>('email', '');
      senha := body.GetValue<string>('senha', '');

      // 2. Chama a função e armazena o resultado em uma variável local
      jsonRetorno := dmUsuario.usuarioLogin(email, senha);

      if jsonRetorno.Size = 0 then
      begin
        res.Status(401).Send('email ou senha inválido');
      end
      else
        // 3. Envia o JSON. O Horse assumirá o controle da liberação deste objeto
        res.Status(201).Send<TJSONObject>(jsonRetorno);

    except
      on E: Exception do
        res.Status(500).Send(E.Message);
    end;
  finally
    // 4. Libera o DataModule, mas o jsonRetorno vive até o res.Send terminar
    if Assigned(dmUsuario) then
      FreeAndNil(dmUsuario);
  end;
end;




end.
