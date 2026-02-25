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
   THorse.Get('/pessoa/:id_pessoa', ListarId); // lista pessoa pelo id
   THorse.Post('/pessoa', Inserir);            // insere uma pessoa
   THorse.Put('/pessoa/:id_pessoa', Editar);   // edita uma pessoa
   THorse.Delete('/pessoa/:id_pessoa', Excluir); // excluir uma pessoa
end;

procedure Listar(req : THorseRequest; res : THorseResponse; Next : TProc);
var
  dm : TDM;
  filtro: string;
begin

  try

    try

      // cria o dm somente quando for usar(ativa o fdConnection)
      dm := TDM.Create(nil);

      // captura o filtro fornecido pelo usuário
      filtro := req.query['filtro']; // vem do corpo da requisição

      {o metodo pessoaListar é chamado dentro do dm,
      e devolve o resultado da qry em formato json,
      que é devolvido com resposta(res) para o servidor(horse) na unit principal}
      res.Send<TJSONArray>(dm.pessoaListar(filtro));

    except on ex: exception do
       res.send('Erro ao listar pessoas').status(500);
    end;

  finally
    // fecha e libera o fdconnection da memária
    freeandnil(dm);
  end;

end;

procedure ListarId (req : THorseRequest; res : THorseResponse; Next : TProc);
var
  dm : TDM;
  id_pessoa: integer;
begin
  // montar um endpoint
  try

    try

      // cria o dm somente quando for usar
      dm := TDM.Create(nil);
      try
        // o valor id_cliente do parametro passado na requisição
        id_pessoa := req.Params['id_pessoa'].ToInteger;
      except
        id_pessoa := 0;
      end;

      {converte o dataset recebido da funcao pessoaListar em um array e
      envia a quem solicitou}
      res.Send<TJSONObject>(dm.pessoaListarId(id_pessoa));

    except on ex: exception do
       res.send('Erro ao listar pessoas').status(500);
    end;

  finally
    freeandnil(dm);
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
        // É importante logar ou enviar a mensagem real (E.Message) para depurar
        res.Status(500).Send('Erro ao Inserir: ' + E.Message);
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
      pessoa_id := req.Params.Dictionary['pessoa_id'].ToInteger;
      if pessoa_id <= 0 then
      begin
        res.Status(400).Send('ID da pessoa inválido');
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
        // Retorna o erro real para facilitar o debug durante o desenvolvimento
        res.Status(500).Send('Erro ao Editar pessoa: ' + E.Message);
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
      try
        pessoa_id := req.Params['pessoa_id'].ToInteger;
      except
        pessoa_id := 0;
      end;

      {converte o dataset recebido da funcao pessoaListar em um array e
      envia a quem solicitou}
      res.Send<TJSONObject>(dm.pessoaExcluir(pessoa_id));

    except on ex: exception do
       res.send('Erro ao Inserir pessoas').status(500);
    end;

  finally
    freeandnil(dm);
  end;

end;

end.
