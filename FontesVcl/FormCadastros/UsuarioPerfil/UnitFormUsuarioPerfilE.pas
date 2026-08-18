unit UnitFormUsuarioPerfilE;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UnitFormBaseEdicao, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.Buttons, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Grids,
  Vcl.DBGrids, FireDAC.Stan.StorageBin;

type
  TFormUsuarioPerfilE = class(TFormBaseEdicao)
    Label1: TLabel;
    Label2: TLabel;
    edtLogin: TEdit;
    Label3: TLabel;
    Edit1: TEdit;
    Label7: TLabel;
    Edit2: TEdit;
    Label6: TLabel;
    Edit3: TEdit;
    Panel2: TPanel;
    DBGrid1: TDBGrid;
    Label5: TLabel;
    ds: TDataSource;
    MemTableAtivo: TStringField;
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DBGrid1CellClick(Column: TColumn);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormUsuarioPerfilE: TFormUsuarioPerfilE;

implementation

{$R *.dfm}

procedure TFormUsuarioPerfilE.DBGrid1CellClick(Column: TColumn);
var
  Field: TField;
  DataSet: TDataSet;
begin
  if not Assigned(Column) then
    Exit;

  Field := Column.Field;

  if not Assigned(Field) then
    Exit;

  if not SameText(Field.FieldName, 'ATIVO') then
    Exit;

  DataSet := Field.DataSet;

  if not Assigned(DataSet) then
    Exit;

  if not DataSet.Active then
    Exit;

  if DataSet.State = dsBrowse then
    DataSet.Edit;

  if SameText(Field.AsString, 'S') then
    Field.AsString := 'N'
  else
    Field.AsString := 'S';

  DataSet.Post;
end;

procedure TFormUsuarioPerfilE.DBGrid1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  ChkRect: TRect;
begin
  // Verifica se existe um Field associado à coluna
  if not Assigned(Column.Field) then
  begin
    DBGrid1.DefaultDrawColumnCell(Rect, DataCol, Column, State);
    Exit;
  end;

  // Verifica se é a coluna ATIVO
  if SameText(Column.Field.FieldName, 'ATIVO') then
  begin
    DBGrid1.Canvas.FillRect(Rect);

    ChkRect := Rect;
    InflateRect(ChkRect, -2, -2);

    if SameText(Column.Field.AsString, 'S') then
    begin
      DrawFrameControl(
        DBGrid1.Canvas.Handle,
        ChkRect,
        DFC_BUTTON,
        DFCS_BUTTONCHECK or DFCS_CHECKED
      );
    end
    else
    begin
      DrawFrameControl(
        DBGrid1.Canvas.Handle,
        ChkRect,
        DFC_BUTTON,
        DFCS_BUTTONCHECK
      );
    end;
  end
  else
  begin
    DBGrid1.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  end;
end;

end.
