unit Service.Perfil;

interface

uses
  System.JSON,
  DataModule.Perfil,
  System.SysUtils;

function listarTodos: TJSONArray;
function InserirPerfil(descricao, obs: string): TJSONObject;
procedure excluir(id_perfil: integer);
procedure alterar(descricao, obs: string; id_perfil: integer);


implementation

function listarTodos: TJSONArray;
var
  dm : TDmPerfil;
begin
  try
    dm := TDmPerfil.Create(nil);
    result := dm.listarTodos;
  finally
    FreeAndNil(dm);
  end;
end;

function InserirPerfil(descricao, obs: string): TJSONObject;
var
  dm : TDmPerfil;
begin
  if (descricao = '') or (obs = '') then
    raise Exception.Create('Informe todos os campos: descrição e observação ');
  try
    dm := TDmPerfil.Create(nil);
    result := dm.InserirPerfil(descricao, obs);
  finally
    FreeAndNil(dm);
  end;
end;

procedure excluir(id_perfil: integer);
var
  dm : TDmPerfil;
begin
  if id_perfil <=0 then
    raise exception.Create('Código do perfil inválido');
  try
    dm := TDmPerfil.Create(nil);
    dm.excluir(id_perfil);
  finally
    FreeAndNil(dm)
  end;
end;

procedure alterar(descricao, obs: string; id_perfil: integer);
var
  dm : TDmPerfil;
begin
  if id_perfil <=0 then
    raise exception.Create('Código do perfil inválido');
  if (descricao = '') or (obs = '') then
    raise Exception.Create('Informe todos os campos: descrição e observação ');
  try
    dm := TDmPerfil.Create(nil);
    dm.alterar(descricao, obs, id_Perfil);
  finally
    FreeAndNil(dm)
  end;
end;


end.
