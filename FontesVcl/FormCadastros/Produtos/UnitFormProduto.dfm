inherited FormProduto: TFormProduto
  Caption = 'Produtos'
  OnCreate = FormCreate
  TextHeight = 15
  inherited PnlHeader: TPanel
    inherited Label1: TLabel
      Width = 106
      Height = 45
      Caption = 'Produto'
      ExplicitWidth = 106
    end
    inherited PnlBotaoInserir: TPanel
      inherited BtnExcluir: TSpeedButton
        OnClick = BtnExcluirClick
      end
    end
    inherited Panel2: TPanel
      inherited btnInserir: TSpeedButton
        OnClick = btnInserirClick
      end
    end
    inherited Panel1: TPanel
      Left = 136
      Width = 674
      ExplicitLeft = 136
      ExplicitWidth = 674
      inherited Panel4: TPanel
        Left = 562
        ExplicitLeft = 562
        inherited btnFiltrar: TSpeedButton
          OnClick = btnFiltrarClick
        end
      end
      inherited edtFiltrar: TEdit
        Width = 547
        TextHint = 'Digite a descri'#231#227'o do produto'
        ExplicitWidth = 547
      end
    end
  end
  inherited dbg: TDBGrid
    OnDblClick = dbgDblClick
    Columns = <
      item
        Expanded = False
        FieldName = 'PRODUTOID'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        Title.Alignment = taCenter
        Title.Caption = 'Cod. Produto'
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
        Width = 361
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'UNIDADE'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        Title.Alignment = taCenter
        Title.Caption = 'Unidade'
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
        FieldName = 'ESTOQUE'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        Title.Alignment = taCenter
        Title.Caption = 'Qtde Estoque'
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
