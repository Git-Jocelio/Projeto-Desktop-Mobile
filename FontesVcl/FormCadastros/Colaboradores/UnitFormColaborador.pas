unit UnitFormColaborador;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UnitFormBaseGrade, Data.DB,
  System.ImageList, Vcl.ImgList, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ExtCtrls, Vcl.Navigation, Vcl.Loading;

type
  TFormColaborador = class(TFormBaseGrade)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnInserirClick(Sender: TObject);
    procedure btnFiltrarClick(Sender: TObject);
    procedure dbgDblClick(Sender: TObject);
    procedure BtnExcluirClick(Sender: TObject);
  private
    procedure OpenCadColaborador(pessoaId: integer);
    procedure RefreshColaborador;
    procedure TerminateBusca;
    procedure Editar;
    procedure TerminateExcluir(Sender: TObject);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormColaborador: TFormColaborador;

implementation


{$R *.dfm}

uses DataModule.Colaborador, UnitFormColaboradorE;

procedure TFormColaborador.TerminateExcluir(Sender: TObject);
begin

  TLoading.Hide;

  if (Sender is TThread) then
    if Assigned(TThread(Sender).FatalException) then
    begin
      ShowMessage( Exception(TThread(Sender).FatalException).Message );
      exit;
    end;

  RefreshColaborador;

end;



procedure TFormColaborador.BtnExcluirClick(Sender: TObject);
begin
  if DmColaborador.TabColaborador.IsEmpty then
    exit;

 if MessageDlg('Deseja realmente excluir este registro?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
 begin

   TLoading.Show;
   TLoading.ExecuteThread(procedure
   begin
      DmColaborador.Excluir(DmColaborador.TabColaborador.FieldByName('pessoaId').AsInteger);
   end,
   TerminateExcluir
   );
 end;

end;

procedure TFormColaborador.btnFiltrarClick(Sender: TObject);
begin
  inherited;
  RefreshColaborador;
end;

procedure TFormColaborador.btnInserirClick(Sender: TObject);
begin
  inherited;
  OpenCadColaborador(0);
end;

procedure TFormColaborador.Editar;
begin
  if DmColaborador.TabColaborador.IsEmpty then
    exit;

    bookMark := dbg.DataSource.DataSet.GetBookmark;
    OpenCadColaborador(DmColaborador.TabColaborador.FieldByName('pessoaId').AsInteger);
end;



procedure TFormColaborador.dbgDblClick(Sender: TObject);
begin
  inherited;
  Editar;
end;

procedure TFormColaborador.FormCreate(Sender: TObject);
begin
  inherited;
  DmColaborador := TDmColaborador.Create(self)
end;

procedure TFormColaborador.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(DmColaborador);
end;

procedure TFormColaborador.OpenCadColaborador(pessoaId: integer);
begin
  TNavigation.ExecuteOnClose := RefreshColaborador;
  TNavigation.ParamInt := pessoaId;
  TNavigation.OpenModal(TFormColaboradorE, FormColaboradorE);
end;

procedure TFormColaborador.TerminateBusca;
begin

  TLoading.Hide;

  ds.DataSet := DmColaborador.TabColaborador;

  if bookMark <> nil then
  try
    dbg.DataSource.DataSet.GotoBookmark(bookMark);
    dbg.DataSource.DataSet.FreeBookmark(bookMark);
    bookMark := nil;
  except
  end;

end;


procedure TFormColaborador.RefreshColaborador;
begin
  TLoading.Show;

  try
    ds.DataSet := nil;
    DmColaborador.Listar(DmColaborador.TabColaborador, UpperCase(edtFiltrar.Text));
    ds.DataSet := DmColaborador.TabColaborador;
    if ds.DataSet.IsEmpty then
      ShowMessage('Nenhum registro encontrado!')
    finally
     TerminateBusca;
  end;

end;



end.
