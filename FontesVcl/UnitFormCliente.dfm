object FormCliente: TFormCliente
  Left = 0
  Top = 0
  Align = alClient
  BorderStyle = bsNone
  Caption = 'Clientes'
  ClientHeight = 476
  ClientWidth = 1089
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poMainFormCenter
  WindowState = wsMaximized
  OnClose = FormClose
  OnShow = FormShow
  TextHeight = 15
  object PnlHeader: TPanel
    Left = 0
    Top = 0
    Width = 1089
    Height = 65
    Align = alTop
    BevelOuter = bvNone
    Color = 16051947
    ParentBackground = False
    TabOrder = 0
    object Label1: TLabel
      AlignWithMargins = True
      Left = 10
      Top = 10
      Width = 89
      Height = 45
      Margins.Left = 10
      Margins.Top = 10
      Margins.Right = 0
      Margins.Bottom = 10
      Align = alLeft
      Caption = 'Pessoa'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -29
      Font.Name = 'Segoe UI Semibold'
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitHeight = 40
    end
    object PnlBotaoInserir: TPanel
      AlignWithMargins = True
      Left = 977
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
      object BtnExcluir: TSpeedButton
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
        OnClick = BtnExcluirClick
        ExplicitLeft = 176
        ExplicitTop = 16
        ExplicitWidth = 23
        ExplicitHeight = 22
      end
    end
    object Panel2: TPanel
      AlignWithMargins = True
      Left = 733
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
      object btnInserir: TSpeedButton
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
        OnClick = btnInserirClick
        ExplicitLeft = 176
        ExplicitTop = 16
        ExplicitWidth = 23
        ExplicitHeight = 22
      end
    end
    object Panel3: TPanel
      AlignWithMargins = True
      Left = 855
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
      object BtnEditar: TSpeedButton
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
        OnClick = BtnEditarClick
        ExplicitLeft = 176
        ExplicitTop = 16
        ExplicitWidth = 23
        ExplicitHeight = 22
      end
    end
    object Panel1: TPanel
      AlignWithMargins = True
      Left = 119
      Top = 0
      Width = 554
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
      object Panel4: TPanel
        AlignWithMargins = True
        Left = 442
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
        object btnFiltrar: TSpeedButton
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
          OnClick = btnFiltrarClick
          ExplicitLeft = 176
          ExplicitTop = 16
          ExplicitWidth = 23
          ExplicitHeight = 22
        end
      end
      object edtFiltrar: TEdit
        AlignWithMargins = True
        Left = 15
        Top = 15
        Width = 427
        Height = 35
        Margins.Left = 15
        Margins.Top = 15
        Margins.Right = 0
        Margins.Bottom = 15
        Align = alClient
        BevelOuter = bvNone
        BorderStyle = bsNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
    end
  end
  object DBGrid: TDBGrid
    Left = 0
    Top = 65
    Width = 1089
    Height = 411
    Align = alClient
    BorderStyle = bsNone
    Color = clWhite
    DataSource = dsPessoa
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'PESSOA_ID'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        Title.Alignment = taCenter
        Title.Caption = 'Cod. Pessoa'
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -15
        Title.Font.Name = 'Segoe UI Semibold'
        Title.Font.Style = [fsBold]
        Width = 91
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOME'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        Title.Alignment = taCenter
        Title.Caption = 'Nome'
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -15
        Title.Font.Name = 'Segoe UI Semibold'
        Title.Font.Style = [fsBold]
        Width = 361
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TELEFONE'
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
        Width = 405
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'SETOR'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        Title.Alignment = taCenter
        Title.Caption = 'Setor'
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -15
        Title.Font.Name = 'Segoe UI Semibold'
        Title.Font.Style = [fsBold]
        Width = 159
        Visible = True
      end>
  end
  object dsPessoa: TDataSource
    AutoEdit = False
    DataSet = DmPessoa.tabPessoa
    Left = 310
    Top = 120
  end
end
