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
    BtnAcessar: TSpeedButton;
    Panel2: TPanel;
    SpeedButton1: TSpeedButton;
    Panel3: TPanel;
    SpeedButton2: TSpeedButton;
    Panel1: TPanel;
    Panel4: TPanel;
    btnFiltrar: TSpeedButton;
    edtFiltrar: TEdit;
    DBGrid: TDBGrid;
    dsPessoa: TDataSource;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SpeedButton1Click(Sender: TObject);
    procedure btnFiltrarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    procedure OpenCadCliente(id_cliente: integer);
    procedure RefreshPessoa;
    procedure TerminateBusca(Sender: TObject);
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

procedure TFormCliente.OpenCadCliente(id_cliente: integer);
begin
  TNavigation.OpenModal(TFormClienteE, FormClienteE);
end;

procedure TFormCliente.SpeedButton1Click(Sender: TObject);
begin
  OpenCadCliente(0);
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
  TLoading.Show(self);

  TLoading.ExecuteThread(procedure
  begin
    sleep(1500);
    dsPessoa.DataSet := nil;
    dmPessoa.ListarPessoa(dmPessoa.tabPessoa, edtFiltrar.text);
  end,
  TerminateBusca
  );
end;



end.
