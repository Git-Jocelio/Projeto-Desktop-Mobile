unit UnitFormClienteE;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  Vcl.Navigation;

type
  TFormClienteE = class(TForm)
    Label1: TLabel;
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
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCancelarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormClienteE: TFormClienteE;

implementation

{$R *.dfm}

procedure TFormClienteE.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action := TCloseAction.caFree;
  FormClienteE := nil;
end;

procedure TFormClienteE.btnCancelarClick(Sender: TObject);
begin
  {aqui o TNavigation vai enteder que aqui é uma tela modal e
  fechará tanto essa tela como a tela sombreada}
  TNavigation.Close(Self);
end;

end.
