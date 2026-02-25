unit UnitFormClienteE;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  Vcl.Navigation, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TFormClienteE = class(TForm)
    lblTitulo: TLabel;
    Label2: TLabel;
    edtNome: TEdit;
    Panel2: TPanel;
    btnSalvar: TSpeedButton;
    Panel1: TPanel;
    btnCancelar: TSpeedButton;
    Label3: TLabel;
    edtTelefone: TEdit;
    Label4: TLabel;
    edtsetor: TEdit;
    MemTable: TFDMemTable;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCancelarClick(Sender: TObject);
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
  FormClienteE: TFormClienteE;

implementation

{$R *.dfm}

uses Vcl.Loading, DataModele.Pessoa;

procedure TFormClienteE.btnSalvarClick(Sender: TObject);
begin
    TLoading.Show;
    TLoading.ExecuteThread(procedure
    begin
       sleep(1000);
       if TNavigation.ParamInt > 0 then // alterando
         DmPessoa.Editar(TNavigation.ParamInt, edtNome.Text, edtTelefone.Text, edtsetor.Text)
       else
         DmPessoa.Inserir(edtNome.Text, edtTelefone.Text, edtsetor.Text)
    end,
    TerminateSalvar
    );
end;

procedure TFormClienteE.TerminateSalvar(Sender: TObject);
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


procedure TFormClienteE.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action := TCloseAction.caFree;
  FormClienteE := nil;
end;

procedure TFormClienteE.FormShow(Sender: TObject);
begin
  //TNavigation.ParamInt valor do pessoa_id
  if TNavigation.ParamInt > 0 then
  begin

    lblTitulo.Caption := 'Editar';

    TLoading.Show;
    TLoading.ExecuteThread(procedure
    begin
       sleep(1000);
       DmPessoa.ListarPessoaID(MemTable, TNavigation.ParamInt);
    end,
    TerminateClienteE
    );

  end;

end;

procedure TFormClienteE.TerminateClienteE(Sender: TObject);
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
  edtTelefone.Text := MemTable.FieldByName('telefone').AsString;
  edtsetor.Text := MemTable.FieldByName('setor').AsString;

end;


procedure TFormClienteE.btnCancelarClick(Sender: TObject);
begin
  {aqui o TNavigation vai enteder que aqui é uma tela modal e
  fechará tanto essa tela como a tela sombreada}
  TNavigation.CloseAndCancel(Self);
end;

end.
