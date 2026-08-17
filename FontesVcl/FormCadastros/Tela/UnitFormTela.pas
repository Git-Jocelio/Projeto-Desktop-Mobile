unit UnitFormTela;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UnitFormBaseGrade, Data.DB,
  System.ImageList, Vcl.ImgList, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ExtCtrls,
  Vcl.Navigation;

type
  TFormTela = class(TFormBaseGrade)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnFiltrarClick(Sender: TObject);
    procedure btnInserirClick(Sender: TObject);
    procedure dbgDblClick(Sender: TObject);
    procedure BtnExcluirClick(Sender: TObject);
  private
    procedure RefreshTela;
    procedure TerminateBusca(Sender: TObject);
    procedure OpenCadTela(id_tela: integer);
    procedure Editar;
    procedure TerminateExcluir(Sender: TObject);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormTela: TFormTela;

implementation

uses
  DataModule.Tela, Vcl.Loading, UnitFormTelaE;


{$R *.dfm}


procedure TFormTela.TerminateExcluir(Sender: TObject);
begin
  TLoading.Hide;

  if (Sender is TThread) then
    if Assigned(TThread(Sender).FatalException) then
    begin
      ShowMessage( Exception(TThread(Sender).FatalException).Message );
      exit;
    end;

  RefreshTela;
end;


procedure TFormTela.BtnExcluirClick(Sender: TObject);
begin
  inherited;
  if DmTela.memTable.IsEmpty then
    exit;

 if MessageDlg('Deseja realmente excluir este registro?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
 begin

   TLoading.Show;
   TLoading.ExecuteThread(procedure
   begin
      DmTela.Excluir(DmTela.memTable.FieldByName('id_tela').AsInteger);
   end,
   TerminateExcluir
   );
 end;

end;

procedure TFormTela.btnFiltrarClick(Sender: TObject);
begin
  inherited;
  RefreshTela
end;

procedure TFormTela.OpenCadTela(id_tela: integer);
begin
  TNavigation.ExecuteOnClose := RefreshTela;
  TNavigation.ParamInt := id_tela;
  TNavigation.OpenModal(TFormTelasE, FormTelasE);
end;

procedure TFormTela.btnInserirClick(Sender: TObject);
begin
  inherited;
  OpenCadTela(0)
end;

procedure TFormTela.Editar;
begin
  if DmTela.memTable.IsEmpty then
    exit;

  bookMark := dbg.DataSource.DataSet.GetBookmark;
  OpenCadTela(DmTela.memTable.FieldByName('id_tela').AsInteger);
end;


procedure TFormTela.dbgDblClick(Sender: TObject);
begin
  inherited;
  Editar;
end;

procedure TFormTela.FormCreate(Sender: TObject);
begin
  inherited;
  DmTela := TDmTela.Create(self)
end;

procedure TFormTela.FormDestroy(Sender: TObject);
begin
  inherited;
  DmTela.Free;
end;

procedure TFormTela.TerminateBusca(Sender: TObject);
begin
  TLoading.Hide;
  ds.DataSet := DmTela.MemTable;
end;

procedure TFormTela.RefreshTela;
begin
  TLoading.Show;
  ds.DataSet := nil;
  TLoading.ExecuteThread(procedure
  begin
    sleep(500);
    DmTela.Listar(DmTela.memTable, UpperCase(edtFiltrar.Text));
  end,
  TerminateBusca
  );
end;


end.
