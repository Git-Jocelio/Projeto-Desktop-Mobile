unit UnitFormBaseEdicao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.Buttons, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Navigation;
type
  TFormBaseEdicao = class(TForm)
    lblTitulo: TLabel;
    Panel2: TPanel;
    btnSalvar: TSpeedButton;
    Panel1: TPanel;
    btnCancelar: TSpeedButton;
    MemTable: TFDMemTable;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCancelarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormBaseEdicao: TFormBaseEdicao;

implementation

{$R *.dfm}



procedure TFormBaseEdicao.btnCancelarClick(Sender: TObject);
begin
  {aqui o TNavigation vai enteder que aqui é uma tela modal e
  fechará tanto essa tela como a tela sombreada}
  TNavigation.CloseAndCancel(Self);
end;

procedure TFormBaseEdicao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action := TCloseAction.caFree;
  //FormBaseEdicao := nil;
  Self := nil;
end;

end.
