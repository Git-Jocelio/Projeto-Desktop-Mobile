object FormPedidos: TFormPedidos
  Left = 0
  Top = 0
  Align = alClient
  BorderStyle = bsNone
  Caption = 'Pedidos'
  ClientHeight = 508
  ClientWidth = 1117
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  WindowState = wsMaximized
  OnClose = FormClose
  TextHeight = 15
  object PnlHeader: TPanel
    Left = 0
    Top = 0
    Width = 1117
    Height = 65
    Align = alTop
    BevelOuter = bvNone
    Color = 16051947
    ParentBackground = False
    TabOrder = 0
    ExplicitLeft = -32
    ExplicitTop = -6
    ExplicitWidth = 855
    object Label1: TLabel
      AlignWithMargins = True
      Left = 10
      Top = 10
      Width = 167
      Height = 45
      Margins.Left = 10
      Margins.Top = 10
      Margins.Right = 0
      Margins.Bottom = 10
      Align = alLeft
      Caption = 'Pedidos'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -29
      Font.Name = 'Segoe UI Semibold'
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitTop = 7
    end
    object PnlBotaoInserir: TPanel
      AlignWithMargins = True
      Left = 1005
      Top = 15
      Width = 102
      Height = 35
      Margins.Left = 10
      Margins.Top = 15
      Margins.Right = 10
      Margins.Bottom = 15
      Align = alRight
      BevelOuter = bvNone
      Color = 6316270
      ParentBackground = False
      TabOrder = 0
      ExplicitLeft = 600
      ExplicitTop = 3
      ExplicitHeight = 59
      object BtnAcessar: TSpeedButton
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
        Caption = 'Excluir'
        Flat = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -15
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        ExplicitLeft = 176
        ExplicitTop = 16
        ExplicitWidth = 23
        ExplicitHeight = 22
      end
    end
    object Panel2: TPanel
      AlignWithMargins = True
      Left = 761
      Top = 15
      Width = 102
      Height = 35
      Margins.Left = 10
      Margins.Top = 15
      Margins.Right = 10
      Margins.Bottom = 15
      Align = alRight
      BevelOuter = bvNone
      Color = 16744448
      ParentBackground = False
      TabOrder = 1
      ExplicitLeft = 600
      ExplicitTop = 3
      ExplicitHeight = 59
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
        Caption = 'Inserir'
        Flat = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -15
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        ExplicitLeft = 176
        ExplicitTop = 16
        ExplicitWidth = 23
        ExplicitHeight = 22
      end
    end
    object Panel3: TPanel
      AlignWithMargins = True
      Left = 883
      Top = 15
      Width = 102
      Height = 35
      Margins.Left = 10
      Margins.Top = 15
      Margins.Right = 10
      Margins.Bottom = 15
      Align = alRight
      BevelOuter = bvNone
      Color = 16744448
      ParentBackground = False
      TabOrder = 2
      ExplicitLeft = 600
      ExplicitTop = 3
      ExplicitHeight = 59
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
        Caption = 'Editar'
        Flat = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -15
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        ExplicitLeft = 176
        ExplicitTop = 16
        ExplicitWidth = 23
        ExplicitHeight = 22
      end
    end
    object Panel1: TPanel
      AlignWithMargins = True
      Left = 197
      Top = 0
      Width = 504
      Height = 65
      Margins.Left = 20
      Margins.Top = 0
      Margins.Right = 50
      Margins.Bottom = 0
      Align = alClient
      BevelOuter = bvNone
      Color = 16051947
      ParentBackground = False
      TabOrder = 3
      ExplicitWidth = 271
      object Panel4: TPanel
        AlignWithMargins = True
        Left = 392
        Top = 15
        Width = 102
        Height = 35
        Margins.Left = 0
        Margins.Top = 15
        Margins.Right = 10
        Margins.Bottom = 15
        Align = alRight
        BevelOuter = bvNone
        Color = 16744448
        ParentBackground = False
        TabOrder = 0
        ExplicitLeft = 600
        ExplicitTop = 3
        ExplicitHeight = 59
        object SpeedButton3: TSpeedButton
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
          Caption = 'Filtrar'
          Flat = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          ExplicitLeft = 176
          ExplicitTop = 16
          ExplicitWidth = 23
          ExplicitHeight = 22
        end
      end
      object EditFiltar: TEdit
        AlignWithMargins = True
        Left = 15
        Top = 15
        Width = 377
        Height = 35
        Margins.Left = 15
        Margins.Top = 15
        Margins.Right = 0
        Margins.Bottom = 15
        Align = alClient
        BevelOuter = bvNone
        BorderStyle = bsNone
        TabOrder = 1
        ExplicitLeft = 0
        ExplicitWidth = 224
      end
    end
  end
  object DBGrid: TDBGrid
    Left = 0
    Top = 65
    Width = 1117
    Height = 443
    Align = alClient
    BorderStyle = bsNone
    Color = clWhite
    DataSource = DataSource
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'Pedido'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        Title.Alignment = taCenter
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -15
        Title.Font.Name = 'Segoe UI Semibold'
        Title.Font.Style = [fsBold]
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Clientes'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        Title.Alignment = taCenter
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -15
        Title.Font.Name = 'Segoe UI Semibold'
        Title.Font.Style = [fsBold]
        Width = 339
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Endereco'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        Title.Alignment = taCenter
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -15
        Title.Font.Name = 'Segoe UI Semibold'
        Title.Font.Style = [fsBold]
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Valor'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        Title.Alignment = taCenter
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -15
        Title.Font.Name = 'Segoe UI Semibold'
        Title.Font.Style = [fsBold]
        Visible = True
      end>
  end
  object FDMemTable: TFDMemTable
    Active = True
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 352
    Top = 184
    object FDMemTablePedido: TIntegerField
      DisplayWidth = 10
      FieldName = 'Pedido'
    end
    object FDMemTableClientes: TStringField
      DisplayWidth = 41
      FieldName = 'Clientes'
      Size = 100
    end
    object FDMemTableEndereco: TStringField
      DisplayWidth = 100
      FieldName = 'Endereco'
      Size = 100
    end
    object FDMemTableValor: TFloatField
      DisplayWidth = 10
      FieldName = 'Valor'
      DisplayFormat = '0.00'
    end
  end
  object DataSource: TDataSource
    AutoEdit = False
    DataSet = FDMemTable
    Left = 256
    Top = 184
  end
end
