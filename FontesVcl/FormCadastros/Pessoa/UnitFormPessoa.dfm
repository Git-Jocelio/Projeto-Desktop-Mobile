inherited FormPessoa: TFormPessoa
  Caption = 'FormPessoa'
  OnCreate = FormCreate
  TextHeight = 15
  inherited PnlHeader: TPanel
    inherited Label1: TLabel
      Height = 45
    end
    inherited Panel2: TPanel
      inherited btnInserir: TSpeedButton
        OnClick = btnInserirClick
      end
    end
    inherited Panel1: TPanel
      inherited Panel4: TPanel
        inherited btnFiltrar: TSpeedButton
          OnClick = btnFiltrarClick
        end
      end
    end
  end
  inherited dbg: TDBGrid
    DataSource = ds
    OnDblClick = dbgDblClick
    Columns = <
      item
        Expanded = False
        FieldName = 'PESSOAID'
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
        Title.Caption = 'Telefone'
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
        FieldName = 'EMAIL'
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
end
