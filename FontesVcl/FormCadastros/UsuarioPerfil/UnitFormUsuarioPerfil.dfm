inherited FormUsuarioPerfil: TFormUsuarioPerfil
  Caption = 'Vincular usu'#225'rio aos perfis'
  ClientWidth = 1245
  ExplicitWidth = 1245
  TextHeight = 15
  inherited PnlHeader: TPanel
    Width = 1245
    ExplicitWidth = 1245
    inherited pnlPesquisa: TPanel
      Width = 802
      ExplicitWidth = 802
      inherited Label2: TLabel
        Width = 802
        Caption = 'Um usu'#225'rio pode ter um ou mas perfis.'
        ExplicitWidth = 295
      end
      inherited Label3: TLabel
        Width = 802
        Caption = 'VINCULAR USU'#193'RIOS AOS PERFIS'
        ExplicitWidth = 325
      end
      inherited pnlBarraPequisa: TPanel
        Width = 802
        ExplicitWidth = 802
        inherited edtFiltrar: TEdit
          Width = 715
          TextHint = 'Pesquisar pelo nome do usu'#225'rio'
          ExplicitWidth = 715
        end
        inherited pnlBtnFiltar: TPanel
          Left = 715
          ExplicitLeft = 715
        end
      end
    end
    inherited pnlBotoes: TPanel
      Left = 872
      ExplicitLeft = 872
      inherited pnlBtnInserir: TPanel
        inherited btnInserir: TSpeedButton
          Caption = 'Vincular'
          OnClick = btnInserirClick
        end
      end
    end
  end
  inherited pnlGrig: TPanel
    Width = 1185
    ExplicitWidth = 1185
    inherited dbg: TDBGrid
      Width = 1185
      DataSource = ds
      Columns = <
        item
          Alignment = taCenter
          Expanded = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          Title.Alignment = taCenter
          Title.Caption = 'Cod. Usu'#225'rio'
          Title.Font.Charset = ANSI_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -15
          Title.Font.Name = 'Segoe UI Semibold'
          Title.Font.Style = [fsBold]
          Width = 129
          Visible = True
        end
        item
          Expanded = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          Title.Caption = 'Usu'#225'rio'
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
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          Title.Caption = 'Perfis Vinculados'
          Title.Font.Charset = ANSI_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -15
          Title.Font.Name = 'Segoe UI Semibold'
          Title.Font.Style = [fsBold]
          Width = 463
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
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
    Left = 494
    Top = 16
  end
  inherited ImageList: TImageList
    Left = 440
    Top = 16
  end
end
