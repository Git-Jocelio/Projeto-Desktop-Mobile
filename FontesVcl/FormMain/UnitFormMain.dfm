object FormMain: TFormMain
  Left = 0
  Top = 0
  Caption = 'FormMain'
  ClientHeight = 649
  ClientWidth = 1083
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  WindowState = wsMaximized
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  TextHeight = 15
  object pnlMain: TPanel
    Left = 0
    Top = 0
    Width = 1083
    Height = 649
    Align = alClient
    BevelOuter = bvNone
    Color = clWhite
    ParentBackground = False
    TabOrder = 0
    object pnlHeader: TPanel
      Left = 0
      Top = 0
      Width = 1083
      Height = 65
      Align = alTop
      BevelOuter = bvNone
      Caption = 'pnlHeader'
      Color = clFuchsia
      ParentBackground = False
      TabOrder = 0
    end
    object pnlRodape: TPanel
      Left = 0
      Top = 569
      Width = 1083
      Height = 80
      Align = alBottom
      BevelOuter = bvNone
      Caption = 'pnlRodape'
      Color = clFuchsia
      ParentBackground = False
      TabOrder = 1
    end
    object pnlMenu: TPanel
      Left = 0
      Top = 65
      Width = 250
      Height = 504
      Align = alLeft
      BevelOuter = bvNone
      Caption = 'pnlMenu'
      Color = clLime
      ParentBackground = False
      TabOrder = 2
    end
    object pnlContainer: TPanel
      Left = 250
      Top = 65
      Width = 833
      Height = 504
      Align = alClient
      BevelOuter = bvNone
      Caption = 'pnlContainer'
      Color = clAqua
      ParentBackground = False
      TabOrder = 3
    end
  end
end
