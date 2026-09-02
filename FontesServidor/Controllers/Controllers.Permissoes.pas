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

implementation


procedure RegistrarRotas;
begin

  THorse.AddCallback(HorseJWT( Controllers.JWT.SECRET,
                     THorseJWTConfig.New.SessionClass(TMyClaims)))
        .Get('/permissoes/:id', ListarPermissoesId); // passar o id do perfil

end;

procedure ListarPermissoesId(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  id: integer;
  ServicePermissoes: TServicePermissoes;
  jsonRetorno: TJSONArray;
begin
  //pega o id do perfil que vem na url da requisição
  id := Req.Params['id'].ToInteger;

  try
    ServicePermissoes:= TServicePermissoes.Create;
    try
      jsonRetorno := ServicePermissoes.ListarPermissoesId( id );
      res.Send<TJSONArray>( jsonRetorno ).Status(200);
    except
      on E: Exception do
        res.Send(E.Message).Status(500);
    end;
  finally
    ServicePermissoes.Free
  end;
end;

end.
