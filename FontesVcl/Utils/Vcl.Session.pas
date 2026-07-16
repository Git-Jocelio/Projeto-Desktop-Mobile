// sessão para cuidar dos dados do usuario
unit Vcl.Session;

interface
// curso poupei aula 5 min 15:00
type
  TSession = class
  private
    class var FID_USUARIO: integer;
    class var FNOME: string;
    class var FEMAIL: string;
    class var FTOKEN: string;
    class var FSTATUS: string;
  public
    class property ID_USUARIO: integer read FID_USUARIO write FID_USUARIO;
    class property NOME: string read FNOME write FNOME;
    class property EMAIL: string read FEMAIL write FEMAIL;
    class property TOKEN: string read FTOKEN write FTOKEN;
    class property STATUS: string read FSTATUS write FSTATUS;// status da empresa TESTE, BLOQUEADO, LIBERADO
  end;

implementation

end.
