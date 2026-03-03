unit Service.Pessoa;

interface

uses
  System.SysUtils, System.JSON, datamodule.pessoa;

type
  TServicePessoa = class
  private
    FDM: TDmPessoa;
  public
    constructor Create;
    destructor Destroy; override;

    function InserirPessoa(const Nome, Telefone, Setor: string): TJSONObject;
  end;

implementation

{ TServicePessoa }

constructor TServicePessoa.Create;
begin
  FDM := TDmPessoa.Create(nil);
end;

destructor TServicePessoa.Destroy;
begin
  FDM.Free;
  inherited;
end;

function TServicePessoa.InserirPessoa(const Nome, Telefone, Setor: string): TJSONObject;
begin
  // Validações da regra de negócio
  if Nome.Trim = '' then
    raise Exception.Create('Informe o nome da Pessoa');

  if Telefone.Trim = '' then
    raise Exception.Create('Telefone é obrigatório');

  if Setor.Trim = '' then
    raise Exception.Create('Setor é obrigatório');

  // Aqui chama o DataModule só para persistência
  Result := FDM.pessoaInserir(Nome, Telefone, Setor);

end;

end.

