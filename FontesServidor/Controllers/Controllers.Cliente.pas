unit Controllers.Cliente;

interface

uses System.SysUtils,
     dialogs,
     DataModule.Pessoa,
     Horse,
     Horse.Jhonson,
     System.JSON,
     Service.Pessoa;


procedure RegistrarRotas;
procedure Listar(req : THorseRequest; res : THorseResponse; Next : TProc);
procedure ListarId(req : THorseRequest; res : THorseResponse; Next : TProc);
procedure Inserir(req : THorseRequest; res : THorseResponse; Next : TProc);
procedure Editar(req : THorseRequest; res : THorseResponse; Next : TProc);
procedure Excluir(req : THorseRequest; res : THorseResponse; Next : TProc);

procedure OnLine(req: THorseRequest; res: THorseResponse; next: TProc);


implementation

procedure RegistrarRotas;
begin
   {para testar a rota, no RESTdebuger do delphi escolha o metodo(GET, POST, PUT, DELETE):
    digite a url http://localhost:3000 }

   {o que estou dizendo para o horse: quando chegar uma requisição /pessoa
   chame o metodo correspondente. ex. Listar para listar pessoas}
   THorse.Get('/pessoa', Listar);               // lista pessoa pelo nome
   THorse.Get('/pessoa/:pessoaId', ListarId);   // lista pessoa pelo id
   THorse.Post('/pessoa', Inserir);             // insere uma pessoa
   THorse.Put('/pessoa/:pessoaId', Editar);     // edita uma pessoa
   THorse.Delete('/pessoa/:pessoaId', Excluir); // excluir uma pessoa

   THorse.Get('/health', OnLine);               // lista pessoa pelo nome

end;

procedure OnLine(req: THorseRequest; res: THorseResponse; next: TProc);
begin
  res.Send('OK');
end;

procedure Listar(req: THorseRequest; res: THorseResponse; Next: TProc);
var
  dmPessoa: TDmPessoa;
  filtro: string;
begin
  filtro := Trim(req.Query['filtro']);

  dmPessoa := TDmPessoa.Create(nil);
  try
    try
      res.Status(200)
         .Send<TJSONArray>(dmPessoa.pessoaListar(filtro));
    except
      on E: Exception do
        res.Status(500).Send(E.Message);
    end;
  finally
    dmPessoa.Free;
  end;
end;


procedure ListarId (req : THorseRequest; res : THorseResponse; Next : TProc);
var
  dmPessoa : TDmPessoa;
  pessoaId: integer;
begin
  if not TryStrToInt(req.Params['pessoaId'], pessoaId) then
  begin
    res.Status(400).Send('ID inválido');
    Exit;
  end;

  dmPessoa := TDmPessoa.Create(nil);
  try
    try
      res.Send<TJSONObject>(dmPessoa.pessoaListarId(pessoaId));
    except
      on E: Exception do
        res.Status(500).Send(E.Message);
    end;
  finally
    dmPessoa.Free;
  end;
end;

procedure Inserir(req: THorseRequest; res: THorseResponse; Next: TProc);
var
  body: TJSONObject;
  nome, telefone, setor: string;
  jsonRetorno: TJSONObject;
  ServicePessoa : TServicePessoa;
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

  ServicePessoa := TServicePessoa.Create;
  try
    try
      jsonRetorno := ServicePessoa.InserirEditarPessoa( 0, Nome, Telefone, Setor );
      res.Status(201).Send<TJSONObject>(jsonRetorno);
    except
      on E: Exception do
        res.Status(400).Send(E.Message); // 400 para erros de validação
    end;
  finally
    ServicePessoa.Free;
  end;

end;

procedure Editar(req: THorseRequest; res: THorseResponse; Next: TProc);
var
  body: TJSONObject;
  pessoaId: Integer;
  nome, telefone, setor: string;

  jsonRetorno: TJSONObject;
  ServicePessoa : TServicePessoa;

begin

  if not TryStrToInt(req.Params['pessoaId'], pessoaId) then
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

  ServicePessoa := TServicePessoa.Create;// nesse momento instância o fdconnection
  try
    try
      jsonRetorno := ServicePessoa.InserirEditarPessoa(PessoaId, nome, telefone, setor);
      res.Status(200).Send<TJSONObject>(jsonRetorno);
    except
      on E: Exception do
        res.Status(500).Send(E.Message);
    end;
  finally
    ServicePessoa.Free;
  end;
end;


procedure Excluir(req: THorseRequest; res: THorseResponse; Next: TProc);
var
  dmPessoa: TDmPessoa;
  pessoaId: Integer;
begin
  if not TryStrToInt(req.Params['pessoaId'], pessoaId) then
  begin
    res.Status(400).Send('ID inválido');
    Exit;
  end;

  dmPessoa := TDmPessoa.Create(nil);
  try
    try
      res.Status(200)
         .Send<TJSONObject>(dmPessoa.pessoaExcluir(pessoaId));
    except
      on E: Exception do
        res.Status(500).Send(E.Message);
    end;
  finally
    dmPessoa.Free;
  end;
end;


end.
