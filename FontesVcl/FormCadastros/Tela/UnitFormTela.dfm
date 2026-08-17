inherited FormTela: TFormTela
  Caption = 'FormTela'
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  TextHeight = 15
  inherited PnlHeader: TPanel
    inherited pnlPesquisa: TPanel
      ExplicitWidth = 790
      inherited Label2: TLabel
        Caption = 'Telas/M'#243'dulos do sistema'
        ExplicitWidth = 198
      end
      inherited Label3: TLabel
        Caption = 'CADASTRAR TELAS (RECURSOS)'
        ExplicitWidth = 307
      end
      inherited pnlBarraPequisa: TPanel
        ExplicitWidth = 1088
        inherited edtFiltrar: TEdit
          ExplicitLeft = 0
          ExplicitTop = 15
          ExplicitWidth = 1001
          ExplicitHeight = 43
        end
        inherited Panel4: TPanel
          ExplicitLeft = 1001
          ExplicitHeight = 43
        end
      end
    end
    inherited pnlBotoes: TPanel
      ExplicitLeft = 1158
      ExplicitTop = 80
      ExplicitHeight = 70
      inherited Panel2: TPanel
        ExplicitLeft = 0
        ExplicitHeight = 40
      end
      inherited Panel3: TPanel
        ExplicitLeft = 122
        ExplicitHeight = 40
      end
      inherited PnlBotaoInserir: TPanel
        ExplicitTop = 0
        ExplicitHeight = 55
      end
    end
  end
  inherited pnlGrig: TPanel
    ExplicitLeft = 30
    ExplicitTop = 153
    ExplicitWidth = 1471
    ExplicitHeight = 385
  end
end
