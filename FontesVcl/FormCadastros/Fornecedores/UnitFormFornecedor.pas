unit UnitFormFornecedor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UnitFormBaseGrade, Data.DB,
  System.ImageList, Vcl.ImgList, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ExtCtrls, DataModule.Fornecedor, Vcl.Loading, Vcl.Navigation;

type
  TFormFornecedor = class(TFormBaseGrade)
    procedure FormCreate(Sender: TObject);
    procedure btnFiltrarClick(Sender: TObject);
    procedure btnInserirClick(Sender: TObject);
    procedure dbgDblClick(Sender: TObject);
  private
    procedure RefreshFornecedor;
    procedure TerminateBusca;
    procedure OpenCadFornecedor(pessoaId: integer);
    procedure Editar;
  public
  end;

var
  FormFornecedor: TFormFornecedor;

implementation

{$R *.dfm}

procedure TFormFornecedor.btnFiltrarClick(Sender: TObject);
begin
  inherited;
  RefreshFornecedor;
end;

procedure TFormFornecedor.btnInserirClick(Sender: TObject);
begin
  inherited;
  OpenCadFornecedor(0);
end;

procedure TFormFornecedor.dbgDblClick(Sender: TObject);
begin
  inherited;
  Editar;
end;

procedure TFormFornecedor.Editar;
begin
  if DmFornecedor.TabFornecedor.IsEmpty then
    exit;

    bookMark := dbg.DataSource.DataSet.GetBookmark;
    OpenCadFornecedor(DmFornecedor.TabFornecedor.FieldByName('pessoaId').AsInteger);
end;


procedure TFormFornecedor.FormCreate(Sender: TObject);
begin
  inherited;
  DmFornecedor := TDmFornecedor.Create(self)

end;

procedure TFormFornecedor.RefreshFornecedor;
begin
  TLoading.Show;

  try
    ds.DataSet := nil;
    DmFornecedor.ListarFornecedor(DmFornecedor.TabFornecedor, UpperCase(edtFiltrar.Text));
    ds.DataSet := DmFornecedor.TabFornecedor;
    if ds.DataSet.IsEmpty then
      ShowMessage('Nenhum registro encontrado!')
  finally
   TerminateBusca;
  end;

end;

procedure TFormFornecedor.TerminateBusca;
begin

  TLoading.Hide;

  ds.DataSet := DmFornecedor.TabFornecedor;

  if bookMark <> nil then
  try
    dbg.DataSource.DataSet.GotoBookmark(bookMark);
    dbg.DataSource.DataSet.FreeBookmark(bookMark);
    bookMark := nil;
  except
  end;

end;

procedure TFormFornecedor.OpenCadFornecedor(pessoaId: integer);
begin
  TNavigation.ExecuteOnClose := RefreshFornecedor;
  TNavigation.ParamInt := pessoaId;
 // TNavigation.OpenModal(TFormFornecedorE, FormfornecedorE);
end;




end.
