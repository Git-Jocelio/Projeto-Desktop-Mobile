unit UnitFormSolicitacaoCompras;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UnitFormBaseGrade, Data.DB,
  System.ImageList, Vcl.ImgList, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ExtCtrls, Vcl.Navigation, UnitFormSolicitacaoComprasE,
  Vcl.Loading;

type
  TFormSolicitacaoCompras = class(TFormBaseGrade)
    Panel5: TPanel;
    RadioGroup1: TRadioGroup;
    procedure btnInserirClick(Sender: TObject);
  private
    procedure OpenCadSolicitacao(solicitacaoId: integer);
    procedure RefreshSolicitacao;
    procedure TerminateBusca;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormSolicitacaoCompras: TFormSolicitacaoCompras;

implementation

{$R *.dfm}

procedure TFormSolicitacaoCompras.TerminateBusca;
begin

  TLoading.Hide;

  //ds.DataSet := DmSolicitacao.tabSolicitacao;

  if bookMark <> nil then
  try
    dbg.DataSource.DataSet.GotoBookmark(bookMark);
    dbg.DataSource.DataSet.FreeBookmark(bookMark);
    bookMark := nil;
  except
  end;

end;



procedure TFormSolicitacaoCompras.RefreshSolicitacao;
begin
  TLoading.Show;

  try
  //  ds.DataSet := nil;
  //  DmSolicitacao.ListarSolicitacao(DmSolicitacao.tabSolicitacao, UpperCase(edtFiltrar.Text));
  //  ds.DataSet := DmSolicitacao.tabSolicitacao;
  finally
   TerminateBusca;
  end;

end;


procedure TFormSolicitacaoCompras.OpenCadSolicitacao(solicitacaoId: integer);
begin
  // guardar a chamada do evento(RefreshProduto) no onExecuteOnClose(onClose deste form)
  TNavigation.ExecuteOnClose := RefreshSolicitacao;
  TNavigation.ParamInt := solicitacaoId;
  TNavigation.OpenModal(TFormSolicitacaoComprasE, FormSolicitacaoComprasE);
end;


procedure TFormSolicitacaoCompras.btnInserirClick(Sender: TObject);
begin
  OpenCadSolicitacao(0);

end;

end.
