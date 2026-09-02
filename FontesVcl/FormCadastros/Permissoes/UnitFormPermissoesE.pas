unit UnitFormPermissoesE;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UnitFormBaseEdicao, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.Buttons, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.DBCtrls,
  DataModule.Perfil,
  DataModule.Permissoes;

type
  TFormPermissoesE = class(TFormBaseEdicao)
    Label2: TLabel;
    Label4: TLabel;
    cbxPerfil: TDBLookupComboBox;
    ds: TDataSource;
    dsPermissoes: TDataSource;
    DBGrid1: TDBGrid;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cbxPerfilClick(Sender: TObject);
  private
    FDmPerfil: TDmPerfil;
    FDmPermissoes: TDmPermissoes;
    procedure ListarPermissoes(perfilId: integer);
    { Private declarations }
  public
    procedure ListarPerfis;
  end;

var
  FormPermissoesE: TFormPermissoesE;

implementation

{$R *.dfm}




procedure TFormPermissoesE.FormCreate(Sender: TObject);
begin
  inherited;

  FDmPerfil := TDmPerfil.Create(Self);
  FDmPermissoes := TDmPermissoes.Create(Self);

  dsPermissoes.DataSet := FDmPermissoes.TabPermissoes;

  DBGrid1.DataSource := dsPermissoes;
end;

procedure TFormPermissoesE.FormShow(Sender: TObject);
begin
  inherited;
   ListarPerfis;
end;

procedure TFormPermissoesE.ListarPerfis;
begin
   FDmPerfil.ListarTodos;
end;

procedure TFormPermissoesE.ListarPermissoes(perfilId: integer);

begin
  FDmPermissoes.ListarPermissoes(perfilId);
end;

procedure TFormPermissoesE.cbxPerfilClick(Sender: TObject);
begin
  inherited;
  if not VarIsNull(cbxPerfil.KeyValue) then
    ListarPermissoes(cbxPerfil.KeyValue);
end;


end.
