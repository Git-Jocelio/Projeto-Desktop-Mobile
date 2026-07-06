unit UnitFormPessoaE;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UnitFormBaseEdicao,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error,
  FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.Buttons, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Navigation,
  Vcl.Loading, DataModele.Pessoa, Service.Pessoa;

type
  TFormPessoaE = class(TFormBaseEdicao)
    Nome: TLabel;
    Label3: TLabel;
    Email: TLabel;
    edtNome: TEdit;
    edtTelefone: TEdit;
    edtEmail: TEdit;
    procedure FormShow(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
  private
    procedure TerminatePessoaE(Sender: TObject);
    procedure TerminateSalvar(Sender: TObject);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormPessoaE: TFormPessoaE;

implementation

{$R *.dfm}

procedure TFormPessoaE.TerminatePessoaE(Sender: TObject);
begin

  TLoading.Hide;

  if (Sender is TThread) then
    if Assigned(TThread(Sender).FatalException) then
    begin
      ShowMessage( Exception(TThread(Sender).FatalException).Message );
      exit;
    end;

  // se não der erro, carrega dos edits
  edtNome.Text := MemTable.FieldByName('nome').AsString;
  edtEmail.Text := MemTable.FieldByName('email').AsString;
  edtTelefone.Text := MemTable.FieldByName('telefone').AsString;

end;

procedure TFormPessoaE.TerminateSalvar(Sender: TObject);
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


procedure TFormPessoaE.btnSalvarClick(Sender: TObject);
begin
    TLoading.Show;

    TLoading.ExecuteThread(
    procedure
    begin
        sleep(500);
        TServicePessoa.Salvar(
                               TNavigation.ParamInt,
                               edtNome.text,
                               edtEmail.Text,
                               edtTelefone.Text
                             );
    end,
    TerminateSalvar
    );
end;

procedure TFormPessoaE.FormShow(Sender: TObject);
begin
  if TNavigation.ParamInt > 0 then
  begin

    lblTitulo.Caption := 'Editar';

    TLoading.Show;
    TLoading.ExecuteThread(procedure
    begin
       sleep(500);
       DmPessoa.ListarPessoaID(MemTable, TNavigation.ParamInt);
    end,
    TerminatePessoaE
    );

  end;
end;

end.
