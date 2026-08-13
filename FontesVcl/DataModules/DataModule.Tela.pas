unit DataModule.Tela;

interface

uses
  System.SysUtils, System.Classes,
    DataSet.Serialize.Config, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TDm = class(TDataModule)
    memTable: TFDMemTable;
    procedure DataModuleCreate(Sender: TObject);
  private
  public
    procedure Listar(memTable: TFDMemTable; filtro: string);
    procedure ListarId(memTable: TFDMemTable; id_tela: integer);
    procedure Inserir(nome_tela, modulo, ativo:string; ordem: integer);
    procedure Editar(id_tela, ordem: integer; nome_tela, modulo, ativo:string);
    procedure Excluir(id_tela: integer);
  end;

var
  Dm: TDm;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDm.DataModuleCreate(Sender: TObject);
begin
  TDataSetSerializeConfig.GetInstance.CaseNameDefinition := cndLower;
  TDataSetSerializeConfig.GetInstance.Import.DecimalSeparator := '.';
end;

procedure TDm.Editar(id_tela, ordem: integer; nome_tela, modulo, ativo: string);
begin

end;

procedure TDm.Excluir(id_tela: integer);
begin

end;

procedure TDm.Inserir(nome_tela, modulo, ativo: string; ordem: integer);
begin

end;

procedure TDm.Listar(memTable: TFDMemTable; filtro: string);
begin

end;

procedure TDm.ListarId(memTable: TFDMemTable; id_tela: integer);
begin

end;

end.
