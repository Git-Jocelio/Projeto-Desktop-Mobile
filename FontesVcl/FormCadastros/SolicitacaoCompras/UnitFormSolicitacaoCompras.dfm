inherited FormSolicitacaoCompras: TFormSolicitacaoCompras
  Caption = 'FormSolicitacaoCompras'
  ClientHeight = 548
  ClientWidth = 1446
  OnShow = FormShow
  ExplicitWidth = 1446
  ExplicitHeight = 548
  TextHeight = 15
  inherited PnlHeader: TPanel
    Width = 1446
    ExplicitWidth = 1292
    inherited Label1: TLabel
      Width = 311
      Height = 45
      Caption = 'Solicita'#231#245'es de compra '
      ExplicitWidth = 311
    end
    object SpeedButton1: TSpeedButton [1]
      Left = 919
      Top = 15
      Width = 39
      Height = 35
      Caption = '?'
      OnClick = SpeedButton1Click
    end
    inherited PnlBotaoInserir: TPanel
      Left = 1334
      ExplicitLeft = 1180
    end
    inherited Panel2: TPanel
      Left = 1090
      ExplicitLeft = 936
      inherited btnInserir: TSpeedButton
        OnClick = btnInserirClick
      end
    end
    inherited Panel3: TPanel
      Left = 1212
      ExplicitLeft = 1058
    end
    inherited Panel1: TPanel
      Left = 341
      Width = 689
      ExplicitLeft = 341
      ExplicitWidth = 535
      inherited Panel4: TPanel
        Left = 577
        ExplicitLeft = 469
        inherited btnFiltrar: TSpeedButton
          Height = 36
        end
      end
      inherited edtFiltrar: TEdit
        Width = 562
        Font.Charset = ANSI_CHARSET
        TextHint = 'Digite o nome do Departamento'
        ExplicitWidth = 50
      end
      object ComboBox1: TComboBox
        AlignWithMargins = True
        Left = 15
        Top = 15
        Width = 562
        Height = 38
        Margins.Left = 15
        Margins.Top = 15
        Margins.Right = 0
        Margins.Bottom = 15
        Align = alClient
        Style = csDropDownList
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -21
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        TextHint = 'Selecione um departamento'
        Items.Strings = (
          'Departamento Financeiro'
          'Departamento Comercial'
          'Departamento de Compras'
          'Suporte'
          'Desenvolvimento'
          'Recursos Humanos'
          'Departamento de Marketing'
          'Diretoria'
          'TODOS')
        ExplicitLeft = 16
        ExplicitTop = 42
        ExplicitWidth = 417
      end
    end
  end
  inherited dbg: TDBGrid
    Top = 233
    Width = 1446
    Height = 315
    Columns = <
      item
        Expanded = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        Title.Alignment = taCenter
        Title.Caption = 'Data Solicita'#231#227'o'
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -15
        Title.Font.Name = 'Segoe UI'
        Title.Font.Style = []
        Width = 133
        Visible = True
      end
      item
        Expanded = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        Title.Alignment = taCenter
        Title.Caption = 'Departamento'
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -15
        Title.Font.Name = 'Segoe UI'
        Title.Font.Style = []
        Width = 393
        Visible = True
      end
      item
        Expanded = False
        Title.Alignment = taCenter
        Title.Caption = 'Colaborador'
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -15
        Title.Font.Name = 'Segoe UI'
        Title.Font.Style = []
        Width = 268
        Visible = True
      end
      item
        Expanded = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        Title.Alignment = taCenter
        Title.Caption = 'Situa'#231#227'o'
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -15
        Title.Font.Name = 'Segoe UI'
        Title.Font.Style = []
        Width = 183
        Visible = True
      end
      item
        Expanded = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        Title.Alignment = taCenter
        Title.Caption = 'Prioridade'
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -15
        Title.Font.Name = 'Segoe UI'
        Title.Font.Style = []
        Width = 125
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        Title.Alignment = taCenter
        Title.Caption = 'A'#231#245'es'
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -15
        Title.Font.Name = 'Segoe UI'
        Title.Font.Style = []
        Width = 130
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        Title.Alignment = taCenter
        Title.Caption = 'Novas Mensagens'
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -15
        Title.Font.Name = 'Segoe UI'
        Title.Font.Style = []
        Width = 149
        Visible = True
      end>
  end
  object pnlPesquisa: TPanel [2]
    Left = 0
    Top = 65
    Width = 1446
    Height = 168
    Align = alTop
    BevelOuter = bvNone
    Color = 16051947
    ParentBackground = False
    TabOrder = 2
    ExplicitWidth = 1338
    object Label2: TLabel
      Left = 16
      Top = 25
      Width = 100
      Height = 15
      Caption = 'Data de solicita'#231#227'o'
      Font.Charset = ANSI_CHARSET
      Font.Color = clGray
      Font.Height = -12
      Font.Name = 'Segoe UI Semibold'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 221
      Top = 51
      Width = 6
      Height = 15
      Caption = #225
      Font.Charset = ANSI_CHARSET
      Font.Color = clGray
      Font.Height = -12
      Font.Name = 'Segoe UI Semibold'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label5: TLabel
      Left = 16
      Top = 92
      Width = 50
      Height = 15
      Caption = 'Categoria'
      Font.Charset = ANSI_CHARSET
      Font.Color = clGray
      Font.Height = -12
      Font.Name = 'Segoe UI Semibold'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object RadioGroup1: TRadioGroup
      Left = 461
      Top = 25
      Width = 241
      Height = 109
      Caption = ' Situa'#231#227'o da Solicita'#231#227'o '
      Font.Charset = ANSI_CHARSET
      Font.Color = clGray
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ItemIndex = 1
      Items.Strings = (
        'Em an'#225'lise'
        'Aprovado para Cota'#231#227'o'
        'Rejeitado pelo Gestor')
      ParentFont = False
      TabOrder = 0
    end
    object dtp_data_solicitacao_ini: TDateTimePicker
      Left = 16
      Top = 47
      Width = 193
      Height = 23
      Date = 46122.000000000000000000
      Time = 0.384940891206497300
      Font.Charset = ANSI_CHARSET
      Font.Color = clGray
      Font.Height = -12
      Font.Name = 'Segoe UI Semibold'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
    end
    object dtp_data_solicitacao_fim: TDateTimePicker
      Left = 240
      Top = 47
      Width = 193
      Height = 23
      Date = 46122.000000000000000000
      Time = 0.384940891206497300
      Font.Charset = ANSI_CHARSET
      Font.Color = clGray
      Font.Height = -12
      Font.Name = 'Segoe UI Semibold'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
    end
    object ComboBox2: TComboBox
      Left = 16
      Top = 111
      Width = 417
      Height = 23
      Style = csDropDownList
      Font.Charset = ANSI_CHARSET
      Font.Color = clGray
      Font.Height = -12
      Font.Name = 'Segoe UI Semibold'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      TextHint = 'Selecione uma categoria'
      Items.Strings = (
        'Material de Escrit'#243'rio'
        'Material de Limpesa'
        'Produtos Aliment'#237'cios'
        'Ativos(Escrit'#243'rio)'
        'Ativos(TI)'
        'Outros ')
    end
  end
  inherited ds: TDataSource
    Left = 430
    Top = 256
  end
  inherited ImageList: TImageList
    Left = 536
    Top = 272
  end
end
