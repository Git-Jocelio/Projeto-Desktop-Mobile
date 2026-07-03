unit Controllers.Colaborador;

interface

uses System.SysUtils,
     dialogs,
     DataModule.Colaborador,
     Horse,
     Horse.Jhonson,
     System.JSON,
     Service.Colaborador;

procedure RegistrarRotas;
procedure Listar(req : THorseRequest; res : THorseResponse; Next : TProc);
procedure ListarId(req : THorseRequest; res : THorseResponse; Next : TProc);
procedure Inserir(req : THorseRequest; res : THorseResponse; Next : TProc);
procedure Editar(req : THorseRequest; res : THorseResponse; Next : TProc);
procedure Excluir(req : THorseRequest; res : THorseResponse; Next : TProc);

implementation

procedure RegistrarRotas;
begin
   THorse.Get('/colaborador', Listar);
   THorse.Get('/colaborador/:pessoaId', ListarId);
   THorse.Post('/colaborador', Inserir);
   THorse.Put('/colaborador/:pessoaId', Editar);
   THorse.Delete('/colaborador/:pessoaId', Excluir);
end;


procedure Listar(req: THorseRequest; res: THorseResponse; Next: TProc);
var
  dmColaborador: TDmColaborador;
  filtro: string;
begin
  filtro := Trim(req.Query['filtro']);

  dmColaborador := TDmColaborador.Create(nil);
  try
    try
      res.Send<TJSONArray>(dmColaborador.Listar(filtro)).Status(200);

    except
      on E: Exception do
        res.Send(E.Message).Status(500);
    end;
  finally
    freeandnil(dmColaborador);
  end;
end;


procedure ListarId (req : THorseRequest; res : THorseResponse; Next : TProc);
var
  dmColaborador: TDmColaborador;
  pessoaId: integer;
begin
  if not TryStrToInt(req.Params['pessoaId'], pessoaId) then
  begin
    res.Send('ID inválido').Status(400);
    Exit;
  end;

  dmColaborador := TDmColaborador.Create(nil);
  try
    try
      res.Send<TJSONObject>(dmColaborador.ListarId(pessoaId)).Status(200);
    except
      on E: Exception do
        res.Send(E.Message).Status(500);
    end;
  finally
    dmColaborador.Free;
  end;
end;

procedure Inserir(req: THorseRequest; res: THorseResponse; Next: TProc);
var
  body: TJSONObject;
  nome, email, telefone: string;
  setorID : integer;
  jsonRetorno: TJSONObject;
  ServiceColaborador : TServiceColaborador;
begin

  body := req.Body<TJSONObject>;

  if not Assigned(body) then
  begin
    res.Send('JSON inválido ou vazio').Status(400);
    Exit;
  end;

  nome     := body.GetValue<string>('nome', '');
  email    := body.GetValue<string>('email', '');
  telefone := body.GetValue<string>('telefone', '');
  setorID    := body.GetValue<integer>('setorID', 0);

  ServiceColaborador := TServiceColaborador.Create;
  try
    try
      jsonRetorno := ServiceColaborador.InserirEditar( 0, nome, email, telefone, setorID );
      res.Send<TJSONObject>(jsonRetorno).Status(201);
    except
      on E: Exception do
        res.Send(E.Message).Status(400); // 400 para erros de validação
    end;
  finally
    ServiceColaborador.Free;
  end;

end;

procedure Editar(req: THorseRequest; res: THorseResponse; Next: TProc);
var
  body: TJSONObject;
  pessoaID: Integer;
  nome, telefone, email: string;
  setorID: integer;
  jsonRetorno: TJSONObject;
  ServiceColaborador : TServiceColaborador;

begin

  if not TryStrToInt(req.Params['pessoaID'], pessoaID) then
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

  nome     := body.GetValue<string>('nome', '');
  telefone := body.GetValue<string>('telefone', '');
  email    := body.GetValue<string>('email', '');
  setorID    := body.GetValue<integer>('setorID', 0);

  ServiceColaborador := TServiceColaborador.Create;// nesse momento instância o fdconnection
  try
    try
      jsonRetorno := ServiceColaborador.InserirEditar(pessoaID, nome, email, telefone, setorID);
      res.Send<TJSONObject>(jsonRetorno).Status(200);
    except
      on E: Exception do
        res.Send(E.Message).Status(500);
    end;
  finally
    ServiceColaborador.Free;
  end;
end;


procedure Excluir(req: THorseRequest; res: THorseResponse; Next: TProc);
var
  dmColaborador: TDmColaborador;
  pessoaId: Integer;
begin
  if not TryStrToInt(req.Params['pessoaId'], pessoaId) then
  begin
    res.Send('ID inválido').Status(400);
    Exit;
  end;

  dmColaborador := TDmColaborador.Create(nil);
  try
    try
      res.Send<TJSONObject>(dmColaborador.Excluir(pessoaId)).Status(200);
    except
      on E: Exception do
        res.Send(E.Message).Status(500);
    end;
  finally
    dmColaborador.Free;
  end;
end;


end.
