inherited FormColaborador: TFormColaborador
  Caption = 'FormColaborador'
  ClientHeight = 377
  ClientWidth = 1368
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  ExplicitWidth = 1368
  ExplicitHeight = 377
  TextHeight = 15
  inherited PnlHeader: TPanel
    Width = 1368
    ExplicitWidth = 1368
    inherited Label1: TLabel
      Width = 163
      Height = 45
      Caption = 'Colaborador'
      ExplicitWidth = 163
    end
    inherited PnlBotaoInserir: TPanel
      Left = 1256
      Visible = True
      ExplicitLeft = 1256
    end
    inherited Panel2: TPanel
      Left = 1012
      ExplicitLeft = 1012
      inherited btnInserir: TSpeedButton
        OnClick = btnInserirClick
      end
    end
    inherited Panel3: TPanel
      Left = 1134
      ExplicitLeft = 1134
    end
    inherited Panel1: TPanel
      Left = 193
      Width = 759
      ExplicitLeft = 193
      ExplicitWidth = 759
      inherited Panel4: TPanel
        Left = 647
        ExplicitLeft = 647
        inherited btnFiltrar: TSpeedButton
          OnClick = btnFiltrarClick
        end
      end
      inherited edtFiltrar: TEdit
        Width = 632
        TextHint = 'Digite o nome do colaborador'
        ExplicitWidth = 632
      end
    end
  end
  inherited dbg: TDBGrid
    Width = 1368
    Height = 312
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
        Title.Caption = 'Cod. Pessoa'
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -15
        Title.Font.Name = 'Segoe UI Semibold'
        Title.Font.Style = [fsBold]
        Width = 110
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
        Title.Caption = 'Telefone'
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -15
        Title.Font.Name = 'Segoe UI Semibold'
        Title.Font.Style = [fsBold]
        Width = 184
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
        Title.Caption = 'Email'
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -15
        Title.Font.Name = 'Segoe UI Semibold'
        Title.Font.Style = [fsBold]
        Width = 265
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'SETOR'
        Title.Caption = 'Setor'
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -15
        Title.Font.Name = 'Segoe UI Semibold'
        Title.Font.Style = [fsBold]
        Width = 143
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'ACOES'
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
    DataSet = DmColaborador.TabColaborador
  end
end
