// unit GLOBAL do projeto para pegar dados do usuario logado
// declarado como class pra pegar de qq lugar do projeto
// usando class não preciso me preocupar em criar ou destruir.
// o delphi se encarrega disso...

// sempre que precisar dos dados de login importar esse form

unit Vcl.Session;

interface

type
  TSession = class
  private
    class var FID_USUARIO: integer;
    class var FEMAIL: string;
    class var FNOME: string;
  public
     class property ID_USUARIO: integer read FID_USUARIO write FID_USUARIO;
     class property EMAIL: string read FEMAIL write FEMAIL;
     class property NOME: string read FNOME write FNOME;
  end;

implementation

end.
