inherited FormSolicitacaoCompras: TFormSolicitacaoCompras
  Caption = 'FormSolicitacaoCompras'
  ClientHeight = 548
  ClientWidth = 1292
  ExplicitWidth = 1292
  ExplicitHeight = 548
  TextHeight = 15
  inherited PnlHeader: TPanel
    Width = 1292
    ExplicitWidth = 1292
    inherited Label1: TLabel
      Width = 311
      Height = 45
      Caption = 'Solicita'#231#245'es de compra '
      ExplicitWidth = 311
    end
    inherited PnlBotaoInserir: TPanel
      Left = 1180
      ExplicitLeft = 1180
    end
    inherited Panel2: TPanel
      Left = 936
      ExplicitLeft = 936
      inherited btnInserir: TSpeedButton
        OnClick = btnInserirClick
      end
    end
    inherited Panel3: TPanel
      Left = 1058
      ExplicitLeft = 1058
    end
    inherited Panel1: TPanel
      Left = 341
      Width = 535
      ExplicitLeft = 341
      ExplicitWidth = 535
      inherited Panel4: TPanel
        Left = 423
        ExplicitLeft = 423
      end
      inherited edtFiltrar: TEdit
        Width = 408
        TextHint = 'Digite o nome do Departamento'
        ExplicitWidth = 408
      end
    end
  end
  inherited dbg: TDBGrid
    Top = 177
    Width = 1292
    Height = 371
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
        Title.Font.Name = 'Segoe UI Semibold'
        Title.Font.Style = [fsBold]
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
        Title.Font.Name = 'Segoe UI Semibold'
        Title.Font.Style = [fsBold]
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
        Title.Font.Name = 'Segoe UI Semibold'
        Title.Font.Style = [fsBold]
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
        Title.Font.Name = 'Segoe UI Semibold'
        Title.Font.Style = [fsBold]
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
        Title.Font.Name = 'Segoe UI Semibold'
        Title.Font.Style = [fsBold]
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
        Title.Font.Name = 'Segoe UI Semibold'
        Title.Font.Style = [fsBold]
        Width = 130
        Visible = True
      end>
  end
  object Panel5: TPanel [2]
    Left = 0
    Top = 65
    Width = 1292
    Height = 112
    Align = alTop
    BevelOuter = bvNone
    Color = 16051947
    ParentBackground = False
    TabOrder = 2
    object RadioGroup1: TRadioGroup
      Left = 0
      Top = 0
      Width = 1292
      Height = 112
      Align = alClient
      Caption = ' Situa'#231#227'o da Solicita'#231#227'o '
      Columns = 3
      Font.Charset = ANSI_CHARSET
      Font.Color = clGray
      Font.Height = -16
      Font.Name = 'Segoe UI Semibold'
      Font.Style = [fsBold]
      ItemIndex = 1
      Items.Strings = (
        'Em an'#225'lise'
        'Aprovado para Cota'#231#227'o'
        'Rejeitado pelo Gestor')
      ParentFont = False
      TabOrder = 0
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
