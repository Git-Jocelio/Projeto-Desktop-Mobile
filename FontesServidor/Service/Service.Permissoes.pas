unit Service.Permissoes;

interface

uses
  DataModule.Permissoes,
  System.JSON,
  System.SysUtils,
  dialogs;

type
   //Classe responsável por:
   // -instanciar e destruir o datamodule
   // -inserir/alterar, excluir, listar todos e listar por id na tabela "Permissoes"
   TServicePermissoes = class
   private
     FDmPermissoes : TDmPermissoes;
   public
     constructor Create;
     destructor Destroy; override;

     function InserirPermissoes(perfilID: integer; permissoes: TJSONArray):TJSONObject;
     //function ExcluirPermissoes(id: integer):TJSONObject;
     //function Listar(filtro:string):TJSONArray;
     function ListarPermissoesId( perfilId: integer ): TJSONArray;
     function ListarPermissoesUsuario(usuarioId: integer): TJSONArray;
   end;


implementation


{ TServicePermissoes }

constructor TServicePermissoes.Create;
begin
  FDmPermissoes := TDmPermissoes.Create(nil)
end;

destructor TServicePermissoes.Destroy;
begin
  FDmPermissoes.Free;
  inherited;
end;

function TServicePermissoes.ListarPermissoesId( perfilId: integer): TJSONArray;
begin
  result := FDmPermissoes.ListarPermissoesId( perfilId );
end;

function TServicePermissoes.InserirPermissoes(perfilID: integer; permissoes: TJSONArray): TJSONObject;
begin
   if (perfilID < 0) then
     raise Exception.Create('Id Perfil inválido.');

   Result := FDmPermissoes.InserirPermissoes(perfilID, permissoes)

end;

function TServicePermissoes.ListarPermissoesUsuario(usuarioId: integer): TJSONArray;
begin
  result := FDmPermissoes.ListarPermissoesUsuario(usuarioId );
end;




end.
