inherited FormColaboradorE: TFormColaboradorE
  Caption = 'FormColaboradorE'
  ClientHeight = 353
  ClientWidth = 406
  OnShow = FormShow
  ExplicitWidth = 406
  ExplicitHeight = 353
  TextHeight = 15
  inherited lblTitulo: TLabel
    Width = 180
    Caption = 'Novo Colaborador'
    ExplicitWidth = 180
  end
  object Label2: TLabel [1]
    Left = 40
    Top = 56
    Width = 33
    Height = 15
    Caption = 'Nome'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 8289918
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel [2]
    Left = 40
    Top = 171
    Width = 44
    Height = 15
    Caption = 'Telefone'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 8289918
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object Label4: TLabel [3]
    Left = 40
    Top = 230
    Width = 27
    Height = 15
    Caption = 'Setor'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 8289918
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object Label6: TLabel [4]
    Left = 40
    Top = 115
    Width = 29
    Height = 15
    Caption = 'Email'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 8289918
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  inherited pnlBotaoSalvar: TPanel
    Left = 95
    Top = 302
    TabOrder = 3
    ExplicitLeft = 95
    ExplicitTop = 302
    inherited btnSalvar: TSpeedButton
      OnClick = btnSalvarClick
    end
  end
  inherited pnlBotaoCancelar: TPanel
    Left = 209
    Top = 301
    TabOrder = 4
    ExplicitLeft = 209
    ExplicitTop = 301
  end
  object edtNome: TEdit [7]
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
  object edtTelefone: TEdit [8]
    Left = 40
    Top = 192
    Width = 326
    Height = 29
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 8289918
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
  end
  object edtEmail: TEdit [9]
    Left = 40
    Top = 136
    Width = 326
    Height = 29
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 8289918
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
  end
  object cbxSetor: TComboBox [10]
    Left = 40
    Top = 251
    Width = 326
    Height = 29
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 8289918
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
    Text = 'cbxSetor'
    TextHint = 'Selecione um setror'
    Items.Strings = (
      'Financeiro'
      'Comercial'
      'Suporte'
      'Compras'
      'Desenvolvimento'
      'Facilites'
      'Marketing'
      'Diretoria'
      'Recursos Humanos')
  end
  inherited MemTable: TFDMemTable
    Left = 296
  end
end
