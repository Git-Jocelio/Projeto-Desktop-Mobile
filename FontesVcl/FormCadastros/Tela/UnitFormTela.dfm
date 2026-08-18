inherited FormTela: TFormTela
  Caption = 'FormTela'
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  TextHeight = 15
  inherited PnlHeader: TPanel
    inherited pnlPesquisa: TPanel
      inherited Label2: TLabel
        Caption = 'Telas/M'#243'dulos do sistema'
        ExplicitWidth = 198
      end
      inherited Label3: TLabel
        Caption = 'CADASTRAR TELAS (RECURSOS)'
        ExplicitWidth = 307
      end
      inherited pnlBarraPequisa: TPanel
        inherited pnlBtnFiltar: TPanel
          inherited btnFiltrar: TSpeedButton
            OnClick = btnFiltrarClick
          end
        end
      end
    end
  end
  inherited pnlGrig: TPanel
    inherited dbg: TDBGrid
      DataSource = ds
      OnDblClick = dbgDblClick
      Columns = <
        item
          Alignment = taCenter
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
          Title.Font.Height = -15
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
          Title.Font.Height = -15
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
          Title.Font.Height = -15
          Title.Font.Name = 'Segoe UI Semibold'
          Title.Font.Style = [fsBold]
          Width = 405
          Visible = True
        end
        item
          Alignment = taCenter
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
          Title.Font.Height = -15
          Title.Font.Name = 'Segoe UI Semibold'
          Title.Font.Style = [fsBold]
          Width = 159
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'ATIVO'
          Title.Caption = 'Ativo'
          Title.Font.Charset = ANSI_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -15
          Title.Font.Name = 'Segoe UI Semibold'
          Title.Font.Style = [fsBold]
          Width = 80
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
          Width = 141
          Visible = True
        end>
    end
  end
  inherited ds: TDataSource
    DataSet = DmTela.memTable
  end
end
