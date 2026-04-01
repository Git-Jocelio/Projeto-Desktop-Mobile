{função do controller, é ver a rota que esta chegado e encaminhar para a
função correspondente}
unit Controllers.Fornecedor;

interface

uses System.SysUtils,
     dialogs,
     Horse,
     Horse.Jhonson,
     System.JSON,
     DataModule.Fornecedor,
     Service.Fornecedor;

procedure RegistrarRotas;
procedure Listar(req: THorseRequest; res: THorseResponse; Next: TProc);
procedure ListarId(req: THorseRequest; res: THorseResponse; Next: TProc);
procedure Inserir(req: THorseRequest; res: THorseResponse; Next: TProc);
procedure Editar(req: THorseRequest; res: THorseResponse; Next: TProc);
procedure Excluir(req: THorseRequest; res: THorseResponse; Next: TProc);

implementation

{definição de rotas e suas responsabilidades}
procedure RegistrarRotas;
begin
   {para testar a rota, no RESTdebuger do delphi escolha o metodo(GET, POST, PUT, DELETE):
    digite a url http://localhost:3000 }

   THorse.Get('/fornecedor', Listar);
   THorse.Get('/fornecedor/:fornecedorId', ListarId);
   THorse.Post('/fornecedor', Inserir);
   //THorse.Put('/fornecedor/:fornecedorId', Editar);
   //THorse.Delete('/fornecedor/:fornecedorId', Excluir);
end;

procedure Listar(req: THorseRequest; res: THorseResponse; Next: TProc);
var
  dmFornecedor : TDmFornecedor;
  filtro : string;
begin
  // meu listar está nesse dm
  dmFornecedor := TDmFornecedor.Create(nil);

  filtro := Trim(req.Query['filtro']);// <--- filtro vem da definição lá no frontend
  try
    try
      res.Status(200).Send<TJSONArray>( DmFornecedor.fornecedorListar(filtro) );
    except
     on e : Exception do
      res.Status(500).Send(E.Message);
    end;
  finally
    freeandnil(dmFornecedor);
  end;

end;

procedure ListarId(req: THorseRequest; res: THorseResponse; Next: TProc);
var
  dmFornecedor : TDmFornecedor;
  pessoaId : integer;
begin

  if not TryStrToInt(req.Params['pessoaId'], pessoaId) then
  begin
    res.Status(400).Send('ID inválido');
    Exit;
  end;

  dmFornecedor := TDmFornecedor.Create(nil);
  try
    try
      res.Status(200).Send<TJSONObject>( DmFornecedor.fornecedorListarId(pessoaId) );
    except
     on e : Exception do
      res.Status(500).Send(E.Message);
    end;
  finally
    freeandnil(dmFornecedor);
  end;

end;

procedure Inserir(req: THorseRequest; res: THorseResponse; Next: TProc);
var
  body : TJSONObject;

  nome, email, telefone,
  contato, telefone_contato: string;

  jsonRetorno: TJSONObject;
  ServiceFornecedor : TServiceFornecedor;
begin
  body := req.Body<TJSONObject>;

  if not Assigned(body) then
  begin
    res.Status(400).Send('JSON inválido ou vazio');
    Exit;
  end;

  nome := body.GetValue<string>('nome','');
  email := body.GetValue<string>('email','');
  telefone := body.GetValue<string>('telefone');
  contato := body.GetValue<string>('contato');
  telefone_contato:= body.GetValue<string>('telefone_contato');
  try
    ServiceFornecedor := TServiceFornecedor.Create;
    try
      jsonRetorno:= ServiceFornecedor.InserirEditarFornecedor(0, nome, telefone, email,contato, telefone_contato );
      res.status(201).Send<TJSONObject>(jsonRetorno);
    except
     on e : Exception do
      res.Status(500).Send(E.Message);
    end;
  finally
     FreeAndNil(ServiceFornecedor);
  end;
end;


procedure Editar(req: THorseRequest; res: THorseResponse; Next: TProc);
var
  body : TJSONObject;

  pessoaId: integer;
  nome, email, telefone,
  contato, telefone_contato: string;

  jsonRetorno: TJSONObject;
  ServiceFornecedor : TServiceFornecedor;
begin
  // valida o id
  if not TryStrToInt(req.Params['pessoaId'], pessoaId) then
  begin
    res.Status(400).Send('ID inválido');
    Exit;
  end;

  body := req.Body<TJSONObject>;
  // valida o body
  if not Assigned(body) then
  begin
    res.Status(400).Send('JSON inválido ou vazio');
    Exit;
  end;

  nome := body.GetValue<string>('nome','');
  email := body.GetValue<string>('email','');
  telefone := body.GetValue<string>('telefone');
  contato := body.GetValue<string>('contato');
  telefone_contato:= body.GetValue<string>('telefone_contato');
  try
    ServiceFornecedor := TServiceFornecedor.Create;
    try
      jsonRetorno:= ServiceFornecedor.InserirEditarFornecedor(pessoaId, nome, telefone, email,contato, telefone_contato );
      res.status(200).Send<TJSONObject>(jsonRetorno);
    except
     on e : Exception do
      res.Status(500).Send(E.Message);
    end;
  finally
     FreeAndNil(ServiceFornecedor);
  end;
end;

procedure Excluir(req: THorseRequest; res: THorseResponse; Next: TProc);
var
  dmFornecedor : TDmFornecedor;
  pessoaId : integer;
begin

  if not TryStrToInt(req.Params['pessoaId'], pessoaId) then
  begin
    res.Status(400).Send('ID inválido');
    Exit;
  end;

  dmFornecedor := TDmFornecedor.Create(nil);
  try
    try
      res.Status(200).Send<TJSONObject>( DmFornecedor.fornecedorExcluir( pessoaId ));
    except
     on e : Exception do
      res.Status(500).Send(E.Message);
    end;
  finally
    freeandnil(dmFornecedor);
  end;

end;

end.
