inherited FormFornecedor: TFormFornecedor
  Caption = 'FormFornecedor'
  ClientHeight = 400
  ClientWidth = 1208
  OnCreate = FormCreate
  ExplicitWidth = 1208
  ExplicitHeight = 400
  TextHeight = 15
  inherited PnlHeader: TPanel
    Width = 1208
    ExplicitWidth = 1208
    inherited PnlBotaoInserir: TPanel
      Left = 1096
      ExplicitLeft = 1096
      ExplicitHeight = 123
    end
    inherited Panel2: TPanel
      Left = 852
      ExplicitLeft = 852
      ExplicitHeight = 123
      inherited btnInserir: TSpeedButton
        OnClick = btnInserirClick
      end
    end
    inherited Panel3: TPanel
      Left = 974
      ExplicitLeft = 974
      ExplicitHeight = 123
    end
    inherited Panel1: TPanel
      Width = 772
      ExplicitLeft = 20
      ExplicitWidth = 772
      ExplicitHeight = 153
      inherited Label2: TLabel
        Width = 772
        Caption = 'Cadastro dos fornecedores da empresa'
        ExplicitWidth = 294
      end
      inherited Label3: TLabel
        Width = 772
        Caption = 'CADASTRAR FORNECEDOR'
        ExplicitWidth = 260
      end
      inherited Panel4: TPanel
        Left = 501
        ExplicitLeft = 501
        inherited btnFiltrar: TSpeedButton
          OnClick = btnFiltrarClick
        end
      end
      inherited edtFiltrar: TEdit
        Width = 486
        TextHint = 'Pesquisar pelo nome do fornecedor'
        ExplicitWidth = 486
      end
    end
  end
  inherited dbg: TDBGrid
    Width = 1208
    Height = 247
    DataSource = ds
    OnDblClick = dbgDblClick
    Columns = <
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'pessoaId'
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
        FieldName = 'nome'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        Title.Alignment = taCenter
        Title.Caption = 'Fornecedor'
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
        FieldName = 'contato'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        Title.Alignment = taCenter
        Title.Caption = 'Contato'
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -15
        Title.Font.Name = 'Segoe UI Semibold'
        Title.Font.Style = [fsBold]
        Width = 405
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'telefone_contato'
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
  inherited ds: TDataSource
    DataSet = DmFornecedor.TabFornecedor
  end
end
