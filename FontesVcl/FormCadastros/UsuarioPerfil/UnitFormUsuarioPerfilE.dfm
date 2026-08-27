inherited FormUsuarioPerfilE: TFormUsuarioPerfilE
  Caption = 'FormUsuarioPerfilE'
  ClientHeight = 537
  ClientWidth = 613
  Font.Charset = ANSI_CHARSET
  Font.Color = clGray
  Font.Height = -16
  Font.Name = 'Segoe UI Semibold'
  Font.Style = [fsBold]
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  ExplicitWidth = 613
  ExplicitHeight = 537
  TextHeight = 21
  inherited lblTitulo: TLabel
    Width = 250
    Caption = 'Vincular usu'#225'rio aos perfis'
    ExplicitWidth = 250
  end
  object Label1: TLabel [1]
    Left = 10
    Top = 53
    Width = 127
    Height = 21
    Caption = 'Dados do usu'#225'rio'
    Color = clGray
    Font.Charset = ANSI_CHARSET
    Font.Color = clGray
    Font.Height = -16
    Font.Name = 'Segoe UI Semibold'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
  end
  object Label2: TLabel [2]
    Left = 10
    Top = 101
    Width = 11
    Height = 15
    Caption = 'ID'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 8289918
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel [3]
    Left = 8
    Top = 157
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
  object Label7: TLabel [4]
    Left = 322
    Top = 101
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
  object Label6: TLabel [5]
    Left = 323
    Top = 157
    Width = 29
    Height = 15
    Caption = 'Email'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 8289918
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object Label4: TLabel [6]
    Left = 20
    Top = 200
    Width = 332
    Height = 17
    Caption = 'os itens marcados ser'#227'o salvos na tabela usuario_perfil'
    Font.Charset = ANSI_CHARSET
    Font.Color = clRed
    Font.Height = -13
    Font.Name = 'Segoe UI Semibold'
    Font.Style = []
    ParentFont = False
  end
  object Label8: TLabel [7]
    Left = 20
    Top = 184
    Width = 560
    Height = 15
    Caption = 
      'ao abrir o form ser'#227'o apresentados todos o perfis disponiveis e ' +
      'ser'#225' marcado  os vinculados com o usuario'
    Font.Charset = ANSI_CHARSET
    Font.Color = clRed
    Font.Height = -12
    Font.Name = 'Segoe UI Semibold'
    Font.Style = []
    ParentFont = False
  end
  object Label9: TLabel [8]
    Left = 20
    Top = 223
    Width = 441
    Height = 15
    Caption = 
      'ao clicar em salvar excluir os todos perfis do usuario e salvar ' +
      'a lista atual novamente'
    Font.Charset = ANSI_CHARSET
    Font.Color = clRed
    Font.Height = -12
    Font.Name = 'Segoe UI Semibold'
    Font.Style = []
    ParentFont = False
  end
  inherited pnlBotaoSalvar: TPanel
    Left = 183
    Top = 503
    ExplicitLeft = 183
    ExplicitTop = 503
    inherited btnSalvar: TSpeedButton
      OnClick = btnSalvarClick
    end
  end
  inherited pnlBotaoCancelar: TPanel
    Left = 297
    Top = 502
    ExplicitLeft = 297
    ExplicitTop = 502
  end
  object edtUsuarioId: TEdit [11]
    Left = 29
    Top = 95
    Width = 251
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
  object edtNome: TEdit [12]
    Left = 47
    Top = 149
    Width = 233
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
  object edtLogin: TEdit [13]
    Left = 365
    Top = 95
    Width = 233
    Height = 29
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 8289918
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
  end
  object edtEmail: TEdit [14]
    Left = 365
    Top = 149
    Width = 233
    Height = 29
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 8289918
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
  end
  object Panel2: TPanel [15]
    Left = 8
    Top = 241
    Width = 599
    Height = 255
    BevelOuter = bvNone
    Color = clWhite
    Font.Charset = ANSI_CHARSET
    Font.Color = clGray
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentBackground = False
    ParentFont = False
    TabOrder = 6
    object Label5: TLabel
      AlignWithMargins = True
      Left = 0
      Top = 0
      Width = 599
      Height = 20
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 5
      Align = alTop
      Caption = 'Perfis Dispon'#237'veis'
      Color = 16744448
      Font.Charset = ANSI_CHARSET
      Font.Color = 16744448
      Font.Height = -15
      Font.Name = 'Segoe UI Semibold'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      ExplicitWidth = 119
    end
    object DBGrid1: TDBGrid
      Left = 0
      Top = 25
      Width = 599
      Height = 230
      Align = alClient
      DataSource = ds
      Font.Charset = ANSI_CHARSET
      Font.Color = clGray
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clGray
      TitleFont.Height = -16
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = []
      OnCellClick = DBGrid1CellClick
      OnDrawColumnCell = DBGrid1DrawColumnCell
      Columns = <
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'VINCULADO'
          Title.Alignment = taCenter
          Title.Caption = 'Ativo'
          Title.Font.Charset = ANSI_CHARSET
          Title.Font.Color = clGray
          Title.Font.Height = -13
          Title.Font.Name = 'Segoe UI Semibold'
          Title.Font.Style = [fsBold]
          Width = 53
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'id_perfil'
          Title.Alignment = taCenter
          Title.Caption = 'ID'
          Title.Font.Charset = ANSI_CHARSET
          Title.Font.Color = clGray
          Title.Font.Height = -13
          Title.Font.Name = 'Segoe UI Semibold'
          Title.Font.Style = [fsBold]
          Width = 66
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'descricao'
          Title.Alignment = taCenter
          Title.Caption = 'Perfil'
          Title.Font.Charset = ANSI_CHARSET
          Title.Font.Color = clGray
          Title.Font.Height = -13
          Title.Font.Name = 'Segoe UI Semibold'
          Title.Font.Style = [fsBold]
          Width = 161
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'obs'
          Title.Caption = 'Descri'#231#227'o'
          Title.Font.Charset = ANSI_CHARSET
          Title.Font.Color = clGray
          Title.Font.Height = -13
          Title.Font.Name = 'Segoe UI Semibold'
          Title.Font.Style = [fsBold]
          Width = 259
          Visible = True
        end>
    end
  end
  inherited MemTable: TFDMemTable
    ResourceOptions.AssignedValues = [rvPersistent, rvSilentMode]
    ResourceOptions.Persistent = True
    StoreDefs = True
  end
  object ds: TDataSource
    DataSet = MemTable
    Left = 288
    Top = 23
  end
end
