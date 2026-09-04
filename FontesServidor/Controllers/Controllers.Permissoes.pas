// SERVICE MODELO
unit Controllers.Permissoes;

interface

uses Horse,
     System.SysUtils,
     System.JSON,
     Service.Permissoes,
     Controllers.JWT,
     Horse.JWT,
     dialogs;

procedure RegistrarRotas;
procedure ListarPermissoesId(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure InserirPermissoes(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure ListarPermissoesusuario(Req: THorseRequest; Res: THorseResponse; Next: TProc);

implementation


procedure RegistrarRotas;
begin

  THorse.AddCallback(HorseJWT( Controllers.JWT.SECRET,
                     THorseJWTConfig.New.SessionClass(TMyClaims)))
        .Get('/permissoes/:id', ListarPermissoesId); // passar o id do perfil

  THorse.AddCallback(HorseJWT( Controllers.JWT.SECRET,
                     THorseJWTConfig.New.SessionClass(TMyClaims)))
        .Post('/permissoes', InserirPermissoes);

  THorse.AddCallback(HorseJWT( Controllers.JWT.SECRET,
                     THorseJWTConfig.New.SessionClass(TMyClaims)))
        .Get('/permissoes/usuario', ListarPermissoesUsuario); // passar o id do usuario

end;

procedure ListarPermissoesId(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  id: integer;
  ServicePermissoes: TServicePermissoes;
  jsonRetorno: TJSONArray;
begin
  //pega o id do perfil que vem na url da requisição
  if not TryStrToInt(Req.Params['id'], id) then
  begin
    Res.Send('ID do perfil inválido').Status(400);
    Exit;
  end;

  try
    ServicePermissoes:= TServicePermissoes.Create;

    try
        jsonRetorno := ServicePermissoes.ListarPermissoesId( id );
        res.Send<TJSONArray>( jsonRetorno ).Status(200);
    finally
      ServicePermissoes.Free
    end;

  except
    on E: Exception do
      res.Send(E.Message).Status(500);
  end;

end;

procedure InserirPermissoes(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  body, jsonRetorno: TJSONObject;
  perfilId: integer;
  permissoes: TJSONArray; // lista de permissoes
  ServicePermissoes: TServicePermissoes;

begin


  body := req.Body<TJSONObject>;

  if not Assigned(body) then
  begin
    res.Send('JSON inválido ou vazio').Status(400);
    exit;
  end;

  perfilId := body.GetValue<integer>('perfil_id', 0);

  if PerfilId <= 0 then
  begin
    Res.Send('perfil_id inválido').Status(400);
    Exit;
  end;

  permissoes := body.GetValue<TJSONArray>('permissoes');

  if not Assigned(Permissoes) then
  begin
    Res.Send('Lista de permissões não informada').Status(400);
    Exit;
  end;


  try
      ServicePermissoes:= TServicePermissoes.Create;

      try
        jsonRetorno := ServicePermissoes.InserirPermissoes(perfilId, permissoes);
        res.Send<TJSONObject>( jsonRetorno ).Status(201);
      finally
        ServicePermissoes.Free
      end;

  Except
      on E: Exception do
        res.Send(E.Message).Status(500);
  end;
end;

procedure ListarPermissoesUsuario(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  id: integer;
  ServicePermissoes: TServicePermissoes;
  jsonRetorno: TJSONArray;
begin
  // pega o ID do usuário autenticado através do token
  id := Get_Usuario_Request(req);

  try
    ServicePermissoes:= TServicePermissoes.Create;

    try
        jsonRetorno := ServicePermissoes.ListarPermissoesUsuario( id );
        res.Send<TJSONArray>( jsonRetorno ).Status(200);
    finally
      ServicePermissoes.Free
    end;

  except
    on E: Exception do
      res.Send(E.Message).Status(500);
  end;

end;


end.
