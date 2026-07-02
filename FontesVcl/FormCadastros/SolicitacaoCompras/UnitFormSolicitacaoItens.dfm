inherited FormSolicitacaoItens: TFormSolicitacaoItens
  AlignWithMargins = True
  BorderStyle = bsDialog
  BorderWidth = 3
  Caption = 'FormSolicitacaoItens'
  ClientHeight = 667
  ClientWidth = 522
  Font.Charset = ANSI_CHARSET
  Font.Color = clGray
  Font.Name = 'Segoe UI Semibold'
  Font.Style = [fsBold]
  OnShow = FormShow
  ExplicitWidth = 544
  ExplicitHeight = 712
  TextHeight = 15
  inherited lblTitulo: TLabel
    Width = 243
    Caption = 'Incluir Item na solicita'#231#227'o'
    ExplicitWidth = 243
  end
  object SpeedButton5: TSpeedButton [1]
    Left = 477
    Top = 81
    Width = 23
    Height = 22
    Caption = '?'
    OnClick = SpeedButton5Click
  end
  inherited pnlBotaoSalvar: TPanel
    Left = 118
    Top = 630
    Width = 133
    Anchors = [akRight, akBottom]
    ExplicitLeft = 112
    ExplicitTop = 571
    ExplicitWidth = 133
    inherited btnSalvar: TSpeedButton
      Width = 133
      Caption = 'Incluir Item'
    end
  end
  inherited pnlBotaoCancelar: TPanel
    Left = 263
    Top = 629
    Anchors = [akRight, akBottom]
    ExplicitLeft = 257
    ExplicitTop = 572
  end
  object rg_tipo_produto: TRadioGroup [4]
    Left = 8
    Top = 72
    Width = 463
    Height = 65
    Caption = 'Tipo de Produto'
    Items.Strings = (
      'Consumo'
      'Ativo Imobolizado')
    TabOrder = 2
    OnClick = rg_tipo_produtoClick
  end
  object gb_Produto: TGroupBox [5]
    Left = 8
    Top = 143
    Width = 505
    Height = 66
    Caption = 'Selecione ou cadastre um produto'
    TabOrder = 3
    object SpeedButton2: TSpeedButton
      Left = 465
      Top = 32
      Width = 25
      Height = 23
      Hint = 'Cadastrar um novo centro de custo'
      Caption = '...'
    end
    object DBLookupComboBox1: TDBLookupComboBox
      Left = 11
      Top = 32
      Width = 450
      Height = 23
      TabOrder = 0
    end
  end
  object gb_quantidade: TGroupBox [6]
    Left = 9
    Top = 531
    Width = 505
    Height = 80
    Caption = 'Quantidade'
    TabOrder = 4
    object Edit1: TEdit
      Left = 16
      Top = 28
      Width = 110
      Height = 23
      TabOrder = 0
      Text = '01'
    end
    object Edit2: TEdit
      Left = 132
      Top = 28
      Width = 121
      Height = 23
      TabOrder = 1
      Text = 'Pe'#231'a'
    end
  end
  object gb_ativo_imobilizado: TGroupBox [7]
    Left = 8
    Top = 214
    Width = 505
    Height = 311
    Caption = 'Ativo Imolizado'
    TabOrder = 5
    object SpeedButton1: TSpeedButton
      Left = 465
      Top = 53
      Width = 25
      Height = 23
      Hint = 'Cadastrar um novo centro de custo'
      Caption = '...'
    end
    object Label1: TLabel
      Left = 16
      Top = 32
      Width = 130
      Height = 15
      Caption = 'Selecione uma categoria'
    end
    object Label2: TLabel
      Left = 19
      Top = 213
      Width = 126
      Height = 15
      Caption = 'Observa'#231#227'o patrimonial'
    end
    object SpeedButton3: TSpeedButton
      Left = 465
      Top = 89
      Width = 23
      Height = 22
      Caption = '?'
      OnClick = SpeedButton3Click
    end
    object SpeedButton4: TSpeedButton
      Left = 465
      Top = 233
      Width = 23
      Height = 22
      Caption = '?'
      OnClick = SpeedButton4Click
    end
    object Label3: TLabel
      Left = 19
      Top = 153
      Width = 115
      Height = 15
      Caption = 'Descri'#231#227'o do Produto'
    end
    object ComboBox1: TComboBox
      Left = 11
      Top = 53
      Width = 450
      Height = 23
      TabOrder = 0
      Text = 'ComboBox1'
      TextHint = 'Selecione uma categoria'
    end
    object RadioGroup2: TRadioGroup
      Left = 11
      Top = 82
      Width = 447
      Height = 65
      Caption = ' Requer Patrim'#244'nio ? '
      ItemIndex = 0
      Items.Strings = (
        'Sim'
        'N'#227'o')
      TabOrder = 1
    end
    object Memo1: TMemo
      Left = 14
      Top = 233
      Width = 445
      Height = 65
      TabOrder = 2
    end
    object Edit3: TEdit
      Left = 11
      Top = 176
      Width = 448
      Height = 23
      TabOrder = 3
      TextHint = 'Descreva o Item'
    end
  end
  object mmAjudaSimNao: TMemo [8]
    Left = 305
    Top = 19
    Width = 49
    Height = 24
    Color = 14346225
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Lines.Strings = (
      'DEFINI'#199#195'O DE REQUERER OU N'#195'O PATRIM'#212'NIO.'
      ''
      'Tecle [ Esc ] para sair a qualque momento.'
      ''
      ''
      '1. Requer patrim'#244'nio? (Sim/N'#227'o)'
      #55357#56393' O que significa?'
      ''
      'Define se aquele item precisa ser controlado individualmente '
      'como um bem da empresa.'
      ''
      #55358#56800' Explicando simples:'
      ''
      'Nem todo ativo precisa virar patrim'#244'nio controlado.'
      ''
      #10004#65039' Exemplo que REQUER patrim'#244'nio'
      'Computador '#55357#56507
      'Notebook'
      'Impressora'
      'M'#225'quina industrial'
      'Ve'#237'culo'
      ''
      #55357#56393' Esses precisam:'
      ''
      'n'#250'mero de patrim'#244'nio'
      'controle de localiza'#231#227'o'
      'respons'#225'vel'
      'hist'#243'rico'
      ''
      #10060' Exemplo que N'#195'O requer patrim'#244'nio'
      'Mouse'
      'Teclado'
      'Cadeira simples'
      'Ferramentas baratas'
      ''
      #55357#56393' Mesmo sendo '#8220'ativo'#8221', n'#227'o vale a pena controlar '
      'individualmente.'
      ''
      #55356#57263' Regra pr'#225'tica'
      ''
      #8220'Se vale a pena controlar individualmente, ent'#227'o requer '
      'patrim'#244'nio.'#8221
      ''
      ''
      #55357#56481' Como usar no sistema'
      ''
      'Se Sim:'
      ''
      'sistema vai gerar:'
      'n'#250'mero de patrim'#244'nio'
      'registro no m'#243'dulo de ativos'
      ''
      'Se N'#227'o:'
      ''
      'apenas registra como compra normal'
      'sem controle patrimonial detalhado')
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 6
    Visible = False
    WordWrap = False
    OnDblClick = mmAjudaSimNaoDblClick
  end
  object mmAjudaObs: TMemo [9]
    Left = 360
    Top = 19
    Width = 65
    Height = 24
    Color = 14346225
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Lines.Strings = (
      #55357#56541' 2. Observa'#231#227'o patrimonial'
      #55357#56393' O que '#233'?'
      ''
      'Campo livre para guardar informa'#231#245'es importantes sobre o ativo.'
      ''
      #55358#56800' Exemplos reais:'
      #8220'Equipamento ser'#225' utilizado no setor financeiro'#8221
      #8220'Notebook para novo colaborador (Jo'#227'o)'#8221
      #8220'Substitui'#231#227'o de equipamento antigo'#8221
      #8220'Precisa ser tombado com urg'#234'ncia'#8221
      ''
      #55356#57263' Por que isso '#233' importante?'
      ''
      'Porque no dia a dia:'
      ''
      'nem tudo cabe em campos estruturados'
      'algu'#233'm do patrim'#244'nio precisa de contexto'
      'auditoria pode exigir justificativa')
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 7
    Visible = False
    WordWrap = False
    OnDblClick = mmAjudaSimNaoDblClick
  end
  object mmAjudaTipoProduto: TMemo [10]
    Left = 431
    Top = 19
    Width = 65
    Height = 24
    Color = 14346225
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Lines.Strings = (
      #55358#56771' 1. Consumo'
      #55358#56800' O que '#233'?'
      ''
      
        'Itens que ser'#227'o usados e '#8220'acabam'#8221' com o tempo ou n'#227'o precisam de' +
        ' controle individual.'
      ''
      #10004#65039' Exemplos:'
      'Papel A4'
      'Caneta'
      'Material de limpeza'
      'Toner'
      'Caf'#233' '#9749
      ''
      #55356#57263' Caracter'#237'sticas:'
      'N'#227'o precisa controlar unidade por unidade'
      'N'#227'o gera patrim'#244'nio'
      'Vai direto para uso ou estoque'
      'N'#227'o tem deprecia'#231#227'o'
      ''
      ''
      #55356#57314' 2. Ativo Imobilizado'
      #55358#56800' O que '#233'?'
      ''
      
        'Itens que fazem parte do patrim'#244'nio da empresa e t'#234'm vida '#250'til l' +
        'onga.'
      ''
      #10004#65039' Exemplos:'
      'Computador '#55357#56507
      'Impressora'
      'M'#225'quinas'
      'Ve'#237'culos '#55357#56983
      'Equipamentos em geral'
      ''
      #55356#57263' Caracter'#237'sticas:'
      'Deve ser controlado individualmente'
      'Pode ter n'#250'mero de patrim'#244'nio'
      'Tem respons'#225'vel (quem usa)'
      'Tem localiza'#231#227'o'
      'Pode sofrer deprecia'#231#227'o')
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 8
    Visible = False
    WordWrap = False
    OnDblClick = mmAjudaSimNaoDblClick
  end
  inherited MemTable: TFDMemTable
    Top = 64
  end
end
