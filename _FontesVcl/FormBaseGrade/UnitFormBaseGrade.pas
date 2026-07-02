unit UnitFormBaseGrade;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, System.ImageList, Vcl.ImgList,
  Vcl.Loading, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;
   // unit que carrega o load na tela
type
  TDBGridHack = class(TDBGrid);

type
  TFormBaseGrade = class(TForm)
    PnlHeader: TPanel;
    Label1: TLabel;
    PnlBotaoInserir: TPanel;
    BtnExcluir: TSpeedButton;
    Panel2: TPanel;
    btnInserir: TSpeedButton;
    Panel3: TPanel;
    BtnEditar: TSpeedButton;
    Panel1: TPanel;
    Panel4: TPanel;
    btnFiltrar: TSpeedButton;
    edtFiltrar: TEdit;
    dbg: TDBGrid;
    ds: TDataSource;
    ImageList: TImageList;
    procedure edtFiltrarKeyPress(Sender: TObject; var Key: Char);
    procedure dbgDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure dbgMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure dbgTitleClick(Column: TColumn);

    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
  public
     bookMark : TBookMark;
  end;

var
  FormBaseGrade: TFormBaseGrade;

implementation

{$R *.dfm}

procedure TFormBaseGrade.dbgDrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  Y: Integer;
begin
  // insere imagens na coluna ações
  if Column.FieldName = 'ACOES' then
  begin
    dbg.Canvas.FillRect(Rect);

    Y := Rect.Top + (Rect.Height - ImageList.Height) div 2;

    ImageList.Draw(dbg.Canvas, Rect.Left + 30, Y, 0);  // editar
    ImageList.Draw(dbg.Canvas, Rect.Left + 60, Y, 1);  // excluir

  end
  else
    dbg.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TFormBaseGrade.dbgMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  GC: TGridCoord;
  R: TRect;
  PosX: Integer;
begin
  // atribui ações as imagens editar ou excluir
  if Button <> mbLeft then Exit;

  GC := dbg.MouseCoord(X, Y);

  if (GC.X < 1) or (GC.Y < 1) then
    Exit;

  if dbg.Columns[GC.X - 1].FieldName = 'ACOES' then
  begin
     R := TDBGridHack(dbg).CellRect(GC.X, GC.Y);

    // posição do clique dentro da célula
    PosX := X - R.Left;

    if PosX < 50 then
      // Editar
      dbg.OnDblClick(nil)
    else
     // BtnExcluir.OnClick(nil);
      BtnExcluir.Click;
  end;

end;

procedure TFormBaseGrade.dbgTitleClick(Column: TColumn);
begin
  // ordena ao clicar no titulo
  if (Column.Grid.DataSource.DataSet is TFDMemTable) then
  begin
    if Column.FieldName <> 'ACOES' then
      TFDMemTable(Column.Grid.DataSource.DataSet).IndexFieldNames := Column.FieldName;
  end;

end;

procedure TFormBaseGrade.edtFiltrarKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then btnFiltrar.Click;
  if Key = #27 then Close;;

end;

procedure TFormBaseGrade.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action := TCloseAction.caFree;
  FormBaseGrade := nil;
end;

end.
