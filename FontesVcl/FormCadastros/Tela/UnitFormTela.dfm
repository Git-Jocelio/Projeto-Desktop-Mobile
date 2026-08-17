inherited FormTela: TFormTela
  Caption = 'FormTela'
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  TextHeight = 15
  inherited PnlHeader: TPanel
    inherited Label1: TLabel
      Width = 358
      Height = 45
      Caption = 'Telas (M'#243'dulos do sistema)'
      ExplicitWidth = 358
    end
    inherited Panel2: TPanel
      inherited btnInserir: TSpeedButton
        OnClick = btnInserirClick
      end
    end
    inherited Panel1: TPanel
      Left = 388
      Width = 422
      ExplicitLeft = 388
      ExplicitWidth = 422
      inherited Panel4: TPanel
        Left = 310
        ExplicitLeft = 310
        inherited btnFiltrar: TSpeedButton
          OnClick = btnFiltrarClick
        end
      end
      inherited edtFiltrar: TEdit
        Width = 295
        TextHint = 'Pesquisar pelo nome da tela'
        ExplicitWidth = 295
      end
    end
  end
  inherited dbg: TDBGrid
    DataSource = ds
    OnDblClick = dbgDblClick
    Columns = <
      item
        Expanded = False
        FieldName = 'ID_TELA'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        Title.Alignment = taCenter
        Title.Caption = 'Cod. Tela'
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -16
        Title.Font.Name = 'Segoe UI Semibold'
        Title.Font.Style = [fsBold]
        Width = 91
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOME_TELA'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        Title.Alignment = taCenter
        Title.Caption = 'Nome da Tela'
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -16
        Title.Font.Name = 'Segoe UI Semibold'
        Title.Font.Style = [fsBold]
        Width = 361
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'MODULO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        Title.Alignment = taCenter
        Title.Caption = 'M'#243'dulo'
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -16
        Title.Font.Name = 'Segoe UI Semibold'
        Title.Font.Style = [fsBold]
        Width = 292
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ORDEM'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        Title.Alignment = taCenter
        Title.Caption = 'Ordem'
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -16
        Title.Font.Name = 'Segoe UI Semibold'
        Title.Font.Style = [fsBold]
        Width = 104
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'ATIVO'
        Title.Alignment = taCenter
        Title.Caption = 'Ativo'
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -16
        Title.Font.Name = 'Segoe UI Semibold'
        Title.Font.Style = [fsBold]
        Width = 87
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ACOES'
        Title.Alignment = taCenter
        Title.Caption = 'A'#231#245'es'
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -16
        Title.Font.Name = 'Segoe UI Semibold'
        Title.Font.Style = [fsBold]
        Width = 116
        Visible = True
      end>
  end
end
