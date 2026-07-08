unit Env.Conf;

interface

uses
  System.SysUtils,
  System.Classes,
  System.IOUtils,
  System.Generics.Collections,
  FireDAC.Comp.Client;

type
  TEnvConfig = class
  private
    class function CarregarEnv: TDictionary<string, string>;
  public
    class procedure ConfigurarConexao(AConnection: TFDConnection);
  end;

implementation

{ ========================================== }
{ LEITOR DO .ENV }
{ ========================================== }

class function TEnvConfig.CarregarEnv: TDictionary<string, string>;
var
  Linhas: TStringList;
  Linha, Chave, Valor: string;
  PosIgual: Integer;
  CaminhoEnv: string;
begin
  Result := TDictionary<string, string>.Create;

  CaminhoEnv := ExtractFilePath(ParamStr(0)) + '.env';

  if not TFile.Exists(CaminhoEnv) then
    raise Exception.Create('.env não encontrado!');

  Linhas := TStringList.Create;
  try
    Linhas.LoadFromFile(CaminhoEnv);

    for Linha in Linhas do
    begin
      var LinhaTratada := Trim(Linha);

      if (LinhaTratada = '') or (LinhaTratada.StartsWith('#')) then
        Continue;

      PosIgual := LinhaTratada.IndexOf('=');

      if PosIgual > 0 then
      begin
        Chave := Trim(LinhaTratada.Substring(0, PosIgual));
        Valor := Trim(LinhaTratada.Substring(PosIgual + 1));
        Result.AddOrSetValue(Chave, Valor);
      end;
    end;
  finally
    Linhas.Free;
  end;
end;

{ ========================================== }
{ CONFIGURA A CONEXÃO }
{ ========================================== }

class procedure TEnvConfig.ConfigurarConexao(AConnection: TFDConnection);
var
  Env: TDictionary<string, string>;
begin
  // busca o arquivo .env e carrega em um dicionario de dados.
  Env := CarregarEnv;
  // configura o fdconnection passado por paramentro
  try
    AConnection.Params.Clear;
    AConnection.DriverName := 'FB';

    AConnection.Params.Add('Server='   + Env['DB_SERVER']);
    AConnection.Params.Add('Port='     + Env['DB_PORT']);
    AConnection.Params.Add('Database=' + Env['DB_DATABASE']);
    AConnection.Params.Add('User_Name='+ Env['DB_USER']);
    AConnection.Params.Add('Password=' + Env['DB_PASSWORD']);

    AConnection.LoginPrompt := False;

  finally
    Env.Free;
  end;
end;

end.
