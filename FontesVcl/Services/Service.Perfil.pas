unit Service.Perfil;

interface

uses System.SysUtils, Dialogs;

type
  TServicePerfil = class
  public
    class procedure InserirPerfil(descricao, obs: string);
    class procedure AlterarPerfil(descricao, obs: string; id_perfil: integer);
  end;

implementation

uses DataModule.Perfil;

class procedure TServicePerfil.InserirPerfil(descricao, obs: string);
var
  dmPerfil : TDmPerfil;
begin
  if (descricao = '') or (obs = '') then
  begin
    ShowMessage('Informe todos os campos. Descrição e observação.');
    exit;
  end;

  dmPerfil := TDmPerfil.Create(nil);
  try
    dmPerfil.InserirPerfil(descricao, obs)
  finally
    freeandnil(dmPerfil);
  end;
end;

class procedure TServicePerfil.AlterarPerfil(descricao, obs: string; id_perfil: integer);
var
  dmPerfil : TDmPerfil;
begin
  dmPerfil := TDmPerfil.Create(nil);
  try
    dmPerfil.AlterarPerfil(descricao, obs, id_perfil)
  finally
    freeandnil(dmPerfil);
  end;
end;

end.
