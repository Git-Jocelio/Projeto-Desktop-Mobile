unit UnitFormMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, UnitMenuManager;

type
  TFormMain = class(TForm)
    pnlMain: TPanel;
    pnlHeader: TPanel;
    pnlRodape: TPanel;
    pnlMenu: TPanel;
    pnlContainer: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FMenuManager : TMenuManager;
  public
    { Public declarations }
  end;

var
  FormMain: TFormMain;

implementation



{$R *.dfm}

uses Vcl.Session;



procedure TFormMain.FormCreate(Sender: TObject);
begin
  FMenuManager := TMenuManager.Create(pnlMenu);
end;

procedure TFormMain.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FMenuManager);
end;

end.
