unit UnitFormSolicitacaoItens;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UnitFormBaseEdicao, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.Buttons, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.DBCtrls;

type
  TFormSolicitacaoItens = class(TFormBaseEdicao)
    rg_tipo_produto: TRadioGroup;
    gb_Produto: TGroupBox;
    DBLookupComboBox1: TDBLookupComboBox;
    SpeedButton2: TSpeedButton;
    gb_quantidade: TGroupBox;
    Edit1: TEdit;
    Edit2: TEdit;
    gb_ativo_imobilizado: TGroupBox;
    SpeedButton1: TSpeedButton;
    Label1: TLabel;
    ComboBox1: TComboBox;
    RadioGroup2: TRadioGroup;
    Memo1: TMemo;
    Label2: TLabel;
    SpeedButton3: TSpeedButton;
    mmAjudaSimNao: TMemo;
    SpeedButton4: TSpeedButton;
    mmAjudaObs: TMemo;
    mmAjudaTipoProduto: TMemo;
    SpeedButton5: TSpeedButton;
    Label3: TLabel;
    Edit3: TEdit;
    procedure SpeedButton3Click(Sender: TObject);
    procedure mmAjudaSimNaoDblClick(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure rg_tipo_produtoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    procedure prc_ajusta_tela;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormSolicitacaoItens: TFormSolicitacaoItens;

implementation

{$R *.dfm}

procedure TFormSolicitacaoItens.FormShow(Sender: TObject);
begin
  inherited;
  rg_tipo_produto.ItemIndex := 0;
end;

procedure TFormSolicitacaoItens.mmAjudaSimNaoDblClick(Sender: TObject);
begin
  inherited;
    mmAjudaSimNao.Visible := false;

end;

procedure TFormSolicitacaoItens.SpeedButton3Click(Sender: TObject);
begin
  inherited;
  mmAjudaObs.Visible := false;

  mmAjudaSimNao.left := 20;
  mmAjudaSimNao.top := 80;

  mmAjudaSimNao.Height := 500;
  mmAjudaSimNao.Width := 480;

  mmAjudaSimNao.Visible := true;
end;

procedure TFormSolicitacaoItens.SpeedButton4Click(Sender: TObject);
begin
  inherited;
  mmAjudaSimNao.Visible := false;

  mmAjudaObs.left := 20;
  mmAjudaObs.top := 80;

  mmAjudaObs.Height := 500;
  mmAjudaObs.Width := 480;

  mmAjudaObs.Visible := true;
end;

procedure TFormSolicitacaoItens.SpeedButton5Click(Sender: TObject);
begin
  inherited;
  mmAjudaSimNao.Visible := false;
  mmAjudaObs.Visible := false;

  mmAjudaTipoProduto.left := 20;
  mmAjudaTipoProduto.top := 80;

  mmAjudaTipoProduto.Height := 500;
  mmAjudaTipoProduto.Width := 500;

  mmAjudaTipoProduto.Visible := true;
end;


procedure TFormSolicitacaoItens.prc_ajusta_tela;
begin
  // consumo
   if rg_tipo_produto.ItemIndex = 0 then
   begin
     gb_Produto.Visible := true;
     gb_ativo_imobilizado.Visible := false;
     gb_quantidade.Top := gb_Produto.top + gb_Produto.Height +20;;
     FormSolicitacaoItens.Height := 410
   end else
   if rg_tipo_produto.ItemIndex = 1 then
   begin
     gb_Produto.Visible := false;
     gb_ativo_imobilizado.Visible := true;
     gb_ativo_imobilizado.top := gb_Produto.top;
     gb_quantidade.Top := gb_ativo_imobilizado.Height +20;
     FormSolicitacaoItens.Height := 550
   end
end;

procedure TFormSolicitacaoItens.rg_tipo_produtoClick(Sender: TObject);
begin
  inherited;
  prc_ajusta_tela;
end;

end.
