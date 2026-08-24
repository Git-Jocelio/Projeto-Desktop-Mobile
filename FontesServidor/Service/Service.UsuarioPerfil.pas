unit Service.UsuarioPerfil;

interface

uses
 DataModule.UsuarioPerfil,
 System.JSON,
 System.SysUtils,
 dialogs;

type
   //Classe responsável por:
   // -instanciar e destruir o datamodule
   // -inserir/alterar na tabela "UsuarioPerfil"
   TServiceUsuarioPerfil = class
   private
     FDmUsuarioPerfil : TDmUsuarioPerfil;
   public
     constructor Create;
     destructor Destroy; override;
     //function InserirUsuarioPerfil(id, id_usuario, id_perfil: integer; perfis: TJSONArray):TJSONObject;
     function InserirUsuarioPerfil(id, id_usuario: integer; perfis: TJSONArray):TJSONObject;
     function ExcluirUsuarioPerfil(id: integer):TJSONObject;
     function Listar(filtro:string):TJSONArray;
    function ListarId(usuarioid: integer): TJSONArray;
   end;

implementation

{ TServiceUsuarioPerfil }

constructor TServiceUsuarioPerfil.Create;
begin
  FDmUsuarioPerfil := TDmUsuarioPerfil.Create(nil)
end;

destructor TServiceUsuarioPerfil.Destroy;
begin
  FDmUsuarioPerfil.Free;
  inherited;
end;

//function TServiceUsuarioPerfil.InserirUsuarioPerfil(id, id_usuario, id_perfil: integer; perfis: TJSONArray): TJSONObject;
function TServiceUsuarioPerfil.InserirUsuarioPerfil(id, id_usuario: integer; perfis: TJSONArray): TJSONObject;
begin

   if (id_usuario < 0) then
     raise Exception.Create('Id do usuário e/ou Id Perfil inválido.');

   if id > 0 then
     // Result := FDmUsuarioPerfil.Editar(id, id_usuario, perfis)
   else
      Result := FDmUsuarioPerfil.Inserir(id_usuario, perfis)

end;

function TServiceUsuarioPerfil.Listar(filtro: string): TJSONArray;
begin
  result := FDmUsuarioPerfil.Listar(filtro);
end;

function TServiceUsuarioPerfil.ListarId(usuarioid: integer): TJSONArray;
begin
  result := FDmUsuarioPerfil.ListarId(usuarioid);
end;


function TServiceUsuarioPerfil.ExcluirUsuarioPerfil(id: integer):TJSONObject;
begin
  result := FDmUsuarioPerfil.Excluir(id)
end;

end.
