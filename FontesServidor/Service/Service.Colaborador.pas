unit Service.Colaborador;

interface

uses
  System.SysUtils, System.JSON, DataModule.Colaborador;

type
  TServiceColaborador = class
  private
    FDM: TDmColaborador;
  public
    constructor Create;
    destructor Destroy; override;

    function InserirEditar(const pessoaId: integer;
                                nome, email, telefone: string; setorID: integer): TJSONObject;
  end;



implementation

constructor TServiceColaborador.Create;
begin
  FDM := TDmColaborador.Create(nil);
end;

destructor TServiceColaborador.Destroy;
begin
  FDM.Free;
  inherited;
end;

function TServiceColaborador.InserirEditar(const pessoaId: integer;
                                nome, email, telefone: string; setorID: integer): TJSONObject;
begin
  // Validações da regra de negócio
  if nome.Trim = '' then
    raise Exception.Create('Informe o nome do Colaborador');

  if Telefone.Trim = '' then
    raise Exception.Create('Telefone é Colaborador é obrigatório');

  if email.Trim = '' then
    raise Exception.Create('Email é obrigatório');

  if setorID <=0 then
    raise Exception.Create('Informe um Setor');


  // Aqui chama o DataModule só para persistência
  if PessoaId = 0 then
     Result := FDM.Inserir(nome, email, telefone, setorID)
  else
     Result := FDM.Editar(pessoaId,  nome, email, telefone, setorID);
end;


end.
