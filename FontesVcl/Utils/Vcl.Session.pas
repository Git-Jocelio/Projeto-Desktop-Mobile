// classe para cuidar dos dados do usuario
unit Vcl.Session;

interface

uses
  System.JSON;

// curso poupei aula 5 min 15:00
type

// Pemissões de uma determinada tela
TPermissaoTela = record
  ID_TELA    : Integer;
  TELA_PAI_ID: Integer;

  NOME_TELA: string;
  MODULO   : string;
  ORDEM    : integer;

  VER     : Boolean;
  INSERIR : Boolean;
  EDITAR  : Boolean;
  EXCLUIR : Boolean;
  IMPRIMIR: Boolean;
end;

//Sessão do usuário logado
TSession = class
  private
    class var FID_USUARIO: integer;
    class var FNOME: string;
    class var FEMAIL: string;
    class var FPRIMEIRO_ACESSO: string;
    class var FTOKEN: string;
    class var FSTATUS: string;

    class var FPERMISSOES: array of TPermissaoTela;

    //Procura uma tela dentro das permissões carregadas
    class function IndicePermissao(ATelaID: Integer): Integer; static;

  public
    class property ID_USUARIO: integer read FID_USUARIO write FID_USUARIO;
    class property NOME: string read FNOME write FNOME;
    class property EMAIL: string read FEMAIL write FEMAIL;
    class property PRIMEIRO_ACESSO: string read FPRIMEIRO_ACESSO write FPRIMEIRO_ACESSO;
    class property TOKEN: string read FTOKEN write FTOKEN;
    class property STATUS: string read FSTATUS write FSTATUS;// status da empresa TESTE, BLOQUEADO, LIBERADO

    // Controle da sessão
    class procedure Limpar; static;

    //Permissões
    class procedure AdicionarPermissao(AIDTela: integer; ATelaPaiID: integer;
                                  ANomeTela: string; AModulo: string; AOrdem: Integer;
                                  AVer: Boolean; AInserir: Boolean; AEditar: Boolean;
                                  AExcluir: Boolean; AImprimir: Boolean); static;

    class procedure CarregarPermissoes(AJson: TJSONArray); static;

    class function QuantidadePermissoes: Integer; static;

    class function ObterPermissao(AIndex: Integer): TPermissaoTela; static;

    //==========================================================================
    // Verificação das permissões
    //==========================================================================
    class function PodeVer(ATelaID: Integer): Boolean; static;
    class function PodeInserir(ATelaID: Integer): Boolean; static;
    class function PodeEditar(ATelaID: Integer): Boolean; static;
    class function PodeExcluir(ATelaID: Integer): Boolean; static;
    class function PodeImprimir(ATelaID: Integer): Boolean; static;

    end;


implementation

//=================================================================
//
//Retorna;
//  índice da permissão encontrada dentro da lista de permissoes
//  -1 caso a tela não exista
//=================================================================
class function TSession.IndicePermissao(ATelaID: Integer): Integer;
var
 I: Integer;
begin
  Result := -1;

  for I := 0 to Length(FPERMISSOES) -1 do
  begin
    if FPERMISSOES[I].ID_TELA = -1 then
    begin
       Result := I;
       exit;
    end;
  end;

end;

class procedure TSession.Limpar;
begin
   FID_USUARIO := 0;
   FNOME := '';
   FEMAIL:= '';
   FPRIMEIRO_ACESSO := '';
   FTOKEN := '';
   FSTATUS := '';

   SetLength(FPERMISSOES,0);//?
end;

//===============================================================================
// Adiciona uma permissão na Session
//===============================================================================

class procedure TSession.AdicionarPermissao(AIDTela: integer; ATelaPaiID: integer;
                                  ANomeTela: string; AModulo: string; AOrdem: Integer;
                                  AVer: Boolean; AInserir: Boolean; AEditar: Boolean;
                                  AExcluir: Boolean; AImprimir: Boolean);
var
  I: Integer;
begin
  I:= Length(FPERMISSOES);

  SetLength(FPERMISSOES, I + 1);

  FPERMISSOES[I].ID_TELA := AIDTela;
  FPERMISSOES[I].TELA_PAI_ID := AIDTela;

 FPERMISSOES[I].NOME_TELA := ANomeTela;
 FPERMISSOES[I].MODULO := AModulo;
 FPERMISSOES[I].ORDEM := AOrdem;

 FPERMISSOES[I].VER := AVer;
 FPERMISSOES[I].INSERIR := AInserir;
 FPERMISSOES[I].EDITAR := AEditar;
 FPERMISSOES[I].EXCLUIR := AExcluir;
 FPERMISSOES[I].IMPRIMIR := AImprimir;


end;

class function TSession.QuantidadePermissoes: Integer;
begin
  Result := Length(FPERMISSOES);
end;

class function TSession.ObterPermissao(AIndex: Integer): TPermissaoTela;
begin
  Result := FPERMISSOES[AIndex];
end;

class function TSession.PodeVer(ATelaID: Integer): Boolean;
var
 I: Integer;
begin
  I := IndicePermissao(ATelaID);

  if I = -1 then Exit(False);  // retorne false e encerre a funcao!
  Result := FPERMISSOES[I].VER;
end;

class function TSession.PodeInserir(ATelaID: Integer): Boolean;
var
 I: Integer;
begin
  I := IndicePermissao(ATelaID);

  if I = -1 then Exit(False);  // retorne false e encerre a funcao!
  Result := FPERMISSOES[I].INSERIR;
end;


class function TSession.PodeEditar(ATelaID: Integer): Boolean;
var
 I: Integer;
begin
  I := IndicePermissao(ATelaID);

  if I = -1 then Exit(False);  // retorne false e encerre a funcao!
  Result := FPERMISSOES[I].EDITAR;
end;

class function TSession.PodeExcluir(ATelaID: Integer): Boolean;
var
 I: Integer;
begin
  I := IndicePermissao(ATelaID);

  if I = -1 then Exit(False);  // retorne false e encerre a funcao!
  Result := FPERMISSOES[I].EXCLUIR;
end;

class function TSession.PodeImprimir(ATelaID: Integer): Boolean;
var
 I: Integer;
begin
  I := IndicePermissao(ATelaID);

  if I = -1 then Exit(False);  // retorne false e encerre a funcao!
  Result := FPERMISSOES[I].IMPRIMIR;
end;

class procedure TSession.CarregarPermissoes(AJson: TJSONArray);
var
  I: Integer;
  Obj: TJSONObject;
begin
  SetLength(FPERMISSOES, 0);

  if not Assigned(AJson) then
    Exit;

  for I := 0 to AJson.Count - 1 do
  begin
    Obj := AJson.Items[I] as TJSONObject;

    AdicionarPermissao(
      Obj.GetValue<Integer>('id_tela', 0),
      Obj.GetValue<Integer>('tela_pai_id', 0),
      Obj.GetValue<string>('nome_tela', ''),
      Obj.GetValue<string>('modulo', ''),
      Obj.GetValue<Integer>('ordem', 0),

      Obj.GetValue<string>('ver', 'N') = 'S',
      Obj.GetValue<string>('inserir', 'N') = 'S',
      Obj.GetValue<string>('editar', 'N') = 'S',
      Obj.GetValue<string>('excluir', 'N') = 'S',
      Obj.GetValue<string>('imprimir', 'N') = 'S'
    );
  end;
end;

end.
