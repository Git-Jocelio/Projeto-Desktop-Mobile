unit UnitMenuManager;

interface

uses
  System.Generics.Collections, dialogs,
  system.Generics.Defaults,
  Vcl.Controls,
  Vcl.ExtCtrls,
  Vcl.Session,
  System.SysUtils,
  System.Classes,
  Vcl.StdCtrls, Vcl.Forms;
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
    FExpandido: Boolean;

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
    property Expandido: Boolean read FExpandido write FExpandido;
    function TemFilhos: Boolean;
  end;


  // Responsável pelo gerenciamento do menu
  TMenuManager = class
  private
    FPanelMenu: TPanel;
    FPanelContainer: TPanel;
    FFormAtual: TForm;

    FNos: TObjectList<TMenuNode>;
    FRaizes: TObjectList<TMenuNode>;

    function EncontrarNo(AIDTela: Integer): TMenuNode;
    procedure MontarArvore;

    class function CompararNos(const Left, Right: TMenuNode): integer; static;

    procedure CriarMenuVisual;
    procedure CriarFilhosVisual(ANoPai: TMenuNode; APanelPai: TPanel; ANivel: integer);

    procedure AlternarNo(Sender: TOBject);
    function CalcularNivel(Ano: TMenuNode): integer;
    function EhDescendente(ANo: TMenuNode; ANoPai: TMenuNode): Boolean;
    procedure ReorganizarMenu;

    procedure AbrirTela(AIDTela: Integer);
    procedure FecharFormAtual;
    //teste
    //procedure AdicionarTextoNo(ANo: TMenuNode; ANivel: Integer; var ATexto: string);

  public
    constructor Create(APanelMenu, APanelContainer: TPanel);
    destructor Destroy; override;

    //teste
    //function TextoArvore: string;
  end;


implementation

uses UnitFormProduto, UnitFormUsuario, UnitFormPerfil, UnitFormTela,
  UnitFormFornecedor, UnitFormColaborador, UnitFormPermissoesE, UnitFormPessoa;

{ TMenuNode }


constructor TMenuNode.Create;
begin
  FFilhos := TObjectList<TMenuNode>.Create(false);
  FExpandido := true;
end;

destructor TMenuNode.Destroy;
begin
  FFilhos.Free;
  inherited;
end;



function TMenuNode.TemFilhos: Boolean;
begin
  Result := FFilhos.Count > 0;
end;

procedure TMenuManager.AbrirTela(AIDTela: Integer);
begin
  FecharFormAtual;

  case AIDTela of

    1:
     begin
        FFormAtual := TFormUsuario.Create(FPanelContainer);
     end;

    2:
     begin
        FFormAtual := TFormPerfil.Create(FPanelContainer);
     end;

    3:
     begin
        FFormAtual := TFormTela.Create(FPanelContainer);
     end;

    4:
     begin
        FFormAtual := TFormFornecedor.Create(FPanelContainer);
     end;

    5:
     begin
        FFormAtual := TFormProduto.Create(FPanelContainer);
     end;

    6:
     begin
        FFormAtual := TFormColaborador.Create(FPanelContainer);
     end;

    9:
     begin
        FFormAtual := TFormColaborador.Create(FPanelContainer);
     end;


    10:
     begin
        FFormAtual := TFormPessoa.Create(FPanelContainer);
     end;


  end;

  if Assigned(FFormAtual) then
  begin
    FFormAtual.Parent := FPanelContainer;
    FFormAtual.Align := alClient;
    //FFormAtual.BorderStyle := bsNone;

    FFormAtual.Show;
  end;
end;

procedure TMenuManager.AlternarNo(Sender: TOBject);
var
  Panel: TPanel;
  NoClicado: TMenuNode;
  No: TMenuNode;
  I: Integer;
  PainelItem: TPanel;
begin
  Panel := TPanel(Sender);

  NoClicado := EncontrarNo(Panel.Tag);

  if not Assigned(NoClicado) then
  begin
    Exit;
  end;

  // Se não possui filhos, futuramente irá abrir a tela
  if not NoClicado.TemFilhos then
  begin
    AbrirTela(NoClicado.IDTela);
    Exit;
  end;

  NoClicado.Expandido := not NoClicado.Expandido;

  for I := 0 to FPanelMenu.ControlCount - 1 do
  begin
    if not (FPanelMenu.Controls[I] is TPanel) then
      Continue;

    PainelItem := TPanel(FPanelMenu.Controls[I]);

    No := EncontrarNo(PainelItem.Tag);

    if not Assigned(No) then
      Continue;

    if EhDescendente(No, NoClicado) then
      PainelItem.Visible := NoClicado.Expandido;

  end;

  ReorganizarMenu;

end;


function TMenuManager.CalcularNivel(Ano: TMenuNode): integer;
var
  NoPai: TMenuNode;
begin
  if Ano.TelaPaiID = 0 then
  begin
    Result := 0;
    Exit;
  end;

  NoPai := EncontrarNo(Ano.TelaPaiID);

  if Assigned(NoPai) then
    Result := CalcularNivel(NoPai) + 1
  else
    Result := 0;
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

constructor TMenuManager.Create(APanelMenu, APanelContainer: TPanel);
begin
  FPanelMenu := APanelMenu;
  FPanelContainer := APanelContainer;

  FNos := TObjectList<TMenuNode>.Create(True);
  FRaizes := TObjectList<TMenuNode>.Create(False);

  MontarArvore;

  CriarMenuVisual;
end;

procedure TMenuManager.CriarFilhosVisual(ANoPai: TMenuNode; APanelPai: TPanel; ANivel: integer);
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
    PanelFilho.Align := alNone;
    PanelFilho.Height := 40;

    PanelFilho.Caption := '';
    PanelFilho.BevelOuter := bvNone;
    PanelFilho.ParentBackground := False;

    PanelFilho.Tag := Filho.IDTela;
    PanelFilho.OnClick := AlternarNo;

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

    criarFilhosVisual(Filho, PanelFilho,  ANivel +1);
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
      PanelMenu.Align := alNone;
      PanelMenu.Height := 45;

      //PanelMenu.Caption := No.NomeTela;
      PanelMenu.Caption := No.NomeTela;// + ' - Nivel: ' + inttostr(No.Nivel);
      PanelMenu.Alignment := taLeftJustify;
      PanelMenu.BevelOuter := bvNone;
      PanelMenu.ParentBackground := False;

      PanelMenu.Tag := No.IDTela;
      PanelMenu.OnClick := AlternarNo;

      CriarFilhosVisual(No, PanelMenu, 1);
    end;

    ReorganizarMenu;
end;

destructor TMenuManager.Destroy;
begin
  FNos.Free;
  FRaizes.Free;
  inherited;
end;

function TMenuManager.EhDescendente(ANo, ANoPai: TMenuNode): Boolean;
var
  NoPai: TMenuNode;
begin
  Result := False;

  if ANo.TelaPaiID = 0 then
    Exit;

  if ANo.TelaPaiID = ANoPai.IDTela then
  begin
    Result := True;
    Exit;
  end;

  NoPai := EncontrarNo(ANo.TelaPaiID);

  if Assigned(NoPai) then
    Result := EhDescendente(NoPai, ANoPai);
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

procedure TMenuManager.FecharFormAtual;
begin
  if not Assigned(FFormAtual) then
    exit;

  FFormAtual.Close;
  FreeAndNil(FFormAtual);
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
        //No.Nivel := Nopai.Nivel +1;;
        No.Nivel := CalcularNivel(No);
        NoPai.Filhos.Add(No);
      end;
    end;
  end;

  FRaizes.Sort(TComparer<TMenuNode>.Construct(CompararNos));

  for No in FNos do
    No.Filhos.Sort(TComparer<TMenuNode>.Construct(CompararNos));

end;
procedure TMenuManager.ReorganizarMenu;
var
  I: Integer;
  TopAtual: Integer;
  PainelItem: TPanel;
begin
  TopAtual := 0;

  for I := 0 to FPanelMenu.ControlCount - 1 do
  begin
    if not (FPanelMenu.Controls[I] is TPanel) then
      Continue;

    PainelItem := TPanel(FPanelMenu.Controls[I]);

    if not PainelItem.Visible then
      Continue;

    PainelItem.Align := alNone;
    PainelItem.Top := TopAtual;

    TopAtual := TopAtual + PainelItem.Height;
  end;
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
