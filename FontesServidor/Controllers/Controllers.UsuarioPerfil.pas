unit Controllers.UsuarioPerfil;


interface

uses Horse,
     System.SysUtils,
     System.JSON,
     Service.UsuarioPerfil,
     Controllers.JWT,
     Horse.JWT,
     dialogs;

procedure RegistrarRotas;
procedure Listar(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure ListarId(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Inserir(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Editar(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Excluir(Req: THorseRequest; Res: THorseResponse; Next: TProc);

implementation


procedure RegistrarRotas;
begin
  THorse.AddCallback(HorseJWT( Controllers.JWT.SECRET,
                     THorseJWTConfig.New.SessionClass(TMyClaims)))
        .Get('/usuario/perfil', Listar);

  THorse.AddCallback(HorseJWT( Controllers.JWT.SECRET,
                     THorseJWTConfig.New.SessionClass(TMyClaims)))
        .Get('/usuario/perfil/:id', ListarId);

  THorse.AddCallback(HorseJWT( Controllers.JWT.SECRET,
                     THorseJWTConfig.New.SessionClass(TMyClaims)))
        .Post('/usuario/perfil', Inserir);

  THorse.AddCallback(HorseJWT( Controllers.JWT.SECRET,
                     THorseJWTConfig.New.SessionClass(TMyClaims)))
        .Put('/usuario/perfil/:id', Editar);

  THorse.AddCallback(HorseJWT( Controllers.JWT.SECRET,
                     THorseJWTConfig.New.SessionClass(TMyClaims)))
        .Delete('/usuario/perfil/:id', Excluir);
end;


procedure Listar(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  filtro: string;
  ServiceUsuarioPerfil: TServiceUsuarioPerfil;
  jsonRetorno: TJSONarray;
begin

  filtro := Trim(req.Query['filtro']);

  try
    ServiceUsuarioPerfil:= TServiceUsuarioPerfil.Create;
    try
      jsonRetorno := ServiceUsuarioPerfil.Listar(filtro);
      res.Send<TJSONarray>( jsonRetorno ).Status(200);
    except
      on E: Exception do
        res.Send(E.Message).Status(500);
    end;
  finally
    ServiceUsuarioPerfil.Free
  end;
end;

procedure ListarId(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  id: integer;
  ServiceUsuarioPerfil: TServiceUsuarioPerfil;
  jsonRetorno: TJSONArray;
begin
  //pega o id que vem na url da requisição
  //id := Req.Params['id'].ToInteger;

  // vai pegar o usuario que esta no token(o que fez o login)
  id := Get_Usuario_Request(req);

  try
    ServiceUsuarioPerfil:= TServiceUsuarioPerfil.Create;
    try
      jsonRetorno := ServiceUsuarioPerfil.ListarId(id);
      res.Send<TJSONArray>( jsonRetorno ).Status(200);
    except
      on E: Exception do
        res.Send(E.Message).Status(500);
    end;
  finally
    ServiceUsuarioPerfil.Free
  end;
end;

procedure Inserir(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  body, jsonRetorno: TJSONObject;
  id_usuario: integer;
  perfis: TJSONArray; // lista de perfis

  ServiceUsuarioPerfil: TServiceUsuarioPerfil;
begin
  body := req.Body<TJSONObject>;
  if not Assigned(body) then
  begin
    res.Send('JSON inválido ou vazio').Status(400);
    exit;
  end;

  id_usuario := body.GetValue<integer>('id_usuario', 0);
  perfis := body.GetValue<TJSONArray>('perfis');

  try
    ServiceUsuarioPerfil:= TServiceUsuarioPerfil.Create;
    try
      jsonRetorno := ServiceUsuarioPerfil.InserirUsuarioPerfil(0, id_usuario, perfis);
      res.Send<TJSONObject>( jsonRetorno ).Status(201);
    except
      on E: Exception do
        res.Send(E.Message).Status(500);
    end;
  finally
    ServiceUsuarioPerfil.Free
  end;
end;

procedure Editar(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  body, jsonRetorno: TJSONObject;
  id, id_usuario: integer;
  perfis: TJSONArray; // lista de perfis
  ServiceUsuarioPerfil: TServiceUsuarioPerfil;
begin
  try
    ServiceUsuarioPerfil:= TServiceUsuarioPerfil.Create;
    try
      if not TryStrToInt(req.Params['id'], id) then
      begin
        res.Send('ID inválido').Status(400);
        Exit;
      end;

      body := req.Body<TJSONObject>;
      if not Assigned(body) then
      begin
        res.Send('JSON inválido ou vazio').Status(400);
        exit;
      end;

      id_usuario  := body.GetValue<integer>('id_usuario', 0);
      jsonRetorno := ServiceUsuarioPerfil.InserirUsuarioPerfil(id, id_usuario, perfis);
      res.Send<TJSONObject>( jsonRetorno ).Status(200);
    except
      on E: Exception do
        res.Send(E.Message).Status(500);
    end;
  finally
    FreeAndNil( ServiceUsuarioPerfil )
  end;
end;

procedure Excluir(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  id: integer;
  ServiceUsuarioPerfil: TServiceUsuarioPerfil;
  jsonRetorno : TJSONObject;
begin

  if not TryStrToInt(req.Params['id'], id) then
  begin
    res.Send('ID inválido').Status(400);
    Exit;
  end;

  try
    ServiceUsuarioPerfil := TServiceUsuarioPerfil.Create;
    try
      jsonRetorno := ServiceUsuarioPerfil.ExcluirUsuarioPerfil(id);
      res.Send<TJSONObject>(jsonRetorno).Status(200);
    except
      on E: Exception do
        res.Send(E.Message).Status(500);
    end;
  finally
    ServiceUsuarioPerfil.Free
  end;

end;


end.
