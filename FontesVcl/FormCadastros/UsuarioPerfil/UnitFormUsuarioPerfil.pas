unit UnitFormUsuarioPerfil;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UnitFormBaseGrade, Data.DB,
  System.ImageList, Vcl.ImgList, Vcl.Grids, Vcl.DBGrids, Vcl.Buttons,
  Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Navigation,
  Vcl.Loading, DataModule.UsuarioPerfil;

type
  TFormUsuarioPerfil = class(TFormBaseGrade)
    procedure btnInserirClick(Sender: TObject);
  private
    procedure OpenCadUsuarioPerfil(pessoaId: integer);
    procedure RefreshCadUsuarioPerfil;
    procedure TerminateBusca(Sender: TObject);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormUsuarioPerfil: TFormUsuarioPerfil;

implementation

{$R *.dfm}

uses UnitFormUsuarioPerfilE;

procedure TFormUsuarioPerfil.TerminateBusca(Sender: TObject);
begin
  TLoading.Hide;
  ds.DataSet := DmUsuarioPerfil.MemTable;
end;


procedure TFormUsuarioPerfil.RefreshCadUsuarioPerfil;
begin
  TLoading.Show;
  ds.DataSet := nil;
  TLoading.ExecuteThread(procedure
  begin
    sleep(500);
    DmUsuarioPerfil.Listar(DmUsuarioPerfil.memTable, UpperCase(edtFiltrar.Text));
  end,
  TerminateBusca
  );
end;


procedure TFormUsuarioPerfil.btnInserirClick(Sender: TObject);
begin
  inherited;
  OpenCadUsuarioPerfil(0)
end;

procedure TFormUsuarioPerfil.OpenCadUsuarioPerfil(pessoaid: integer);
begin
  TNavigation.ExecuteOnClose := RefreshCadUsuarioPerfil;
  TNavigation.ParamInt := pessoaid;
  TNavigation.OpenModal(TFormUsuarioPerfilE, FormUsuarioPerfilE);
end;

end.
