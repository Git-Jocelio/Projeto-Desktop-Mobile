unit UnitPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls,
  DataModule.Global,
  Controllers.Cliente;

type
  TFormPrincipal = class(TForm)
    lblServidor: TLabel;
    Image1: TImage;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormPrincipal: TFormPrincipal;

implementation

{$R *.dfm}

uses
  Horse,
  Horse.Jhonson,
  Horse.CORS;

procedure TFormPrincipal.FormShow(Sender: TObject);
begin
   THorse.use(Jhonson());
   THorse.use(CORS);

   // verifica a rota chamada e da andamento a requisição
   Controllers.Cliente.RegistrarRotas;

   THorse.Listen(3000);
   lblServidor.caption := 'Servidor Horse respondendo na porta : ' + THorse.Port.toString;
end;

end.
