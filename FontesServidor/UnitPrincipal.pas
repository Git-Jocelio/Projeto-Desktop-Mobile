unit UnitPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls, Vcl.WinXCtrls,

  Horse,
  Horse.Jhonson,
  Horse.CORS,
//  DataModule.Pessoa,
  Controllers.Cliente,
  Controllers.Usuario,
  Controllers.Produto,
  Controllers.Fornecedor;

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

{$R *.dfm}



procedure TFormPrincipal.FormShow(Sender: TObject);
begin
   THorse.use(Jhonson());
   THorse.use(CORS);
   // verifica a rota chamada e da andamento a requisição
   Controllers.Cliente.RegistrarRotas;
   Controllers.Usuario.RegistrarRotas;
   Controllers.Produto.RegistrarRotas;
   controllers.Fornecedor.RegistrarRotas;

   THorse.Listen(3000);
   lblServidor.caption := 'Servidor Horse respondendo na PORTA : ' + THorse.Port.toString;

end;

procedure TFormPrincipal.SwitchClick(Sender: TObject);
begin
   if Switch.State = tssOn then
   begin
     THorse.Listen(3000);
     lblServidor.caption := 'Servidor Horse respondendo na PORTA : ' + THorse.Port.toString;
   end
   else
   if Switch.State = tssOff then
   begin
     THorse.StopListen;
     lblServidor.caption := 'Servidor desativado';
   end;

end;

end.
