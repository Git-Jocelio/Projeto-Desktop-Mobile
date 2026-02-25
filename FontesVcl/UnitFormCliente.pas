unit UnitFormCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.Navigation, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, DataModele.Pessoa,
  Vcl.Loading; // unit que carrega um loandin na tela

type
  TFormCliente = class(TForm)
    PnlHeader: TPanel;
    Label1: TLabel;
    PnlBotaoInserir: TPanel;
    BtnExcluir: TSpeedButton;
    Panel2: TPanel;
    btnInserir: TSpeedButton;
    Panel3: TPanel;
    BtnEditar: TSpeedButton;
    Panel1: TPanel;
    Panel4: TPanel;
    btnFiltrar: TSpeedButton;
    edtFiltrar: TEdit;
    DBGrid: TDBGrid;
    dsPessoa: TDataSource;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnInserirClick(Sender: TObject);
    procedure btnFiltrarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnEditarClick(Sender: TObject);
    procedure BtnExcluirClick(Sender: TObject);
  private
    procedure OpenCadCliente(pessoa_id: integer);
    procedure RefreshPessoa;
    procedure TerminateBusca(Sender: TObject);
    procedure Editar;
    procedure TerminateExcluir(Sender: TObject);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormCliente: TFormCliente;

implementation

{$R *.dfm}

uses UnitFormClienteE;

procedure TFormCliente.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action := TCloseAction.caFree;
  FormCliente := nil;

end;


procedure TFormCliente.FormShow(Sender: TObject);
begin
  RefreshPessoa;
end;

procedure TFormCliente.OpenCadCliente(pessoa_id: integer);
begin
  TNavigation.ParamInt := pessoa_id;
  TNavigation.OpenModal(TFormClienteE, FormClienteE);
end;

procedure TFormCliente.btnInserirClick(Sender: TObject);
begin
  OpenCadCliente(0);
end;

procedure TFormCliente.Editar;
begin
  if DmPessoa.tabPessoa.IsEmpty then
    exit;

   OpenCadCliente(DmPessoa.tabPessoa.FieldByName('pessoa_id').AsInteger);

end;


procedure TFormCliente.BtnEditarClick(Sender: TObject);
begin
  Editar;
end;

procedure TFormCliente.BtnExcluirClick(Sender: TObject);
begin
  if DmPessoa.tabPessoa.IsEmpty then
    exit;
 if MessageDlg('Deseja realmente excluir este registro?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
 begin

   TLoading.Show;
   TLoading.ExecuteThread(procedure
   begin
      DmPessoa.Excluir(DmPessoa.tabPessoa.FieldByName('pessoa_id').AsInteger);
   end,
   TerminateExcluir
   );
 end;

end;

procedure TFormCliente.TerminateExcluir(Sender: TObject);
begin

  TLoading.Hide;

  if (Sender is TThread) then
    if Assigned(TThread(Sender).FatalException) then
    begin
      ShowMessage( Exception(TThread(Sender).FatalException).Message );
      exit;
    end;

  RefreshPessoa;

end;


procedure TFormCliente.btnFiltrarClick(Sender: TObject);
begin
  RefreshPessoa;
end;

procedure TFormCliente.TerminateBusca(Sender: TObject);
begin

  TLoading.Hide;
  dsPessoa.DataSet := DmPessoa.tabPessoa;

   if (Sender is TThread) then
     if Assigned(TThread(Sender).FatalException) then
     begin
       ShowMessage( Exception(TThread(Sender).FatalException).Message );
       exit;
     end;

end;


procedure TFormCliente.RefreshPessoa;
begin
  TLoading.Show;

  TLoading.ExecuteThread(procedure
  begin
    sleep(1000);
    dsPessoa.DataSet := nil; // Evita erro ao redenrizar a tela
    dmPessoa.ListarPessoa( dmPessoa.tabPessoa, edtFiltrar.text );
  end,
  TerminateBusca
  );

end;



end.
