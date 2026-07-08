unit Servidor.Startup;

interface

procedure ConfigurarServidor;
procedure IniciarServidor(APorta: Integer);
procedure PararServidor;
function PortaServidor: Integer;

implementation

uses
  Horse,
  Horse.Jhonson,
  Horse.CORS,
  Dataset.Serialize.Config,
  Controllers.Cliente,
  Controllers.Usuario,
  Controllers.Produto,
  Controllers.Fornecedor,
  Controllers.Colaborador;

var
  ServidorConfigurado: Boolean = false;

procedure ConfigurarServidor;
begin

  if ServidorConfigurado then
    Exit;

  THorse.Use(Jhonson());
  THorse.Use(CORS);

  TDataSetSerializeConfig.GetInstance.CaseNameDefinition := cndLower;
  TDataSetSerializeConfig.GetInstance.Import.DecimalSeparator := '.';

  Controllers.Cliente.RegistrarRotas;
  Controllers.Usuario.RegistrarRotas;
  Controllers.Produto.RegistrarRotas;
  Controllers.Fornecedor.RegistrarRotas;
  Controllers.Colaborador.RegistrarRotas;

  ServidorConfigurado := True;
end;

function PortaServidor: Integer;
begin
  Result := THorse.Port;
end;

procedure IniciarServidor(APorta: Integer);
begin
  THorse.Listen(APorta);
end;

procedure PararServidor;
begin
  THorse.StopListen;
end;

end.


