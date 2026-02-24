unit Controllers.Cliente;

interface

uses Horse,
     DataModule.Global,
     System.SysUtils,
     System.JSON;

procedure RegistrarRotas;
procedure Listar(req : THorseRequest; res : THorseResponse; Next : TProc);
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
   THorse.Get('/pessoa', Listar);
   THorse.Post('/pessoa', Inserir);
   THorse.Put('/pessoa', Editar);
   THorse.Delete('/pessoa', Excluir);
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

procedure Inserir(req : THorseRequest; res : THorseResponse; Next : TProc);
begin
  res.Send('Aqui vou Inserir clientes').Status(201);
end;

procedure Editar(req : THorseRequest; res : THorseResponse; Next : TProc);
begin
  res.Send('Aqui vou Editar os clientes').Status(200);
end;

procedure Excluir(req : THorseRequest; res : THorseResponse; Next : TProc);
begin
  res.Send('Aqui vou Excluir os clientes').Status(200);
end;

end.
