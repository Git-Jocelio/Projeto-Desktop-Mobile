unit UnitFormColaboradorE;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UnitFormBaseEdicao, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.Buttons, Vcl.ExtCtrls, Vcl.StdCtrls;

type
  TFormColaboradorE = class(TFormBaseEdicao)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormColaboradorE: TFormColaboradorE;

implementation

{$R *.dfm}

end.
