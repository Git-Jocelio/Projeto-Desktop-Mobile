inherited FormPerfilE: TFormPerfilE
  Caption = 'FormPerfilE'
  ClientHeight = 397
  ClientWidth = 421
  OnShow = FormShow
  ExplicitWidth = 421
  ExplicitHeight = 397
  TextHeight = 15
  inherited lblTitulo: TLabel
    Width = 297
    Caption = 'Alterar minha senha de usu'#225'rio'
    ExplicitWidth = 297
  end
  object Nome: TLabel [1]
    Left = 46
    Top = 85
    Width = 33
    Height = 15
    Caption = 'Nome'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 8289918
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object Email: TLabel [2]
    Left = 46
    Top = 144
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
  object Label2: TLabel [3]
    Left = 46
    Top = 217
    Width = 62
    Height = 15
    Caption = 'Nova senha'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 8289918
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel [4]
    Left = 46
    Top = 289
    Width = 122
    Height = 15
    Caption = 'Confirme a nova senha'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 8289918
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  inherited pnlBotaoSalvar: TPanel
    Left = 108
    Top = 353
    Anchors = [akRight, akBottom]
    ExplicitLeft = 103
    ExplicitTop = 353
    inherited btnSalvar: TSpeedButton
      OnClick = btnSalvarClick
    end
  end
  inherited pnlBotaoCancelar: TPanel
    Left = 223
    Top = 353
    Anchors = [akRight, akBottom]
    ExplicitLeft = 218
    ExplicitTop = 353
    inherited btnCancelar: TSpeedButton
      ExplicitHeight = 30
    end
  end
  object edtNome: TEdit [7]
    Left = 46
    Top = 106
    Width = 326
    Height = 29
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 8289918
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
  end
  object edtEmail: TEdit [8]
    Left = 46
    Top = 165
    Width = 326
    Height = 29
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 8289918
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
  end
  object edtNovaSenha: TEdit [9]
    Left = 46
    Top = 238
    Width = 326
    Height = 29
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 8289918
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
  end
  object edtConfirmarSenha: TEdit [10]
    Left = 46
    Top = 310
    Width = 326
    Height = 29
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 8289918
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
  end
  inherited MemTable: TFDMemTable
    Left = 304
    Top = 40
  end
end
