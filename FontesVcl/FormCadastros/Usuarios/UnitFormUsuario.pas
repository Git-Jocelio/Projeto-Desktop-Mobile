unit UnitFormUsuario;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UnitFormBaseGrade, Data.DB,
  System.ImageList, Vcl.ImgList, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ExtCtrls;

type
  TFormUsuario = class(TFormBaseGrade)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    procedure Listartodos;
    procedure TerminateListartodos;
  public
    { Public declarations }
  end;

var
  FormUsuario: TFormUsuario;

implementation

{$R *.dfm}

uses DataModule.Usuario, Vcl.Loading;


procedure TFormUsuario.TerminateListartodos;
begin
  TLoading.Hide;
  ds.DataSet := DmUsuario.MemTable;
end;


procedure TFormUsuario.ListarTodos;
begin
  TLoading.Show;

  try
    ds.DataSet := nil;
    DmUsuario.ListarTodos;
    ds.DataSet := DmUsuario.MemTable;
    if ds.DataSet.IsEmpty then
      ShowMessage('Nenhum registro encontrado!')
  finally
     TerminateListartodos;
  end;

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

procedure TFormUsuario.FormShow(Sender: TObject);
begin
  inherited;
  ListarTodos;

end;

end.
