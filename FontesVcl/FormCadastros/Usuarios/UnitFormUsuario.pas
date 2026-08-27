unit UnitFormUsuario;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UnitFormBaseGrade, Data.DB,
  System.ImageList, Vcl.ImgList, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ExtCtrls, Vcl.Navigation;

type
  TFormUsuario = class(TFormBaseGrade)
    procedure btnInserirClick(Sender: TObject);
    procedure dbgDblClick(Sender: TObject);

    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    procedure Listartodos;
    procedure TerminateListartodos(Sender: TObject);
    procedure OpenCadUsuario(pessoaId: integer);
    procedure Editar;
  public
    { Public declarations }
  end;

var
  FormUsuario: TFormUsuario;

implementation

{$R *.dfm}

uses DataModule.Usuario, Vcl.Loading, UnitFormUsuarioE;

procedure TFormUsuario.TerminateListartodos(Sender: TObject);
begin
  TLoading.Hide;
  ds.DataSet := DmUsuario.MemTable;
end;

procedure TFormUsuario.ListarTodos;
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

procedure TFormUsuario.FormShow(Sender: TObject);
begin
  inherited;
  ListarTodos;
end;


procedure TFormUsuario.btnInserirClick(Sender: TObject);
begin
  inherited;
  OpenCadUsuario(0);
end;

procedure TFormUsuario.FormCreate(Sender: TObject);
begin
  inherited;
  dmUsuario := TdmUsuario.Create(Self);
end;

procedure TFormUsuario.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(dmUsuario);
end;


procedure TFormUsuario.OpenCadUsuario(pessoaId: integer);
begin
  TNavigation.ExecuteOnClose := ListarTodos;
  TNavigation.ParamInt := pessoaId;
  TNavigation.OpenModal(TFormUsuarioE, FormUsuarioE);
end;

procedure TFormUsuario.dbgDblClick(Sender: TObject);
begin
  inherited;
  Editar;
end;

procedure TFormUsuario.Editar;
begin
  if dmUsuario.MemTable.IsEmpty then
    exit;

    bookMark := dbg.DataSource.DataSet.GetBookmark;
    OpenCadUsuario(dmUsuario.MemTable.FieldByName('pessoaid').AsInteger);
end;

end.
