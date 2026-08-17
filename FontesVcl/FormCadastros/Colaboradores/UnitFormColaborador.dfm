inherited FormColaborador: TFormColaborador
  Caption = 'FormColaborador'
  ClientHeight = 377
  ClientWidth = 1368
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  ExplicitWidth = 1368
  ExplicitHeight = 377
  TextHeight = 15
  inherited PnlHeader: TPanel
    Width = 1368
    Height = 167
    ExplicitWidth = 1368
    ExplicitHeight = 167
    inherited Panel1: TPanel
      Width = 1298
      Height = 137
      Margins.Bottom = 30
      ExplicitWidth = 1298
      ExplicitHeight = 137
      inherited Label2: TLabel
        Width = 1298
      end
      inherited Label3: TLabel
        Width = 1298
      end
      inherited Panel4: TPanel
        Left = 660
        Height = 35
        ExplicitLeft = 660
        inherited btnFiltrar: TSpeedButton
          Height = 35
          OnClick = btnFiltrarClick
        end
      end
      inherited edtFiltrar: TEdit
        Width = 744
        Height = 35
        TextHint = 'Pesquisar pelo nome do colaborador'
        ExplicitWidth = 744
      end
    end
    inherited pnlBotoes: TPanel
      Left = 995
      Height = 84
    end
  end
  inherited pnlGrig: TPanel
    Top = 167
    Width = 1308
    Height = 180
    ExplicitLeft = 30
    ExplicitTop = 65
    ExplicitWidth = 1308
    ExplicitHeight = 282
    inherited dbg: TDBGrid
      Width = 1308
      Height = 180
    end
  end
  inherited ds: TDataSource
    DataSet = DmColaborador.TabColaborador
  end
end
