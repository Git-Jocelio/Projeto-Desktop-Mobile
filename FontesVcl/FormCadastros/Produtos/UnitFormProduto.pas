unit UnitFormProduto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UnitFormBaseGrade, Data.DB,
  System.ImageList, Vcl.ImgList, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ExtCtrls;

type
  TFormProduto = class(TFormBaseGrade)
    procedure FormCreate(Sender: TObject);
    procedure btnFiltrarClick(Sender: TObject);
    procedure dbgDblClick(Sender: TObject);
    procedure btnInserirClick(Sender: TObject);
    procedure BtnExcluirClick(Sender: TObject);

  private
    procedure Editar;
    procedure OpenCadProduto(produtoId: integer);
    procedure RefreshProduto;
    procedure TerminateBusca;
    procedure TerminateExcluir(Sender: TObject);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormProduto: TFormProduto;

implementation

{$R *.dfm}

uses DataModule.Produto, Vcl.Loading, Vcl.Navigation, UnitFormProdutoE;

procedure TFormProduto.FormCreate(Sender: TObject);
begin
  inherited;
   DmProduto := TDmProduto.Create(self)
end;



procedure TFormProduto.RefreshProduto;
begin
  TLoading.Show;

  try
    ds.DataSet := nil;
    DmProduto.ListarProduto(DmProduto.tabProduto, UpperCase(edtFiltrar.Text));
    ds.DataSet := DmProduto.tabProduto;
  finally
   TerminateBusca;
  end;

end;

procedure TFormProduto.TerminateBusca;
begin

  TLoading.Hide;

  ds.DataSet := DmProduto.tabProduto;

  if bookMark <> nil then
  try
    dbg.DataSource.DataSet.GotoBookmark(bookMark);
    dbg.DataSource.DataSet.FreeBookmark(bookMark);
    bookMark := nil;
  except
  end;

end;

procedure TFormProduto.TerminateExcluir(Sender: TObject);
begin

  TLoading.Hide;

  if (Sender is TThread) then
    if Assigned(TThread(Sender).FatalException) then
    begin
      ShowMessage( Exception(TThread(Sender).FatalException).Message );
      exit;
    end;

  RefreshProduto;

end;

procedure TFormProduto.BtnExcluirClick(Sender: TObject);
begin
  inherited;
  if DmProduto.tabProduto.IsEmpty then
    exit;

 if MessageDlg('Deseja realmente excluir este registro?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
 begin

   TLoading.Show;
   TLoading.ExecuteThread(procedure
   begin
      DmProduto.Excluir(DmProduto.tabProduto.FieldByName('produtoId').AsInteger);
   end,
   TerminateExcluir
   );
 end;

end;

procedure TFormProduto.btnFiltrarClick(Sender: TObject);
begin
  inherited;

  //  if length(trim(edtFiltrar.Text)) >= 4 then
    RefreshProduto;
  //  else
  //    ShowMessage('Informe pelo menos 4 caracteres. Após tecle[ENTER] ou Filtar.')

end;

procedure TFormProduto.btnInserirClick(Sender: TObject);
begin
  inherited;
  OpenCadProduto(0);
end;

procedure TFormProduto.dbgDblClick(Sender: TObject);
begin
  inherited;
  Editar;
end;

procedure TFormProduto.Editar;
begin
  if DmProduto.tabProduto.IsEmpty then
    exit;

    bookMark := dbg.DataSource.DataSet.GetBookmark;
    OpenCadProduto(DmProduto.tabProduto.FieldByName('produtoId').AsInteger);
end;

procedure TFormProduto.OpenCadProduto(produtoId: integer);
begin
  // guardar a chamada d evento(RefreshProduto) no onExecuteOnClose(onClose deste form)
  TNavigation.ExecuteOnClose := RefreshProduto;
  TNavigation.ParamInt := produtoId;
  TNavigation.OpenModal(TFormProdutoE, FormProdutoE);
end;


end.
