unit UnitFormPermissoesE;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UnitFormBaseEdicao, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.Buttons, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.DBCtrls;

type
  TFormPermissoesE = class(TFormBaseEdicao)
    Label2: TLabel;
    Label4: TLabel;
    cbxPerfil: TDBLookupComboBox;
    DBGrid1: TDBGrid;
    ds: TDataSource;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    procedure ListarPerfis;
  end;

var
  FormPermissoesE: TFormPermissoesE;

implementation

{$R *.dfm}

uses DataModule.Perfil;

procedure TFormPermissoesE.FormShow(Sender: TObject);
begin
  inherited;
  ListarPerfis;
end;

procedure TFormPermissoesE.ListarPerfis;
var
  dmPerfil : TDmPerfil;
begin
   dmPerfil := TDmPerfil.Create(self);
   DmPerfil.ListarTodos;
end;
(*
sql para listar permissoes

SELECT
    T.ID_TELA,
    T.NOME_TELA,
    T.MODULO,
    T.ORDEM,

    COALESCE(P.VER, 'N') AS VER,
    COALESCE(P.INSERIR, 'N') AS INSERIR,
    COALESCE(P.EDITAR, 'N') AS EDITAR,
    COALESCE(P.EXCLUIR, 'N') AS EXCLUIR,
    COALESCE(P.IMPRIMIR, 'N') AS IMPRIMIR

FROM TELA T

LEFT JOIN PERMISSOES P
    ON P.TELA_ID = T.ID_TELA
    AND P.PERFIL_ID = :PERFIL_ID

WHERE T.ATIVO = 'S'

ORDER BY T.ORDEM;

*)


end.
