inherited FormPerfilEdicao: TFormPerfilEdicao
  Caption = 'FormPerfilEdicao'
  OnShow = FormShow
  TextHeight = 15
  inherited lblTitulo: TLabel
    Left = 15
    Top = 15
    Width = 254
    Caption = 'Perfil de acesso ao sistema'
    ExplicitLeft = 15
    ExplicitTop = 15
    ExplicitWidth = 254
  end
  object Label2: TLabel [1]
    Left = 15
    Top = 96
    Width = 51
    Height = 15
    Caption = 'Descri'#231#227'o'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 8289918
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object Label1: TLabel [2]
    Left = 15
    Top = 168
    Width = 62
    Height = 15
    Caption = 'Observa'#231#227'o'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 8289918
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  inherited pnlBotaoSalvar: TPanel
    inherited btnSalvar: TSpeedButton
      OnClick = btnSalvarClick
    end
  end
  object edtDescricao: TEdit [5]
    Left = 15
    Top = 117
    Width = 402
    Height = 29
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 8289918
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
  end
  object edtObs: TEdit [6]
    Left = 15
    Top = 189
    Width = 402
    Height = 29
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 8289918
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
  end
end
