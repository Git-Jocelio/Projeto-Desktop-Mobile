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

    function InserirEditarPessoa(const pessoaId: integer; const nome, email, telefone: string): TJSONObject;
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



function TServicePessoa.InserirEditarPessoa(const pessoaId: integer; const nome, email, telefone: string): TJSONObject;
begin
  // Validações da regra de negócio
  if Nome.Trim = '' then
    raise Exception.Create('Informe o nome da Pessoa');

  if email.Trim = '' then
    raise Exception.Create('Email é obrigatório');

  if Telefone.Trim = '' then
    raise Exception.Create('Telefone é obrigatório');


  // Aqui chama o DataModule só para persistência
  if PessoaId = 0 then
     Result := FDM.pessoaInserir( nome, telefone, email)
  else
     Result := FDM.pessoaEditar(pessoaId, nome, telefone, email);
end;




end.

