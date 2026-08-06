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
    inherited Label1: TLabel
      Width = 280
      Height = 45
      Caption = ' Usu'#225'rios do sistema '
      ExplicitWidth = 280
    end
    inherited PnlBotaoInserir: TPanel
      Left = 1188
      ExplicitLeft = 1188
    end
    inherited Panel2: TPanel
      Left = 944
      ExplicitLeft = 944
      inherited btnInserir: TSpeedButton
        OnClick = btnInserirClick
      end
    end
    inherited Panel3: TPanel
      Left = 1066
      ExplicitLeft = 1066
    end
    inherited Panel1: TPanel
      Left = 310
      Width = 574
      ExplicitLeft = 310
      ExplicitWidth = 574
      inherited Panel4: TPanel
        Left = 462
        ExplicitLeft = 462
      end
      inherited edtFiltrar: TEdit
        Width = 447
        ExplicitWidth = 447
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
