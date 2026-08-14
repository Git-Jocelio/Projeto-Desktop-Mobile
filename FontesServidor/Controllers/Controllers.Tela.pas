unit Controllers.Tela;

interface

uses
   Horse,
   Horse.Jhonson,
   System.SysUtils,
   System.JSON,
   Service.Tela,
   DataModule.Tela;

procedure RegistrarRotas;
procedure Listar(req : THorseRequest; res : THorseResponse; Next : TProc);
procedure ListarId(req : THorseRequest; res : THorseResponse; Next : TProc);
procedure Inserir(req : THorseRequest; res : THorseResponse; Next : TProc);
procedure Editar(req : THorseRequest; res : THorseResponse; Next : TProc);
procedure Excluir(req : THorseRequest; res : THorseResponse; Next : TProc);

implementation

procedure RegistrarRotas;
begin
  THorse.Post('/tela',Inserir);
  THorse.Get('/tela',Listar);
  THorse.Get('/tela/:id_tela',ListarId);
  THorse.Put('/tela/:id_tela',Editar);
  THorse.Delete('/tela/:id_tela',Excluir);
end;

procedure Listar(req : THorseRequest; res : THorseResponse; Next : TProc);
var
  filtro: string;
  dmTela : TdmTela;
begin
  filtro := Trim(req.Query['filtro']);
  try
    dmTela := TdmTela.Create(nil);
    try
      res.Send<TJSONArray>(dmTela.Listar(filtro)).Status(200);
    except
      on E: Exception do
        res.Send(E.Message).Status(500);
    end;
  finally
    dmTela.Free
  end;
end;

procedure ListarId(req : THorseRequest; res : THorseResponse; Next : TProc);
var
  id_tela: integer;
begin
  if not TryStrToInt(req.Params['id_tela'], id_tela) then
  begin
    res.Send('ID inválido').Status(400);
    Exit;
  end;

  try
    dmTela := TdmTela.Create(nil);
    try
      res.Send<TJSONObject>(dmTela.ListarId(id_tela)).Status(200);
    except
      on E: Exception do
        res.Send(E.Message).Status(500);
    end;
  finally
    dmTela.Free
  end;
end;

procedure Inserir(req : THorseRequest; res : THorseResponse; Next : TProc);
var
  ordem: integer;
  nome_tela, modulo, ativo: string;
  body, jsonRetorno: TJSONObject;
  serviceTela : TServiceTela;
begin

  body := req.Body<TJSONObject>;

  if not Assigned(body) then
  begin
    res.Send('json vazio ou inválido');
    Exit;
  end;

  nome_tela := body.GetValue<string>('nome_tela', '');
  modulo := body.GetValue<string>('modulo', '');
  ordem := body.GetValue<integer>('ordem',0);
  ativo := body.GetValue<string>('ativo', 'N');

  serviceTela := TServiceTela.Create;
  try
    try
      jsonRetorno := serviceTela.InserirEditar(0, ordem, nome_tela, modulo, ativo);
      res.Send<TJSONObject>(jsonRetorno).Status(201);
    except
      on E: Exception do
        res.Send(E.Message).Status(500);
    end;
  finally
    serviceTela.Free
  end;
end;

procedure Editar(req : THorseRequest; res : THorseResponse; Next : TProc);
var
  id_tela, ordem: integer;
  nome_tela, modulo, ativo: string;
  body, jsonRetorno: TJSONObject;
  serviceTela : TServiceTela;
begin
  if not TryStrToInt(req.Params['id_tela'], id_tela) then
  begin
    res.Send('ID inválido').Status(400);
    Exit;
  end;

  body := req.Body<TJSONObject>;

  if not Assigned(body) then
  begin
    res.Send('json vazio ou inválido');
    Exit;
  end;

  nome_tela := body.GetValue<string>('nome_tela', '');
  modulo := body.GetValue<string>('modulo', '');
  ordem := body.GetValue<integer>('ordem',0);
  ativo := body.GetValue<string>('ativo', 'N');

  serviceTela := TServiceTela.Create;
  try
    try
      jsonRetorno := serviceTela.InserirEditar(id_tela, ordem, nome_tela, modulo, ativo);
      res.Send<TJSONObject>(jsonRetorno).Status(201);
    except
      on E: Exception do
        res.Send(E.Message).Status(500);
    end;
  finally
    serviceTela.Free
  end;
end;

procedure Excluir(req : THorseRequest; res : THorseResponse; Next : TProc);
var
  id_tela: integer;
  serviceTela : TServiceTela;
  jsonRetorno : TJSONObject;
begin
  if not TryStrToInt(req.Params['id_tela'], id_tela) then
  begin
    res.Send('ID inválido').Status(400);
    Exit;
  end;

  serviceTela := TServiceTela.Create;
  try
    try
      jsonRetorno := serviceTela.Excluir(id_tela);
      res.Send<TJSONObject>(jsonRetorno).Status(200);
    except
      on E: Exception do
        res.Send(E.Message).Status(500);
    end;
  finally
    serviceTela.Free
  end;
end;


end.
