unit DataModule.Produto;

interface

uses
  System.SysUtils, System.Classes;

type
  TDmProduto = class(TDataModule)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DmProduto: TDmProduto;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
