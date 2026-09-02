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
    procedure DBGrid1CellClick(Column: TColumn);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    FDmPerfil: TDmPerfil;
    FDmPermissoes: TDmPermissoes;
    procedure ListarPermissoes(perfilId: integer);
    function EhPermissao(const Campo: string): Boolean;
  public
    procedure ListarPerfis;
  end;

var
  FormPermissoesE: TFormPermissoesE;

implementation

{$R *.dfm}




procedure TFormPermissoesE.DBGrid1CellClick(Column: TColumn);
var
  Campo: TField;
begin

  // Verifica se a coluna clicada é uma coluna de permissão
  if not EhPermissao(Column.FieldName) then
    Exit;

  Campo := Column.Field;

  // Coloca o registro em modo de edição
  FDmPermissoes.TabPermissoes.Edit;

  // Alterna a permissão
  if Campo.AsString = 'S' then
    Campo.AsString := 'N'
  else
    Campo.AsString := 'S';

  // Confirma a alteração no MemTable
  FDmPermissoes.TabPermissoes.Post;

  // Manda o DBGrid redesenhar o checkbox
  DBGrid1.Invalidate;
end;


procedure TFormPermissoesE.DBGrid1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  R: TRect;
  Flags: UINT;
begin

  // Se não for coluna de permissão,
  // deixa o DBGrid desenhar normalmente
  if not EhPermissao(Column.FieldName) then
  begin
    DBGrid1.DefaultDrawColumnCell(
      Rect,
      DataCol,
      Column,
      State
    );

    Exit;
  end;

  // Limpa o fundo da célula
  DBGrid1.Canvas.FillRect(Rect);

  // Calcula a posição do checkbox no centro da célula
  R.Left := Rect.Left + ((Rect.Width - 13) div 2);
  R.Top := Rect.Top + ((Rect.Height - 13) div 2);
  R.Right := R.Left + 13;
  R.Bottom := R.Top + 13;

  // Checkbox desmarcado
  Flags := DFCS_BUTTONCHECK;

  // Se tiver permissão, marca o checkbox
  if SameText(Column.Field.AsString, 'S') then
    Flags := Flags or DFCS_CHECKED;

  // Desenha o checkbox
  DrawFrameControl(
    DBGrid1.Canvas.Handle,
    R,
    DFC_BUTTON,
    Flags
  );

end;

function TFormPermissoesE.EhPermissao(const Campo: string): Boolean;
begin
  Result :=
    SameText(Campo, 'VER') or
    SameText(Campo, 'INSERIR') or
    SameText(Campo, 'EDITAR') or
    SameText(Campo, 'EXCLUIR') or
    SameText(Campo, 'IMPRIMIR');
end;

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
