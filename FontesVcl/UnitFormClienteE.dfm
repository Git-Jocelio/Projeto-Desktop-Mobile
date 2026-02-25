object FormClienteE: TFormClienteE
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'Cadastro de Cliente'
  ClientHeight = 318
  ClientWidth = 409
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poMainFormCenter
  OnClose = FormClose
  OnShow = FormShow
  TextHeight = 15
  object lblTitulo: TLabel
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
    Top = 116
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
    Top = 177
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
    Height = 29
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 8289918
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
  end
  object Panel2: TPanel
    AlignWithMargins = True
    Left = 105
    Top = 254
    Width = 102
    Height = 30
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
      Height = 30
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
      OnClick = btnSalvarClick
      ExplicitLeft = 2
      ExplicitTop = 8
      ExplicitHeight = 35
    end
  end
  object Panel1: TPanel
    AlignWithMargins = True
    Left = 219
    Top = 253
    Width = 102
    Height = 30
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
      Height = 30
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
      ExplicitLeft = -2
      ExplicitTop = 16
      ExplicitHeight = 35
    end
  end
  object edtTelefone: TEdit
    Left = 40
    Top = 137
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
  object edtsetor: TEdit
    Left = 40
    Top = 198
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
  object MemTable: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 256
    Top = 48
  end
end
