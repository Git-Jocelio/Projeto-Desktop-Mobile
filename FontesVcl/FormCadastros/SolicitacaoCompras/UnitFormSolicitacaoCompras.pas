unit UnitFormSolicitacaoCompras;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UnitFormBaseGrade, Data.DB,
  System.ImageList, Vcl.ImgList, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ExtCtrls, Vcl.Navigation, UnitFormSolicitacaoComprasE,
  Vcl.Loading, Vcl.ComCtrls;

type
  TFormSolicitacaoCompras = class(TFormBaseGrade)
    pnlPesquisa: TPanel;
    RadioGroup1: TRadioGroup;
    SpeedButton1: TSpeedButton;
    Label2: TLabel;
    dtp_data_solicitacao_ini: TDateTimePicker;
    dtp_data_solicitacao_fim: TDateTimePicker;
    Label3: TLabel;
    Label5: TLabel;
    ComboBox2: TComboBox;
    ComboBox1: TComboBox;
    procedure btnInserirClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    procedure OpenCadSolicitacao(solicitacaoId: integer);
    procedure RefreshSolicitacao;
    procedure TerminateBusca;
    procedure prc_componentes;
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


procedure TFormSolicitacaoCompras.SpeedButton1Click(Sender: TObject);
begin
  inherited;
  ShowMessage('REGRA DE NEGÓCIO' + slineBreak +
              'o botão filtro e o edit de pesquisa só será habilitado para o Gestor de compras.' + slineBreak +
              'os demais usuários só terão acesso ao seu departamento ' + slineBreak +
              'ou seja edit e o botão não serão visiveis e o departamento do usuário' +
              'logado será exibido no lugar ' + slineBreak +
              'a grig só mostrará as solicitações de seu departamento');
end;

procedure TFormSolicitacaoCompras.FormShow(Sender: TObject);
begin
  inherited;
  prc_componentes;
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

procedure TFormSolicitacaoCompras.prc_componentes;
begin
  dtp_data_solicitacao_ini.date := date;
  dtp_data_solicitacao_fim.date := date;
end;

end.
