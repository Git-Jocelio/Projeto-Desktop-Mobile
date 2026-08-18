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
    Height = 167
    ExplicitWidth = 1368
    ExplicitHeight = 167
    inherited pnlPesquisa: TPanel
      Width = 925
      Height = 167
      ExplicitWidth = 925
      ExplicitHeight = 167
      inherited Label2: TLabel
        Width = 925
      end
      inherited Label3: TLabel
        Width = 925
        Caption = 'CADASTRAR COLABORADOR'
        ExplicitWidth = 279
      end
      inherited pnlBarraPequisa: TPanel
        Top = 94
        Width = 925
        ExplicitTop = 94
        ExplicitWidth = 925
        inherited edtFiltrar: TEdit
          Width = 838
          TextHint = 'Pesquisar pelo nome do colaborador'
          ExplicitWidth = 838
        end
        inherited pnlBtnFiltar: TPanel
          Left = 838
          ExplicitLeft = 838
          inherited btnFiltrar: TSpeedButton
            OnClick = btnFiltrarClick
          end
        end
      end
    end
    inherited pnlBotoes: TPanel
      Left = 995
      Top = 95
      Height = 69
      Margins.Top = 95
      ExplicitLeft = 995
      ExplicitTop = 95
      ExplicitHeight = 69
      inherited pnlBtnInserir: TPanel
        Height = 39
        ExplicitHeight = 39
        inherited btnInserir: TSpeedButton
          Height = 39
          OnClick = btnInserirClick
          ExplicitHeight = 39
        end
      end
      inherited pnlBtnEditar: TPanel
        Height = 39
        ExplicitHeight = 39
        inherited BtnEditar: TSpeedButton
          Height = 39
          ExplicitHeight = 39
        end
      end
      inherited PnlBotaoExcluir: TPanel
        Height = 39
        ExplicitHeight = 39
        inherited BtnExcluir: TSpeedButton
          Height = 39
        end
      end
    end
  end
  inherited pnlGrig: TPanel
    Top = 167
    Width = 1308
    Height = 180
    ExplicitTop = 167
    ExplicitWidth = 1308
    ExplicitHeight = 180
    inherited dbg: TDBGrid
      Width = 1308
      Height = 180
      DataSource = ds
      OnDblClick = dbgDblClick
      Columns = <
        item
          Alignment = taCenter
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
          Alignment = taCenter
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
          FieldName = 'SETOR'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
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
  inherited ds: TDataSource
    DataSet = DmColaborador.TabColaborador
  end
end
