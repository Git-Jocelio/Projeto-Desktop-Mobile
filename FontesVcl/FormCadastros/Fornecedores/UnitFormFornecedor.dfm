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
    inherited pnlPesquisa: TPanel
      Width = 765
      ExplicitWidth = 765
      inherited Label2: TLabel
        Width = 765
        Caption = 'Cadastro de fornecedores'
        ExplicitWidth = 194
      end
      inherited Label3: TLabel
        Width = 765
        Caption = 'CADASTRAR FORNECEDOR'
        ExplicitWidth = 260
      end
      inherited pnlBarraPequisa: TPanel
        Width = 765
        ExplicitWidth = 765
        inherited edtFiltrar: TEdit
          Width = 678
          TextHint = 'Pesquisar pelo nome do fornecedor'
          ExplicitWidth = 678
        end
        inherited pnlBtnFiltar: TPanel
          Left = 678
          ExplicitLeft = 678
          inherited btnFiltrar: TSpeedButton
            OnClick = btnFiltrarClick
          end
        end
      end
    end
    inherited pnlBotoes: TPanel
      Left = 835
      ExplicitLeft = 835
      inherited pnlBtnInserir: TPanel
        inherited btnInserir: TSpeedButton
          OnClick = btnInserirClick
        end
      end
    end
  end
  inherited pnlGrig: TPanel
    Width = 1148
    Height = 217
    ExplicitWidth = 1148
    ExplicitHeight = 217
    inherited dbg: TDBGrid
      Width = 1148
      Height = 217
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
  end
  inherited ds: TDataSource
    DataSet = DmFornecedor.TabFornecedor
  end
end
