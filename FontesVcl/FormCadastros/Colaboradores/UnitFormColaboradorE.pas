unit UnitFormColaboradorE;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UnitFormBaseEdicao, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.Buttons, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Navigation,
  Vcl.Loading, DataModule.Colaborador, Service.Colaborador;

type
  TFormColaboradorE = class(TFormBaseEdicao)
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    edtNome: TEdit;
    edtTelefone: TEdit;
    edtEmail: TEdit;
    cbxSetor: TComboBox;
    procedure FormShow(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
  private
    procedure TerminateColaboradorE(Sender: TObject);
    procedure TerminateSalvar(Sender: TObject);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormColaboradorE: TFormColaboradorE;

implementation

{$R *.dfm}


procedure TFormColaboradorE.TerminateColaboradorE(Sender: TObject);
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
  cbxSetor.ItemIndex := MemTable.FieldByName('setorid').AsInteger -1;

end;

procedure TFormColaboradorE.TerminateSalvar(Sender: TObject);
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


procedure TFormColaboradorE.btnSalvarClick(Sender: TObject);
begin
    TLoading.Show;

    TLoading.ExecuteThread(
    procedure
    begin
        sleep(500);
        TServiceColaborador.Salvar(
                               TNavigation.ParamInt,
                               edtNome.Text,
                               edtEmail.Text,
                               edtTelefone.Text,
                               cbxSetor.ItemIndex +1
                             );
    end,
    TerminateSalvar
    );
end;

procedure TFormColaboradorE.FormShow(Sender: TObject);
begin
  if TNavigation.ParamInt > 0 then
  begin

    lblTitulo.Caption := 'Editar';

    TLoading.Show;
    TLoading.ExecuteThread(procedure
    begin
       sleep(500);
       DmColaborador.ListarId(MemTable, TNavigation.ParamInt);
    end,
    TerminateColaboradorE
    );
  end;
end;

end.
