inherited FormPessoaE: TFormPessoaE
  Caption = 'Nome'
  ClientHeight = 318
  ClientWidth = 418
  OnShow = FormShow
  ExplicitWidth = 418
  ExplicitHeight = 318
  TextHeight = 15
  inherited lblTitulo: TLabel
    Width = 121
    Caption = 'Nova Pessoa'
    ExplicitWidth = 121
  end
  object Nome: TLabel [1]
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
  object Email: TLabel [3]
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
    inherited btnSalvar: TSpeedButton
      OnClick = btnSalvarClick
    end
  end
  object edtNome: TEdit [6]
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
    TabOrder = 2
  end
  object edtTelefone: TEdit [7]
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
    TabOrder = 3
  end
  object edtEmail: TEdit [8]
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
    TabOrder = 4
  end
  inherited MemTable: TFDMemTable
    Left = 280
    Top = 32
  end
end
