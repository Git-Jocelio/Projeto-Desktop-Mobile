unit UnitFormTela;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UnitFormBaseGrade, Data.DB,
  System.ImageList, Vcl.ImgList, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ExtCtrls;

type
  TFormTela = class(TFormBaseGrade)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnFiltrarClick(Sender: TObject);
  private
    procedure RefreshTela;
    procedure TerminateBusca(Sender: TObject);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormTela: TFormTela;

implementation

uses
  DataModule.Tela, Vcl.Loading;


{$R *.dfm}


procedure TFormTela.btnFiltrarClick(Sender: TObject);
begin
  inherited;
  RefreshTela
end;

procedure TFormTela.FormCreate(Sender: TObject);
begin
  inherited;
  Dm := TDm.Create(self)
end;

procedure TFormTela.FormDestroy(Sender: TObject);
begin
  inherited;
  DM.Free;
end;

procedure TFormTela.TerminateBusca(Sender: TObject);
begin
  TLoading.Hide;
  ds.DataSet := Dm.MemTable;
end;

procedure TFormTela.RefreshTela;
begin

(*
  TLoading.Show;

  try
    ds.DataSet := nil;
    sleep(500);
    Dm.Listar(Dm.memTable, UpperCase(edtFiltrar.Text));
  finally
   TerminateBusca;
  end;
*)
 //
  TLoading.Show;
  ds.DataSet := nil;
  TLoading.ExecuteThread(procedure
  begin
    sleep(500);
    Dm.Listar(Dm.memTable, UpperCase(edtFiltrar.Text));
  end,
  TerminateBusca
  );
 //



end;


end.
