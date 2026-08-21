inherited FormUsuarioPerfilE: TFormUsuarioPerfilE
  Caption = 'FormUsuarioPerfilE'
  ClientHeight = 537
  ClientWidth = 613
  Font.Charset = ANSI_CHARSET
  Font.Color = clGray
  Font.Height = -16
  Font.Name = 'Segoe UI Semibold'
  Font.Style = [fsBold]
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
    Width = 346
    Height = 15
    Caption = 
      'ao clicar em salvar excluir os perfis do usuario e salvar novame' +
      'nte'
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
  end
  inherited pnlBotaoCancelar: TPanel
    Left = 297
    Top = 502
    ExplicitLeft = 297
    ExplicitTop = 502
  end
  object edtLogin: TEdit [11]
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
  object Edit1: TEdit [12]
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
  object Edit2: TEdit [13]
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
  object Edit3: TEdit [14]
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
          FieldName = 'Ativo'
          Title.Alignment = taCenter
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
    Active = True
    FieldDefs = <
      item
        Name = 'Ativo'
        DataType = ftString
        Size = 1
      end>
    ResourceOptions.AssignedValues = [rvPersistent, rvSilentMode]
    ResourceOptions.Persistent = True
    StoreDefs = True
    Content = {
      41444253100000003E010000FF00010001FF02FF030400100000004D0065006D
      005400610062006C0065000500100000004D0065006D005400610062006C0065
      00060000000000070000080032000000090000FF0AFF0B04000A000000410074
      00690076006F0005000A00000041007400690076006F000C00010000000E000D
      000F000100000010000111000112000113000114000115000116000A00000041
      007400690076006F00170001000000FEFEFF18FEFF19FEFF1AFF1B1C00000000
      00FF1D00000100000053FEFEFF1B1C0001000000FF1D00000100000053FEFEFF
      1B1C0002000000FF1D0000010000004EFEFEFF1B1C0003000000FF1D00000100
      000053FEFEFF1B1C0004000000FF1D0000010000004EFEFEFF1B1C0005000000
      FF1D00000100000053FEFEFEFEFEFF1EFEFF1F200006000000FF21FEFEFE0E00
      4D0061006E0061006700650072001E0055007000640061007400650073005200
      650067006900730074007200790012005400610062006C0065004C0069007300
      74000A005400610062006C00650008004E0061006D006500140053006F007500
      7200630065004E0061006D0065000A0054006100620049004400240045006E00
      66006F0072006300650043006F006E00730074007200610069006E0074007300
      1E004D0069006E0069006D0075006D0043006100700061006300690074007900
      180043006800650063006B004E006F0074004E0075006C006C00140043006F00
      6C0075006D006E004C006900730074000C0043006F006C0075006D006E001000
      53006F0075007200630065004900440018006400740041006E00730069005300
      7400720069006E00670010004400610074006100540079007000650008005300
      69007A0065001400530065006100720063006800610062006C00650012004100
      6C006C006F0077004E0075006C006C000800420061007300650014004F004100
      6C006C006F0077004E0075006C006C0012004F0049006E005500700064006100
      7400650010004F0049006E00570068006500720065001A004F00720069006700
      69006E0043006F006C004E0061006D006500140053006F007500720063006500
      530069007A0065001C0043006F006E00730074007200610069006E0074004C00
      690073007400100056006900650077004C006900730074000E0052006F007700
      4C00690073007400060052006F0077000A0052006F0077004900440010004F00
      72006900670069006E0061006C001800520065006C006100740069006F006E00
      4C006900730074001C0055007000640061007400650073004A006F0075007200
      6E0061006C001200530061007600650050006F0069006E0074000E0043006800
      61006E00670065007300}
    object MemTableAtivo: TStringField
      DisplayWidth = 12
      FieldName = 'Ativo'
      Size = 1
    end
  end
  object ds: TDataSource
    DataSet = MemTable
    Left = 240
    Top = 431
  end
end
