unit UnitMenuManager;

interface

uses
  System.Generics.Collections,
  system.Generics.Defaults,
  Vcl.Controls,
  Vcl.ExtCtrls,
  Vcl.Session,
  System.SysUtils,
  System.Classes,
  Vcl.StdCtrls;
type

  // Representa um nó da árvore do menu
  TMenuNode = class
  private
    FIDTela: Integer;
    FTelaPaiID: Integer;
    FNomeTela: string;
    FModulo: string;
    FOrdem: Integer;
    FFilhos: TObjectList<TMenuNode>;
    FNivel: Integer;

  public
    constructor Create;
    destructor Destroy; override;

    property IDTela: Integer read FIDTela write FIDTela;
    property TelaPaiID: Integer read FTelaPaiID write FTelaPaiID;
    property NomeTela: string read FNomeTela write FNomeTela;
    property Modulo: string read FModulo write FModulo;
    property Ordem: Integer read FOrdem write FOrdem;
    property Nivel: Integer read FNivel write FNivel;
    property Filhos: TObjectList<TMenuNode> read FFilhos;
  end;


  // Responsável pelo gerenciamento do menu
  TMenuManager = class
  private
    FPanelMenu: TPanel;

    FNos: TObjectList<TMenuNode>;
    FRaizes: TObjectList<TMenuNode>;

    function EncontrarNo(AIDTela: Integer): TMenuNode;
    procedure MontarArvore;

    class function CompararNos(const Left, Right: TMenuNode): integer; static;

    procedure CriarMenuVisual;
    procedure criarFilhosVisual(ANoPai: TMenuNode; ANivel: integer);

    //teste
    //procedure AdicionarTextoNo(ANo: TMenuNode; ANivel: Integer; var ATexto: string);

  public
    constructor Create(APanelMenu: TPanel);
    destructor Destroy; override;

    //teste
    //function TextoArvore: string;
  end;


implementation

{ TMenuNode }


constructor TMenuNode.Create;
begin
  FFilhos := TObjectList<TMenuNode>.Create(false);
end;

destructor TMenuNode.Destroy;
begin
  FFilhos.Free;

  inherited;
end;


{ TMenuManager }

(*
//teste
procedure TMenuManager.AdicionarTextoNo(ANo: TMenuNode; ANivel: Integer;
  var ATexto: string);
var
  Filho: TMenuNode;
  I: Integer;
  Indentacao: string;
begin
  Indentacao := StringOfChar(' ', ANivel * 2);

  ATexto := ATexto +
    Indentacao +
    '- ' + ANo.NomeTela +
    ' (ID: ' + inttostr( ANo.IDTela ) + ')' +
    sLineBreak;

  for I := 0 to ANo.Filhos.Count - 1 do
  begin
    Filho := ANo.Filhos[I];

    AdicionarTextoNo(
      Filho,
      ANivel + 1,
      ATexto
    );
  end;
end;
*)
class function TMenuManager.CompararNos(const Left, Right: TMenuNode): integer;
begin
  Result := Left.Ordem - Right.Ordem;
end;

constructor TMenuManager.Create(APanelMenu: TPanel);
begin
  FPanelMenu := APanelMenu;

  FNos := TObjectList<TMenuNode>.Create(True);
  FRaizes := TObjectList<TMenuNode>.Create(False);

  MontarArvore;

  CriarMenuVisual;
end;

procedure TMenuManager.CriarFilhosVisual(ANoPai: TMenuNode; ANivel: integer);
var
  Filho: TMenuNode;
  PanelFilho: TPanel;
  LabelFilho: TLabel;
  imageFilho : TImage;
begin
  for Filho in ANoPai.Filhos do
  begin
    PanelFilho := TPanel.Create(FPanelMenu);

    PanelFilho.Parent := FPanelMenu;
    PanelFilho.Align := alTop;
    PanelFilho.Height := 40;

    PanelFilho.Caption := '';
    PanelFilho.BevelOuter := bvNone;
    PanelFilho.ParentBackground := False;

    ImageFilho := TImage.Create(PanelFilho);
    ImageFilho.Parent := PanelFilho;

    ImageFilho.Left := 10;
    ImageFilho.Top := 8;
    ImageFilho.Width := 24;
    ImageFilho.Height := 24;
    //ImageFilho.Picture.LoadFromFile('D:\desktop_mobile\FontesVcl\Images\menu_cadastros.png');

    ImageFilho.Stretch := True;
    ImageFilho.Proportional := True;


    LabelFilho := TLabel.Create(PanelFilho);
    LabelFilho.Parent := PanelFilho;
    LabelFilho.Caption := Filho.NomeTela;
    LabelFilho.Left := Filho.Nivel * 20;
    LabelFilho.Top := 12;

    criarFilhosVisual(Filho, ANivel +1);
  end;
end;

procedure TMenuManager.CriarMenuVisual;
var
  No: TMenuNode;
  PanelMenu: TPanel;
begin
  for No in FRaizes do
    begin
      PanelMenu := TPanel.Create(FPanelMenu);

      PanelMenu.Parent := FPanelMenu;
      PanelMenu.Align := alTop;
      PanelMenu.Height := 45;

      //PanelMenu.Caption := No.NomeTela;
      PanelMenu.Caption := No.NomeTela;// + ' - Nivel: ' + inttostr(No.Nivel);
      PanelMenu.Alignment := taLeftJustify;
      PanelMenu.BevelOuter := bvNone;
      PanelMenu.ParentBackground := False;

      CriarFilhosVisual(No, 1);
    end;
end;

destructor TMenuManager.Destroy;
begin
  inherited;
end;

function TMenuManager.EncontrarNo(AIDTela: Integer): TMenuNode;
var
 No: TMenuNode;
begin
  Result := nil;

  for No in FNos do
  begin
   if No.IDTela = AIDTela then
   begin
     Result := No;
     exit;
   end;
  end;
end;

procedure TMenuManager.MontarArvore;
var
  I: integer;
  // não precisa por Vcl.Session, coloquei só pra saber que os metódos estão dento de vcl.session
  Permissao: Vcl.Session.TPermissaoTela; // permissao é um record com todos os campos da tabela
  No : TMenuNode;
  NoPai : TMenuNode;

begin
  FRaizes.Clear;
  FNos.Clear;

  // primeiro criamos todos os nós
  for I := 0 to Vcl.Session.TSession.QuantidadePermissoes -1 do
  begin
    Permissao := Vcl.Session.TSession.ObterPermissao(I);

    // só entra no menu aquilo que o usuário pode visualizar
    if not Permissao.VER then
      continue;

    No := TMenuNode.Create;

    No.IDTela    := Permissao.ID_TELA;
    No.TelaPaiID := Permissao.TELA_PAI_ID;
    No.NomeTela  := Permissao.NOME_TELA;
    No.Modulo    := Permissao.MODULO;
    No.Ordem     := Permissao.ORDEM;

    FNos.Add(No);
  end;

  //depois relacionamos os filhos aos pais
  for No in FNos do
  begin
    if No.TelaPaiID = 0 then
    begin
      // é um nó raiz
      No.Nivel := 0;
      FRaizes.Add(No);
    end
    else
    begin
      NoPai := EncontrarNo(No.TelaPaiID);

      if Assigned(NoPai) then
      begin
        No.Nivel := Nopai.Nivel +1;;
        NoPai.Filhos.Add(No);
      end;
    end;
  end;

  FRaizes.Sort(TComparer<TMenuNode>.Construct(CompararNos));

  for No in FNos do
    No.Filhos.Sort(TComparer<TMenuNode>.Construct(CompararNos));

end;
(*
//teste
function TMenuManager.TextoArvore: string;
var
  No: TMenuNode;
begin
  Result := '';

  for No in FRaizes do
  begin
    AdicionarTextoNo( No, 0, Result );
  end;
end;
*)
end.
