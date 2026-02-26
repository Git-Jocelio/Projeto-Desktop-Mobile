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

procedure Listar(req : THorseRequest; res : THorseResponse; Next : TProc);
var
  dm : TDM;
  filtro: string;
begin

  try

    dm := nil;
    filtro := Trim(req.Query['filtro']);

    try
      dm := TDM.Create(nil);
      res.Send<TJSONArray>(dm.pessoaListar(filtro));
    except
      on E: Exception do
        res.Status(500).Send(E.Message);
    end;

  finally
    if Assigned(dm) then
      FreeAndNil(dm);
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

  dm := nil;
  try
    try
      dm := TDM.Create(nil);
      res.Send<TJSONObject>(dm.pessoaListarId(pessoa_id));
    except
      on E: Exception do
        res.Status(500).Send(E.Message);
    end;
  finally
    if Assigned(dm) then
      FreeAndNil(dm);
  end;
end;

procedure Inserir(req: THorseRequest; res: THorseResponse; Next: TProc);
var
  dm: TDM;
  body: TJSONObject;
  nome, telefone, setor: string;
  jsonRetorno: TJSONObject;
begin
  dm := nil;
  try
    try
      dm := TDM.Create(nil);

      // 1. Tenta pegar o body e valida se não está vazio
      body := req.Body<TJSONObject>;
      if not Assigned(body) then
      begin
        res.Send('JSON inválido ou vazio').Status(400);
        Exit;
      end;

      nome     := body.GetValue<string>('nome', '');
      telefone := body.GetValue<string>('telefone', '');
      setor    := body.GetValue<string>('setor', '');

      // 2. Chama a função e armazena o resultado em uma variável local
      jsonRetorno := dm.pessoaInserir(nome, telefone, setor);

      // 3. Envia o JSON. O Horse assumirá o controle da liberação deste objeto
      res.Status(201).Send<TJSONObject>(jsonRetorno);

    except
      on E: Exception do
        res.Status(500).Send(E.Message);
    end;
  finally
    // 4. Libera o DataModule, mas o jsonRetorno vive até o res.Send terminar
    if Assigned(dm) then
      FreeAndNil(dm);
  end;
end;

procedure Editar(req : THorseRequest; res : THorseResponse; Next : TProc);
var
  dm : TDM;
  body : TJSONObject;
  pessoa_id: integer;
  nome, telefone, setor: string;
begin
  dm := nil;
  try
    try
      // 1. Validar o ID antes de qualquer coisa
      if not TryStrToInt(req.Params['pessoa_id'], pessoa_id) then
      begin
        res.Status(400).Send('ID inválido');
        Exit;
      end;

      // 2. Validar o Body
      body := req.Body<TJSONObject>;
      if not Assigned(body) then
      begin
        res.Status(400).Send('Corpo da requisição vazio ou inválido');
        Exit;
      end;

      dm := TDM.Create(nil);

      nome     := body.GetValue<string>('nome', '');
      telefone := body.GetValue<string>('telefone', '');
      setor    := body.GetValue<string>('setor', '');

      // 3. Executar e retornar (O Horse gerencia a memória do JSON retornado)
      res.Status(200).Send<TJSONObject>(dm.pessoaEditar(pessoa_id, nome, telefone, setor));

    except
      on E: Exception do
        res.Status(500).Send(E.Message);
    end;
  finally
    if Assigned(dm) then
      FreeAndNil(dm);
  end;
end;

procedure Excluir(req : THorseRequest; res : THorseResponse; Next : TProc);
var
  dm : TDM;
  pessoa_id: integer;
begin
  // montar um endpoint
  try

    try

      // cria o dm somente quando for usar
      dm := TDM.Create(nil);
      // extrair o pessoa_id passado por parametro
      if not TryStrToInt(req.Params['pessoa_id'], pessoa_id) then
      begin
        res.Status(400).Send('ID inválido');
        Exit;
      end;
      {converte o dataset recebido da funcao pessoaListar em um array e
      envia a quem solicitou}
      res.Send<TJSONObject>(dm.pessoaExcluir(pessoa_id));

    except on e: exception do
       res.Status(500).Send(E.Message);
    end;

  finally
    freeandnil(dm);
  end;

end;

end.
