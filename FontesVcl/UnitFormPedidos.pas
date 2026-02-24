unit UnitFormPedidos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons,
  Data.DB, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids;

type
  TFormPedidos = class(TForm)
    PnlHeader: TPanel;
    Label1: TLabel;
    PnlBotaoInserir: TPanel;
    BtnAcessar: TSpeedButton;
    Panel2: TPanel;
    SpeedButton1: TSpeedButton;
    Panel3: TPanel;
    SpeedButton2: TSpeedButton;
    DBGrid: TDBGrid;
    FDMemTable: TFDMemTable;
    DataSource: TDataSource;
    FDMemTablePedido: TIntegerField;
    FDMemTableClientes: TStringField;
    FDMemTableEndereco: TStringField;
    FDMemTableValor: TFloatField;
    Panel1: TPanel;
    Panel4: TPanel;
    SpeedButton3: TSpeedButton;
    EditFiltar: TEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormPedidos: TFormPedidos;

implementation

{$R *.dfm}

procedure TFormPedidos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action := TCloseAction.caFree;
  FormPedidos := nil;
end;

end.
