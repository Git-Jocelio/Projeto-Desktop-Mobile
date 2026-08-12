unit Controllers.Perfil;

interface

uses Horse,
     DataModule.Perfil,
     System.SysUtils,
     System.JSON,
     Service.Perfil,
     Controllers.JWT,
     Horse.JWT;

procedure RegistrarRotas;
procedure listarTodos(req: THorseRequest; res: THorseResponse; Next: TProc);
procedure InserirPerfil(req: THorseRequest; res: THorseResponse; Next: TProc);
procedure EditarPerfil(req: THorseRequest; res: THorseResponse; Next: TProc);
procedure listarPerfilId(req: THorseRequest; res: THorseResponse; Next: TProc);
procedure ExcluirPerfil(req: THorseRequest; res: THorseResponse; Next: TProc);

implementation

procedure RegistrarRotas;
begin
  // rotas protejidas
  THorse.AddCallback(HorseJWT( Controllers.JWT.SECRET,
                     THorseJWTConfig.New.SessionClass(TMyClaims)))
        .Post('/perfil', InserirPerfil);


  THorse.AddCallback(HorseJWT( Controllers.JWT.SECRET,
                     THorseJWTConfig.New.SessionClass(TMyClaims)))
        .Get('/perfil/:id', listarPerfilId);

  THorse.AddCallback(HorseJWT( Controllers.JWT.SECRET,
                     THorseJWTConfig.New.SessionClass(TMyClaims)))
        .Get('/perfil', listarTodos);


  THorse.AddCallback(HorseJWT( Controllers.JWT.SECRET,
                     THorseJWTConfig.New.SessionClass(TMyClaims)))
        .Put('/perfil/:id_perfil', EditarPerfil);

  THorse.AddCallback(HorseJWT( Controllers.JWT.SECRET,
                     THorseJWTConfig.New.SessionClass(TMyClaims)))
        .Delete('/perfil/:id', ExcluirPerfil);
end;

procedure listarTodos(req: THorseRequest; res: THorseResponse; Next: TProc);
begin
  try
    res.Send<TJSONArray>( Service.Perfil.listarTodos );
  except
    on E: Exception do
      res.Send(E.Message).Status(500);
  end;
end;

procedure InserirPerfil(req: THorseRequest; res: THorseResponse; Next: TProc);
var
  body : TJSONObject;
  descricao, obs: string;
begin
  try
    body := req.Body<TJSONObject>;
    if not Assigned(body) then
    begin
      res.Send('JSON inválido ou vazio').Status(400);
      exit;
    end;

    descricao := body.GetValue<string>('descricao','');
    obs := body.GetValue<string>('obs','');

    res.Send<TJSONObject>( Service.Perfil.InserirPerfil(descricao, obs) ).Status(201);
  except
    on E: Exception do
      res.Send(E.Message).Status(500);
  end;
end;

procedure EditarPerfil(req: THorseRequest; res: THorseResponse; Next: TProc);
var
  body : TJSONObject;
  id_perfil: integer;
  descricao, obs : string;
begin
  try

    if not TryStrToInt(req.Params['id_perfil'], id_perfil) then
    begin
      res.Send('ID inválido').Status(400);
      Exit;
    end;

    body := req.Body<TJSONObject>;
    if not Assigned(body) then
    begin
      res.Send('Corpo da requisição vazio ou inválido').Status(400);
      Exit;
    end;

    descricao := body.GetValue<string>('descricao', '');
    obs := body.GetValue<string>('obs', '');
    service.Perfil.alterar(descricao, obs, id_perfil);
    res.send('OK').Status(200);
  except
     on e : Exception do
       raise Exception.Create('Erro ao alterar o Perfil');
  end;
end;

procedure listarPerfilId(req: THorseRequest; res: THorseResponse; Next: TProc);
begin
//
end;

procedure ExcluirPerfil(req: THorseRequest; res: THorseResponse; Next: TProc);
var
  id_perfil: integer;
begin
  try
    id_perfil := StrToIntDef(req.Params['id'], 0);
    Service.Perfil.excluir(id_perfil);
    res.Send('OK').Status(204);
  except
     on e : Exception do
       raise Exception.Create('Erro ao excluir o Perfil');
  end;
end;

end.
