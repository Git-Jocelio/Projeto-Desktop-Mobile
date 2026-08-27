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
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    procedure OpenCadUsuarioPerfil(pessoaId: integer);
    procedure RefreshCadUsuarioPerfil;
    procedure TerminateBusca(Sender: TObject);
    procedure ListarTodos;
    procedure TerminateListartodos(Sender: TObject);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormUsuarioPerfil: TFormUsuarioPerfil;

implementation

{$R *.dfm}

uses UnitFormUsuarioPerfilE, DataModule.Usuario;

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
  OpenCadUsuarioPerfil(dmUsuario.MemTable.FieldByName('USUARIOID').AsInteger);
end;

procedure TFormUsuarioPerfil.FormCreate(Sender: TObject);
begin
  inherited;
  dmUsuario := TdmUsuario.Create(Self);
end;

procedure TFormUsuarioPerfil.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(dmUsuario);
end;

procedure TFormUsuarioPerfil.FormShow(Sender: TObject);
begin
  inherited;
  ListarTodos;
end;

procedure TFormUsuarioPerfil.OpenCadUsuarioPerfil(pessoaid: integer);
begin
  TNavigation.ExecuteOnClose := RefreshCadUsuarioPerfil;
  TNavigation.ParamInt := pessoaid;
  TNavigation.OpenModal(TFormUsuarioPerfilE, FormUsuarioPerfilE);
end;

procedure TFormUsuarioPerfil.TerminateListartodos(Sender: TObject);
begin
  TLoading.Hide;
  ds.DataSet := DmUsuario.MemTable;
end;


procedure TFormUsuarioPerfil.ListarTodos;
begin
  TLoading.Show;
  ds.DataSet := nil;
  TLoading.ExecuteThread(procedure
  begin
     sleep(1000);
     DmUsuario.ListarTodos;
  end,
  TerminateListartodos
  );
end;


end.
