unit UnitFormPessoa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UnitFormBaseGrade, Data.DB,
  System.ImageList, Vcl.ImgList, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ExtCtrls, Vcl.Loading, DataModele.Pessoa, UnitFormPessoaE, vcl.Navigation;

type
  TFormPessoa = class(TFormBaseGrade)
    procedure btnFiltrarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnInserirClick(Sender: TObject);
    procedure BtnEditarClick(Sender: TObject);
    procedure BtnExcluirClick(Sender: TObject);
    procedure dbgDblClick(Sender: TObject);
  private
    procedure RefreshPessoa;
    procedure TerminateBusca;
    procedure OpenCadPessoa(pessoaId: integer);
    procedure Editar;
    procedure TerminateExcluir(Sender: TObject);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormPessoa: TFormPessoa;

implementation

{$R *.dfm}

procedure TFormPessoa.Editar;
begin
  if DmPessoa.tabPessoa.IsEmpty then
    exit;

    bookMark := dbg.DataSource.DataSet.GetBookmark;
    OpenCadPessoa(DmPessoa.tabPessoa.FieldByName('pessoaId').AsInteger);
end;

procedure TFormPessoa.BtnEditarClick(Sender: TObject);
begin
  inherited;
  Editar;

end;

procedure TFormPessoa.TerminateExcluir(Sender: TObject);
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


procedure TFormPessoa.BtnExcluirClick(Sender: TObject);
begin
  inherited;
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

procedure TFormPessoa.btnFiltrarClick(Sender: TObject);
begin
  inherited;
  RefreshPessoa;
end;

procedure TFormPessoa.RefreshPessoa;
begin
  TLoading.Show;

  try
    ds.DataSet := nil;
    DmPessoa.ListarPessoa(DmPessoa.TabPessoa, UpperCase(edtFiltrar.Text));
    ds.DataSet := DmPessoa.TabPessoa;
  finally
   TerminateBusca;
  end;
end;

procedure TFormPessoa.btnInserirClick(Sender: TObject);
begin
  inherited;
  OpenCadPessoa(0);

end;

procedure TFormPessoa.dbgDblClick(Sender: TObject);
begin
  inherited;
  Editar;
end;

procedure TFormPessoa.FormCreate(Sender: TObject);
begin
  inherited;
  DmPessoa := TDmPessoa.Create(self)
end;

procedure TFormPessoa.TerminateBusca;
begin

  TLoading.Hide;

  ds.DataSet := DmPessoa.TabPessoa;

  if bookMark <> nil then
  try
    dbg.DataSource.DataSet.GotoBookmark(bookMark);
    dbg.DataSource.DataSet.FreeBookmark(bookMark);
    bookMark := nil;
  except
  end;

end;

procedure TFormPessoa.OpenCadPessoa(pessoaId: integer);
begin
  // guardar a chamada do evento(RefreshProduto) no onExecuteOnClose(onClose deste form)
  TNavigation.ExecuteOnClose := RefreshPessoa;
  TNavigation.ParamInt := pessoaId;
  TNavigation.OpenModal(TFormPessoaE, FormPessoaE);
end;



end.
