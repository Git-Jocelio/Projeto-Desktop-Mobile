inherited FormUsuario: TFormUsuario
  Caption = 'FormUsuario'
  ClientWidth = 1300
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  ExplicitWidth = 1300
  TextHeight = 15
  inherited PnlHeader: TPanel
    Width = 1300
    ExplicitWidth = 1300
    inherited Panel1: TPanel
      Width = 1230
      ExplicitWidth = 864
      inherited Label2: TLabel
        Width = 1230
        Caption = 'Cadastro de acesso ao sistema.'
        ExplicitWidth = 233
      end
      inherited Label3: TLabel
        Width = 1230
        Caption = 'CRIAR USU'#193'RIO PARA O COLABORADOR'
        ExplicitWidth = 395
      end
      inherited Panel4: TPanel
        Left = 462
        ExplicitLeft = 462
      end
      inherited edtFiltrar: TEdit
        Width = 447
        TextHint = 'Pesquisar pelo nome do colaborador'
        ExplicitWidth = 447
      end
      inherited pnlBotoes: TPanel
        Left = 857
      end
    end
  end
  inherited dbg: TDBGrid
    Width = 1300
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
        Title.Font.Height = -16
        Title.Font.Name = 'Segoe UI Semibold'
        Title.Font.Style = [fsBold]
        Width = 99
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
        Title.Caption = 'Colaborador'
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -16
        Title.Font.Name = 'Segoe UI Semibold'
        Title.Font.Style = [fsBold]
        Width = 399
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'LOGIN'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        Title.Alignment = taCenter
        Title.Caption = 'Login'
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -16
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
        Title.Alignment = taCenter
        Title.Caption = 'Email'
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -16
        Title.Font.Name = 'Segoe UI Semibold'
        Title.Font.Style = [fsBold]
        Width = 370
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'ATIVO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        Title.Alignment = taCenter
        Title.Caption = 'Ativo'
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -16
        Title.Font.Name = 'Segoe UI Semibold'
        Title.Font.Style = [fsBold]
        Width = 74
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ACOES'
        Title.Alignment = taCenter
        Title.Caption = 'A'#231#245'es'
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -15
        Title.Font.Name = 'Segoe UI Semibold'
        Title.Font.Style = [fsBold]
        Width = 112
        Visible = True
      end>
  end
  inherited ds: TDataSource
    DataSet = dmUsuario.MemTable
  end
end
