unit Service.Perfil;

interface

uses System.SysUtils;

type
  TServicePerfil = class
  public
    class procedure InserirPerfil(descricao, observacao: string);
    class procedure AlterarPerfil(descricao, observacao: string; id_perfil: integer);
  end;

implementation

uses DataModule.Perfil;

class procedure TServicePerfil.InserirPerfil(descricao, observacao: string);
var
  dmPerfil : TDmPerfil;
begin
  dmPerfil := TDmPerfil.Create(nil);
  try
    dmPerfil.InserirPerfil(descricao, observacao)
  finally
    freeandnil(dmPerfil);
  end;
end;

class procedure TServicePerfil.AlterarPerfil(descricao, observacao: string; id_perfil: integer);
var
  dmPerfil : TDmPerfil;
begin
  dmPerfil := TDmPerfil.Create(nil);
  try
    dmPerfil.AlterarPerfil(descricao, observacao, id_perfil)
  finally
    freeandnil(dmPerfil);
  end;
end;



end.
