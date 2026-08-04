inherited FormUsuarioE: TFormUsuarioE
  Caption = 'FormUsuarioE'
  ClientHeight = 326
  ClientWidth = 480
  OnShow = FormShow
  ExplicitWidth = 480
  ExplicitHeight = 326
  TextHeight = 15
  inherited lblTitulo: TLabel
    Width = 295
    Caption = 'Cadastro do acesso ao sistema'
    ExplicitWidth = 295
  end
  object Label4: TLabel [1]
    Left = 24
    Top = 86
    Width = 66
    Height = 15
    Caption = 'Colaborador'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 8289918
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel [2]
    Left = 24
    Top = 160
    Width = 30
    Height = 15
    Caption = 'Login'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 8289918
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object Label6: TLabel [3]
    Left = 274
    Top = 160
    Width = 32
    Height = 15
    Caption = 'Senha'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 8289918
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  inherited pnlBotaoSalvar: TPanel
    Left = 118
    Top = 281
    ExplicitLeft = 118
    ExplicitTop = 281
    inherited btnSalvar: TSpeedButton
      ExplicitTop = -24
    end
  end
  inherited pnlBotaoCancelar: TPanel
    Left = 232
    Top = 280
    ExplicitLeft = 232
    ExplicitTop = 280
  end
  object edtLogin: TEdit [6]
    Left = 24
    Top = 181
    Width = 233
    Height = 29
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 8289918
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
  end
  object edtSenha: TEdit [7]
    Left = 274
    Top = 181
    Width = 183
    Height = 29
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 8289918
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
  end
  object cbAtivo: TCheckBox [8]
    Left = 24
    Top = 240
    Width = 97
    Height = 17
    Caption = 'Ativo'
    Font.Charset = ANSI_CHARSET
    Font.Color = 8289918
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
  end
  object cbxColaboradores: TDBLookupComboBox [9]
    Left = 24
    Top = 107
    Width = 433
    Height = 29
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 8289918
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    KeyField = 'PESSOAID'
    ListField = 'NOME'
    ListSource = dsColaboradores
    ParentFont = False
    TabOrder = 5
  end
  object dsColaboradores: TDataSource
    DataSet = dmUsuario.TabColaboradores
    Left = 376
    Top = 232
  end
end
