object frmPrincipal: TfrmPrincipal
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'Atualizador Script'
  ClientHeight = 800
  ClientWidth = 1230
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 1230
    Height = 800
    ActivePage = tsRodar
    Align = alClient
    TabOrder = 0
    object tsAdd: TTabSheet
      Caption = 'Adicionar SQL'
      DesignSize = (
        1222
        772)
      object memoSql: TMemo
        AlignWithMargins = True
        Left = 3
        Top = 149
        Width = 1216
        Height = 296
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 0
      end
      object edtArquivo: TLabeledEdit
        Left = 3
        Top = 72
        Width = 417
        Height = 21
        EditLabel.Width = 37
        EditLabel.Height = 13
        EditLabel.Caption = 'Arquivo'
        TabOrder = 1
      end
      object dbGrid: TDBGrid
        AlignWithMargins = True
        Left = 3
        Top = 492
        Width = 1217
        Height = 242
        Anchors = [akLeft, akRight, akBottom]
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        TabOrder = 2
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        OnDblClick = dbGridDblClick
      end
      object btnSelecionarArquivo: TButton
        Left = 426
        Top = 70
        Width = 34
        Height = 25
        Caption = '...'
        TabOrder = 3
        OnClick = btnSelecionarArquivoClick
      end
      object btnGravar: TButton
        AlignWithMargins = True
        Left = 1144
        Top = 744
        Width = 75
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = 'Gravar'
        TabOrder = 4
        OnClick = btnGravarClick
      end
      object btnConfirma: TButton
        AlignWithMargins = True
        Left = 1144
        Top = 457
        Width = 75
        Height = 25
        Anchors = [akRight]
        Caption = 'Adicionar'
        TabOrder = 5
        OnClick = btnConfirmaClick
      end
      object edtVersao: TLabeledEdit
        Left = 3
        Top = 112
        Width = 70
        Height = 21
        EditLabel.Width = 33
        EditLabel.Height = 13
        EditLabel.Caption = 'Vers'#227'o'
        TabOrder = 6
      end
    end
    object tsRodar: TTabSheet
      Caption = 'Executar Script'
      ImageIndex = 1
      object edtArquivoXml: TLabeledEdit
        Left = 16
        Top = 40
        Width = 513
        Height = 21
        EditLabel.Width = 37
        EditLabel.Height = 13
        EditLabel.Caption = 'Arquivo'
        TabOrder = 0
      end
      object btnAdd: TButton
        Left = 535
        Top = 38
        Width = 42
        Height = 25
        Caption = '...'
        TabOrder = 1
        OnClick = btnAddClick
      end
      object btnListar: TButton
        Left = 592
        Top = 38
        Width = 75
        Height = 25
        Caption = 'Listar'
        TabOrder = 2
        OnClick = btnListarClick
      end
      object dbGridExec: TDBGrid
        Left = 16
        Top = 189
        Width = 1193
        Height = 252
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgMultiSelect, dgTitleClick, dgTitleHotTrack]
        TabOrder = 3
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        OnCellClick = dbGridExecCellClick
        OnDrawColumnCell = dbGridExecDrawColumnCell
      end
      object btnExecutarSql: TButton
        Left = 1125
        Top = 735
        Width = 94
        Height = 34
        Caption = 'Executar'
        TabOrder = 4
        OnClick = btnExecutarSqlClick
      end
      object GroupBox1: TGroupBox
        Left = 776
        Top = 0
        Width = 433
        Height = 183
        Caption = 'Conex'#227'o'
        TabOrder = 5
        object lblConexao: TLabel
          Left = 16
          Top = 80
          Width = 120
          Height = 13
          Caption = 'Conectado ao banco: '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblBanco: TLabel
          Left = 16
          Top = 112
          Width = 47
          Height = 13
          Caption = 'lblBanco'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblservidor: TLabel
          Left = 16
          Top = 131
          Width = 60
          Height = 13
          Caption = 'lblservidor'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblPorta: TLabel
          Left = 16
          Top = 150
          Width = 44
          Height = 13
          Caption = 'lblPorta'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object btnConectar: TButton
          Left = 17
          Top = 38
          Width = 75
          Height = 25
          Caption = 'Conectar'
          TabOrder = 0
          OnClick = btnConectarClick
        end
      end
    end
  end
  object dialog: TOpenDialog
    Left = 608
  end
  object OpenTextFileDialog: TOpenTextFileDialog
    Left = 468
  end
end
