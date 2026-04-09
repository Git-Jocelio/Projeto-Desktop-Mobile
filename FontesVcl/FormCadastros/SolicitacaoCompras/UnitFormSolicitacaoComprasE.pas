unit UnitFormSolicitacaoComprasE;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  Data.DB, Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.StorageBin, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.Navigation, Vcl.Loading, UnitFormSolicitacaoItens,
  Vcl.ComCtrls;

type
  TFormSolicitacaoComprasE = class(TForm)
    lblTitulo: TLabel;
    Label2: TLabel;
    edtNome: TEdit;
    Panel2: TPanel;
    btnSalvar: TSpeedButton;
    Panel1: TPanel;
    btnCancelar: TSpeedButton;
    Label1: TLabel;
    ComboBox1: TComboBox;
    Label5: TLabel;
    ComboBox2: TComboBox;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    Memo1: TMemo;
    Label3: TLabel;
    Label4: TLabel;
    Label8: TLabel;
    TabSolicitações: TFDMemTable;
    ds: TDataSource;
    TabSolicitaçõesDESCRICAO_ITEM: TStringField;
    TabSolicitaçõesQUANTIDADE: TFloatField;
    TabSolicitaçõesPRIORIDADE: TStringField;
    TabSolicitaçõesUNIDADE: TStringField;
    rg_situacao: TRadioGroup;
    pnl_situacao: TPanel;
    SpeedButton4: TSpeedButton;
    TabSolicitaçõesCONS_ATIVO: TStringField;
    Panel3: TPanel;
    SpeedButton5: TSpeedButton;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    DBGrid2: TDBGrid;
    DBGrid1: TDBGrid;
    Panel4: TPanel;
    SpeedButton6: TSpeedButton;
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SpeedButton5Click(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure rg_situacaoClick(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
  private
    procedure TerminateSolicitacaoE(Sender: TObject);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormSolicitacaoComprasE: TFormSolicitacaoComprasE;

implementation

{$R *.dfm}

procedure TFormSolicitacaoComprasE.TerminateSolicitacaoE(Sender: TObject);
begin

  TLoading.Hide;

  if (Sender is TThread) then
    if Assigned(TThread(Sender).FatalException) then
    begin
      ShowMessage( Exception(TThread(Sender).FatalException).Message );
      exit;
    end;

  // se não der erro, carrega dos edits
 // edtDescricao.Text := MemTable.FieldByName('descricao').AsString;
 // edtUnidade.Text   := MemTable.FieldByName('unidade').AsString;
 // edtEstoque.Text   := MemTable.FieldByName('estoque').AsString;

end;


procedure TFormSolicitacaoComprasE.btnCancelarClick(Sender: TObject);
begin
  TNavigation.CloseAndCancel(Self);
end;

procedure TFormSolicitacaoComprasE.btnSalvarClick(Sender: TObject);
begin
   ShowMessage('Mudança de status de rascunho para Pendente para aprovação' + #13 +
               '*** REGRA DE NEGÓCIO' + #13 +
               'valor até R$ 1000,00 -> Gestor do departamento libera' + #13 +
               'de R$ 1000,01 a R$ 5000,00 -> Gestor do departamento + financeiro libera' + #13 +
               'acima -> Diretoria' + #13 +
               'Salva em log, Data/hora, usuario. Ação: “Solicitação enviada para aprovação” ' + #13 +
    #13 +  #13  + #13 +
  'Na tabela de solicitacção deve ter um campo para status e criar uma tabela  ' + #13 +
  'para salvar as solicitações enviadas para aprovação ou seja                 ' + #13 +
  'na tela de solicitações o departamento responsavel ex diretoria e financeiro ' + #13 +
  'receberão um alerta na tela avisando que tem aprovações pendentes');







end;

procedure TFormSolicitacaoComprasE.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action := TCloseAction.caFree;
  Self := nil;
end;

procedure TFormSolicitacaoComprasE.FormShow(Sender: TObject);
begin
  if TNavigation.ParamInt > 0 then
  begin

    lblTitulo.Caption := 'Editar Solicitação';

    TLoading.Show;
    TLoading.ExecuteThread(procedure
    begin
       sleep(500);
      // DmSolicitacao.ListarSolicitacaoID(MemTable, TNavigation.ParamInt);
    end,
    TerminateSolicitacaoE
    );

  end;

end;

procedure TFormSolicitacaoComprasE.rg_situacaoClick(Sender: TObject);
begin
  if rg_situacao.ItemIndex = 0 then pnl_situacao.Color := $000BCFF2;
  if rg_situacao.ItemIndex = 1 then pnl_situacao.Color := $00408000;
  if rg_situacao.ItemIndex = 2 then pnl_situacao.Color := clRed;
end;

procedure TFormSolicitacaoComprasE.SpeedButton1Click(Sender: TObject);
begin
  showmessage('Abre o formulário para cadastrar um novo cento de custo');
end;

procedure TFormSolicitacaoComprasE.SpeedButton2Click(Sender: TObject);
begin
  showmessage('Abre o formulário para cadastrar uma nova categoria');

end;

procedure TFormSolicitacaoComprasE.SpeedButton3Click(Sender: TObject);
begin
  showmessage('Abre formulário de Pesquisa de Colaboradores');
end;

procedure TFormSolicitacaoComprasE.SpeedButton4Click(Sender: TObject);
begin
   ShowMessage('Mudança de status Aprovado para cotaçõa' + #13 +
               '*** REGRA DE NEGÓCIO' + #13 +
               'salvar enviar a solicitação para a tabela de cotação');// + #13 +
//    #13 +  #13  + #13 +

end;

procedure TFormSolicitacaoComprasE.SpeedButton5Click(Sender: TObject);
begin
  try
    if FormSolicitacaoItens= nil then
     FormSolicitacaoItens := TFormSolicitacaoItens.Create(Self);

    FormSolicitacaoItens.ShowModal;
  finally
    FreeAndNil(FormSolicitacaoItens) ;
  end;

end;

procedure TFormSolicitacaoComprasE.SpeedButton6Click(Sender: TObject);
begin
   ShowMessage('Salva Rascunho --> status rascunho' + #13 +
               '*** REGRA DE NEGÓCIO' + #13 +
               'Salva no banco como rascunho.' + #13 +
               'Podendo fazer alterações ou até excluir')

end;

end.
