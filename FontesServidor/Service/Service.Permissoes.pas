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

     //function InserirPermissoes(id, id_usuario: integer; perfis: TJSONArray):TJSONObject;
     //function ExcluirPermissoes(id: integer):TJSONObject;
     //function Listar(filtro:string):TJSONArray;
     function ListarPermissoesId( perfilId: integer ): TJSONArray;
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

end.
