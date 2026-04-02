inherited FormFornecedorE: TFormFornecedorE
  Caption = 'FormFornecedorE'
  ClientHeight = 485
  ClientWidth = 395
  OnShow = FormShow
  ExplicitWidth = 395
  ExplicitHeight = 485
  TextHeight = 15
  inherited lblTitulo: TLabel
    Width = 169
    Caption = 'Novo Fornecedor'
    ExplicitWidth = 169
  end
  object Label2: TLabel [1]
    Left = 40
    Top = 56
    Width = 45
    Height = 15
    Caption = 'Empresa'
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
    Width = 92
    Height = 15
    Caption = 'Telefone Empresa'
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
  object Label1: TLabel [4]
    Left = 40
    Top = 291
    Width = 79
    Height = 15
    Caption = 'Nome Contato'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 8289918
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object Label5: TLabel [5]
    Left = 40
    Top = 352
    Width = 90
    Height = 15
    Caption = 'Telefone Contato'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 8289918
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object Label6: TLabel [6]
    Left = 40
    Top = 115
    Width = 27
    Height = 15
    Caption = 'CNPJ'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 8289918
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  inherited pnlBotaoSalvar: TPanel
    Left = 82
    Top = 421
    TabOrder = 6
    ExplicitLeft = 82
    ExplicitTop = 421
    inherited btnSalvar: TSpeedButton
      OnClick = btnSalvarClick
      ExplicitHeight = 30
    end
  end
  inherited pnlBotaoCancelar: TPanel
    Left = 196
    Top = 420
    TabOrder = 7
    ExplicitLeft = 196
    ExplicitTop = 420
    inherited btnCancelar: TSpeedButton
      ExplicitHeight = 30
    end
  end
  object edtEmpresa: TEdit [9]
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
  object edtTelefone: TEdit [10]
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
  object edtEmail: TEdit [11]
    Left = 40
    Top = 251
    Width = 326
    Height = 29
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 8289918
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
  end
  object edtNomeContato: TEdit [12]
    Left = 40
    Top = 312
    Width = 326
    Height = 29
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 8289918
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
  end
  object edtTelefoneContato: TEdit [13]
    Left = 40
    Top = 373
    Width = 326
    Height = 29
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 8289918
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
  end
  object edtCNPJ: TEdit [14]
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
  inherited MemTable: TFDMemTable
    Left = 320
    Top = 32
  end
end
