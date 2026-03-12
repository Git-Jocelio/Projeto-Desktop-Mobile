unit UnitFormProduto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UnitFormBaseGrade, Data.DB,
  System.ImageList, Vcl.ImgList, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ExtCtrls;

type
  TFormProduto = class(TFormBaseGrade)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormProduto: TFormProduto;

implementation

{$R *.dfm}

uses DataModule.Produto;

procedure TFormProduto.FormCreate(Sender: TObject);
begin
  inherited;
   DmProduto := TDmProduto.Create(self)
end;

end.
