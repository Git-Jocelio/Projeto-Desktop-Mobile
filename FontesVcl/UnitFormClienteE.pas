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
    Edit1: TEdit;
    Panel2: TPanel;
    SpeedButton1: TSpeedButton;
    Panel1: TPanel;
    SpeedButton2: TSpeedButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SpeedButton2Click(Sender: TObject);
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

procedure TFormClienteE.SpeedButton2Click(Sender: TObject);
begin
  {aqui o TNavigation vai enteder que aqui é uma tela modal e
  fechará tanto essa tela como a tela sombreada}
  TNavigation.Close(Self);
end;

end.
