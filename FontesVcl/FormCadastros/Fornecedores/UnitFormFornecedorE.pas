unit UnitFormFornecedorE;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UnitFormBaseEdicao, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.Buttons, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Navigation,
  Vcl.Loading, DataModule.Fornecedor, Service.Fornecedor;

type
  TFormFornecedorE = class(TFormBaseEdicao)
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    edtEmpresa: TEdit;
    edtTelefone: TEdit;
    edtEmail: TEdit;
    Label1: TLabel;
    Label5: TLabel;
    edtNomeContato: TEdit;
    edtTelefoneContato: TEdit;
    Label6: TLabel;
    edtCNPJ: TEdit;
    procedure FormShow(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
  private
    procedure TerminateFornecedorE(Sender: TObject);
    procedure TerminateSalvar(Sender: TObject);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormFornecedorE: TFormFornecedorE;

implementation

{$R *.dfm}

procedure TFormFornecedorE.btnSalvarClick(Sender: TObject);
begin
    TLoading.Show;

    TLoading.ExecuteThread(
    procedure
    begin
        sleep(500);
        TServiceFornecedor.Salvar(
                               TNavigation.ParamInt,
                               edtEmpresa.Text,
                               edtCNPJ.Text,
                               edtEmail.Text,
                               edtTelefone.Text,
                               edtNomeContato.text,
                               edtTelefoneContato.Text
                             );
    end,
    TerminateSalvar
    );end;

procedure TFormFornecedorE.FormShow(Sender: TObject);
begin
  if TNavigation.ParamInt > 0 then
  begin

    lblTitulo.Caption := 'Editar';

    TLoading.Show;
    TLoading.ExecuteThread(procedure
    begin
       sleep(500);
       DmFornecedor.ListarFornecedorId(MemTable, TNavigation.ParamInt);
    end,
    TerminateFornecedorE
    );

  end;
end;

procedure TFormFornecedorE.TerminateSalvar(Sender: TObject);
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


procedure TFormFornecedorE.TerminateFornecedorE(Sender: TObject);
begin

  TLoading.Hide;

  if (Sender is TThread) then
    if Assigned(TThread(Sender).FatalException) then
    begin
      ShowMessage( Exception(TThread(Sender).FatalException).Message );
      exit;
    end;

  // se não der erro, carrega dos edits
  edtEmpresa.Text := MemTable.FieldByName('nome').AsString;
  edtCNPJ.Text := '08253739000117';// MemTable.FieldByName('CPF_CNPJ').AsString;
  edtTelefone.Text := MemTable.FieldByName('telefone').AsString;
  edtEmail.Text := MemTable.FieldByName('email').AsString;
  edtNomeContato.Text := MemTable.FieldByName('contato').AsString;
  edtTelefoneContato.Text := MemTable.FieldByName('telefone_contato').AsString;

end;

end.
