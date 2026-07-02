unit UnitPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.pngimage,
  Vcl.WinXCtrls, Vcl.ExtCtrls;

//  DataModule.Pessoa,

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

uses

  Horse,
  Horse.Jhonson,
  Horse.CORS,
  Dataset.Serialize.Config,
  DataModule.Pessoa,
  Controllers.Cliente,
  Controllers.Usuario,
  Controllers.Produto,
  Controllers.Fornecedor;


procedure TFormPrincipal.FormShow(Sender: TObject);
begin
   THorse.use(Jhonson());
   THorse.use(CORS);

   TDataSetSerializeConfig.GetInstance.CaseNameDefinition := cndLower;
   TDataSetSerializeConfig.GetInstance.Import.DecimalSeparator := '.';

   // registrar as rotas
   Controllers.Cliente.RegistrarRotas;
   Controllers.Usuario.RegistrarRotas;
   Controllers.Produto.RegistrarRotas;
   controllers.Fornecedor.RegistrarRotas;

   THorse.Listen(3000);

   lblServidor.caption := 'Servidor Compras respondendo na PORTA : ' + THorse.Port.toString;

   Switch.State := tssOn;
   lblSwith.Caption := 'Servidor Ativo';

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
     lblServidor.caption := 'Servidor Desativado';
   end;

end;

end.
