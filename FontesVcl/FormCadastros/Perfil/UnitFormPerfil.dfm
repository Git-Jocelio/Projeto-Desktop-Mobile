inherited FormPerfil: TFormPerfil
  Caption = 'FormPerfil'
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  TextHeight = 15
  inherited PnlHeader: TPanel
    inherited Label1: TLabel
      Width = 357
      Height = 45
      Caption = 'Perfis de acesso ao sistema'
      ExplicitWidth = 357
    end
    inherited Panel2: TPanel
      inherited btnInserir: TSpeedButton
        OnClick = btnInserirClick
      end
    end
    inherited Panel1: TPanel
      Left = 387
      Width = 423
      ExplicitLeft = 387
      ExplicitWidth = 423
      inherited Panel4: TPanel
        Left = 311
        ExplicitLeft = 311
      end
      inherited edtFiltrar: TEdit
        Width = 296
        TextHint = 'Pesquisar perfil'
        ExplicitWidth = 296
      end
    end
  end
  inherited dbg: TDBGrid
    DataSource = ds
    OnDblClick = dbgDblClick
    Columns = <
      item
        Expanded = False
        FieldName = 'ID_PERFIL'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        Title.Alignment = taCenter
        Title.Caption = 'Cod. Perfil'
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
        FieldName = 'DESCRICAO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        Title.Alignment = taCenter
        Title.Caption = 'Descri'#231#227'o'
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -15
        Title.Font.Name = 'Segoe UI Semibold'
        Title.Font.Style = [fsBold]
        Width = 344
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'OBS'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        Title.Alignment = taCenter
        Title.Caption = 'Observa'#231#227'o'
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -15
        Title.Font.Name = 'Segoe UI Semibold'
        Title.Font.Style = [fsBold]
        Width = 587
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'ACOES'
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
  inherited ds: TDataSource
    AutoEdit = True
    DataSet = DmPerfil.MemTable
  end
end
