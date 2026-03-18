unit UnitFormProdutoE;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UnitFormBaseEdicao, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.Buttons, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Navigation, Vcl.Loading;

type
  TFormProdutoE = class(TFormBaseEdicao)
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    edtDescricao: TEdit;
    edtEstoque: TEdit;
    edtUnidade: TComboBox;
    procedure FormShow(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
  private
    procedure TerminateClienteE(Sender: TObject);
    procedure TerminateSalvar(Sender: TObject);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormProdutoE: TFormProdutoE;

implementation

{$R *.dfm}

uses DataModule.Produto, Service.Produto;

procedure TFormProdutoE.btnSalvarClick(Sender: TObject);
begin
    TLoading.Show;

    TLoading.ExecuteThread(
    procedure
    begin
        sleep(500);
        TServiceProduto.Salvar(
                               TNavigation.ParamInt,
                               edtDescricao.Text,
                               edtUnidade.Text,
                               strtointdef(edtUnidade.Text,0)
                             );
    end,
    TerminateSalvar
    );
end;

procedure TFormProdutoE.TerminateSalvar(Sender: TObject);
begin

  TLoading.Hide;

  if (Sender is TThread) then
    if Assigned(TThread(Sender).FatalException) then
    begin
      ShowMessage( Exception(TThread(Sender).FatalException).Message );
      exit;
    end;

   TNavigation.Close(self);

end;


procedure TFormProdutoE.FormShow(Sender: TObject);
begin
  if TNavigation.ParamInt > 0 then
  begin

    lblTitulo.Caption := 'Editar';

    TLoading.Show;
    TLoading.ExecuteThread(procedure
    begin
       sleep(500);
       DmProduto.ListarProdutoID(MemTable, TNavigation.ParamInt);
    end,
    TerminateClienteE
    );

  end;

end;


procedure TFormProdutoE.TerminateClienteE(Sender: TObject);
begin

  TLoading.Hide;

  if (Sender is TThread) then
    if Assigned(TThread(Sender).FatalException) then
    begin
      ShowMessage( Exception(TThread(Sender).FatalException).Message );
      exit;
    end;

  // se não der erro, carrega dos edits
  edtDescricao.Text := MemTable.FieldByName('descricao').AsString;
  edtUnidade.Text   := MemTable.FieldByName('unidade').AsString;
  edtEstoque.Text   := MemTable.FieldByName('estoque').AsString;

end;


end.
