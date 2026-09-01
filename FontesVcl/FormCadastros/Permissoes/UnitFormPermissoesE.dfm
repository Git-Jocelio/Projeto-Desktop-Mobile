inherited FormPermissoesE: TFormPermissoesE
  Caption = 'Permiss'#245'es por perfil'
  ClientHeight = 429
  ClientWidth = 727
  OnShow = FormShow
  ExplicitWidth = 727
  ExplicitHeight = 429
  TextHeight = 15
  inherited lblTitulo: TLabel
    Width = 717
    Margins.Bottom = 0
    Align = alTop
    Caption = 'DEFINIR PERMISS'#195'O PARA CADA PERFIL'
    ExplicitWidth = 386
  end
  object Label2: TLabel [1]
    Left = 0
    Top = 40
    Width = 727
    Height = 21
    Align = alTop
    Caption = '  Permiss'#245'es que cada perfil ter'#225' em cada tela.'
    Font.Charset = ANSI_CHARSET
    Font.Color = clGray
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
    ExplicitWidth = 350
  end
  object Label4: TLabel [2]
    Left = 24
    Top = 86
    Width = 27
    Height = 15
    Caption = 'Perfil'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 8289918
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  inherited pnlBotaoSalvar: TPanel
    Left = 255
    Top = 388
    ExplicitLeft = 255
    ExplicitTop = 388
  end
  inherited pnlBotaoCancelar: TPanel
    Left = 369
    Top = 387
    ExplicitLeft = 369
    ExplicitTop = 387
  end
  object cbxPerfil: TDBLookupComboBox [5]
    Left = 57
    Top = 78
    Width = 648
    Height = 29
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 8289918
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    KeyField = 'id_perfil'
    ListField = 'descricao'
    ListSource = ds
    ParentFont = False
    TabOrder = 2
  end
  object DBGrid1: TDBGrid [6]
    Left = 24
    Top = 120
    Width = 681
    Height = 256
    BorderStyle = bsNone
    Color = clWhite
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'ID'
        Title.Alignment = taCenter
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -12
        Title.Font.Name = 'Segoe UI Semibold'
        Title.Font.Style = [fsBold]
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'nome_tela'
        Title.Alignment = taCenter
        Title.Caption = 'Tela(Recurso)'
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -12
        Title.Font.Name = 'Segoe UI Semibold'
        Title.Font.Style = [fsBold]
        Width = 227
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ver'
        Title.Alignment = taCenter
        Title.Caption = 'Visualizar'
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -12
        Title.Font.Name = 'Segoe UI Semibold'
        Title.Font.Style = [fsBold]
        Width = 75
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'inserir'
        Title.Alignment = taCenter
        Title.Caption = 'Inserir'
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -12
        Title.Font.Name = 'Segoe UI Semibold'
        Title.Font.Style = [fsBold]
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'alterar'
        Title.Alignment = taCenter
        Title.Caption = 'Alterar'
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -12
        Title.Font.Name = 'Segoe UI Semibold'
        Title.Font.Style = [fsBold]
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'excluir'
        Title.Alignment = taCenter
        Title.Caption = 'Excluir'
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -12
        Title.Font.Name = 'Segoe UI Semibold'
        Title.Font.Style = [fsBold]
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'imprimir'
        Title.Alignment = taCenter
        Title.Caption = 'Imprimir'
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -12
        Title.Font.Name = 'Segoe UI Semibold'
        Title.Font.Style = [fsBold]
        Visible = True
      end>
  end
  inherited MemTable: TFDMemTable
    Left = 485
  end
  object ds: TDataSource
    DataSet = DmPerfil.MemTable
    Left = 424
    Top = 24
  end
end
