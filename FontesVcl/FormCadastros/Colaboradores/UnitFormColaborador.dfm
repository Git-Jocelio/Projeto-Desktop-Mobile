inherited FormColaborador: TFormColaborador
  Caption = 'FormColaborador'
  ClientHeight = 377
  ClientWidth = 1194
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  ExplicitWidth = 1194
  ExplicitHeight = 377
  TextHeight = 15
  inherited PnlHeader: TPanel
    Width = 1194
    ExplicitWidth = 1194
    inherited Label1: TLabel
      Width = 163
      Height = 45
      Caption = 'Colaborador'
      ExplicitWidth = 163
    end
    inherited PnlBotaoInserir: TPanel
      Left = 1082
      ExplicitLeft = 1082
    end
    inherited Panel2: TPanel
      Left = 838
      ExplicitLeft = 838
      inherited btnInserir: TSpeedButton
        OnClick = btnInserirClick
      end
    end
    inherited Panel3: TPanel
      Left = 960
      ExplicitLeft = 960
    end
    inherited Panel1: TPanel
      Left = 193
      Width = 585
      ExplicitLeft = 193
      ExplicitWidth = 585
      inherited Panel4: TPanel
        Left = 473
        ExplicitLeft = 473
      end
      inherited edtFiltrar: TEdit
        Width = 458
        TextHint = 'Digite o nome do colaborador'
        ExplicitWidth = 458
      end
    end
  end
  inherited dbg: TDBGrid
    Width = 1194
    Height = 312
    DataSource = ds
  end
end
