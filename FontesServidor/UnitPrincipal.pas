unit UnitPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls;


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
  Horse.CORS,
  Dataset.Serialize.Config,
  DataModule.Pessoa,
  Controllers.Cliente,
  Controllers.Usuario;


procedure TFormPrincipal.FormShow(Sender: TObject);
begin
   THorse.use(Jhonson());
   THorse.use(CORS);

   TDataSetSerializeConfig.GetInstance.CaseNameDefinition := cndLower;
   TDataSetSerializeConfig.GetInstance.Import.DecimalSeparator := '.';

   // registrar as rotas
   Controllers.Cliente.RegistrarRotas;
   Controllers.Usuario.RegistrarRotas;

   THorse.Listen(3000);
   lblServidor.caption := 'Servidor Horse respondendo na PORTA : ' + THorse.Port.toString;
end;

end.
