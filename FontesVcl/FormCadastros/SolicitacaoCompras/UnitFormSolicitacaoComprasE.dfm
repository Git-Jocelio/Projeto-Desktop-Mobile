object FormSolicitacaoComprasE: TFormSolicitacaoComprasE
  Left = 0
  Top = 0
  Caption = 'Solicita'#231#227'o de Compras'
  ClientHeight = 747
  ClientWidth = 704
  Color = clBtnFace
  ParentFont = True
  Position = poMainFormCenter
  ShowHint = True
  OnClose = FormClose
  OnShow = FormShow
  TextHeight = 15
  object lblTitulo: TLabel
    AlignWithMargins = True
    Left = 10
    Top = 10
    Width = 215
    Height = 30
    Margins.Left = 10
    Margins.Top = 10
    Margins.Right = 0
    Margins.Bottom = 10
    Caption = 'Solicita'#231#227'o de Compra'
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
    Left = 16
    Top = 200
    Width = 66
    Height = 15
    Caption = 'Colaborador'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 8289918
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object Label1: TLabel
    Left = 16
    Top = 85
    Width = 173
    Height = 15
    Caption = 'Centro de Custo (Departamento)'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 8289918
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object Label5: TLabel
    Left = 16
    Top = 144
    Width = 51
    Height = 15
    Caption = 'Categoria'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 8289918
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object SpeedButton1: TSpeedButton
    Left = 343
    Top = 107
    Width = 25
    Height = 23
    Hint = 'Cadastrar um novo centro de custo'
    Caption = '...'
    OnClick = SpeedButton1Click
  end
  object SpeedButton2: TSpeedButton
    Left = 343
    Top = 165
    Width = 25
    Height = 23
    Hint = 'Cadastrar um novo centro de custo'
    Caption = '...'
    OnClick = SpeedButton2Click
  end
  object SpeedButton3: TSpeedButton
    Left = 345
    Top = 221
    Width = 168
    Height = 29
    Caption = 'Selecionar um Colaborador'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 8289918
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    OnClick = SpeedButton3Click
  end
  object Label3: TLabel
    Left = 16
    Top = 53
    Width = 100
    Height = 15
    Caption = 'Data da Solicita'#231#227'o'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 8289918
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object Label4: TLabel
    Left = 122
    Top = 53
    Width = 60
    Height = 15
    Caption = '01/01/1999'
    Font.Charset = ANSI_CHARSET
    Font.Color = 8289918
    Font.Height = -12
    Font.Name = 'Segoe UI Semibold'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label8: TLabel
    Left = 16
    Top = 257
    Width = 61
    Height = 15
    Caption = 'Justificativa'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 8289918
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object edtNome: TEdit
    Left = 16
    Top = 221
    Width = 326
    Height = 29
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 8289918
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    TextHint = 'JOSE MARIA DA SILVA'
  end
  object Panel2: TPanel
    AlignWithMargins = True
    Left = 226
    Top = 700
    Width = 102
    Height = 30
    Margins.Left = 10
    Margins.Top = 15
    Margins.Right = 10
    Margins.Bottom = 15
    BevelOuter = bvNone
    Color = 16744448
    ParentBackground = False
    TabOrder = 1
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
    end
  end
  object Panel1: TPanel
    AlignWithMargins = True
    Left = 340
    Top = 700
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
    TabOrder = 2
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
      ExplicitLeft = 48
    end
  end
  object ComboBox1: TComboBox
    Left = 16
    Top = 106
    Width = 326
    Height = 23
    Style = csDropDownList
    TabOrder = 3
    TextHint = 'Selecione um centro de custo'
    Items.Strings = (
      'Departamento Financeiro'
      'Departamento Comercial'
      'Departamento de Compras'
      'Suporte'
      'Recursos Humanos'
      'Outros')
  end
  object ComboBox2: TComboBox
    Left = 16
    Top = 165
    Width = 326
    Height = 23
    Style = csDropDownList
    TabOrder = 4
    TextHint = 'Selecione uma categoria'
    Items.Strings = (
      'Material de Escrit'#243'rio'
      'Material de Limpesa'
      'Produtos Aliment'#237'cios'
      'Ativos(Escrit'#243'rio)'
      'Ativos(TI)'
      'Outros ')
  end
  object GroupBox1: TGroupBox
    Left = 16
    Top = 409
    Width = 673
    Height = 270
    Caption = 'Itens da Solicita'#231#227'o'
    TabOrder = 5
    object DBGrid1: TDBGrid
      Left = 2
      Top = 48
      Width = 669
      Height = 220
      Align = alBottom
      DataSource = ds
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'DESCRICAO_ITEM'
          Title.Alignment = taCenter
          Title.Caption = 'Descri'#231#227'o do Item'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clGray
          Title.Font.Height = -13
          Title.Font.Name = 'Segoe UI'
          Title.Font.Style = []
          Width = 278
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'QUANTIDADE'
          Title.Alignment = taCenter
          Title.Caption = 'Quantidade'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clGray
          Title.Font.Height = -13
          Title.Font.Name = 'Segoe UI'
          Title.Font.Style = []
          Width = 127
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'PRIORIDADE'
          Title.Alignment = taCenter
          Title.Caption = 'Prioridade'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clGray
          Title.Font.Height = -13
          Title.Font.Name = 'Segoe UI'
          Title.Font.Style = []
          Width = 100
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'UNIDADE'
          Title.Alignment = taCenter
          Title.Caption = 'Unidade'
          Title.Font.Charset = ANSI_CHARSET
          Title.Font.Color = clGray
          Title.Font.Height = -12
          Title.Font.Name = 'Segoe UI Semibold'
          Title.Font.Style = [fsBold]
          Visible = True
        end
        item
          Expanded = False
          Title.Alignment = taCenter
          Title.Caption = 'A'#231#245'es'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clGray
          Title.Font.Height = -13
          Title.Font.Name = 'Segoe UI'
          Title.Font.Style = []
          Width = 75
          Visible = True
        end>
    end
    object Panel3: TPanel
      AlignWithMargins = True
      Left = 15
      Top = 19
      Width = 178
      Height = 24
      Margins.Left = 10
      Margins.Top = 15
      Margins.Right = 10
      Margins.Bottom = 15
      BevelOuter = bvNone
      Color = clGray
      ParentBackground = False
      TabOrder = 1
      object SpeedButton5: TSpeedButton
        AlignWithMargins = True
        Left = 0
        Top = 0
        Width = 178
        Height = 24
        Cursor = crHandPoint
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alClient
        Caption = 'Incluir um novo Item'
        Flat = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -15
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        OnClick = SpeedButton5Click
        ExplicitLeft = 2
        ExplicitTop = 8
        ExplicitWidth = 102
        ExplicitHeight = 30
      end
    end
  end
  object Memo1: TMemo
    Left = 16
    Top = 276
    Width = 671
    Height = 116
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 8289918
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Lines.Strings = (
      'Descreva a necessidade dessa solicita'#231#227'o')
    ParentFont = False
    TabOrder = 6
  end
  object RadioGroup1: TRadioGroup
    Left = 464
    Top = 85
    Width = 223
    Height = 116
    Caption = ' Situa'#231#227'o da Solicita'#231#227'o '
    Font.Charset = ANSI_CHARSET
    Font.Color = clGray
    Font.Height = -12
    Font.Name = 'Segoe UI Semibold'
    Font.Style = [fsBold]
    ItemIndex = 1
    Items.Strings = (
      'Em an'#225'lise'
      'Aprovado para Cota'#231#227'o'
      'Rejeitado pelo Gestor')
    ParentFont = False
    TabOrder = 7
  end
  object Panel4: TPanel
    AlignWithMargins = True
    Left = 480
    Top = 700
    Width = 207
    Height = 30
    Margins.Left = 10
    Margins.Top = 15
    Margins.Right = 10
    Margins.Bottom = 15
    BevelOuter = bvNone
    Color = clDarkgreen
    ParentBackground = False
    TabOrder = 8
    object SpeedButton4: TSpeedButton
      AlignWithMargins = True
      Left = 0
      Top = 0
      Width = 207
      Height = 30
      Cursor = crHandPoint
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alClient
      Caption = 'Liberado para cota'#231#227'o'
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
      ExplicitWidth = 102
    end
  end
  object TabSolicitações: TFDMemTable
    Active = True
    FieldDefs = <
      item
        Name = 'DESCRICAO_ITEM'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'QUANTIDADE'
        DataType = ftFloat
      end
      item
        Name = 'PRIORIDADE'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'UNIDADE'
        DataType = ftString
        Size = 10
      end>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvPersistent, rvSilentMode]
    ResourceOptions.Persistent = True
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 320
    Top = 537
    Content = {
      414442531000000061030000FF00010001FF02FF0304001E0000005400610062
      0053006F006C0069006300690074006100E700F5006500730005001E00000054
      006100620053006F006C0069006300690074006100E700F50065007300060000
      000000070000080032000000090000FF0AFF0B04001C00000044004500530043
      0052004900430041004F005F004900540045004D0005001C0000004400450053
      00430052004900430041004F005F004900540045004D000C00010000000E000D
      000F006400000010000111000112000113000114000115000116001C00000044
      0045005300430052004900430041004F005F004900540045004D001700640000
      00FEFF0B0400140000005100550041004E005400490044004100440045000500
      140000005100550041004E005400490044004100440045000C00020000000E00
      1800100001110001120001130001140001150001160014000000510055004100
      4E00540049004400410044004500FEFF0B0400140000005000520049004F0052
      00490044004100440045000500140000005000520049004F0052004900440041
      00440045000C00030000000E000D000F00140000001000011100011200011300
      011400011500011600140000005000520049004F005200490044004100440045
      00170014000000FEFF0B04000E00000055004E00490044004100440045000500
      0E00000055004E00490044004100440045000C00040000000E000D000F000A00
      000010000111000112000113000114000115000116000E00000055004E004900
      440041004400450017000A000000FEFEFF19FEFF1AFEFF1BFF1C1D0000000000
      1F001E00FF2000001900000043414E4554412045534645524F4752C146494341
      20415A554C01000000000000003E40020005000000424149584F030004000000
      5045C741FEFEFF1C1D0001000000FF20000021000000434152545543484F2049
      4D50524553534F5241204550534F4E204C582D32303030010000000000000000
      400200050000004DC94449410300040000005045C741FEFEFF1C1D0002000000
      1F001E00FF20000019000000464F4C484120444520504150454C2053554C4649
      54452041340100000000000000F03F020007000000555247454E544503000A00
      000050435445203530302046FEFEFEFEFEFF21FEFF22230007000000FF24FEFE
      FE0E004D0061006E0061006700650072001E0055007000640061007400650073
      005200650067006900730074007200790012005400610062006C0065004C0069
      00730074000A005400610062006C00650008004E0061006D006500140053006F
      0075007200630065004E0061006D0065000A0054006100620049004400240045
      006E0066006F0072006300650043006F006E00730074007200610069006E0074
      0073001E004D0069006E0069006D0075006D0043006100700061006300690074
      007900180043006800650063006B004E006F0074004E0075006C006C00140043
      006F006C0075006D006E004C006900730074000C0043006F006C0075006D006E
      00100053006F0075007200630065004900440018006400740041006E00730069
      0053007400720069006E00670010004400610074006100540079007000650008
      00530069007A0065001400530065006100720063006800610062006C00650012
      0041006C006C006F0077004E0075006C006C000800420061007300650014004F
      0041006C006C006F0077004E0075006C006C0012004F0049006E005500700064
      0061007400650010004F0049006E00570068006500720065001A004F00720069
      00670069006E0043006F006C004E0061006D006500140053006F007500720063
      006500530069007A00650010006400740044006F00750062006C0065001C0043
      006F006E00730074007200610069006E0074004C006900730074001000560069
      00650077004C006900730074000E0052006F0077004C00690073007400060052
      006F0077000A0052006F0077004900440016007200730055006E006300680061
      006E006700650064001A0052006F0077005000720069006F0072005300740061
      007400650010004F0072006900670069006E0061006C001800520065006C0061
      00740069006F006E004C006900730074001C0055007000640061007400650073
      004A006F00750072006E0061006C001200530061007600650050006F0069006E
      0074000E004300680061006E00670065007300}
    object TabSolicitaçõesDESCRICAO_ITEM: TStringField
      DisplayWidth = 50
      FieldName = 'DESCRICAO_ITEM'
      Size = 100
    end
    object TabSolicitaçõesQUANTIDADE: TFloatField
      DisplayWidth = 16
      FieldName = 'QUANTIDADE'
    end
    object TabSolicitaçõesUNIDADE: TStringField
      DisplayWidth = 20
      FieldName = 'UNIDADE'
      Size = 10
    end
    object TabSolicitaçõesPRIORIDADE: TStringField
      DisplayWidth = 20
      FieldName = 'PRIORIDADE'
    end
  end
  object ds: TDataSource
    DataSet = TabSolicitações
    Left = 240
    Top = 537
  end
end
