unit UnitFormSolicitacaoComprasE;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  Data.DB, Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.StorageBin, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.Navigation, Vcl.Loading;

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
    GroupBox1: TGroupBox;
    DBGrid1: TDBGrid;
    Memo1: TMemo;
    Panel3: TPanel;
    SpeedButton5: TSpeedButton;
    Label3: TLabel;
    Label4: TLabel;
    Label8: TLabel;
    TabSolicitações: TFDMemTable;
    ds: TDataSource;
    TabSolicitaçõesDESCRICAO_ITEM: TStringField;
    TabSolicitaçõesQUANTIDADE: TFloatField;
    TabSolicitaçõesPRIORIDADE: TStringField;
    TabSolicitaçõesUNIDADE: TStringField;
    RadioGroup1: TRadioGroup;
    Panel4: TPanel;
    SpeedButton4: TSpeedButton;
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SpeedButton5Click(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
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
   ShowMessage('Salva a solicitação no banco de dados')
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

procedure TFormSolicitacaoComprasE.SpeedButton5Click(Sender: TObject);
begin
  ShowMessage('abre o formulário de produtos')
end;

end.
