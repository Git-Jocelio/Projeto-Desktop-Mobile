unit UnitFormPerfilEdicao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UnitFormBaseEdicao, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.Buttons, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Navigation, Vcl.Loading;

type
  TFormPerfilEdicao = class(TFormBaseEdicao)
    Label2: TLabel;
    edtDescricao: TEdit;
    Label1: TLabel;
    edtObs: TEdit;
    procedure FormShow(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
  private
    Foperacao: string;
    procedure TerminatePerfilE(Sender: TObject);
    function Validar: boolean;
    procedure TerminateSalvar(Sender: TObject);
  public
    property operacao :string read Foperacao write Foperacao;
  end;

var
  FormPerfilEdicao: TFormPerfilEdicao;

implementation

{$R *.dfm}

uses DataModule.Perfil, Service.Perfil;

procedure TFormPerfilEdicao.TerminatePerfilE(Sender: TObject);
begin
  TLoading.Hide;
  if (Sender is TThread) then
    if Assigned(TThread(Sender).FatalException) then
    begin
      ShowMessage( Exception(TThread(Sender).FatalException).Message );
      exit;
    end;

  // carrega os edits
  edtDescricao.Text := DmPerfil.MemTable.FieldByName('DESCRICAO').AsString;
  edtObs.Text := DmPerfil.MemTable.FieldByName('OBS').AsString;

end;

function TFormPerfilEdicao.Validar: boolean;
begin
  result := false;

  if edtDescricao.Text = '' then
  begin
    ShowMessage('Informe uma descrição.');
    edtDescricao.SetFocus;
    exit;
  end;

  if edtObs.Text = '' then
  begin
    ShowMessage('Descreva o perfil.');
    edtObs.SetFocus;
    exit;
  end;


  result := true;
end;

procedure TFormPerfilEdicao.TerminateSalvar(Sender: TObject);
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



procedure TFormPerfilEdicao.btnSalvarClick(Sender: TObject);
begin
  inherited;
  TLoading.Show;
  TLoading.ExecuteThread(
      procedure
      begin
        sleep(500);

        if operacao = 'opIncluir' then
          TServicePerfil.InserirPerfil(edtDescricao.Text, edtObs.Text)
        else if operacao = 'opAlterar' then
          TServicePerfil.AlterarPerfil(edtDescricao.Text, edtObs.Text,
                                        DmPerfil.MemTable.FieldByName('id_perfil').AsInteger )
      end,
      TerminateSalvar
      );
end;

procedure TFormPerfilEdicao.FormShow(Sender: TObject);
begin
  inherited;

  if TNavigation.ParamInt > 0 then
  begin
    Operacao := 'opAlterar';
    lblTitulo.Caption := lblTitulo.Caption + ' - Editar';

    TLoading.Show;
    TLoading.ExecuteThread(procedure
    begin
       sleep(500);
       dmPerfil.ListarId(MemTable, TNavigation.ParamInt);
    end,
    TerminatePerfilE
    );
  end
  else
    Operacao := 'opIncluir';

end;

end.
