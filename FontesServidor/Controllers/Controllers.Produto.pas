unit Controllers.Produto;

interface

uses System.SysUtils,
     dialogs,
     DataModule.Produto,
     Horse,
     Horse.Jhonson,
     System.JSON,
     Service.Produto;


procedure RegistrarRotas;
procedure Listar(req: THorseRequest; res: THorseResponse; Next: TProc);
procedure ListarId (req : THorseRequest; res : THorseResponse; Next : TProc);
procedure Inserir(req: THorseRequest; res: THorseResponse; Next: TProc);
procedure Editar(req: THorseRequest; res: THorseResponse; Next: TProc);
procedure Excluir(req: THorseRequest; res: THorseResponse; Next: TProc);

implementation



procedure RegistrarRotas;
begin
   {http://localhost:3000 }

   THorse.Get('/produto', Listar);
   THorse.Get('/produto/:produtoId', ListarId);
   THorse.Post('/produto', Inserir);
   THorse.Put('/produto/:produtoId', Editar);
   THorse.Delete('/produto/:produtoId', Excluir);

end;


procedure Listar(req: THorseRequest; res: THorseResponse; Next: TProc);
var
  dmProduto: TdmProduto;
  filtro: string;
begin
  filtro := Trim(req.Query['filtro']);

  dmProduto := TdmProduto.Create(nil);
  try
    try
      res.Status(200)
         .Send<TJSONArray>(dmProduto.produtoListar(filtro));
    except
      on E: Exception do
        res.Status(500).Send(E.Message);
    end;
  finally
    dmProduto.Free;
  end;
end;


procedure ListarId (req : THorseRequest; res : THorseResponse; Next : TProc);
var
  dmProduto : TDmProduto;
  produtoId: integer;
begin
  if not TryStrToInt(req.Params['produtoId'], produtoId) then
  begin
    res.Status(400).Send('ID inválido');
    Exit;
  end;

  dmProduto := TdmProduto.Create(nil);
  try
    try
      res.Send<TJSONObject>(dmProduto.produtoListarId(produtoId));
    except
      on E: Exception do
        res.Status(500).Send(E.Message);
    end;
  finally
    dmProduto.Free;
  end;
end;


procedure Inserir(req: THorseRequest; res: THorseResponse; Next: TProc);
var
  body: TJSONObject;
  descricao, unidade: string;
  estoque: integer;
  jsonRetorno: TJSONObject;
  ServiceProduto : TServiceProduto;
begin

  body := req.Body<TJSONObject>;

  if not Assigned(body) then
  begin
    res.Status(400).Send('JSON inválido ou vazio');
    Exit;
  end;

  descricao:= body.GetValue<string>('descricao', '');
  unidade  := body.GetValue<string>('unidade', '');
  estoque  := body.GetValue<integer>('estoque', 0);

  ServiceProduto := TServiceProduto.Create;
  try
    try
      jsonRetorno := ServiceProduto.InserirEditarProduto( 0, descricao, unidade, estoque );
      res.Status(201).Send<TJSONObject>(jsonRetorno);
    except
      on E: Exception do
        res.Status(400).Send(E.Message); // 400 para erros de validação
    end;
  finally
    ServiceProduto.Free;
  end;

end;


procedure Editar(req: THorseRequest; res: THorseResponse; Next: TProc);
var
  body: TJSONObject;
  produtoId: Integer;
  descricao, unidade: string;
  estoque: integer;

  jsonRetorno: TJSONObject;
  ServiceProduto : TServiceProduto;

begin

  if not TryStrToInt(req.Params['produtoId'], produtoId) then
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

  descricao := body.GetValue<string>('descricao', '');
  unidade := body.GetValue<string>('unidade', '');
  estoque := body.GetValue<integer>('estoque', 0);

  ServiceProduto := TServiceProduto.Create;// nesse momento instância o fdconnection
  try
    try
      jsonRetorno := ServiceProduto.InserirEditarProduto(produtoId, descricao, unidade, estoque);
      res.Status(200).Send<TJSONObject>(jsonRetorno);
    except
      on E: Exception do
        res.Status(500).Send(E.Message);
    end;
  finally
    ServiceProduto.Free;
  end;
end;


procedure Excluir(req: THorseRequest; res: THorseResponse; Next: TProc);
var
  dmProduto: TdmProduto;
  produtoId: Integer;
begin
  if not TryStrToInt(req.Params['produtoId'], produtoId) then
  begin
    res.Status(400).Send('ID inválido');
    Exit;
  end;

  dmProduto := TdmProduto.Create(nil);
  try
    try
      res.Status(200)
         .Send<TJSONObject>(dmProduto.produtoExcluir(produtoId));
    except
      on E: Exception do
        res.Status(500).Send(E.Message);
    end;
  finally
    dmProduto.Free;
  end;
end;



end.
