inherited FormProdutoE: TFormProdutoE
  Caption = 'FormProdutoE'
  ClientHeight = 252
  ClientWidth = 452
  OnShow = FormShow
  ExplicitWidth = 452
  ExplicitHeight = 252
  TextHeight = 15
  inherited lblTitulo: TLabel
    Width = 138
    Caption = 'Novo Produto'
    ExplicitWidth = 138
  end
  object Label2: TLabel [1]
    Left = 36
    Top = 56
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
  object Label3: TLabel [2]
    Left = 36
    Top = 116
    Width = 44
    Height = 15
    Caption = 'Unidade'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 8289918
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object Label4: TLabel [3]
    Left = 228
    Top = 116
    Width = 42
    Height = 15
    Caption = 'Estoque'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 8289918
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  inherited Panel2: TPanel
    Left = 114
    Top = 198
    ExplicitLeft = 114
    ExplicitTop = 198
    inherited btnSalvar: TSpeedButton
      OnClick = btnSalvarClick
      ExplicitTop = 16
      ExplicitHeight = 30
    end
  end
  inherited Panel1: TPanel
    Left = 228
    Top = 197
    ExplicitLeft = 228
    ExplicitTop = 197
    inherited btnCancelar: TSpeedButton
      ExplicitHeight = 30
    end
  end
  object edtDescricao: TEdit [6]
    Left = 36
    Top = 77
    Width = 377
    Height = 29
    CharCase = ecUpperCase
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 8289918
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    MaxLength = 100
    ParentFont = False
    TabOrder = 2
  end
  object edtEstoque: TEdit [7]
    Left = 222
    Top = 137
    Width = 185
    Height = 29
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 8289918
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    NumbersOnly = True
    ParentFont = False
    TabOrder = 3
  end
  object edtUnidade: TComboBox [8]
    Left = 36
    Top = 137
    Width = 180
    Height = 29
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 8289918
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    Items.Strings = (
      'PE'#199'A'
      'LATA')
  end
end
