inherited FormPerfil: TFormPerfil
  Caption = 'FormPerfil'
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  TextHeight = 15
  inherited PnlHeader: TPanel
    inherited pnlPesquisa: TPanel
      inherited Label2: TLabel
        Width = 1088
        Caption = 'Perfis que agrupam permiss'#245'es.'
        ExplicitWidth = 242
      end
      inherited Label3: TLabel
        Width = 1088
        Caption = 'CADASTRAR PERFIS'
        ExplicitWidth = 189
      end
      inherited pnlBarraPequisa: TPanel
        inherited edtFiltrar: TEdit
          TextHint = 'Pesquisar pela descri'#231#227'o do perfil'
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
  end
  inherited ds: TDataSource
    AutoEdit = True
    DataSet = DmPerfil.MemTable
  end
end
