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
        .Put('/perfil', EditarPerfil);
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
begin

end;

procedure listarPerfilId(req: THorseRequest; res: THorseResponse; Next: TProc);
begin

end;

end.
