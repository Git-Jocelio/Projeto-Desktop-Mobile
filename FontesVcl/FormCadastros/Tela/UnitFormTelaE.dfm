inherited FormTelasE: TFormTelasE
  Caption = 'Cadastro de Telas'
  ClientHeight = 347
  ClientWidth = 403
  OnShow = FormShow
  ExplicitWidth = 403
  ExplicitHeight = 347
  TextHeight = 15
  inherited lblTitulo: TLabel
    Left = 15
    Top = 12
    Width = 272
    Caption = 'Cadastro de Telas (M'#243'dulos)'
    ExplicitLeft = 15
    ExplicitTop = 12
    ExplicitWidth = 272
  end
  object Label2: TLabel [1]
    Left = 40
    Top = 56
    Width = 72
    Height = 15
    Caption = 'Nome da Tela'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 8289918
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel [2]
    Left = 40
    Top = 177
    Width = 37
    Height = 15
    Caption = 'Ordem'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 8289918
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object Label6: TLabel [3]
    Left = 40
    Top = 117
    Width = 42
    Height = 15
    Caption = 'M'#243'dulo'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 8289918
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  inherited pnlBotaoSalvar: TPanel
    Top = 301
    TabOrder = 5
    ExplicitTop = 301
    inherited btnSalvar: TSpeedButton
      OnClick = btnSalvarClick
    end
  end
  inherited pnlBotaoCancelar: TPanel
    Top = 300
    TabOrder = 4
    ExplicitTop = 300
  end
  object edtNomeTela: TEdit [6]
    Left = 40
    Top = 77
    Width = 326
    Height = 29
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 8289918
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
  end
  object edtOrdem: TEdit [7]
    Left = 40
    Top = 197
    Width = 326
    Height = 29
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 8289918
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    NumbersOnly = True
    ParentFont = False
    TabOrder = 2
  end
  object cbAtivo: TCheckBox [8]
    Left = 40
    Top = 248
    Width = 97
    Height = 17
    Caption = 'Ativo'
    Checked = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 8289918
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    State = cbChecked
    TabOrder = 3
  end
  object cbxModulo: TComboBox [9]
    Left = 40
    Top = 136
    Width = 326
    Height = 23
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 8289918
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    Text = 'cbxModulo'
    Items.Strings = (
      'CADASTRO'
      'OPERACIONAL'
      'CONFIGURA'#199#213'ES'
      'FINANCEIRO'
      'ESTOQUES')
  end
  inherited MemTable: TFDMemTable
    Left = 328
    Top = 16
  end
end
