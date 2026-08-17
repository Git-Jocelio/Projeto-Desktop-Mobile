unit UnitFormTelaE;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UnitFormBaseEdicao, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.Buttons, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Loading,
  Vcl.Navigation,
  Service.Tela, system.StrUtils;

type
  TFormTelasE = class(TFormBaseEdicao)
    Label2: TLabel;
    Label3: TLabel;
    Label6: TLabel;
    edtNomeTela: TEdit;
    edtOrdem: TEdit;
    cbAtivo: TCheckBox;
    cbxModulo: TComboBox;
    procedure btnSalvarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    procedure TerminateSalvar(Sender: TObject);
    procedure TerminateTelaE(Sender: TObject);
  public
    { Public declarations }
  end;

var
  FormTelasE: TFormTelasE;

implementation

{$R *.dfm}

uses DataModule.Tela;

procedure TFormTelasE.TerminateTelaE(Sender: TObject);
begin
  TLoading.Hide;

  if (Sender is TThread) then
    if Assigned(TThread(Sender).FatalException) then
    begin
      ShowMessage( Exception(TThread(Sender).FatalException).Message );
      exit;
    end;

  // se não der erro, carrega dos edits
  edtNomeTela.Text := MemTable.FieldByName('nome_tela').AsString;
  cbxModulo.Text := MemTable.FieldByName('modulo').AsString;
  edtOrdem.Text := MemTable.FieldByName('ordem').AsString;
  cbAtivo.Checked := MemTable.FieldByName('ativo').AsString = 'S';
end;

procedure TFormTelasE.FormShow(Sender: TObject);
begin
  inherited;
  if TNavigation.ParamInt > 0 then
  begin
    lblTitulo.Caption := 'Cadastro de telas - Editar';

    TLoading.Show;
    TLoading.ExecuteThread(procedure
    begin
       sleep(500);
       DmTela.ListarId(MemTable, TNavigation.ParamInt);
    end,
    TerminateTelaE
    );
  end;

end;

procedure TFormTelasE.TerminateSalvar(Sender: TObject);
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


procedure TFormTelasE.btnSalvarClick(Sender: TObject);
begin
  inherited;

  TLoading.Show;
  TLoading.ExecuteThread(
  procedure
  begin
      sleep(500);
      TServiceTela.Salvar(
                           TNavigation.ParamInt,
                           strtoint(edtOrdem.Text),
                           edtNomeTela.Text,
                           cbxModulo.Text,
                           IfThen(cbAtivo.checked, 'S','N')
                           );
  end,
  TerminateSalvar
  );
end;


end.
