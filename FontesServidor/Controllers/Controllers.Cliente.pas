unit Controllers.Cliente;

interface

uses Horse,
     DataModule.Global,  dialogs,
     System.SysUtils,
     System.JSON;

procedure RegistrarRotas;
procedure Listar(req : THorseRequest; res : THorseResponse; Next : TProc);
procedure ListarId(req : THorseRequest; res : THorseResponse; Next : TProc);
procedure Inserir(req : THorseRequest; res : THorseResponse; Next : TProc);
procedure Editar(req : THorseRequest; res : THorseResponse; Next : TProc);
procedure Excluir(req : THorseRequest; res : THorseResponse; Next : TProc);


implementation

procedure RegistrarRotas;
begin
   {para testar a rota, no RESTdebuger do delphi escolha o metodo(GET, POST, PUT, DELETE):
    digite a url http://localhost:3000 }

   {o que estou dizendo para o horse: quando chegar uma requisição /pessoa
   chame o metodo correspondente. ex. Listar para listar pessoas}
   THorse.Get('/pessoa', Listar);              // lista pessoa pelo nome
   THorse.Get('/pessoa/:pessoa_id', ListarId); // lista pessoa pelo id
   THorse.Post('/pessoa', Inserir);            // insere uma pessoa
   THorse.Put('/pessoa/:pessoa_id', Editar);   // edita uma pessoa
   THorse.Delete('/pessoa/:pessoa_id', Excluir); // excluir uma pessoa
end;

procedure Listar(req: THorseRequest; res: THorseResponse; Next: TProc);
var
  dm: TDM;
  filtro: string;
begin
  filtro := Trim(req.Query['filtro']);

  dm := TDM.Create(nil);
  try
    try
      res.Status(200)
         .Send<TJSONArray>(dm.pessoaListar(filtro));
    except
      on E: Exception do
        res.Status(500).Send(E.Message);
    end;
  finally
    dm.Free;
  end;
end;


procedure ListarId (req : THorseRequest; res : THorseResponse; Next : TProc);
var
  dm : TDM;
  pessoa_id: integer;
begin
  if not TryStrToInt(req.Params['pessoa_id'], pessoa_id) then
  begin
    res.Status(400).Send('ID inválido');
    Exit;
  end;

  dm := TDM.Create(nil);
  try
    try
      res.Send<TJSONObject>(dm.pessoaListarId(pessoa_id));
    except
      on E: Exception do
        res.Status(500).Send(E.Message);
    end;
  finally
    dm.Free;
  end;
end;

procedure Inserir(req: THorseRequest; res: THorseResponse; Next: TProc);
var
  dm: TDM;
  body: TJSONObject;
  nome, telefone, setor: string;
  jsonRetorno: TJSONObject;
begin
  body := req.Body<TJSONObject>;
  if not Assigned(body) then
  begin
    res.Status(400).Send('JSON inválido ou vazio');
    Exit;
  end;

  nome     := body.GetValue<string>('nome', '');
  telefone := body.GetValue<string>('telefone', '');
  setor    := body.GetValue<string>('setor', '');

  dm := TDM.Create(nil);
  try
    try
      jsonRetorno := dm.pessoaInserir(nome, telefone, setor);
      res.Status(201).Send<TJSONObject>(jsonRetorno);
    except
      on E: Exception do
        res.Status(500).Send(E.Message);
    end;
  finally
    dm.Free;
  end;
end;

procedure Editar(req: THorseRequest; res: THorseResponse; Next: TProc);
var
  dm: TDM;
  body: TJSONObject;
  pessoa_id: Integer;
  nome, telefone, setor: string;
begin
  if not TryStrToInt(req.Params['pessoa_id'], pessoa_id) then
  begin
    res.Status(400).Send('ID inválido');
    Exit;
  end;

  body := req.Body<TJSONObject>;
  if not Assigned(body) then
  begin
    res.Status(400).Send('Corpo da requisição vazio ou inválido');
    Exit;
  end;

  nome     := body.GetValue<string>('nome', '');
  telefone := body.GetValue<string>('telefone', '');
  setor    := body.GetValue<string>('setor', '');

  dm := TDM.Create(nil);
  try
    try
      res.Status(200)
         .Send<TJSONObject>(dm.pessoaEditar(pessoa_id, nome, telefone, setor));
    except
      on E: Exception do
        res.Status(500).Send(E.Message);
    end;
  finally
    dm.Free;
  end;
end;


procedure Excluir(req: THorseRequest; res: THorseResponse; Next: TProc);
var
  dm: TDM;
  pessoa_id: Integer;
begin
  if not TryStrToInt(req.Params['pessoa_id'], pessoa_id) then
  begin
    res.Status(400).Send('ID inválido');
    Exit;
  end;

  dm := TDM.Create(nil);
  try
    try
      res.Status(200)
         .Send<TJSONObject>(dm.pessoaExcluir(pessoa_id));
    except
      on E: Exception do
        res.Status(500).Send(E.Message);
    end;
  finally
    dm.Free;
  end;
end;


end.
