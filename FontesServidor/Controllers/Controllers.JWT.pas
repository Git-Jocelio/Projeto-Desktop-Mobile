unit Controllers.JWT;

interface

uses
  Horse,
  Horse.JWT,
  JOSE.Core.JWT,
  JOSE.Types.JSON,
  JOSE.Core.Builder,
  System.JSON,
  System.SysUtils,
  DataSet.Serialize;

const
  SECRET = '2026_07_14_@D3us!4b3nçõ3s#M3us%F1lh0s&Pará(Todo=Sempr3@';

type
  TMyClaims = class(TJWTClaims)
  strict private
    function GetIdUsuario: Integer;
    procedure SetIdUsuario(const Value: Integer);
  public
    property id_usuario: Integer read GetIdUsuario write SetIdUsuario;
  end;

function Criar_Token(id_usuario: Integer): string;
function Get_Usuario_Request(Req: THorseRequest): Integer;

implementation

function Criar_Token(id_usuario: Integer): string;
var
  jwt: TJWT;
  claims: TMyClaims;
begin
  try
    jwt := TJWT.Create;
    claims := TMyClaims(jwt.Claims);

    try
      claims.id_usuario := id_usuario;
      //claims.Expiration := now + 1;   //<<<--- data de expiracao

      Result := TJOSE.SHA256CompactToken(SECRET, jwt);
    except
      Result := '';
    end;

  finally
    FreeAndNil(jwt);
  end;
end;

function Get_Usuario_Request(Req: THorseRequest): Integer;
var
  claims: TMyClaims;
begin
  claims := Req.Session<TMyClaims>;
  Result := claims.id_usuario;
end;

function TMyClaims.GetIdUsuario: Integer;
begin
  Result := FJSON.GetValue<Integer>('id', 0);
end;

procedure TMyClaims.SetIdUsuario(const Value: Integer);
begin
  TJSONUtils.SetJSONValueFrom<Integer>('id', Value, FJSON);
end;

end.
