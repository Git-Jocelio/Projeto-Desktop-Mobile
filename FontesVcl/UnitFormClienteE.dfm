object FormClienteE: TFormClienteE
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'Cadastro de Cliente'
  ClientHeight = 309
  ClientWidth = 413
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poMainFormCenter
  OnClose = FormClose
  TextHeight = 15
  object Label1: TLabel
    AlignWithMargins = True
    Left = 10
    Top = 10
    Width = 124
    Height = 30
    Margins.Left = 10
    Margins.Top = 10
    Margins.Right = 0
    Margins.Bottom = 10
    Caption = 'Novo Cliente'
    Color = 16744448
    Font.Charset = ANSI_CHARSET
    Font.Color = 16744448
    Font.Height = -21
    Font.Name = 'Segoe UI Semibold'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
  end
  object Label2: TLabel
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
  object Label3: TLabel
    Left = 40
    Top = 104
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
  object Label4: TLabel
    Left = 40
    Top = 160
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
  object edtNome: TEdit
    Left = 40
    Top = 77
    Width = 326
    Height = 23
    TabOrder = 0
  end
  object Panel2: TPanel
    AlignWithMargins = True
    Left = 116
    Top = 236
    Width = 102
    Height = 35
    Margins.Left = 10
    Margins.Top = 15
    Margins.Right = 10
    Margins.Bottom = 15
    BevelOuter = bvNone
    Color = 16744448
    ParentBackground = False
    TabOrder = 3
    object btnSalvar: TSpeedButton
      AlignWithMargins = True
      Left = 0
      Top = 0
      Width = 102
      Height = 35
      Cursor = crHandPoint
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alClient
      Caption = 'Salvar'
      Flat = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -15
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      ExplicitLeft = 2
      ExplicitTop = 16
    end
  end
  object Panel1: TPanel
    AlignWithMargins = True
    Left = 230
    Top = 235
    Width = 102
    Height = 35
    Margins.Left = 10
    Margins.Top = 15
    Margins.Right = 10
    Margins.Bottom = 15
    BevelOuter = bvNone
    Color = 16249584
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 15458266
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentBackground = False
    ParentFont = False
    TabOrder = 4
    object btnCancelar: TSpeedButton
      AlignWithMargins = True
      Left = 0
      Top = 0
      Width = 102
      Height = 35
      Cursor = crHandPoint
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alClient
      Caption = 'Cancelar'
      Flat = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 8289918
      Font.Height = -15
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      OnClick = btnCancelarClick
      ExplicitLeft = 176
      ExplicitTop = 16
      ExplicitWidth = 23
      ExplicitHeight = 22
    end
  end
  object edtTelefone: TEdit
    Left = 40
    Top = 125
    Width = 326
    Height = 23
    TabOrder = 1
  end
  object edtsetor: TEdit
    Left = 40
    Top = 181
    Width = 326
    Height = 23
    TabOrder = 2
  end
end
