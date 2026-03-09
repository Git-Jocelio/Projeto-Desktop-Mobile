unit UnitFormCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.Navigation, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, DataModele.Pessoa, System.UITypes,
  Vcl.Loading, System.ImageList, Vcl.ImgList; // unit que carrega o load na tela


type
  TDBGridHack = class(TDBGrid);

  type
  TFormCliente = class(TForm)
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
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

    procedure btnInserirClick(Sender: TObject);
    procedure BtnExcluirClick(Sender: TObject);
    procedure btnFiltrarClick(Sender: TObject);
    procedure dbgDblClick(Sender: TObject);
    procedure dbgDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure dbgMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure dbgKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dbgTitleClick(Column: TColumn);
    procedure edtFiltrarKeyPress(Sender: TObject; var Key: Char);
  private
    bookMark : TBookMark;
    procedure OpenCadCliente(pessoaId: integer);
    procedure RefreshPessoa;
    procedure TerminateBusca(Sender: TObject);
    procedure Editar;
    procedure TerminateExcluir(Sender: TObject);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormCliente: TFormCliente;

implementation


{$R *.dfm}

uses UnitFormClienteE;

procedure TFormCliente.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  // pode ficar como herança
  action := TCloseAction.caFree;
  FormCliente := nil;
end;

procedure TFormCliente.OpenCadCliente(pessoaId: integer);
begin
  TNavigation.ExecuteOnClose := RefreshPessoa;
  TNavigation.ParamInt := pessoaId;
  TNavigation.OpenModal(TFormClienteE, FormClienteE);
end;

procedure TFormCliente.btnInserirClick(Sender: TObject);
begin
  OpenCadCliente(0);
end;

procedure TFormCliente.dbgDblClick(Sender: TObject);
begin
  Editar;
end;

procedure TFormCliente.dbgDrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  Y: Integer;
begin
  // pode ficar como herança
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

procedure TFormCliente.dbgKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  // pode ficar como herança

  // Tecla DELETE
  if Key = VK_DELETE then
  begin
    BtnExcluirClick(nil);
    Key := 0; // evita comportamento padrão
  end;

  // Tecla ENTER (opcional, mas muito usado em ERP)
  if Key = VK_RETURN then
  begin
    Editar;
    Key := 0;
  end;

end;

procedure TFormCliente.dbgMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  GC: TGridCoord;
  R: TRect;
  PosX: Integer;
begin
  // pode ficar como herança
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
      Editar
    else
      BtnExcluirClick(nil);
  end;

end;



procedure TFormCliente.dbgTitleClick(Column: TColumn);
begin
  // pode ficar como herança
  if (Column.Grid.DataSource.DataSet is TFDMemTable) then
  begin
    if Column.FieldName <> 'ACOES' then
      TFDMemTable(Column.Grid.DataSource.DataSet).IndexFieldNames := Column.FieldName;
  end;
end;

procedure TFormCliente.Editar;
begin
  if DmPessoa.tabPessoa.IsEmpty then
    exit;

    bookMark := dbg.DataSource.DataSet.GetBookmark;

    OpenCadCliente(DmPessoa.tabPessoa.FieldByName('pessoaId').AsInteger);

end;


procedure TFormCliente.edtFiltrarKeyPress(Sender: TObject; var Key: Char);
begin
  // pode ficar como herança
  if key = #13 then btnFiltrarClick(nil);

end;

procedure TFormCliente.BtnExcluirClick(Sender: TObject);
begin
  if DmPessoa.tabPessoa.IsEmpty then
    exit;
 if MessageDlg('Deseja realmente excluir este registro?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
 begin

   TLoading.Show;
   TLoading.ExecuteThread(procedure
   begin
      DmPessoa.Excluir(DmPessoa.tabPessoa.FieldByName('pessoaId').AsInteger);
   end,
   TerminateExcluir
   );
 end;

end;

procedure TFormCliente.TerminateExcluir(Sender: TObject);
begin

  TLoading.Hide;

  if (Sender is TThread) then
    if Assigned(TThread(Sender).FatalException) then
    begin
      ShowMessage( Exception(TThread(Sender).FatalException).Message );
      exit;
    end;

  RefreshPessoa;

end;


procedure TFormCliente.btnFiltrarClick(Sender: TObject);
begin

  if length(trim(edtFiltrar.Text)) >= 4 then
    RefreshPessoa
  else
    ShowMessage('Informe pelo menos 4 caracteres. Após tecle[ENTER] ou Filtar.')
end;

procedure TFormCliente.TerminateBusca(Sender: TObject);
begin

  TLoading.Hide;
  ds.DataSet := DmPessoa.tabPessoa;

   if (Sender is TThread) then
     if Assigned(TThread(Sender).FatalException) then
     begin
       ShowMessage( Exception(TThread(Sender).FatalException).Message );
       exit;
     end;

   if bookMark<>nil then
   try
     dbg.DataSource.DataSet.GotoBookmark(bookMark);
     dbg.DataSource.DataSet.FreeBookmark(bookMark);
     bookMark := nil;
   except
     //
   end;
end;


procedure TFormCliente.RefreshPessoa;
begin
  TLoading.Show;

  TLoading.ExecuteThread(procedure
  begin
    sleep(800);
    ds.DataSet := nil; // Evita erro ao redenrizar a tela
    dmPessoa.ListarPessoa( dmPessoa.tabPessoa, uppercase(edtFiltrar.text) );
  end,
  TerminateBusca
  );

end;



end.
