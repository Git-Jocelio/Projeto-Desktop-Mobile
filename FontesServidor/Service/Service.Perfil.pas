unit Service.Perfil;

interface

uses
  System.JSON,
  DataModule.Perfil,
  System.SysUtils;

function listarTodos: TJSONArray;


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


end.
