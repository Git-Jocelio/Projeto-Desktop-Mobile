object FormClienteE: TFormClienteE
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'Cadastro de Cliente'
  ClientHeight = 258
  ClientWidth = 428
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
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Segoe UI Semibold'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
  end
  object Label2: TLabel
    Left = 56
    Top = 80
    Width = 33
    Height = 15
    Caption = 'Nome'
  end
  object Edit1: TEdit
    Left = 56
    Top = 101
    Width = 326
    Height = 23
    TabOrder = 0
  end
  object Panel2: TPanel
    AlignWithMargins = True
    Left = 166
    Top = 201
    Width = 102
    Height = 35
    Margins.Left = 10
    Margins.Top = 15
    Margins.Right = 10
    Margins.Bottom = 15
    BevelOuter = bvNone
    Color = 16744448
    ParentBackground = False
    TabOrder = 1
    object SpeedButton1: TSpeedButton
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
      ExplicitLeft = -48
    end
  end
  object Panel1: TPanel
    AlignWithMargins = True
    Left = 280
    Top = 200
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
    TabOrder = 2
    object SpeedButton2: TSpeedButton
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
      Font.Color = 14666948
      Font.Height = -15
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      OnClick = SpeedButton2Click
      ExplicitLeft = 176
      ExplicitTop = 16
      ExplicitWidth = 23
      ExplicitHeight = 22
    end
  end
end
