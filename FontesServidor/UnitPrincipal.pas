unit UnitPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.pngimage,
  Vcl.WinXCtrls, Vcl.ExtCtrls;

type
  TFormPrincipal = class(TForm)
    lblServidor: TLabel;
    Image1: TImage;
    Switch: TToggleSwitch;
    lblSwith: TLabel;
    procedure FormShow(Sender: TObject);
    procedure SwitchClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormPrincipal: TFormPrincipal;

implementation

uses
  Servidor.Startup;

{$R *.dfm}

procedure TFormPrincipal.FormShow(Sender: TObject);
begin
  ConfigurarServidor;
  IniciarServidor(3000);

  lblServidor.Caption := 'Servidor Compras respondendo na PORTA : ' + PortaServidor.ToString;
  Switch.State := tssOn;
  lblSwith.Caption := 'Servidor Ativo';

end;

procedure TFormPrincipal.SwitchClick(Sender: TObject);
begin
  if Switch.State = tssOn then
  begin
    ConfigurarServidor;
    IniciarServidor(3000);
    lblServidor.Caption := 'Servidor Horse respondendo na PORTA : ' + PortaServidor.ToString;
  end
  else
  begin
    PararServidor;
    lblServidor.Caption := 'Servidor Desativado';
  end;
end;

end.
