unit Service.Fornecedor;

interface
uses
  System.SysUtils, System.JSON, DataModule.Fornecedor;

type
  TServiceFornecedor = class
  private
    FDM: TDmFornecedor;
  public
    constructor Create;
    destructor Destroy; override;

    function InserirEditarFornecedor(const pessoaId: integer; const nome, telefone, email, contato, telefone_contato: string): TJSONObject;
  end;



implementation

constructor TServiceFornecedor.Create;
begin
  FDM := TDmFornecedor.Create(nil);
end;

destructor TServiceFornecedor.Destroy;
begin
  FDM.Free;
  inherited;
end;

function TServiceFornecedor.InserirEditarFornecedor(const pessoaId: integer; const nome, telefone, email, contato, telefone_contato: string): TJSONObject;
begin
  // Validações da regra de negócio
  if Nome.Trim = '' then
    raise Exception.Create('Informe o nome do Fornecedor');

  if Telefone.Trim = '' then
    raise Exception.Create('Telefone da empresa é obrigatório');

  if email.Trim = '' then
    raise Exception.Create('Email é obrigatório');

  if contato.Trim = '' then
    raise Exception.Create('Informe o nome do contato');

  if telefone_contato.Trim = '' then
    raise Exception.Create('Informe o telefone de contato');

  // Aqui chama o DataModule só para persistência
  if PessoaId = 0 then
     Result := FDM.fornecedorInserir(nome, telefone, email, contato, telefone_contato)
  else
     Result := FDM.fornecedorEditar(pessoaId, nome, telefone, email, contato, telefone_contato);
end;


end.
