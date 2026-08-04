unit UnitFormUsuarioE;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UnitFormBaseEdicao, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.Buttons, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.DBCtrls;

type
  TFormUsuarioE = class(TFormBaseEdicao)
    Label4: TLabel;
    Label2: TLabel;
    Label6: TLabel;
    edtLogin: TEdit;
    edtSenha: TEdit;
    cbAtivo: TCheckBox;
    dsColaboradores: TDataSource;
    cbxColaboradores: TDBLookupComboBox;
    procedure FormShow(Sender: TObject);
  private
    procedure ListarColaboradores;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormUsuarioE: TFormUsuarioE;

implementation

{$R *.dfm}

uses DataModule.Usuario;

procedure TFormUsuarioE.FormShow(Sender: TObject);
begin
  inherited;
  ListarColaboradores;
end;


procedure TFormUsuarioE.ListarColaboradores;
begin
  dmUsuario.ListarColaboradores;
end;

end.
