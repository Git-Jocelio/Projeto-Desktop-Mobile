unit UnitFormUsuarioPerfilE;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UnitFormBaseEdicao, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.Buttons, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Grids,
  Vcl.DBGrids, FireDAC.Stan.StorageBin,
  Vcl.Navigation, Vcl.Loading;

type
  TFormUsuarioPerfilE = class(TFormBaseEdicao)
    Label1: TLabel;
    Label2: TLabel;
    edtUsuarioId: TEdit;
    Label3: TLabel;
    edtNome: TEdit;
    Label7: TLabel;
    edtLogin: TEdit;
    Label6: TLabel;
    edtEmail: TEdit;
    Panel2: TPanel;
    DBGrid1: TDBGrid;
    Label5: TLabel;
    ds: TDataSource;
    Label4: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
  private
    procedure LerDados;
    procedure TerminateLerDados(Sender: TObject);
    procedure TerminateSalvar(Sender: TObject);
  public
    { Public declarations }
  end;

var
  FormUsuarioPerfilE: TFormUsuarioPerfilE;

implementation

{$R *.dfm}

uses DataModule.UsuarioPerfil;

procedure TFormUsuarioPerfilE.TerminateSalvar(Sender: TObject);
begin
  TLoading.Hide;

  if (Sender is TThread) then
    if Assigned(TThread(Sender).FatalException) then
    begin
      ShowMessage( Exception(TThread(Sender).FatalException).Message );
      exit;
    end;
  //TNavigation.Close(self);
  TNavigation.CloseAndCancel(Self);
end;


procedure TFormUsuarioPerfilE.btnSalvarClick(Sender: TObject);
begin
  inherited;
  TLoading.Show;
  TLoading.ExecuteThread(
  procedure
  begin
    sleep(500);
    DmUsuarioPerfil.VincularPerfis(MemTable, strtoint(edtUsuarioId.Text));
  end,
  TerminateSalvar
  );

end;

procedure TFormUsuarioPerfilE.DBGrid1CellClick(Column: TColumn);
begin

  if SameText(Column.FieldName, 'VINCULADO') then
  begin
    MemTable.Edit;

    if MemTable.FieldByName('VINCULADO').AsString = 'S' then
      MemTable.FieldByName('VINCULADO').AsString := 'N'
    else
      MemTable.FieldByName('VINCULADO').AsString := 'S';

    MemTable.Post;

    DBGrid1.Invalidate;
  end;

end;

procedure TFormUsuarioPerfilE.DBGrid1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  R: TRect;
  Flags: UINT;
begin
  if SameText(Column.FieldName, 'VINCULADO') then
  begin
    DBGrid1.Canvas.FillRect(Rect);

    R.Left := Rect.Left + ((Rect.Width - 13) div 2);
    R.Top := Rect.Top + ((Rect.Height - 13) div 2);
    R.Right := R.Left + 13;
    R.Bottom := R.Top + 13;

    Flags := DFCS_BUTTONCHECK;

    if Column.Field.AsString = 'S' then
      Flags := Flags or DFCS_CHECKED;

    DrawFrameControl(
      DBGrid1.Canvas.Handle,
      R,
      DFC_BUTTON,
      Flags
    );
  end
  else
    DBGrid1.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TFormUsuarioPerfilE.FormCreate(Sender: TObject);
begin
  inherited;
  DmUsuarioPerfil := TDmUsuarioPerfil.Create(self)
end;

procedure TFormUsuarioPerfilE.FormDestroy(Sender: TObject);
begin
  inherited;
  DmUsuarioPerfil.Free;
end;

procedure TFormUsuarioPerfilE.FormShow(Sender: TObject);
begin
  inherited;
  LerDados;
end;

procedure TFormUsuarioPerfilE.TerminateLerDados(Sender: TObject);
begin
  TLoading.Hide;

  if (Sender is TThread) then
    if Assigned(TThread(Sender).FatalException) then
    begin
      ShowMessage( Exception(TThread(Sender).FatalException).Message );
      exit;
    end;


  ds.DataSet := MemTable;


  if memtable.RecordCount > 0 then
  begin
    edtUsuarioId.Text := MemTable.FieldByName('usuarioid').asstring;
    edtNome.Text := MemTable.FieldByName('nome').asstring;
    edtLogin.Text := MemTable.FieldByName('login').asstring;
    edtEmail.Text := MemTable.FieldByName('email').asstring;
  end
  else
    ShowMessage('Erro ao carregar perfis do usuário.');
end;


procedure TFormUsuarioPerfilE.LerDados;
begin
  TLoading.Show;
  ds.DataSet := nil;
  TLoading.ExecuteThread(procedure
  begin
    sleep(500);
    DmUsuarioPerfil.ListarId(MemTable, TNavigation.ParamInt);
  end,
  TerminateLerDados
  );
end;

end.
