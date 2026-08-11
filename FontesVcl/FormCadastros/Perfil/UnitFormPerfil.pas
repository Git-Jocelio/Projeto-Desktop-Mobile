unit UnitFormPerfil;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UnitFormBaseGrade, Data.DB,
  System.ImageList, Vcl.ImgList, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ExtCtrls, DataModule.Perfil, Vcl.Loading;

type
  TFormPerfil = class(TFormBaseGrade)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    procedure ListarTodos;
    procedure TerminateListartodos(Sender: TObject);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormPerfil: TFormPerfil;

implementation

{$R *.dfm}

procedure TFormPerfil.FormCreate(Sender: TObject);
begin
  inherited;
  DmPerfil := TDmPerfil.Create(Self);
end;

procedure TFormPerfil.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(DmPerfil);
end;

procedure TFormPerfil.FormShow(Sender: TObject);
begin
  inherited;
  ListarTodos;
end;

procedure TFormPerfil.TerminateListartodos(Sender: TObject);
begin
  TLoading.Hide;
  ds.DataSet := DmPerfil.MemTable;
end;

procedure TFormPerfil.ListarTodos;
begin
  TLoading.Show;
  ds.DataSet := nil;
  TLoading.ExecuteThread(procedure
  begin
     sleep(500);
     DmPerfil.ListarTodos;
  end,
  TerminateListartodos
  );
end;

end.
