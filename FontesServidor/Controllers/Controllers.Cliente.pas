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

   {o que estou dizendo para o horse: quando chegar uma requisição /cliente chame
   o metodo Listar para listar os clientes}
   THorse.Get('/pessoa', Listar); // lista pessoa pelo nome
   THorse.Get('/pessoa/:id_pessoa', ListarId); // lista pessoa pelo id
   THorse.Post('/pessoa', Inserir);
   THorse.Put('/pessoa/:id_pessoa', Editar);
   THorse.Delete('/pessoa/:id_pessoa', Excluir);
end;

procedure Listar(req : THorseRequest; res : THorseResponse; Next : TProc);
var
  dm : TDM;
  filtro: string;
begin

  try

    try

      // cria o dm somente quando for usar
      dm := TDM.Create(nil);

      // captura o filtro fornecido pelo usuário
      filtro := req.query['filtro'];

      {converte o dataset recebido da funcao pessoaListar em um array e
      envia a quem solicitou}
      res.Send<TJSONArray>(dm.pessoaListar(filtro));

    except on ex: exception do
       res.send('Erro ao listar pessoas').status(500);
    end;

  finally
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


procedure Inserir(req : THorseRequest; res : THorseResponse; Next : TProc);
var
  dm : TDM;
  body : TJSONObject;
  nome, telefone, setor: string;
begin
  // montar um endpoint
  try

    try

      // cria o dm somente quando for usar
      dm := TDM.Create(nil);

      //re.body tem um json no formato string, então  <TJSONObject> transforma num json
      body := req.Body<TJSONObject>;

      nome := body.GetValue<string>('nome','');
      telefone := body.GetValue<string>('telefone','');
      setor := body.GetValue<string>('setor','');

      {converte o dataset recebido da funcao pessoaListar em um array e
      envia a quem solicitou}
      res.Send<TJSONObject>(dm.pessoaInserir(nome, telefone, setor)).Status(201);

    except on ex: exception do
       res.send('Erro ao Inserir pessoas').status(500);
    end;

  finally
    freeandnil(dm);
  end;

end;

procedure Editar(req : THorseRequest; res : THorseResponse; Next : TProc);
var
  dm : TDM;
  body : TJSONObject;
  pessoa_id: integer;
  nome, telefone, setor: string;
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

      //re.body tem um json no formato string, então  <TJSONObject> transforma num json
      body := req.Body<TJSONObject>;

      nome := body.GetValue<string>('nome','');
      telefone := body.GetValue<string>('telefone','');
      setor := body.GetValue<string>('setor','');

      {converte o dataset recebido da funcao pessoaListar em um array e
      envia a quem solicitou}
      res.Send<TJSONObject>(dm.pessoaEditar(pessoa_id, nome, telefone, setor));

    except on ex: exception do
       res.send('Erro ao Inserir pessoas').status(500);
    end;

  finally
    freeandnil(dm);
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
