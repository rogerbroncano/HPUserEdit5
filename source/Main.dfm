object MainProgram: TMainProgram
  Left = 227
  Top = 131
  HorzScrollBar.Visible = False
  VertScrollBar.Visible = False
  BorderIcons = [biSystemMenu, biMinimize, biMaximize, biHelp]
  Caption = 'HPUserEdit'
  ClientHeight = 550
  ClientWidth = 692
  Color = 14474460
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter: TSplitter
    Left = 228
    Top = 75
    Height = 453
    Cursor = crSizeWE
    ResizeStyle = rsNone
  end
  object DockTop: TTBXDock
    Left = 0
    Top = 0
    Width = 692
    Height = 75
    object MenuBar: TTBXToolbar
      Left = 0
      Top = 0
      Cursor = crHandPoint
      HelpContext = 6910
      DockableTo = [dpTop]
      DockMode = dmCannotFloatOrChangeDocks
      DragHandleStyle = dhDouble
      FullSize = True
      Images = TBXImageList
      Options = [tboShowHint]
      TabOrder = 0
      Caption = 'Barra de men'#250's'
      ChevronHint = 'M'#225's Botones|'
      object MenuFile: TTBXSubmenuItem
        Caption = 'Archivo'
        Hint = ''
        object TBXItem1: TTBXItem
          Action = FileNew
        end
        object TBXItem3: TTBXItem
          Action = FileOpen
        end
        object TBXItem4: TTBXItem
          Action = FileClose
        end
        object TBXItem5: TTBXItem
          Action = FileCloseAll
        end
        object TBXSeparatorItem1: TTBXSeparatorItem
          Caption = ''
          Hint = ''
        end
        object TBXItem6: TTBXItem
          Action = FileSave
        end
        object TBXItem7: TTBXItem
          Action = FileSaveAs
        end
        object TBXSeparatorItem2: TTBXSeparatorItem
          Caption = ''
          Hint = ''
        end
        object TBXItem94: TTBXItem
          Action = FileImport
        end
        object TBXItem93: TTBXItem
          Action = FileExport
        end
        object TBXSeparatorItem27: TTBXSeparatorItem
          Caption = ''
          Hint = ''
        end
        object TBXItem95: TTBXItem
          Action = FileSendToHP
        end
        object TBXSeparatorItem7: TTBXSeparatorItem
          Caption = ''
          Hint = ''
        end
        object TBXItem20: TTBXItem
          Action = FilePrint
        end
        object TBXItem21: TTBXItem
          Action = FilePreview
        end
        object TBXItem46: TTBXItem
          Action = FilePageSetup
        end
        object TBXSeparatorItem22: TTBXSeparatorItem
          Caption = ''
          Hint = ''
        end
        object TBXMRUListItem1: TTBXMRUListItem
          MRUList = MRUList
          Caption = '(TBX MRU List)'
          Hint = ''
        end
        object TBXSeparatorItem8: TTBXSeparatorItem
          Caption = ''
          Hint = ''
        end
        object TBXItem23: TTBXItem
          Action = FileExit
        end
      end
      object MenuEdit: TTBXSubmenuItem
        Caption = 'Edici'#243'n'
        Hint = ''
        object TBXItem8: TTBXItem
          Action = EditUndo
        end
        object TBXItem9: TTBXItem
          Action = EditRedo
        end
        object TBXSeparatorItem3: TTBXSeparatorItem
          Caption = ''
          Hint = ''
        end
        object TBXItem10: TTBXItem
          Action = EditCut
        end
        object TBXItem11: TTBXItem
          Action = EditCopy
        end
        object TBXItem12: TTBXItem
          Action = EditPaste
        end
        object TBXSeparatorItem4: TTBXSeparatorItem
          Caption = ''
          Hint = ''
        end
        object TBXItem13: TTBXItem
          Action = EditSelectAll
        end
      end
      object MenuSearch: TTBXSubmenuItem
        Caption = 'B'#250'squeda'
        Hint = ''
        object TBXItem14: TTBXItem
          Action = SearchFind
        end
        object TBXItem15: TTBXItem
          Action = SearchFindNext
        end
        object TBXItem16: TTBXItem
          Action = SearchFindPrev
        end
        object TBXSeparatorItem5: TTBXSeparatorItem
          Caption = ''
          Hint = ''
        end
        object TBXItem17: TTBXItem
          Action = SearchReplace
        end
        object TBXSeparatorItem6: TTBXSeparatorItem
          Caption = ''
          Hint = ''
        end
        object TBXItem18: TTBXItem
          Action = SearchGoTo
        end
      end
      object MenuView: TTBXSubmenuItem
        Caption = 'Ver'
        Hint = ''
        object TBXItem24: TTBXItem
          Action = ViewToolBar
        end
        object TBXItem25: TTBXItem
          Action = ViewInsertBar
        end
        object TBXItem26: TTBXItem
          Action = ViewCommandsBar
        end
        object TBXItem27: TTBXItem
          Action = ViewSymbolsBar
        end
        object TBXItem28: TTBXItem
          Action = ViewStatusBar
        end
        object TBXSeparatorItem9: TTBXSeparatorItem
          Caption = ''
          Hint = ''
        end
        object TBXItem29: TTBXItem
          Action = ViewLineNumbers
        end
      end
      object MenuInsert: TTBXSubmenuItem
        Caption = 'Insertar'
        Hint = ''
        object TBXItem34: TTBXItem
          Action = InsertProgram
        end
        object TBXItem120: TTBXItem
          Action = InsertSubprogram
        end
        object TBXItem35: TTBXItem
          Action = InsertString
        end
        object TBXItem36: TTBXItem
          Action = InsertEquation
        end
        object TBXItem37: TTBXItem
          Action = InsertList
        end
        object TBXItem38: TTBXItem
          Action = InsertArray
        end
        object TBXItem39: TTBXItem
          Action = InsertComplex
        end
        object TBXItem121: TTBXItem
          Action = InsertDirectory
        end
        object TBXSeparatorItem30: TTBXSeparatorItem
          Caption = ''
          Hint = ''
        end
        object TBXItem40: TTBXItem
          Action = InsertIf
        end
        object TBXItem41: TTBXItem
          Action = InsertCase
        end
        object TBXItem42: TTBXItem
          Action = InsertStart
        end
        object TBXItem43: TTBXItem
          Action = InsertFor
        end
        object TBXItem44: TTBXItem
          Action = InsertWhile
        end
        object TBXItem45: TTBXItem
          Action = InsertDo
        end
        object TBXItem117: TTBXItem
          Action = InsertIfErr
        end
      end
      object MenuEmu: TTBXSubmenuItem
        Caption = 'Emulador'
        Hint = ''
        object TBXItem113: TTBXItem
          Action = EmuRun
        end
        object TBXItem19: TTBXItem
          Action = EmuSend
        end
        object TBXSeparatorItem39: TTBXSeparatorItem
          Caption = ''
          Hint = ''
        end
        object TBXItem105: TTBXItem
          Action = EmuProgramRun
        end
        object TBXItem106: TTBXItem
          Action = EmuProgramParam
        end
        object TBXSeparatorItem34: TTBXSeparatorItem
          Caption = ''
          Hint = ''
        end
        object TBXItem107: TTBXItem
          Action = EmuProgramStep
        end
        object TBXSeparatorItem35: TTBXSeparatorItem
          Caption = ''
          Hint = ''
        end
        object TBXItem108: TTBXItem
          Action = EmuProgramBreak
        end
        object TBXItem33: TTBXItem
          Action = EmuClearBreak
        end
      end
      object MenuTools: TTBXSubmenuItem
        Caption = 'Herramientas'
        Hint = ''
        object TBXItem92: TTBXItem
          Action = ToolsProgram
        end
        object TBXSeparatorItem42: TTBXSeparatorItem
          Caption = ''
          Hint = ''
        end
        object TBXItem99: TTBXItem
          Action = ToolsMatrixWriter
        end
        object TBXItem111: TTBXItem
          Action = ToolsPicture
        end
        object TBXSeparatorItem21: TTBXSeparatorItem
          Caption = ''
          Hint = ''
        end
        object TBXItem30: TTBXItem
          Action = ToolsInput
        end
        object TBXItem31: TTBXItem
          Action = ToolsChoose
        end
        object TBXItem32: TTBXItem
          Action = ToolsInform
        end
      end
      object MenuOptions: TTBXSubmenuItem
        Caption = 'Opciones'
        Hint = ''
        object TBXItem48: TTBXItem
          Action = OptionsEnvironment
        end
        object TBXSeparatorItem36: TTBXSeparatorItem
          Caption = ''
          Hint = ''
        end
        object TBXItem47: TTBXItem
          Action = OptionsEditor
        end
        object TBXSeparatorItem37: TTBXSeparatorItem
          Caption = ''
          Hint = ''
        end
        object MenuLanguage: TTBXSubmenuItem
          Caption = 'Lenguajes'
          Hint = ''
          object Lang1: TTBXItem
            Visible = False
            OnClick = OptionsLanguageExecute
            Caption = ''
            Hint = ''
          end
          object Lang2: TTBXItem
            Visible = False
            OnClick = OptionsLanguageExecute
            Caption = ''
            Hint = ''
          end
          object Lang3: TTBXItem
            Visible = False
            OnClick = OptionsLanguageExecute
            Caption = ''
            Hint = ''
          end
          object Lang4: TTBXItem
            Visible = False
            OnClick = OptionsLanguageExecute
            Caption = ''
            Hint = ''
          end
          object Lang5: TTBXItem
            Visible = False
            OnClick = OptionsLanguageExecute
            Caption = ''
            Hint = ''
          end
          object Lang6: TTBXItem
            Visible = False
            OnClick = OptionsLanguageExecute
            Caption = ''
            Hint = ''
          end
          object Lang7: TTBXItem
            Visible = False
            OnClick = OptionsLanguageExecute
            Caption = ''
            Hint = ''
          end
          object Lang8: TTBXItem
            Visible = False
            OnClick = OptionsLanguageExecute
            Caption = ''
            Hint = ''
          end
          object Lang9: TTBXItem
            Visible = False
            OnClick = OptionsLanguageExecute
            Caption = ''
            Hint = ''
          end
        end
      end
      object MenuHelp: TTBXSubmenuItem
        Caption = 'Ayuda'
        Hint = ''
        object TBXItem49: TTBXItem
          Action = HelpIndex
        end
        object TBXItem109: TTBXItem
          Action = HelpFaq
        end
        object TBXItem110: TTBXItem
          Action = HelpWeb
        end
        object TBXSeparatorItem38: TTBXSeparatorItem
          Caption = ''
          Hint = ''
        end
        object TBXItem50: TTBXItem
          Action = HelpTipOfDay
        end
        object TBXSeparatorItem11: TTBXSeparatorItem
          Caption = ''
          Hint = ''
        end
        object TBXItem51: TTBXItem
          Action = HelpAbout
        end
      end
    end
    object ToolBar: TTBXToolbar
      Left = 0
      Top = 23
      Cursor = crHandPoint
      HelpContext = 6920
      DockableTo = [dpTop]
      DockPos = -7
      DockRow = 1
      DragHandleStyle = dhDouble
      FullSize = True
      Images = TBXImageList
      Options = [tboShowHint]
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnVisibleChanged = ToolBarVisibleChanged
      Caption = 'Barra de herramientas'
      ChevronHint = 'M'#225's Botones|'
      object TBXItem52: TTBXItem
        Action = FileNew
      end
      object TBXItem54: TTBXItem
        Action = FileOpen
      end
      object TBXItem55: TTBXItem
        Action = FileSave
      end
      object TBXSeparatorItem12: TTBXSeparatorItem
        Caption = ''
        Hint = ''
      end
      object TBXItem96: TTBXItem
        Action = FileImport
      end
      object TBXItem97: TTBXItem
        Action = FileExport
      end
      object TBXSeparatorItem28: TTBXSeparatorItem
        Caption = ''
        Hint = ''
      end
      object TBXItem98: TTBXItem
        Action = FileSendToHP
      end
      object TBXSeparatorItem13: TTBXSeparatorItem
        Caption = ''
        Hint = ''
      end
      object TBXItem57: TTBXItem
        Action = FilePrint
      end
      object TBXItem58: TTBXItem
        Action = FilePreview
      end
      object TBXSeparatorItem14: TTBXSeparatorItem
        Caption = ''
        Hint = ''
      end
      object TBXItem59: TTBXItem
        Action = EditCut
      end
      object TBXItem60: TTBXItem
        Action = EditCopy
      end
      object TBXItem61: TTBXItem
        Action = EditPaste
      end
      object TBXSeparatorItem15: TTBXSeparatorItem
        Caption = ''
        Hint = ''
      end
      object TBXItem62: TTBXItem
        Action = EditUndo
      end
      object TBXItem63: TTBXItem
        Action = EditRedo
      end
      object TBXSeparatorItem16: TTBXSeparatorItem
        Caption = ''
        Hint = ''
      end
      object TBXItem64: TTBXItem
        Action = SearchFind
      end
      object TBXItem65: TTBXItem
        Action = SearchReplace
      end
      object TBXSeparatorItem17: TTBXSeparatorItem
        Caption = ''
        Hint = ''
      end
      object TBXItem115: TTBXItem
        Action = OptionsEnvironment
      end
      object TBXItem66: TTBXItem
        Action = OptionsEditor
      end
      object TBXSeparatorItem18: TTBXSeparatorItem
        Caption = ''
        Hint = ''
      end
      object TBXItem67: TTBXItem
        Action = HelpAbout
      end
      object TBXItem68: TTBXItem
        Action = HelpIndex
      end
      object TBXSeparatorItem32: TTBXSeparatorItem
        Caption = ''
        Hint = ''
      end
      object TBXItem101: TTBXItem
        Action = HelpWhatThisIs
      end
    end
    object InsertBar: TTBXToolbar
      Left = 0
      Top = 49
      Cursor = crHandPoint
      HelpContext = 6930
      DockableTo = [dpTop]
      DockPos = 0
      DockRow = 2
      DragHandleStyle = dhDouble
      FullSize = True
      Images = TBXImageList
      Options = [tboNoAutoHint, tboSameWidth, tboShowHint, tboToolbarStyle]
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnVisibleChanged = ToolBarVisibleChanged
      Caption = 'Barra de herramientas'
      ChevronHint = 'M'#225's Botones|'
      object TBXItem69: TTBXItem
        Action = InsertProgram
      end
      object TBXItem118: TTBXItem
        Action = InsertSubprogram
      end
      object TBXItem70: TTBXItem
        Action = InsertString
      end
      object TBXItem71: TTBXItem
        Action = InsertEquation
      end
      object TBXItem72: TTBXItem
        Action = InsertList
      end
      object TBXItem73: TTBXItem
        Action = InsertArray
      end
      object TBXItem74: TTBXItem
        Action = InsertComplex
      end
      object TBXItem119: TTBXItem
        Action = InsertDirectory
      end
      object TBXSeparatorItem19: TTBXSeparatorItem
        Caption = ''
        Hint = ''
      end
      object TBXItem75: TTBXItem
        Action = InsertIf
      end
      object TBXItem76: TTBXItem
        Action = InsertCase
      end
      object TBXItem77: TTBXItem
        Action = InsertStart
      end
      object TBXItem78: TTBXItem
        Action = InsertFor
      end
      object TBXItem79: TTBXItem
        Action = InsertWhile
      end
      object TBXItem80: TTBXItem
        Action = InsertDo
      end
      object TBXItem116: TTBXItem
        Action = InsertIfErr
      end
      object TBXSeparatorItem20: TTBXSeparatorItem
        Caption = ''
        Hint = ''
      end
      object TBXItem91: TTBXItem
        Action = ToolsProgram
      end
      object TBXSeparatorItem40: TTBXSeparatorItem
        Caption = ''
        Hint = ''
      end
      object TBXItem100: TTBXItem
        Action = ToolsMatrixWriter
      end
      object TBXItem84: TTBXItem
        Action = ToolsPicture
      end
      object TBXSeparatorItem31: TTBXSeparatorItem
        Caption = ''
        Hint = ''
      end
      object TBXItem81: TTBXItem
        Action = ToolsInput
      end
      object TBXItem82: TTBXItem
        Action = ToolsChoose
      end
      object TBXItem83: TTBXItem
        Action = ToolsInform
      end
      object TBXSeparatorItem33: TTBXSeparatorItem
        Caption = ''
        Hint = ''
      end
      object TBXItem56: TTBXItem
        Action = EmuRun
      end
      object TBXItem114: TTBXItem
        Action = EmuSend
      end
      object TBXSeparatorItem41: TTBXSeparatorItem
        Caption = ''
        Hint = ''
      end
      object TBXItem22: TTBXItem
        Action = EmuProgramRun
      end
      object TBXItem102: TTBXItem
        Action = EmuProgramStep
      end
      object TBXItem104: TTBXItem
        Action = EmuProgramBreak
      end
    end
  end
  object StatusBar: TTBXStatusBar
    Left = 0
    Top = 528
    Width = 692
    HelpContext = 6970
    Panels = <
      item
        Alignment = taCenter
        Size = 70
        Tag = 0
      end
      item
        Alignment = taCenter
        Size = 80
        Tag = 0
      end
      item
        Alignment = taCenter
        Size = 120
        Tag = 0
      end
      item
        StretchPriority = 1
        Tag = 0
      end>
    UseSystemFont = False
  end
  object MultiDock: TTBXMultiDock
    Left = 0
    Top = 75
    Width = 228
    Height = 453
    AllowDrag = False
    Position = dpLeft
    OnResize = MultiDockResize
    object CommandsBar: TTBXDockablePanel
      Left = 0
      Top = 0
      BorderStyle = bsNone
      CaptionRotation = dpcrAlwaysHorz
      Color = 14474460
      DockableTo = [dpLeft]
      DockedWidth = 224
      DockPos = 0
      TabOrder = 0
      UseThemeColor = False
      OnVisibleChanged = ToolBarVisibleChanged
      Caption = 'Commandos'
      object TreeCommands: TTreeView
        Left = 0
        Top = 0
        Width = 224
        Height = 127
        Cursor = crHandPoint
        Hint = 'Doble click para insertar comando'
        HelpContext = 6940
        Align = alClient
        BevelInner = bvNone
        BevelOuter = bvNone
        BevelKind = bkFlat
        BorderStyle = bsNone
        Ctl3D = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'HP48'
        Font.Style = []
        HotTrack = True
        Images = TreeImageList
        Indent = 19
        ParentCtl3D = False
        ParentFont = False
        ParentShowHint = False
        ReadOnly = True
        ShowHint = False
        TabOrder = 0
        TabStop = False
        ToolTips = False
        OnClick = TreeCommandsClick
        OnDblClick = TreeCommandsDblClick
      end
    end
    object SymbolsBar: TTBXDockablePanel
      Left = 0
      Top = 288
      BorderStyle = bsNone
      CaptionRotation = dpcrAlwaysHorz
      Color = 14474460
      DockableTo = [dpLeft]
      DockedWidth = 224
      DockedHeight = 108
      DockPos = 288
      SnapDistance = 20
      TabOrder = 1
      UseThemeColor = False
      OnVisibleChanged = ToolBarVisibleChanged
      Caption = 'S'#237'mbolos'
      object StringGrid: TStringGrid
        Left = 0
        Top = 0
        Width = 224
        Height = 127
        Cursor = crHandPoint
        HelpContext = 6950
        Align = alClient
        BorderStyle = bsNone
        ColCount = 8
        DefaultColWidth = 20
        DefaultRowHeight = 20
        FixedCols = 0
        RowCount = 16
        FixedRows = 0
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'HP48'
        Font.Style = [fsBold]
        Options = [goVertLine, goHorzLine]
        ParentFont = False
        ParentShowHint = False
        ScrollBars = ssVertical
        ShowHint = True
        TabOrder = 0
        OnDrawCell = StringGridDrawCell
        OnMouseDown = StringGridMouseDown
        OnMouseMove = StringGridMouseMove
      end
    end
    object StackBar: TTBXDockablePanel
      Left = 0
      Top = 149
      MaxClientHeight = 135
      MinClientHeight = 135
      BorderStyle = bsNone
      DockableTo = [dpLeft]
      DockedWidth = 224
      DockMode = dmCannotFloatOrChangeDocks
      DockPos = 149
      ShowCaption = False
      ShowCaptionWhenDocked = False
      TabOrder = 2
      object StackPanel: TPanel
        Left = 0
        Top = 14
        Width = 224
        Height = 121
        Align = alClient
        BevelOuter = bvNone
        Color = clWindow
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = '_CAS_HP48x-49x-50x_8x7pxl-f01'
        Font.Style = []
        ParentBackground = False
        ParentFont = False
        TabOrder = 0
        OnResize = StackPanelResize
        object ShapeLine: TShape
          Left = 0
          Top = 60
          Width = 224
          Height = 1
          Align = alTop
          Pen.Color = 10526880
          ExplicitTop = 74
        end
        object StackViewIn: TJvStringGrid
          Left = 0
          Top = 0
          Width = 224
          Height = 60
          Align = alTop
          BorderStyle = bsNone
          ColCount = 2
          Ctl3D = False
          DefaultRowHeight = 12
          Enabled = False
          FixedCols = 0
          FixedRows = 0
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = '_CAS_HP48x-49x-50x_8x7pxl-f01'
          Font.Style = []
          Options = []
          ParentCtl3D = False
          ParentFont = False
          ScrollBars = ssNone
          TabOrder = 0
          Alignment = taRightJustify
          FixedFont.Charset = DEFAULT_CHARSET
          FixedFont.Color = clWindowText
          FixedFont.Height = -11
          FixedFont.Name = '_CAS_HP48x-49x-50x_8x7pxl-f01'
          FixedFont.Style = []
        end
        object StackViewOut: TJvStringGrid
          Left = 0
          Top = 61
          Width = 224
          Height = 60
          Align = alTop
          BorderStyle = bsNone
          ColCount = 2
          Ctl3D = False
          DefaultRowHeight = 12
          Enabled = False
          FixedCols = 0
          FixedRows = 0
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = '_CAS_HP48x-49x-50x_8x7pxl-f01'
          Font.Style = []
          Options = []
          ParentCtl3D = False
          ParentFont = False
          ScrollBars = ssNone
          TabOrder = 1
          Alignment = taRightJustify
          FixedFont.Charset = DEFAULT_CHARSET
          FixedFont.Color = clWindowText
          FixedFont.Height = -11
          FixedFont.Name = '_CAS_HP48x-49x-50x_8x7pxl-f01'
          FixedFont.Style = []
        end
      end
      object TabSet: TTabSet
        Left = 0
        Top = 0
        Width = 224
        Height = 14
        Align = alTop
        BackgroundColor = 14474460
        DitherBackground = False
        EndMargin = 0
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = '_CAS_HP48x-49x-50x_8x7pxl-f01'
        Font.Style = []
        StartMargin = 0
        SelectedColor = clWindow
        SoftTop = True
        Style = tsSoftTabs
        TabPosition = tpTop
        UnselectedColor = 14474460
        OnChange = TabSetChange
      end
    end
  end
  object Panel: TPanel
    Left = 231
    Top = 75
    Width = 461
    Height = 453
    Align = alClient
    BevelOuter = bvNone
    Ctl3D = True
    ParentColor = True
    ParentCtl3D = False
    TabOrder = 3
    object TabBar: TJvTabBar
      Left = 0
      Top = 0
      Width = 461
      PopupMenu = PopupMenu
      CloseButton = False
      AutoFreeClosed = False
      Margin = 0
      Painter = JvModernTabBarPainter
      Tabs = <>
      OnTabSelected = TabBarTabSelected
    end
    object EditPanel: TPanel
      Left = 0
      Top = 23
      Width = 461
      Height = 430
      Align = alClient
      BevelEdges = [beLeft, beRight, beBottom]
      BevelKind = bkFlat
      BevelOuter = bvNone
      Color = 14474460
      TabOrder = 1
      object PageList: TJvPageList
        Left = 0
        Top = 0
        Width = 457
        Height = 428
        PropagateEnable = False
        ShowDesignCaption = sdcNone
        Align = alClient
      end
    end
  end
  object FlatHint: TFlatHint
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    OnShowHint = FlatHintShowHint
    Left = 400
    Top = 288
  end
  object OpenDialog: TOpenDialog
    DefaultExt = 'hpe'
    Filter = 'Archivos de HPUser Edit|*.hparr|Todos los archivos|*.*'
    Options = [ofHideReadOnly, ofPathMustExist, ofFileMustExist]
    Title = 'Abrir'
    Left = 368
    Top = 257
  end
  object SaveDialog: TSaveDialog
    DefaultExt = 'hpe'
    Filter = 'Archivos de HPUser Edit|*.hpe|Todos los archivos|*.*'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofExtensionDifferent, ofPathMustExist]
    Title = 'Guardar'
    Left = 400
    Top = 257
  end
  object ApplicationEvents: TApplicationEvents
    OnActivate = ApplicationEventsActivate
    OnHint = ApplicationEventsHint
    Left = 304
    Top = 288
  end
  object SynEditPrint: TSynEditPrint
    Copies = 1
    Header.DefaultFont.Charset = DEFAULT_CHARSET
    Header.DefaultFont.Color = clBlack
    Header.DefaultFont.Height = -13
    Header.DefaultFont.Name = 'Arial'
    Header.DefaultFont.Style = []
    Footer.DefaultFont.Charset = DEFAULT_CHARSET
    Footer.DefaultFont.Color = clBlack
    Footer.DefaultFont.Height = -13
    Footer.DefaultFont.Name = 'Arial'
    Footer.DefaultFont.Style = []
    Margins.Left = 25.000000000000000000
    Margins.Right = 15.000000000000000000
    Margins.Top = 25.000000000000000000
    Margins.Bottom = 25.000000000000000000
    Margins.Header = 15.000000000000000000
    Margins.Footer = 15.000000000000000000
    Margins.LeftHFTextIndent = 2.000000000000000000
    Margins.RightHFTextIndent = 2.000000000000000000
    Margins.HFInternalMargin = 0.500000000000000000
    Margins.MirrorMargins = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    TabWidth = 8
    Color = clWhite
    Left = 338
    Top = 257
  end
  object PrintDialog: TPrintDialog
    Left = 432
    Top = 257
  end
  object HelpRouter: THelpRouter
    HelpType = htHTMLhelp
    CHMPopupTopics = 'CSHelp.txt'
    ValidateID = False
    Left = 584
    Top = 88
  end
  object HelpContextMap: THelpContextMap
    Left = 616
    Top = 88
  end
  object ActionManager: TActionManager
    Images = TBXImageList
    OnUpdate = ActionManagerUpdate
    Left = 432
    Top = 288
    StyleName = 'XP Style'
    object FileNew: TAction
      Category = 'File'
      Caption = 'Nuevo'
      Hint = 'Nuevo|Crea un objeto nuevo'
      ImageIndex = 0
      ShortCut = 16462
      OnExecute = FileNewExecute
    end
    object InsertProgram: TAction
      Category = 'Insert'
      Caption = 'Programa'
      Hint = 'Programa|Inserta los delimitadores de un programa'
      ImageIndex = 18
      OnExecute = InsertProgramExecute
    end
    object InsertSubprogram: TAction
      Category = 'Insert'
      Caption = 'Programa con argumentos'
      Hint = 
        'Programa con argumentos|Inserta los delimitadores de un programa' +
        ' con argumentos'
      ImageIndex = 47
      OnExecute = InsertSubprogramExecute
    end
    object InsertString: TAction
      Category = 'Insert'
      Caption = 'Cadena de caracteres'
      Hint = 
        'Cadena de caracteres|Inserta los delimitadores de una cadena de ' +
        'caracteres'
      ImageIndex = 19
      OnExecute = InsertStringExecute
    end
    object InsertEquation: TAction
      Category = 'Insert'
      Caption = 'Objeto algebraico'
      Hint = 
        'Objeto algebraico|Inserta los delimitadores de un objeto algebra' +
        'ico'
      ImageIndex = 20
      OnExecute = InsertEquationExecute
    end
    object InsertList: TAction
      Category = 'Insert'
      Caption = 'Listas'
      Hint = 'Lista|Inserta los delimitadores de una lista'
      ImageIndex = 21
      OnExecute = InsertListExecute
    end
    object ToolsMatrixWriter: TAction
      Category = 'Tools'
      Caption = 'Editor de matrices'
      Hint = 'Editor de matrices|Ejecuta el editor de matrices de HPUserEdit'
      ImageIndex = 37
      ShortCut = 16499
      OnExecute = ToolsMatrixWriterExecute
    end
    object InsertArray: TAction
      Category = 'Insert'
      Caption = 'Matriz'
      Hint = 'Matriz|Inserta los delimitadores de una matriz'
      ImageIndex = 22
      OnExecute = InsertArrayExecute
    end
    object InsertComplex: TAction
      Category = 'Insert'
      Caption = 'N'#250'mero complejo'
      Hint = 'N'#250'mero complejo|Inserta los delimitadores de un n'#250'mero complejo'
      ImageIndex = 23
      OnExecute = InsertComplexExecute
    end
    object InsertDirectory: TAction
      Category = 'Insert'
      Caption = 'Directorio'
      Hint = 'Directorio|Inserta la estructura de un objeto directorio'
      ImageIndex = 48
      OnExecute = InsertDirectoryExecute
    end
    object InsertIf: TAction
      Category = 'Insert'
      Caption = 'IF...THEN...END'
      Hint = 'Estructura IF|Inserta la estructura IF...THEN...END'
      ImageIndex = 24
      OnExecute = InsertIfExecute
    end
    object InsertCase: TAction
      Category = 'Insert'
      Caption = 'CASE...THEN...END..END'
      Hint = 'Estructura CASE|Inserta la estructura CASE...THEN...END...END'
      ImageIndex = 25
      OnExecute = InsertCaseExecute
    end
    object InsertStart: TAction
      Category = 'Insert'
      Caption = 'START...NEXT'
      Hint = 'Estructura START|Inserta la estructura START...NEXT'
      ImageIndex = 26
      OnExecute = InsertStartExecute
    end
    object InsertFor: TAction
      Category = 'Insert'
      Caption = 'FOR...NEXT'
      Hint = 'Estructura FOR|Inserta la estructura FOR...NEXT'
      ImageIndex = 27
      OnExecute = InsertForExecute
    end
    object InsertDo: TAction
      Category = 'Insert'
      Caption = 'DO...UNTIL...END'
      Hint = 'Estructura DO|Inserta la estructura DO...UNTIL...END'
      ImageIndex = 28
      OnExecute = InsertDoExecute
    end
    object InsertWhile: TAction
      Category = 'Insert'
      Caption = 'WHILE...REPEAT...END'
      Hint = 'Estructura WHILE|Inserta la estructura WHILE...REPEAT...END'
      ImageIndex = 29
      OnExecute = InsertWhileExecute
    end
    object ToolsInput: TAction
      Category = 'Tools'
      Caption = 'Asistente para INPUT'
      Hint = 'INPUT|Inserta la estructura del comando INPUT personalizado'
      ImageIndex = 39
      ShortCut = 16500
      OnExecute = ToolsInputExecute
    end
    object ToolsChoose: TAction
      Category = 'Tools'
      Caption = 'Asistente para CHOOSE'
      Hint = 'CHOOSE|Inserta la estructura del comando CHOOSE personalizado'
      ImageIndex = 40
      ShortCut = 16501
      OnExecute = ToolsChooseExecute
    end
    object ToolsInform: TAction
      Category = 'Tools'
      Caption = 'Asistente para INFORM'
      Hint = 'INFORM|Inserta la estructura del comando INFORM personalizado'
      ImageIndex = 41
      ShortCut = 16502
      OnExecute = ToolsInformExecute
    end
    object ToolsPicture: TAction
      Category = 'Tools'
      Caption = 'Editor de gr'#225'ficos...'
      Hint = 'Editor de gr'#225'ficos|Ejecutar el editor de gr'#225'ficos de HPUserEdit'
      ImageIndex = 38
      ShortCut = 16503
      OnExecute = ToolsPictureExecute
    end
    object ViewToolBar: TAction
      Category = 'View'
      AutoCheck = True
      Caption = 'Barra de Herramientas Est'#225'ndar'
      Checked = True
      Hint = 
        'Barra de Herramientas|Muestra u oculta la barra de herramientas ' +
        'est'#225'ndar'
      OnExecute = ToolWindowExecute
    end
    object ViewInsertBar: TAction
      Category = 'View'
      AutoCheck = True
      Caption = 'Barra de Inserci'#243'n de Objetos'
      Checked = True
      Hint = 
        'Barra de Objetos|Muestra u oculta la barra de inserci'#243'n de objet' +
        'os'
      OnExecute = ToolWindowExecute
    end
    object ViewCommandsBar: TAction
      Category = 'View'
      AutoCheck = True
      Caption = 'Barra de Comandos'
      Checked = True
      Hint = 'Comandos|Muestra u oculta la barra de comandos'
      OnExecute = ToolWindowExecute
    end
    object ViewSymbolsBar: TAction
      Category = 'View'
      AutoCheck = True
      Caption = 'Barra de S'#237'mbolos'
      Checked = True
      Hint = 'S'#237'mbolos|Muestra u oculta la barra de s'#237'mbolos'
      OnExecute = ToolWindowExecute
    end
    object ViewStatusBar: TAction
      Category = 'View'
      AutoCheck = True
      Caption = 'Barra de Estado'
      Checked = True
      Hint = 'Barra de Estado|Muestra u oculta la barra de estado'
      OnExecute = ToolWindowExecute
    end
    object EditUndo: TEditUndo
      Category = 'Edit'
      Caption = 'Deshacer'
      Hint = 'Deshacer|Deshace la '#250'ltima acci'#243'n'
      ImageIndex = 10
      ShortCut = 16474
      OnExecute = EditUndoExecute
    end
    object EditRedo: TAction
      Category = 'Edit'
      Caption = 'Rehacer'
      Hint = 'Rehacer|Rehace la acci'#243'n previamente desecha'
      ImageIndex = 11
      ShortCut = 16473
      OnExecute = EditRedoExecute
    end
    object EditCut: TEditCut
      Category = 'Edit'
      Caption = 'Cortar'
      Enabled = False
      Hint = 'Cortar|Corta la selecci'#243'n de texto al portapapeles'
      ImageIndex = 12
      ShortCut = 16472
      OnExecute = EditCutExecute
    end
    object EditCopy: TEditCopy
      Category = 'Edit'
      Caption = 'Copiar'
      Enabled = False
      Hint = 'Copiar|Copia la selecci'#243'n de texto al portapapeles'
      ImageIndex = 13
      ShortCut = 16451
      OnExecute = EditCopyExecute
    end
    object EditPaste: TEditPaste
      Category = 'Edit'
      Caption = 'Pegar'
      Hint = 'Pegar|Inserta el contenido del portapapeles'
      ImageIndex = 14
      ShortCut = 16470
      OnExecute = EditPasteExecute
    end
    object EditSelectAll: TEditSelectAll
      Category = 'Edit'
      Caption = 'Seleccionar Todo'
      Hint = 'Seleccionar todo|Selecciona el objeto completo'
      ShortCut = 16449
      OnExecute = EditSelectAllExecute
    end
    object SearchFind: TAction
      Category = 'Search'
      Caption = 'Buscar'
      Hint = 'Buscar|Busca un texto espec'#237'fico en el documento actual'
      ImageIndex = 15
      ShortCut = 16454
      OnExecute = SearchSearchExecute
    end
    object FileOpen: TAction
      Category = 'File'
      Caption = 'Abrir...'
      Hint = 'Abrir|Abre un objeto existente'
      ImageIndex = 1
      ShortCut = 16463
      OnExecute = FileOpenExecute
    end
    object FileClose: TAction
      Category = 'File'
      Caption = 'Cerrar'
      Hint = 'Cerrar|Cierra el objeto actual'
      ImageIndex = 2
      OnExecute = FileCloseExecute
    end
    object FileCloseAll: TAction
      Category = 'File'
      Caption = 'Cerrar todo'
      Hint = 'Cerrar todo|Cierra todos los objetos'
      OnExecute = FileCloseAllExecute
    end
    object FileSave: TAction
      Category = 'File'
      Caption = 'Guardar'
      Hint = 'Guardar|Guarda el objeto actual'
      ImageIndex = 3
      ShortCut = 16467
      OnExecute = FileSaveExecute
    end
    object FileSaveAs: TAction
      Category = 'File'
      Caption = 'Guardar como...'
      Hint = 'Guardar como|Guarda el objeto actual con otro nombre'
      OnExecute = FileSaveAsExecute
    end
    object FileImport: TAction
      Category = 'File'
      Caption = 'Importar...'
      Hint = 'Importar|Importa un archivo binario HP como un objeto nuevo'
      ImageIndex = 4
      OnExecute = FileImportExecute
    end
    object FileExport: TAction
      Category = 'File'
      Caption = 'Exportar...'
      Hint = 'Exportar|Exporta el objeto actual a un archivo binario HP'
      ImageIndex = 5
      OnExecute = FileExportExecute
    end
    object EmuRun: TAction
      Category = 'Emu'
      Caption = 'Iniciar emulador'
      Hint = 'EMU48|Abre el emulador'
      ImageIndex = 31
      OnExecute = EmuRunExecute
    end
    object EmuSend: TAction
      Category = 'Emu'
      Caption = 'Enviar al emulador...'
      Hint = 'Enviar a EMU48|Env'#237'a el objeto actual al emulador'
      ImageIndex = 32
      ShortCut = 16453
      OnExecute = EmuSendExecute
    end
    object FileSendToHP: TAction
      Category = 'File'
      Caption = 'Enviar a la calculadora...'
      Hint = 'Enviar a HP|Envia el objeto actual a la calculadora HP'
      ImageIndex = 6
      OnExecute = FileSendToHPExecute
    end
    object FilePrint: TAction
      Category = 'File'
      Caption = 'Imprimir...'
      Hint = 
        'Imprimir|Imprime el objeto actual usando la configuraci'#243'n existe' +
        'nte'
      ImageIndex = 7
      ShortCut = 16464
      OnExecute = FilePrintExecute
    end
    object FilePreview: TAction
      Category = 'File'
      Caption = 'Vista previa...'
      Hint = 
        'Vista Previa|Muestra una vista preliminar del objeto a diferente' +
        's escalas'
      ImageIndex = 8
      ShortCut = 49232
      OnExecute = FilePreviewExecute
    end
    object HelpIndex: TAction
      Category = 'Help'
      Caption = 'Contenido'
      Hint = 'Ayuda|Lista el contenido de la ayuda de HP UserEdit'
      ImageIndex = 44
      ShortCut = 112
      OnExecute = HelpIndexExecute
    end
    object OptionsEnvironment: TAction
      Category = 'Options'
      Caption = 'Opciones del entorno...'
      Hint = 'Opciones del entorno|Configura las opciones del entorno'
      ImageIndex = 42
      OnExecute = OptionsEnvironmentExecute
    end
    object OptionsEditor: TAction
      Category = 'Options'
      Caption = 'Opciones del editor...'
      Hint = 'Opciones del editor|Configura las opciones del editor'
      ImageIndex = 43
      OnExecute = OptionsEditorExecute
    end
    object SearchFindNext: TAction
      Category = 'Search'
      Caption = 'Buscar Siguiente               '
      Hint = 'Buscar siguiente|Busca la siguiente ocurrencia del texto'
      ShortCut = 114
      OnExecute = SearchFindNextClick
    end
    object SearchFindPrev: TAction
      Category = 'Search'
      Caption = 'Buscar Anterior'
      Hint = 'Buscar anterior|Busca la anterior coincidencia del texto'
      ShortCut = 8306
      OnExecute = SearchFindPrevClick
    end
    object SearchReplace: TAction
      Category = 'Search'
      Caption = 'Reemplazar'
      Hint = 
        'Reemplazar|Reemplazar las ocurrencias del texto buscado en el do' +
        'cumento actual'
      ImageIndex = 16
      ShortCut = 115
      OnExecute = SearchReplaceExecute
    end
    object SearchGoTo: TAction
      Category = 'Search'
      Caption = 'Ir a la l'#237'nea...'
      Hint = 'Ir a|Permite ir a una l'#237'nea espec'#237'fica'
      ImageIndex = 17
      ShortCut = 16455
      OnExecute = SearchGoToClick
    end
    object HelpFaq: TAction
      Category = 'Help'
      Caption = 'Preguntas frecuentes'
      Hint = 'Preguntas frecuentes|Ofrece respuestas a consultas frecuentes'
      OnExecute = HelpFaqExecute
    end
    object HelpWeb: TAction
      Category = 'Help'
      Caption = 'HPUserEdit en la Web'
      Hint = 'HPUserEdit Web|Abre el sitio Web de HPUserEdit'
      OnExecute = HelpWebExecute
    end
    object HelpTipOfDay: TAction
      Category = 'Help'
      Caption = 'Sugerencia del d'#237'a...'
      Hint = 'Sugerencia|Muestra el cuadro de sugerencias del d'#237'a'
      OnExecute = HelpTipOfDayExecute
    end
    object HelpAbout: TAction
      Category = 'Help'
      Caption = 'Acerca de...'
      Hint = 
        'Acerca de|Informaci'#243'n del programa, versi'#243'n, colaboraciones y co' +
        'pyrigth'
      ImageIndex = 45
      OnExecute = HelpAboutExecute
    end
    object FilePageSetup: TAction
      Category = 'File'
      Caption = 'Configurar p'#225'gina...'
      Hint = 
        'Configurar p'#225'gina|Cambia la configuraci'#243'n de p'#225'gina impresa para' +
        ' los objetos'
      OnExecute = FilePageSetupExecute
    end
    object FileExit: TAction
      Category = 'File'
      Caption = 'Salir'
      Hint = 
        'Salir|Sale de la aplicaci'#243'n y pregunta si desea guardar sus obje' +
        'tos'
      ImageIndex = 9
      OnExecute = FileExitExecute
    end
    object ViewLineNumbers: TAction
      Category = 'View'
      AutoCheck = True
      Caption = 'N'#250'meros de L'#237'nea'
      Hint = 'N'#250'meros de l'#237'nea|Muestra u oculta los n'#250'meros de l'#237'nea'
      ShortCut = 16460
      OnExecute = ViewLineNumbersExecute
    end
    object HelpWhatThisIs: TAction
      Category = 'Help'
      Caption = #191'Qu'#233' es esto?'
      Hint = 'Ayuda|Muestra ayuda de los botones, men'#250's y ventanas pulsados'
      ImageIndex = 46
      OnExecute = HelpWhatThisIsExecute
    end
    object EmuProgramRun: TAction
      Category = 'Emu'
      Caption = 'Ejecutar programa'
      Hint = 'Ejecutar|Ejecuta el programa actual en el emulador'
      ImageIndex = 33
      ShortCut = 120
      OnExecute = EmuProgramRunExecute
    end
    object EmuProgramParam: TAction
      Category = 'Emu'
      Caption = 'Par'#225'metros...'
      Hint = 
        'Par'#225'metros|Establece los par'#225'metros para la ejecuci'#243'n del progra' +
        'ma en el emulador'
      OnExecute = EmuProgramParamExecute
    end
    object EmuProgramStep: TAction
      Category = 'Emu'
      Caption = 'Ejecutar programa paso a paso'
      Hint = 
        'Paso a paso|Ejecuta paso a paso el programa actual en el emulado' +
        'r'
      ImageIndex = 34
      ShortCut = 119
      OnExecute = EmuProgramStepExecute
    end
    object EmuProgramBreak: TAction
      Category = 'Emu'
      Caption = 'Alternar punto de interrupci'#243'n'
      Hint = 
        'Punto de interrupci'#243'n|Alterna un punto de interrupci'#243'n para el p' +
        'rograma'
      ImageIndex = 35
      OnExecute = EmuProgramBreakExecute
    end
    object EmuClearBreak: TAction
      Category = 'Emu'
      Caption = 'Borrar punto de interrupci'#243'n'
      Hint = 
        'Borrar punto de interrupci'#243'n|Borra el punto de interrupci'#243'n esta' +
        'blecido para el programa'
      OnExecute = EmuClearBreakExecute
    end
    object OptionsLanguage: TAction
      Category = 'Options'
      OnExecute = OptionsLanguageExecute
    end
    object ToolsProgram: TAction
      Category = 'Tools'
      Caption = 'Constructor...'
      Hint = 
        'Constructor|Asistente para crear bloques de c'#243'digo mediante diag' +
        'ramas de flujo'
      ImageIndex = 36
      OnExecute = ToolsProgramExecute
    end
    object InsertIfErr: TAction
      Category = 'Insert'
      Caption = 'IFERR...THEN...ELSE...END'
      ImageIndex = 30
      OnExecute = InsertIfErrExecute
    end
  end
  object SynEditSearch: TSynEditSearch
    Left = 306
    Top = 257
  end
  object TBXSwitcher: TTBXSwitcher
    Theme = 'Aluminum'
    FlatMenuStyle = fmsEnable
    Left = 368
    Top = 288
  end
  object MRUList: TTBXMRUList
    HidePathExtension = False
    OnClick = MRUListClick
    Prefix = 'History'
    Left = 336
    Top = 288
  end
  object PopupMenu: TTBXPopupMenu
    Images = TBXImageList
    OnPopup = PopupMenuPopup
    Left = 464
    Top = 288
    object TBXItem2: TTBXItem
      Action = FileClose
    end
    object TBXSeparatorItem23: TTBXSeparatorItem
      Caption = ''
      Hint = ''
    end
    object TBXItem53: TTBXItem
      Action = FileSave
    end
    object TBXItem103: TTBXItem
      Action = FileSaveAs
    end
    object TBXSeparatorItem24: TTBXSeparatorItem
      Caption = ''
      Hint = ''
    end
    object TBXItem85: TTBXItem
      Action = FilePrint
    end
    object TBXItem86: TTBXItem
      Action = FilePreview
    end
    object TBXSeparatorItem25: TTBXSeparatorItem
      Caption = ''
      Hint = ''
    end
    object TBXItem87: TTBXItem
      Action = EditCut
    end
    object TBXItem88: TTBXItem
      Action = EditCopy
    end
    object TBXItem89: TTBXItem
      Action = EditPaste
    end
    object TBXSeparatorItem26: TTBXSeparatorItem
      Caption = ''
      Hint = ''
    end
    object TBXItem90: TTBXItem
      Action = EmuProgramRun
    end
    object TBXSeparatorItem29: TTBXSeparatorItem
      Caption = ''
      Hint = ''
    end
    object TBXItem112: TTBXItem
      Action = OptionsEditor
    end
  end
  object GutterGlyphs: TImageList
    Height = 14
    Width = 11
    Left = 528
    Top = 257
    Bitmap = {
      494C01010100040004000B000E00FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      00000000000036000000280000002C0000000E0000000100200000000000A009
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF0000FF00000000FF000000FF000000
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000FF0000FF
      000000FF000000FF00000000FF000000FF000000FF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FF000000FF00000000FF0000FF00000000FF000000
      FF000000FF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      FF000000FF0000FF000000FF00000000FF000000FF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000FF000000FF000000FF000000FF0000FF00000000
      FF000000FF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      FF000000FF000000FF0000FF000000FF00000000FF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000FF000000FF000000FF0000FF
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000FF000000FF000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      280000002C0000000E0000000100010000000000700000000000000000000000
      000000000000000000000000FFFFFF00FFE0000000000000FFE0000000000000
      E0E0000000000000C06000000000000080200000000000008020000000000000
      802000000000000080200000000000008020000000000000C060000000000000
      E020000000000000FE60000000000000FFE0000000000000FFE0000000000000
      00000000000000000000000000000000000000000000}
  end
  object WhatsThis: TWhatsThis
    Active = True
    HelpContextMap = HelpContextMap
    F1Action = goContext
    Options = [wtInheritFormContext]
    PopupCaption = #191'Qu'#233' es esto?'
    PopupHelpContext = 0
    Left = 552
    Top = 88
  end
  object ComputerInfo: TJvComputerInfoEx
    Left = 496
    Top = 288
  end
  object Registry: TJvAppRegistryStorage
    StorageOptions.BooleanStringTrueValues = 'TRUE, YES, Y'
    StorageOptions.BooleanStringFalseValues = 'FALSE, NO, N'
    StorageOptions.BooleanAsString = False
    StorageOptions.EnumerationAsString = False
    StorageOptions.TypedIntegerAsString = False
    StorageOptions.DateTimeAsString = False
    Root = '%NONE%'
    SubStorages = <>
    Left = 528
    Top = 288
  end
  object SearchFiles: TJvSearchFiles
    DirOption = doExcludeSubDirs
    ErrorResponse = erIgnore
    FileParams.SearchTypes = [stFileMask]
    FileParams.FileMasks.Strings = (
      '*.lng')
    OnFindFile = SearchFilesFindFile
    Left = 560
    Top = 288
  end
  object TBXImageList: TTBXImageList
    Left = 496
    Top = 256
    PngDIB = {
      3100000089504E470D0A1A0A0000000D49484452000000100000031008060000
      002E1BE5FC000051A2494441547801EC7D076055C5D6EE774A7AEF09E90D1220
      74E9109A74044410151051F48A821DB061B00216AA7AC58A827A11546C88A074
      91DE8BD4107A0BA427A7EDF7AD393987734212D0FF7FF7FDEFBD9BEC3575AD35
      6BD69E993DEDCCE8344D43FCBD3F8DF40BF1BE4BAF437300DE041D011053A3A1
      D960B15A8F5C3CA7FDAABB7CE1A94B4B8799543C0D3D019E3E867BD73CDFA6E9
      9A17DA05AE7EA19DCFEA49EDBC153CDFCE7BD5736DBD573DDFD67BE1E3AD1A0C
      EC953EAE59CBA697437BCDF7123A01C5C060D4D5F3F23006EF3CA337EC3967C0
      9E0B06EC3E6BC0F6333A6C3909AC3E6A45664C10BA368E46428AB76FB3E64D2F
      47F6FB5C31510C743ABD3FB362F0321AE0C9100F4A4D278CB475F4EBED794142
      883786754A40BD863E3E1E21011F3B25D0ECB985812106121948A52718A814BD
      4E073D391D3F5F82BA81156811A9C3B3DDA360F0340E263AC85F2C80BA848711
      F030E869EB205208030F72F4A6387BCEE9F0EB610B96EC2E868FA7117A0FBD45
      2815031B45E04391F5502932C648424F2399510A4F32F5F136C2D7CB005F6F4F
      6892AE4EE485B8983A09AC04E2C220223BC0A683107B5632F3321AE1E36180E0
      4AA224B133B099C98422A8088652A16242CF44842169E0493D783005C9A29588
      0244B233B0DA6CD0842599D889258A403F4DBE03BE078DD9A12406828FA70E16
      B34DA240B501C2CD42648D9CEDC112C7005A565A1606D282556C6ACD934A3557
      281D564A60D6606371253E03F81EC5C174C56282A02E190E18A94C1D99D8F8CA
      4CE54C8D08E407982D5658EC0C19249AAD9D8946514CA5541CB1ED0CCAAC36B3
      4D94C090CA87B9AE74D999B94AE2E161B0992D3695A4D281A9D4722ED0CB180E
      5D991F95A8E78B0625550C42FD3C942D39F4F3348005D4C6375204B3F5944428
      067A9DF666FCE01F06EAF4BAA61A345F8950402E7CC84F54C810BB55AED9ACDB
      588E3E6708744C51ECBF0D4A0257EAE4E4647B3AAE8174E7E6E6E630B1C974BA
      3DD73090D8A46349B8E62F1939649E935BC9886E9550B50C72937351F5CFC9B4
      9291F805EF1A06C78E1DD3F12FBB0A834E20A18409E1AAC9AB90C47FF11B05B9
      63C78EAB983FD85827D6AF5FDF89EED512E902AB93939373C03F21EEF4422738
      FEF442BC7AF56ABCF9E69BF8ECB3CFD0BA75EB556DDAB4D1686B2D5BB6D46EBA
      E926AD458B169A1048EAAEC412A6EBD0A183B6E6B7A1E2AE1592D35FAF365ED7
      BE7D7B6DEDCF83A09596568BE0082C657C9B7EDF61F7EEDD9DE0F267888F8FCF
      19757B2A505EAEEAF5C573E7D0E9F65F3177FE7EBCF7D95E05FFFC742F3EF8FC
      00A81B4444448C0C0F0F57101616365227F9FDFD9B5EB03185BCBC3C0C7EF220
      367FD1C5258DEA9D172F5E44DB116BA113656DF85737E41E3880C1CFE662F307
      F5504166D593D94325A13ECF17E2D0A14339BA56AD5A690B5F4DC6A00987B171
      A63F24AF76B4EA4D211E302540111363953134345411AF7BB500678E1F6158CD
      CFC58B97317876BA93983A59AD5FBA7469272A036D26F8A3EFB444F4999A805E
      AFC5A1E7ABB1E8F14A1DDCFC5234BABD1885AE9323AF2196A4547566694CA427
      0937F697CB948F3B50150387A73A9B4558AB2E5CEA8C84EBC5B81E48117605C1
      A7D4D9625F531B25B0265825B5F09324E4E6E67642E59FBED2BEAE25C42E15A9
      13F5B05A886E9841D2274C990D8DCA4A52520E2AFFF835D765F34F63B5D6A462
      39F25619AF2C697994C3C520DE0BE2ADB63D90E2ED680BA4A085848420282808
      8181811066AE521899178C1C39128EBF7AF5EA399CD5DAD2F838222845B6519A
      B14F26C739C26AB5F3F3F2D07CB53B8A92001557602A28708FA9C667ADB81647
      4900D315584DD74656E5511D4EA5049761AB867B55060E1C51A4234E27ADEEA6
      991E28BC812C1410A7F3B35E3872E4482754FEE9A4C9DEF87A29A4A1A80CABD5
      926A7DF4E8D1AB2571CB962D9D5A3CEE85016FA5A2FF9B29E8F77A926A177A4F
      8957ED82B409DD5F8E71B60942CC147251F9A7AA33DF6722FD49B8B1BF5C969D
      E30E549D67CFC58FD1230CDAD34E21F8B3D768A4AD63CF82163B57EC1FEAD9C7
      D1D84DB15971C5CB13874BCA2BA69A96DDB9C86048BBFDDED5B37A8EB9A7577A
      9D59631AF94CB833D3306168A6EEB1DB32F0F0C0BA787248069E1D5E1FE38766
      E0817E7531B277BA57DBACA8A863674A6F1E33E3F74B925207E910BDBFF23266
      DFEBC31435F49EF81B16E564033A76753DF4904E7799C9861282D90A9D85FDF7
      F177340C1B35E5F2DB22C1CB237BA6796F3952869B1BF9ABCEE497BFE56240C7
      44D5BDF5E10042FA6F8565569456B00765B3E1C3E517D02CC5179F2E3B64101D
      9896BFD5C3E3E3DFF2F1F29DD1940018F1F25A7CF65C07F8FB1AE1C5FC1757D8
      70B1D0C28E99955D00E0B5C527D1A19E371E9DC12F9367CF45B6A56FF6D07DFA
      DB653C37244A31200D027D8CF0F3D2B1130A5C2EB6A0A8DCA28829035E5B9887
      D6E9DE786ACE3AD557D6A92E23BBAFF74D596B1F2FE8014F76D16931551BCCEC
      58DB146BBB111E1E099399EA238DC1903A246768B764EC3C5AC20623040141C1
      08080C82AF6F207CFC020874D3F6F3177700BC7D7CA95B0322FC6D58BDED04A8
      C42139833BA760F7F132C5DEF9F27560079C201AE46B6262954302CAC2F210EA
      AB61CD8E537606B7662761DF093B031622E8F82FB695C4EC95B23CB1374FB78D
      79D5D8FFB7725C10E463C586DDA7A1F3ECB150FBFC852EF866C3157C382E5549
      713D63D04B9B911661C3AC853BA0F3E9B948FBF8D94EF86ED3657C30360DE37F
      EE582BFDD41EAB71EBE40D480AB761EED77BF816985711959622EC99FAA4B26B
      33AC1C5F584D1A51582CBD7A2EB4BD3FBE936ED9F62B787F6CFA0D49D0F7E955
      880BD5F0D94FFB342375935B6EB6266737F0671900DEE8B5869C6B7FE2426CB0
      5A3441BA2C856EC9436FAEF9E9A1B7D65C0EE8F525027A2D807FCFF9F0EF310F
      BEDD3F866FB70FE0D3752E7CBAFC133E9DDF8177F6DBF86CE97EEDF35FF61732
      C5FDC68A9F073FC606258EECA20806426DCF7946E6B141B1D1560FCBA3B2A3F2
      F3F37FF5F2F20AD0F34F855431CACACA3073E6CC5993274F9ECE049D4C1C0C0C
      425C5858281F5B27A9C964E268CEC23E683992939371DB6DB78D9348572642A0
      DE2013D67B7878C0DBDB1B468E91050C060318CEB2AF50101515857FFCE31FE3
      5E7AE92569061384995E0C070891B81DB630743091F0808000040707E3C9279F
      14492299150EE224A61284805981808F8F8F9244C2C47DE2C409E4E6E64A1FB1
      12DB6EB94920E2DA83397AD5EB15234F4F4F0808130763078ED86E0C24C01584
      A1100903B1054447AE388EB7E01AE6E61626A213B1DD222A3DB54A5089C346C3
      5EBEA6AC9E8CD77ECB81EB5F8D1248CFC58168E504C3F33F4FE03C831956B305
      0FCD1BED88C2752528AB28C1534BC671C6C284848804C44526A0DC5486D68F37
      FB2AEB9E0C7E359CBCDC1D8E3C4FFBF5555CBC721E15E5265498CDA8B098F856
      BC613699A3E1A95BE29A05A99FF62257C94B984CEEFB9AF2F599DA0D3111316C
      E6CD3876FC184E6F3BF7E0E9F5E73E32B06681653BE6A9A79E1A466D8BB6DC98
      286A1A1FAD781F313175C8C0823DBBF6E0E877792FE5E4E49C7148708E45349B
      7835EAA4F9D8AC8DBF2C5F0E8B899F38939AFE90AA0D4707E33FED01B5270FDF
      8258AA1A8B43AAF27FDA037BCB24BA91622D7AA90A35963C574451E4C3DF8FC2
      B8EF47E3C1AF4762E87BFD9DD18EA2EC0C7038AAB6072676B2DAA4B696196EAC
      D8F2AB03EDFAED813426826D92EACCAA5C6EAE8097CE0BC9DD121A4A788D5970
      E4F9E5659370CFBCA108F50E73B607A1C1E108CD087A37EB81CCA58EEA1BFBDC
      73CFDD478E6E55991F0EB44E6E87E53B97B139B322C0DF9FFD461372F38EE3C2
      B94BA72C664B5B476D6C71E5CA95D56CB66566BF5AA9EE9E79272AB472F60F59
      954B75B6A55396B7645BB2D5C854E5B96E7B20480D46D5FBC85C61B61C5C70F4
      5EFAAFB607F4D4F81C3E7CF863B3D93C8C60B470E29536E4AB5D095F1AD82C55
      4BCC0986204EF5CCE7B0F7CED0D008BDAF7F0082028311121A86F0F0086466D6
      C7FEFDFB1A56CBE0E8D1A33D99DA324E3AB556E3E5BCD31CD515A1B0B0040585
      85CAADE314F1D1238761183D7A740515F8127B28394C31E7DCB97339EC8D0C2B
      2F2F0FA41BC78F1F47C1954BC8CFBF80FC4BE72144A74F9F405A5A3D1C3EF427
      0C8F3CF2C84B0909D257E0CCBDAF3FFCD90708A4A841C121080D0D47047BE611
      5131C8CA6A883DBB772323B331C41F10E08F3F0FEC838E4AD298478C7B7B3375
      A1636F040416071DDD7A026D1994CE7EB80D7E5DB114C5C5C5AA4CF41F3018DF
      2D5904C3983163727CFDFCB16CCB19844584C3CFDF1F7E94C23F201001047F76
      FDF32F5E40AF16713870602FB29AB44474743C0203FC38B3B71346791DEC6C32
      550EAE1C7D22BDBD6F24C55980A261D696DB511A548450BFC7F1CDF16FF052DC
      0C545454C070DF7DF7E5C8EB59BEE3BC1A68E80D464EC293019919D84BD11B0D
      2CB667E11BB516F1E11958F3E797C82D326160D2606CDBB61986912347E684F2
      DDAED8714131488FF1434880172E6204CC864528D57D09AF8895A81392864671
      1D51C451FEE5CBBBD139F14EECDCB61D86E1C387E74451CB8B561D84E4F570EE
      691CCE3D85C09835E8D56834D2A29A233DBA39A2821271FA4A1E92231AA0D854
      827F6E9988C8CB0D61B8F3CE3B73121212D1A55118BA378F4697C611685B3718
      1B2F7C85BAD12D70ECC2015C2C398F8BC56738F02C42417901D2A39AA0D85C82
      55E50B61183C7870E0E1C3873C8F1E3D7246E0C8914315C54557420E587E43BD
      E89BE0EB19C8E15F10FCBD43C8A004118171D8727C0DB6E66D43A3937D61ECD7
      AFDF13A8FC7BFFFDF71FE15BB925BD6E46F2E25DE598BBF62554D82A506E3621
      3DB211DAA7F5C11FC75661D5DE556871E116F894071C705467CC9D3B37828DE7
      8C7EFDFA5399819813B7896F438FA9535F2B9932658A7FE337F5253ABD8FEF8A
      FDCB4E996CE8FAE9CCCFFF94749D8D07DF693EEBC4D6050B3EC3EC5933306BE6
      5B42CC41A7799F2096546858BE7F054A6CE8707292A68825DC29C1D8B163AD19
      637E99E36B5F77ECCA48AE97A19CCB5F594D27FE66AB38BFE29D131F757D98E1
      6E8F530209F5F033CCFD6562AB6EBF3CDD5AB76C626B2C9BD0DAFBE709ADBC3F
      1B7B93AE5FF7D487FABEB8BF3479F0575E82EB0037064683C122EB6B072F79E0
      50BE117BCFEBB0FD3450372600233A24A26E031F1F6388FFC70E62B1DD1868AC
      888E403D6BA102D6C813174A901668C284AE51307AD89709054FC0C980ED02A7
      2F6C7ACD062E190AE8D45B90E5C27DE7F45875C40C6F8EE8751E3A5BCF9E3D89
      2BE4FC768A45E27B69536078520AAE3572919201B2CAE7C12185B797013E5E46
      C83221A5F2646B759E53EA42033D896FE604FD0743870EF5D71BEC4B81949ECB
      86CC0F577CB9A6044FCEA3C872AA954C0D0623F811F2E7B4E1070D1A34B8595E
      E39B5DBA7461273206AD2EBF84E79FFA17D1AA7FBE66703B428306CF839550A6
      C4DE1506F59A366DCA6060D8B0616CFBB294BB2663EBD6AD6C91A2157CF4D147
      293A3669DA8C193314FE82050BC0150F486BAC02AA18326AFBE5975FC04648C5
      F4EFDF1FBAFBEFBF5F632954013FFEF823FAF6ED5BE3C41C7585850B1762C890
      210AFF965B6E816EE4C891DAADB7DEAA02366DDA8441830621373717D5FD2526
      26E2D34F3F85E84CE285918E0D8A3670E040F1E3E0C1834EF1F9714151111B10
      CE21F2A3C30F4B3EF83506A70F55224270FBEDB743C714AD3D7AF4D0F31B88B5
      6BD7A249B396888C8E91F86BE0ECE9937864EC187CF2C927EA8BC501280C2929
      29B1BB76EDF2DCB061435451E33178F9FE9E888C49446C7C2262E212C82C1EA1
      5175101A5907ED5B35C31FFA0E786D4C5F5099BB98C22CE30F3FFCF0001DEAE9
      FDEA1AEB90991BD582A50AA02125536674E8E4B7835F2CE8D8FFB219C42F20E5
      40221CE3853612580B48A7220FCFDAD90A9E6240C77FE60FA804796480C1AE9E
      1AF6CB705F3AD91226EEFF6DF3078EB720025C03FCBAE397AD47391D5A86920A
      6F362C1E9CE9B46170448113D7D9263A435C1CDFADDDC7CFB92F9AD44D47A716
      A9488E0DE39E043F7CF7FB492796D1E9AAC671AEC80B0D538270A94C0F4BB109
      9ACE0371B111D8BBFFAA043532607945495939BCBC7D70B9AC023616BE0AB38D
      2D3360D53C9CC9D59A051F2F4FF6834C1C70835D7DB6F724D3485156524897FD
      A1D7EEA86AEAA9C1E860030A4BCC08F0F3E224AD1702FD7D70E64219B4CB7FE2
      C9FE0DFA088D2B030A294157E1A6FAB1D06B261C3D761227D8DDDDB3EF10CEEC
      FE19ADC32EA24DE3B427A70F4BBF5D27AD0C0716D71D2F38D8EEF865817671DF
      4A84C7A4E8F6ED585DEA50E20D8D171C4C467789EEDAE1A64B938C9E9EBE4A02
      47C48DDAA7163C32D56AB53C4E2872487043B467BE78FC90CD664DF38C8EE59C
      DA7684EBBD2C4E25BEF2CA2BDA8B2FBEA87100A24D9A34497BE69967B4891327
      6A6C38B5535F3CA19DF9E231CD2B2A362DB2630F04A666B285B6B1FBC30E8C23
      690E3090949404F9A352C592A64ED9366D1B22DA75A35B87F2A2F35CD42A67C1
      B272E863B1CFA13006926A6A6A2A96967D835EBE0339DFAA879405896B67DD88
      E8F65D5151708A3359150CD263CFC655F02A2DBBE054A2889C9191818FF3DF81
      1F027147C4DD4E096E2A5F8DD8F6DD507EE524AC1661A0C3BECDBF435770E582
      6153EC2AEDB3CD1FE59CF03D8A6D259B909E98066F5F6FAC3FBE064D825B2826
      51657F22303E05A6924B4A028D33DB17CF9C64052B2835A4F48ACBB9A7CF0834
      ACDB0859751B202A221A919111385F701E6B8FAC468B8856082DD98BA0B82498
      8A2F4233972126320FC78E16A1BCE072A9AEF38CD6DADDFD86E362D905354F66
      B29A9947AEEEE83DF0FB864DF0BDE80F2E8A23A5632F945E38C2910A870549A7
      B07E51292E1C3B7DC110DF2D26A77E7AA622D2EB0C90DE91ACA3FCBEE10F5C3E
      5E885159F7C3FFD26684C627A3BCF002CAD855D5957AB30B5082E24BE74A75AD
      5F6DA259B97864E61497CCDA272525C2CC8588CBB90578BCC504A58388FDEFA0
      7EE77E28397F90536154223B5E79B94771F6F0DEAB6F41FA09BD7AF5C2EC1DD3
      51662AC7C4D6CF522AA85719B8FD756475ED8FA273875806CAC8D403C74F1CC7
      E9833BAE32B8EBAEBB34E9B2CCDCF2261E69F138A7418D8A81142AAF8D2FA249
      D781283AFB276CE672C520EFCC29E4EDDB72C1C0A2AB10D975C961B70DAD63DB
      9298BAD0D9C78CC2C07A7419A293EBC1D337041EDEC1DC5264E4F0E82CF2CFE5
      95EAD859D0D83F0007DB6A4029531E02D2264AF1167B74BD43F00F0AE2125100
      BC7CFCE0E9E5CD31743E8EEEF9E382F1EEBBEFD629116A313EBB372C32FF5C51
      AAD562CAB458CD755923E3F446AFA12431388B323D7FEB7156E7BF454D222783
      478E8FD01E3E364C1B73F00E6DF4BE21DA3D3B6FD5866FE9AFDDB1A18F75F0AA
      1EE7FBFFD265699FEF3B3E7AF3D76DE249E77C9C0CACDCBD7647F230DC59F76E
      0CCB1C8E110D47627893BB31BCD9DDFA21CD6E8FE8967973CF7AD199D3CD65A6
      D96D3F6ADCC6C1C1C9C0C21A66E39A9AC56A82C56683496CAB0516CDCCD7EAC1
      6F833F9AD76D8EF60D3BF4AFA8304D6834334D49622F2D6427B3B51F6E9BAB96
      444C152464D136711ADC42775A643AB292D809F7D023A94E0A321333FB6FD9B3
      651580194E061F647D55E3EBECF059B3E99BF76E1E747BB7A1F1169D0951E1D1
      3095597A08036749A4A7C66754E30796BDBD616682A78757EBF09070EEA034E2
      8FAD5B829EE83AFE75A70E849A9A3650D3F65A24012E40E5B11536C3C4CD8C15
      D48DB9C2A462DD18982ACC1F5454986F57312E46E6EBC9D339393F282E360E05
      DCAB70FADC29504F5B05C5C9A0E777ED67A784A78E4C8E48CD6AF35123ADF9BB
      991A35AD654E4BD2D293D21E1DD2FFF6780F6F4F78EB7DF95139024B85699930
      503AE8B9A4FDB494F094C79AA5355333F80D53B390954EC86C8446F51B23A64E
      1D14590A608407F6EEDB8FB5ABD72DE14CDE9BCF0FC829540C3EDCF5CFEC209F
      A08E11A1116C8DF8C5613E59695816CC5CC836ABA99F7367CE63C7CE9D58B76A
      ED128BC93AB5629EB65724E0278A2D2057646F7AAFC18CA13FF4D36EFDB6B756
      F7D5382DE98568ADCED3E15AE4E3415AC858BFF3010F782DF51E6578D4381CF1
      D2257080B31C6CBA7FCFA30DDE48F6A7725A1E7AF64423C5FD060C2703C1A5A6
      1F60897C4ADC370AFFDEF660C8EA9E1307FCD2CD395A1129DDB22001B501E796
      EF349B4C69C4B98FA01E674112DFB8DC11F10F1D1CF6E803FB6E5F7AEFCE41E7
      476C6683B2BE8F3678650FADFFB22E5A6A645A567A54DD7B3BCDBFC93ED42591
      93C1B86323DA5081B3D302D3A7774AECDA735083DB2346B41889BB5B8FC48876
      F76054F628B4AED71A2D325A223D2EFD91E6EF64BE4C7A28060F1F191E4FE209
      ADA2DBF46FC6D9AB40AF000EFF8D2C4816982C5CD5B1B012594D749B38356E61
      EFD50CCEEE7A3A19B0580E4A0BAADB3F2190DF45762CCB4C26ACFE7315DE59F6
      36DEFEE96DCCF96E0E662D9A83159B7FC5AF9B7EC5B6BDDBE7EC7AECF07861A0
      5EE37DBB062FCD4EEADC5352966DB7F3D7CF3F41A68B7FE8B3EA3141724093D9
      19BB5889B6EE79F2E83D8E30950593C9DCDCDF2B507DDA0F9D3948F14CD7100B
      81B9DCF42F56F7FBC4ED0025C11DEBFB9C1FD8645004778F636FDE5EACDFBD6E
      C6F2C11BDC52771054B5556DFCE2D0A75DC2FD22D2D8B3E6BE6C7F6C3FB83D76
      EEE67712EE6BF6A0AAF355895CFD2A0B6C9E96E59ECF8507BB351E1E9E18987D
      6B7C6A6CEAA38DA6A769195392B4B4C9B15AC273515A9DF1615AC423415AF043
      7E9A838992E0933D1F9C3A7DFE748AB7A777869F5F008A2D456CBE93D0900D4A
      E3AC2C346ED4048D1B374293164D14FCB166239EB9E5F9C9C2C428C6B281EB4E
      B4FFA4D9D4157FFC8ABA89F5FA478645212498BD5023E78E342B1B196E60D158
      1E38EED1D8FDB1D857FB84D45E90C4B56EE4B60DA672F3D8EDBBB63FF6FDB2EF
      7FFEE8D34F2EBCFBDE3F6D7366BF83B7A7BF8DD96FBC8339536763E6AB73F8F1
      71E6E06A575798FC1D504AAC8930E11FEFD76FF3ECC28F42EE9E7D75985605B9
      5606B16181D9B7B4ACD79D5B6994AE1CB44123663BE99C0E47A4ABED61307844
      07FB867B78E855C591B8D8D173B3DAD44BF85EDC02D761A0F70CF5F7E53C9C31
      48908347CCA9F7F4E00E4BE3C30375E217B81E03AFF0001F8E1D749EBE77CC88
      7FFDEE9B7FF4D0EBAD5FAED93D4A8805DCF22601AEC029529F203F2F6190FDEA
      886EFFC84A8C4C1A38E55FD9450BC69D75E0D5CAC0C368F0F0307A60FCA0F6B3
      07B5CDF4B9E5E52FC69EF9E01FEB1DC462EBC5A80AC6D677A97052EBFDF8C387
      CCB8709FE7E6AF9CB7FDF5BBE654C555888E40DFECFBEA347CE0E3AFDA74BF73
      47DDFB3F991FE4E3D5A5B0D484F92B77FEBE70F9BAFB1C78AEB693816FC7FBA2
      9B670F5CDDAC7BB7DBC25392933B0CBCF5AE96E909CD42FDBDB98DA4ACCC7C72
      7707574287DBC920A57EDB3909F5EBA5FCF0C11BD92BBF787718AB38779F19B1
      2AB70C214DBB771DF2D4EBBF45DC7CDF35523819D4494DEF7E7CDFF665F94B67
      AE89ABDBA0A7FCC861DF894BDAAF79A558F3C9476B2E9F3AB227B97EFF19FAFA
      377B3B5217DB288640455969496C66D366ED5F5CB2BE75BF616DB77CFFD39F3A
      AB47585C5685F79F0B1ECA4E1AF4D4F8D8B4EE53BDBD7DC2887F8AA01E434E4E
      0EE46FE2F4B927221352FB85C525D7DDBD6CD5D69DEBE6F788AC933532322D3E
      F8F65B07CE4BCA6A75AB874758E3BC83BFBF3269CCB072A111508DAA3804FC3B
      8D8EE6AA8E77E18A7FE6827F9977CDFBBDF55DB7B4397F64EFE988D8A43A5BBE
      5BFDE79E4FEECA6094F3313A5D7414AF7AFF2C2DE77370C782CEFC19CE8EA0C8
      E8A4133BD61EDFBFE5D3F6C05DCE7871180307FCB4302CC42B4D6F40303B3B56
      CE6773CA514399D956E291FEF047FBFE3CD7549BD7BD52E43B84C60DF421C1C6
      BAC73EEE1AB0EA8D4E58F34667C3AAD7B30D3F4FED60F87D5676E0B0DB9B3D9A
      9451778EAEDD87BE6E542E1E6E7CD4FB9E2DD20C3B4F69D875C6866D272C5873
      C884601F4FDCD23C0203FBD7ED1258275C7D075DE89C4EBD46998DACDDBE1EFC
      2D161DDE043F6F3D4E5C28E64F8F80493DC3512F29609893A28A4315243D1978
      519D9EF479F0572FBE1E062CDA56903C63C5E9E4C9DFE625B76B96989AFDD2BA
      924E93D794361AFFEB41EF01DF4DD2B57EDF4778E9657E8A2344FE5AC6C08509
      03BCC840A4904FFCD4DB92F178AF243C41F8ECE1D6BEEF8F69E5F3DDD3EDD3A9
      9BC9D4CD42EAC6DF10D878C4B8FBFBA4E83990E7D759D8C97097130C27AE8434
      490AC1F693369C2FD170F2B21507CE9AD12CC107DE7EDEF009F5ADBB2FF77220
      97446CEAEB42A999BA48C0D50C2E4250375C21026AD34D90B7CF439C8436708C
      6496EC5C03D5E966CF591D96EC29C3A5621B2728B92EA9D38C8652F3956B8825
      33D5E9C6CFD788108A6530F2BB492A7D45795989973E04E17E1508F2AE40849F
      19314194881C582C89226C6CEC74F1357B726598E04D62F9D599C67C1AF9ABA0
      D30D47AE88A830836DBFAD8C2A24910D216146BC3020956F0624E6E28D209323
      77DC9213E0CF72233D7663FEB7BD65F44522F7277EF8AFE46D66E920A67B94F2
      59399E8455264C94F75A83BA3156A71B076619F5A6B31A744CC111E46E171597
      E45337A1A21B0E64B95F973F916289152C1658AE8285726ED564726B5024D201
      DE3D7F58CD1FC7A55303D1DC6C5AE2D08DC453709DD566290E0FF2E47E5A0921
      BC7E8BAE3EADBD04F5BCE4FC1EA3E0A9EFB46015588D6124613386E700E81718
      118B07DE9C85E2736BE8A5A6A33AE29D87EE0D220EDF013E67E0D764B698B6F3
      D1D3F5F52DC387F71D3AE661746B5487AB211AACE5450A382243F71629B86DC4
      9DB875F81DB711F71354F9132526FA068470AAEFB42AD207DF9F442636A26938
      A7AD079B39949D3E069FA8444F060AD0BAFA8804D491051ABBF5FAD038D8C213
      60098F27D0E646366B4422A77D74A8B85C7C95CAC5251270132FA71EB869CDCA
      192C996812D15D706A752A09348E54AD1C50689A884E816C3A6C3E1B8235A7C2
      B1E66438569F08C3CA5C6F9CF66C22EB6CD3B857731A57C7A671D1FB5EC3CDF5
      9053BF716354145EE2ACBB193666A5C2A243BE2109239E9987066DFBA371C741
      68D2B13F3A0FB8079C2E6B27C025F7965F7EF9E53EDDB47ED06EBB7B184ACE1C
      A51ED8A5E50C7E39CBF87E737DDCFAC84CFCFAEBAFCC91BC457B4EA40289AB4B
      972E663299A624C868D480BF5FC8E7449B6CA165DF98DB68CF5BC3D0A04D1FB5
      122A9B3C64A950C0E1E632BBEDF3CF3F5FAF241878E7ED28CE3B42F14599DC97
      6AD5639FAD01868E7F072B56AC704AE048DD2101D71BED12D4AB9F89F2CB325F
      6A55529845022D1C0DDBF775934052770057806C5C7B5CAF5E23278B60E392BE
      66B1510F16821E363D5B2526B56EDD3A9AEE8F48D2B56B5735FB273AE89A929A
      9AE81312068FA060780685401F1882B366EAA07577A7048E94E3E2E220BA101D
      702A51493065E90F3F04308D2604F55839D55110D61EB2402513922AB08A4106
      4A02A52011C915B834AEEFD6ADDB84CE9D3B4FE32AF0B4B66DDB4EE30F63A635
      6FDE7C5A93264DA6356AD4685AC3860DA7D5AF5FFFFE1A1B942A09D6E8D5D718
      738311C6AA780B7E589797999911FFE79F7FE28EDEED74CB361ED2641BD1BA95
      BF1C7AFBF5C975ABE25F234161C16504F8FA80040A77D386D5DC621488B6D937
      FBAA802A8693C173AFCDD2BEFE6D9BC619DBF86D3B7763FFEE1D0A75DBC675D8
      BD7D0BCE9E3E11DBA5677FADF780DBBFC86CD8D83F322656D1EA371E38EB3DE3
      C3853D331A36E566D632145CCEC7778B16203C321253DE9EA7A56534C0B9520F
      04C7D5C780110F21243C72E8E913C7C715155C5635CC30E08E7B111D13B73C3E
      3E3668C7B6ADFC91830D996D6E41979EFD101A9B6C0E8C4A3744047A63DFBE3F
      71914D5B9BF61DF1CDBFE6A5992A2A66E7E4E468865B060F33949614BD61F4F0
      C2C9BC636AE7DBE5D347B07FC71FF868E6CB86C2F3C7E1CF518BA7AE82BF7DD6
      E1FCD95358FBEBCFFC8EE21532B021E78D773D468D79A2A27BDF41DAF0D1E3B4
      4EDDFB6A2DDB75A2E80D4FC5C4C537494CADFB635C42B296D1A09156273E510B
      0E0DD3583AF3A920BD143EC3CA653FD8BEF9FEE71E43468C4E78E0FED1E8DCAD
      0F329BB4C6813D3B7EDAB56DD39C8F3F5D70CBE3CF4F69F8F4A417316CE403E8
      D46B20967DB7686B6969C94764C2193E9AEC23B43971EC08D0A135BEFAEA0B94
      959672A2A52C8B51309597659514178A13FF5AF839BF91460E40CADBA8001AEA
      555498CA9DB353F25B665F4E01949796A6D56FD44C575A561A13CCED65C4550F
      7F0FCCBDCB6627BE2A8915FC79A68E3BDD0AB8F3CDC8519A919D2C4F1F1FCF4B
      972E0406F8079E266548517129F7AF7AF0AB6CE4DC6A0583EC8F924044FEF6CB
      791836B82F16CDFF009FBD3F0BE74F9DE4BC6999DF995327BC1E19751B3A344E
      C28BE3C7E09971F7A81A6C27875D07BFFDBCA4F2CBEF0876B3F98977F3BB7994
      046E217FD1A374D066AEE97E4EABBFC7495B14149B53B78DF33B7AA37C14830D
      F77BCE6D36ABE4BDB2321CDDF1D88D134B222A0B4DA697340F30F2FD9AB4A3A9
      2F172C4C985CB03CF6B982C182703D500CCA4D5AB76076DE4BF95B76BED1A375
      C33CBA1975B685018F5E4AB91E0395051276DB72C48A532F07DD2C0424EC1617
      6A687EBADC2A0C6AD5879EA286D8CC5AB7B232CB5742EC3DF652489B360B9AC7
      A5CF310DBEF5BE9512561BE849D82DCACF000ED2554A3DBABDFD47DF26A5E8DE
      D0E6595A54B6A0FB27ED0C6D67F73FD5624EC98426B34A96377CAB6479E6EB25
      0B335E2BBE5F181BB4E6E31F399B6F0AE11A4B83C9DF94CC0C0B396A4C8929F0
      6E15D71A0525450DFFCC6BF3B4D1736A70529867B7B3F9D694BA511E290D63BC
      1A7081A9DFC4EF4BCE18CB67873D209CAEC2580C587CF3B4CBF9F94FC586DE86
      50FFB61E617E7A6C3E5631F5C004BF89A92F154CB929D967824163BFA9CC16A2
      947895D8EEFA76D0F2F1ED66377BA459C65D9E7E1C89FDB17F8B6633644E95D8
      F20A84B0EBC68D0D9C6735DB2E57CB80C4A78A0B4A3D7F5E713B4CB89B1FEF58
      9BDE2F7361F47305DD1A467B202BC613CB7714A3DC84AFF4C2B52AAC1FBB2DB6
      D4B025D4E6BF7B45C3B4E7D030E51E4305C5E5C2CC57510146E4E55B505C6ED9
      CAEC572F8130AC305997378DF5696E66577D4B6EC9C44B53C2A6FA3D7A69C2C9
      8BA6C1EC46B051D1D46BAF360BF1930BBA4507189BB749F1C48C65F96C173097
      E52385BFEFBA3F2BDE133F6D2D06678FB74A42D56681E2A6F872506CB2009971
      DED271CCF733D88E348FF749D1D8836B92E08DC410E372FD9D67BA55FB790F7E
      E25208D771A77031F77EAB55E8B5AD9CD0FC8A559E7D491B7F0DC2EE34AC5FC1
      8A892A0B55CF43A9C3C1891A8D7A727F22DF37FBC20D781E8A77E57928D1FF39
      0F45F79FF350F80D95C225E02CCAFF73CE4389BFBB1312EEEE8A84118461740F
      CF46D2B06CA48DC846DD61EDD1604447341CD6917B5034763CAC920355E2D9B1
      B272C69EF30AF1DC0DD8FF1644F6ED8D883E04F6D4227AF5414477BA7BD0EED1
      139E7562E17A1E8AAA8D81B77D5FB2E5ED2E3E3163EFD171C8410432AFD4924E
      636D6435145BDA421DABB9F7E26F6DDE3D17976A2B6E63FB445CC7792867E6CC
      FBF79F87C2F4FF273D87A5A5AA14E846DC95A8766BBD0BB1ABDB1E0BB886B9BA
      55FCD72EC4AE6E15E962B8C639DCD536EB2E3437EE7CD7450A57B783836B98AB
      DB11AFEC1C172637E2C6FF88BFAB7DE451EFB0DA54CAF4D1187BB823CCD5EF70
      57A2BABF05891470100A5255BF84B980FA363AFD0E422172044A98ABDF115E69
      DF980495C8D559EE12548751354C2492B05AA492E8FFA760A1CC1ED79C23F7B7
      501D5E794975A1CE307B89737AAB38DE3F77B5748E8EAA16B7F6D758515A85E3
      B5DE6AB92AB437F7D8537FA2A10EAE6E1579D5A8590249FD9996F604C47D95C6
      CD6547700BA267D24A7BEA745EF3BCD8D98DA67A0924C5A97DDC1031E1C76A99
      BA2349728F2EB423CE18724371D74A20A9BF3BF25A62612E7162BBC05544472D
      7344BAD6B6AA71D5E138C2FE63FF750D5C7D0B2EB4AE7D0397E06A9DD796834A
      B434AE43563A6BB5AEDFA0D44A5E390D741D1CA0F713F6E22D883FBD7935DB0C
      374A58AD402415EF2074F825D011E6AA3457B74AD9954088045CC2F46E0412F9
      17419F466D0BFC5D46B5BF05471E5D4456D97291F2AA46192852883474BA3FAE
      0CAA63EAC016060EF77FEC7FA3069CAFD1F106AA7D8D2E02558BB7CDA58FEC82
      5BABD341A34AA27DDEBA56FC6B221D34FF65064661EDE0E656CEA5C83A8AB0B8
      05D1C5EFA0D1BFC3FC0F638D9478050E64E5A1217E174286A847688456654185
      D46408B130A9215E3F86A94FA11435C403422C4CAA20088DD0BAEB4090AA228B
      DF9589B889E7D0019D007F7F7BB5D55521D7371C344A076EDCAE4FAB301C34CE
      A23CA0520FDF52270AA30663C00DE2D540FE3F3158E9E07065BE44C0B45A7450
      1D9E7A0BB2AE2F8402C2A426907801C177E018C5E11A00E45496891C259DC457
      0D73C727C63267161CC40CBCCAA892E1D5B0ABF8B04F445DC351706B0157FC2A
      5910B11D52885BB888ED1E760D03F751911008A12BB887B9E257914088DC5393
      90EB2A71D25F54E255FC4A25BA8A644FB176D315BF4A1624AF55B3706D98AB12
      55527739B3A0BCD7355CF1556973D471A1FCB696BA30C025A16F6BC1133EFF3F
      8152A2A3A148BB41C5B8E13BBEF37F476B42AB77B4EF6E5F66E1265F24B1055C
      DD2E7EA1BDCA4022FE220803CC77291C4E29AAA6288C1D610E9B618A56BEF174
      5F7D5C10AE0656BAAAC409AD7B160441BEBE6257D2D4664916AE32102221160A
      B1C52FEE5AC09D412D888EF75E154518F0DC15B834DB555100211EE0AA681794
      110C377ECAD2E740F8966E9778E57C9266D5F0012464308456ECFFCB41D5C66B
      F2D06C80866DDFEA20B62352FC0EB78B6D747157EFAC81D081AC77386AB45DA5
      A806E9FA0CFECB125493EADF0A7AA2B2F05425AEFE2D54C112E2371826A5F2CD
      2AA5F55A06556AE1133FBD092126BD7AAA32A9FE354A7556E800531497264CAA
      124BC4F5DF02B1C844571D31A3EC9D2C715C0FDEEC4D4D548374550755F2AE70
      9995279EB8B6BDE0F9F64E3A771DFC243955A49CFAA1D08A2995E812FC24832B
      319455BB0E2881C2AAC57097A07715F695845553AD0CFEEFB1ECCA70D43847C5
      11BFC32DE9885F6C010977F5BB351A82E08874B51D6E891770F1BBEB4022055C
      1054CBE41A261238FC741B158283800112E716E688930847BCB8055CE3C4FF77
      C0AE44A11C706D89C3B770C6B320BB7DC1A47E0899BB0E9A485025ECA0AD4A22
      6D795CAAB56B6971672088AEE05E12355742079A3B0349D51153C576885C25F8
      6A1E9D1122B67BCA2AAA6AAD74D4487709142A0D6142CBFDB95A2B5DEB46F50C
      AA910099E0A11AEE2CC5573D0389A9020E91AB04E3861938BB800E0E955256CF
      A05A1D90D2D162B9B41BCE92C6E8DA9FAA4C2B25B033A8AE5248C59170B185B5
      B8C516BFC32DFE1B6A0F04D14154C5D6BB555D41740507B2234CFC2281C34FDB
      DE2A4BA04432C0ED9170D700F157C1333AB32091AEC8FF2EB7FD2D486A353428
      551B124175AD99EE05A9814457C2DE4A9B96CB970D55DB04BB128954ED53B5F0
      5483E42E814BAA0AD75EDAAA6D89547CB5464DA9D6107E5589D5215082AA2D91
      24EA5AB5DDB3E0A86D8225354E31BDDA1249B06B6B24FEDA95480904A9367097
      4052AD06BB6AAAD5A0DC4090CACEB5785795E85A49A45ED4E49738173EEE3A90
      48010782AB5BC2C4EFCA9861EE0CAA4432DEFD917861E212EACEA04AA40B9EDD
      29F1C2C4EE53A63B0315E46254417689F9EF735E7D0B0362DC3A102A896FCFE8
      FE627B7046D129636F8CB2C4F877B60757539594D5DA02C74A555B211557A351
      4391BDE6E35AC9E0AA12AB23646DFC4F7B50A929B1AAD311C3AF2A911EF538CA
      BF541C0970F8C5ED08137725545F9904F13A8495F4373E6E741054B5AB97A02A
      562DFEEA1988F8920D07A1F81DEEFF6EDBF9166A2AB27FA93D78C3A5E2BB7E4C
      5C82FF37F70F5C5355BA626DA4FD7FB87F801A3A5F944C3DEE5FE71AFA07A8A1
      F3251CAA2F48122360D781B86A0477096AE81FA06AE7AB4676B545D4D01EC0D9
      577694F7EBD99288E054827B1624F246A1B2B255AF44E17E3D4695387606951E
      274D2577A7BF3A47258E9D41A5A73A3CB730D784C42DE086F0373CCEF6A0A622
      FB97DA839A8AECBFAF3DB8A6C8DAEBC2FFE1F6A0A6C6D6F1C2DC8B720DED414D
      8DAD30B11724715507761D5417E30C7397A086F6E09AC6D649FE571C35B407F6
      3504A90BAEE5DAD55FD52D893A7019E7AE0306A8E900411210BFD802E27610BA
      F8DD19B822085255BF8455017706928A2B82AB5F9855E37767E04A2C6E21125B
      40886BF30B4E6D505DB516FCABED81F86A0021962A2D9D6ED7B90341BF964195
      F7FD9FF5853775FF690FA4A8D40EEA2759B5A3D41EEB6CD2E48485ECECEC3B02
      0303E3E47C71FE385E9D682B47C2CA0FE4E52217011E647F71DFBE7D5F2C5BB6
      6C9CB07632B8E9A69B7ABCFEFAEBFE12781D081C376EDC6DC47167101C1C5C9F
      81065DCB1769D5FC689B2679F24474E710D729014F95506EB9932D3C2A1AF443
      6730F0501D9DD37DFCF021C559E294838622A2AD8E2D105B80E7A4414F62D183
      20DB19498C1D6C2E53F27A7B90DD9473747F9DD21EF3C6C4E39F23C330F30E7F
      BCD65F8F9CEE1578BA7309DEB9274221F24823658BE16420C43CDF03AB56ADC2
      BBEFBEABEEAE5BBF7E3D162C58C08B5D02D072C65BC8187B1FCF9536D90FD010
      6A820B03FB8FFD78CA0A264C98C0FBC83C216EDE10A18E90CF9B320D858B7F52
      E1BC8191A4F6C7C9C06436A9909F7FFE595D57EDCDDBF356AE5C89F7DE7B4F49
      20878A7CFCF1C74A020B8F8854C8340C39393990BF254B96E4C8DD0B7249032F
      C88528303D3D1D3CC64315A8BA75EB823731430E13212E883B59E8AE4A60B288
      1F3FFDF413EF2099AA5EDD2FBFFC82E9D3A7F3D80223E468973973E62809E464
      4B854CC329C1BF16FE2B67D0A041EAF81291807190547955AF62266E1E2C8288
      88082CFC6A1106DD3A5049E0AC4C2436DF3664087F595DA613E26BE78424943F
      A2F4F1D1167DF555F9E2458B7C25C42886006F7938F0C5822F5278D49DAF4E58
      F0C4775EDAC1291889E52598B4D42F2BCD16537151C14E7AD5E364408D67A990
      BF682806F7DD779F1C947287BFBF7F9C2ABA1441DE8254630139F159AA726969
      E9455E70F10515AB6AA2A4A518646666F678F8E1876FA82A93D859959D0C9872
      7D7A0CEDEEFB8856CDCFFA0F46797A787838ABB260AA72C063D145129DAFAF2F
      6262E3119B9088B8A4142426F3BA80D474A4A4D7E3B1F9BE82AF5EA972541A42
      E8762C8581BFE5D5F30039D10119F36C249EBB2E6FA5924073A9CA12A4241087
      286AD6838DF1FCAD5178AA77201EBDD907FFE8A0C3BDADCC3CE5B90C4FF60911
      3492BB9710C5408845FBDBB66DC337DF7CA36A9F9CBD2D4559B2D560E1BF90F8
      D66BFC35AEC5AD2A0B47C5408E87168F145BB95245DA0571CB5D23541ACE3E38
      0625AFBEA9EA040FF3145427D819F0BC6409D9B87123BEF8E20B25C1D6AD5BF1
      EDB7DF2AE5893472538A343A561EC024B80E500C78D4ADF24B65E1C9DF4AD322
      81482312883BAE49301E9A3D181B8A17A3E7C486852DC7443F27448A81230BBF
      FFFE3BE6CF9FAFEABF5CADC2239C14B3F9CBDEC1BE8295E8DEB90DC6DF3301ED
      3B340E08AEA3BD94324CF786625051D91A8904F7DC738F229254E5DE19D1C78E
      B36BD1B2610B580D56B488EBCB53CE4CE8D8AC13F8F790AACE3C32DFDCB94B17
      03B3A2DEB8FB8B025EF9F97E3C356A3C06367156017CB56D1A26BC35C17E9A29
      AF94D9EDEBEB97C25769AFCA9595C9BE12ADE1ABBCD73174481F58F8BBE757FA
      7E8B67BF1B001FA3173EFA7C61B92A89B367CFAEB52A7F3EEC9597D76C5DF56C
      E7E65D54CA5E7A36719B973307785B65415CD7032A8C1BC5318678018422C23B
      47E76B1369FFD71EA534371639F69C2387C5DE2DA27A8F7A8D55A3F25E580232
      A8FA32AAA2297FB50C2466DBF8976F88498D0C84C92F63875E9749AD0C6E84C9
      75190893CFEF6B58A32437C44098CC1A46D3F186E8743C37CC60DC7C9254F36A
      6F88C19D1FEC912C5C5B66C8F3BA0CBACFFEB24662D2D73E317D3DE25A19349B
      F65CAD290BB140B5594898DCFF868885C1FF79B8A641D13D863A142B9620DDD2
      20DAF214D0B84038A54DC769DACEC7A90312FA135AF44ABE347046E783237FE8
      BFFDD9B58337CE597DDB1F73BEEEBDF9D9696DF78CBC39EEDC40C121F83B3828
      0695014DA77438DA6F62AB93E3FAB7081BD3AE45FDB6AD5AB50C6DD3BA556876
      ABACB6035B458C19DBE8F0B8679BECEC47E2A69534CE729041E26EEDE34B1E6F
      9E55BF6E529D307E070DC8E715831709726A675A42143AB4E1050A91571E9FD0
      706B3732C920F0BC51E69962B76A135B34B44983FAFE7E3CE6F3D4A5729EB7CF
      E32B2ADB24391AF50219A545F9A2738756FE853F2C1FDA2E3CECBCEEB1A4D392
      85D81E0917EA27C4C7D515E267E61F42D3877F428B713FA1E523B4C77E8F9663
      7F44ABB13FA0F74B5B11CCB386EB376C58B7A9F7DEFA9420D680D6394DC6343A
      3EA45E4A5C3CEF6AC03D6FACC5CC87DA206758438CEA99867B7BA42BC84A89C2
      87DF6DC37DBD32D4D77BDFF6F5E635C52DB61AC92528D0B322C3CFC713170A4C
      F40237A507B123C1D32399059345C303FFDC8BD747D65367805CE22D4909113E
      F0B216880E824482ACBB33F27A2724C4FB94F0C6D4777F388086C991880DF546
      6985150FCEDD877DFB0F22954A5CB3E3044651024F667CFDFA35656BCAB37F12
      06097D934ED78F8A088BF7F234E28AD903CFCD5C84076EBD09DFFC710EDFAFDC
      C97375ACF86DF361B468521FC33AC6E0E4F9026CD8B473FB266B87E5C220B869
      E8C5E8C410C34DF151C1488C64E76A400B0EC2785F5F1D7F5CB1F8E0C0D1D3F8
      EEB501E8DB3C120991BE58B7790F361E2EF97EBFD6EC77D1C1A9657911FB92BC
      761E0C0E09AA9B19EB879DB9C54A177228E5B8DE3C0ED3CAC33909CD5203B1F3
      30EFAA59F5CBC1FDE8B78F48A70CDA869CA27B16076A311E67CCF92776370F8F
      AEE3592F3690BD141D8FCDD778429B0EB7B48C44BD387FEC3E7A1E733FFCA4F8
      6869F4FB7FE87AFFC67AF1A74840463830E748479F7B2297E2FCFC2F86366FD1
      BA6E4A623CAFCB08E4612B361C3B9D8F9F0F1CC2DA95BF1C3C694BFC72B9E7BD
      2B48748060EF6028C763900A92D1C4675FAB74EBC6FA41A6BC26DE5A6186D96C
      4189CDE7C005C4EC38EAD976DF21FD4D1B897F80A9AB7CFE97ABF3350CC8FD2F
      3D2C12EEF867DF9ADAE7DCDBD3779D7F77E6957373DE3A776EE61BE7CE4E9F72
      E5F46B93779D78FA8941794F3DEAE94AE1C6E0D494977A7B4585BD17DEBA7E56
      649B7A41512DD323A35AA54746B7AE1B14D5A641967754C4224B49F1C3D53238
      F5EA8BBDBC6222DE0ECC4C8C355C3C0CEC5E0DEC5907EC5A056C5A0143DE1E04
      D74F866F74E48387EF1AD21B957F4A8253AF4DEEED1D13F17E48665292E10CCB
      C7C9A3405905C013FC505C6A771F39008F3F3722AC517A9A4F429DB98706F656
      4C14035EA9382DB85E6CACE1CC5E208FA997B15696940025242E2E038AE9E621
      61F8732F3C76AD43644662ACCE6898264218C5B0D92C090698815C125B6D60E9
      E1DD626422836CE9064B4321EE8A72F05C4478C4A6B3B9B22608AD1AFA16AC58
      F6586074A81FF2FEA4B824E4F1752867CA920D710B948A5F804CE2EBE2E2BEC3
      8561C346BE6E67F0F34F4F06C586F9E1C87EA64C04574221764069855D2F2999
      38BFFF7049C4C8FBDE5059D02ACA7C78ED1170E50A542F51894B49C416E079B3
      900B5C4C64C03B6D795115B48A0A1F6716F2BFFA6258206F72D39792C1A93C4A
      4162DED5C6831299254A24D91128E4072A311DA6C8045CD8BAF348D4438FBCA3
      24309F3F3FFECC861D73A35A34AFE371993F6B38B05B9883372153A164C6DB0E
      6C25C5405A3D94B7BA192757AE396D3E7776BC2039EBC2DE76CDFAF9A7A5CE8A
      69DD34C973C32FC0BE9DCC0E0F3BAAE095193C8D4FE3ED60A6F63D716AC59A23
      85DBB63ED6B2C8F6BD30504A1447E4BD0F1C3CFEDCD3472CC5A5D9BE8D9A051A
      32B2604D6D004BBDC6B03668818A685E49BB7A030A376E79B565A9F6092AFF54
      162ADD68BCF7C80F3B5263FE51F4E7E157751EC604CD6CAE9031A55EB37A594A
      4AF3ACF9975ED4EBF09D035F6C6716C4F37740FF77885C69AE61F0EBB001BEDF
      F4CE6EB730BBC55DC7EBA66AB9E17E0A8EA725695F66371FF14DAFEC7682E360
      720D038FB3977ECBBE54B6AE6B7EE97C1F9B15E14DDA209C4A94527373A1795E
      7641F93AC3998BBFD5C8207CCFEE963E61E108CDEE09F878E1D2AE8DB8B47F9B
      7287B6EB069FE03084EDD8D8F28B4E2DEA0A13FD8049FD7C3B3DD2A15DABFB9B
      DFD5F5F5969A5749B1CED0BA352E6FF80D3AD6C28421A32120C8177F5B8A2B7F
      EE44804E1DD7ED2B61FA325BD16F515901EB221B07CED719792C38E7113D23EB
      20B04336F4BE5EB8BC6D3D2EEF5807537E01AF132AE404A5077FD0E73CC813FA
      F386332D792B106E4A69C1E34EBD79DF804E187388694040FB2EF0CC6C00F3A9
      5330781BD81FAA541975A39068E8CBB552DDCD997D7032FF144C3CFEBBCCE089
      4BFF7C8B513A9ED8C52942DE0663D3F889D331658656F0C6B4024B853637A07D
      58D751537C8D469D91DD961074ACDB051991E7F0F1C468B45FB0130D3E7F17C1
      514908C8EE02A3A70FCA8B8B505C74017B629230BFD503BA8A987A2BCA8EEFDF
      C853CF0D9CA1ABE00D69A5BC4AC517A10DEA63FA9D2178B4F9686C2DCDC79985
      1FA1F0D229ECF7045E68F5005EE8F22AA23A6623887DA5FD973C5BEA0D56BD96
      7BE9284ACDA528AE28A25DC1BE8115CB75E938FCEE4A3CF68F4FD177C05C2C7A
      7609826FBF9B9900366C3B8E0347CEC3C3C75F67F43B1B9CFDD137F31622CC1A
      DDA5411704FB06C3C3C38773083A84FAF9A2438B0CD44F2BC58EE3F9B87085A7
      DE9694C353CFFBB03D8DC4E13116EBE66E5ACBF9B23AAD1FBC69D40F1797CEF4
      0A33F8D9342B35CEAC59AC282304F87BA1714A183EFF75BF22D6F3758B287222
      DA35B5B1E5E8E6E11C35171F397777E94343DBF1FC341DACFCC417B3C3F5ED9A
      83BC92D2A8FA4C572E97A130BF50736B0F84EBA6F7B75E14BB7EEFC7B33FF8F4
      D2428B4F9DE81E1DD2111AE0031F1E775A58C213EFCF1520D07AEE6282AEF8AE
      6B24106207306BBA46FD26DC7BA6DC6F86E61FED67E27491AEE862599821FFF9
      63BFCE7C53F06A652008D7035536277E7E76D28405674F3CFED929EDD14F4E68
      0F7D78421B3D3757BBE79D23DAB0D987B421D30F6803A7EDD5FABCBA4BBB79F2
      36ADD3B35BB4F613376E12E64A07564D1BFB6CFFB07009B851E89AB3B991E02A
      092C56AB227E7DDB937865F338E46CF80726AE1B85C756DE8507570CC6A89F6F
      C15D3FF4C4E0255DD07F517BA1E3C1BD162F7128092CEC448AE7958EB3C4BA2E
      5C6187BBDCC4AF39311503338FACA41BCF7F998B1BF97BA26F1D1E036A51A88A
      8189A54DF968BC34340993FF75142FDC9E429FFD7975F1513C33E8AA5FAE9770
      93A08212509160F1C6AB8B72C18B5CF0DAE25C7066148EB6E78D6F73D5A7CE8B
      B5B27D46107B407609F4E09F5CEA64A3EDC932FECC6D496C9980A7072561C280
      243C496094B29F1C9882B17D5278CD948D4D001B1B46A82C54300BAC3F8A70C6
      8FC76164E32336E35598D8920D19680859C7BAFEEC46880BAC748CE5C9A56C03
      6CF022E1A37D12E14F4CB105C6F44C44B8BF010F748F83483081529084D59E79
      A1434960927A291E4E097FB0FC045D80C396069C15119FAF3DA3C2C56891E8C3
      095A17094CECC6688CE1E50EB8EFE678A54CB105EEE9160FE9E98DED9D080710
      1546A53D3628E291B7202D6FE786213874AA08CD5302B0FD483E2C7C3B52C83A
      65F860C3DEF382EA04ABCD7EC6BEE2C323E2D7DFFCFCC6924ECFFE81EC67D6A3
      E3C4B5C89EB006ED096DC7FF86EAE0CAC902D543513AD831BD7D7B27EBBFE850
      12FC451A377425C1B4CFFE78D36AD5DD55546EF52E35B9C5DB3DA261BB4B99F2
      BAFDBCF0F1A47BDB3EA618586DBA610F0ECC88F0F3F3E3A4BE0A5288D519BC07
      54DDE539FDF3ED2301D819149559BD7C7CFD742F7C790E25388D7CFD266425E6
      C1DFEB02CC54F6998BFE58BF3D02815A6B787286E4E327B3589C39F54B0E2A39
      E9DD1B3853CBEF05CAF4C7901597075FEFBDB85876595DB1E6E9EB8BC61929D8
      BD330891DEB11C9893B2F2510CC42DE5CAC03E5C997602DE5EE7709E37A7965A
      4A58EF794F9B56005F1F1F1494F9A38E7F0F7EFA4529029505C995818DE5B6CC
      5C811253298A08E55633C525068F4BB7B159971BE86548CC10F5385F23BB00EC
      7DE8E18778E4170431152F9491A0CCC41BC374BCF8F3720842BCD3D4DC0AE482
      6345EE228130D0B3E68418D371E8582EC2795A7620A7177CF4265C391B88DC63
      29480D6FC4EA6DEFC154D2DBABB3E4866710AB8176B05702D202BAE1DCCAB330
      ADDA0DFCB6075E1B4FA07E9DDE880A49A704AE0BA695ED81701309369FCEC2A6
      D30DB12FBF279A95EEC698A848DC1F1B8B4EC6E33874A507FEC84BC1C6BC5441
      77827A0BFC06F2830C8CBAF9FDAB111DCFA3B0E034FC78AF6DDC80D7F19CD1CB
      1907B67F2C1ECAAF18D87325195161CAB0F84742A034B689F2BB1B760A09530C
      FCBC7405B05604754EEA07118509481C5B61F5D8DD2EA69963270F0F75C22A14
      036F0FFDBFA67FB1B34D9945CB7288E6827F8DD3836DA7971EF324423178FEDE
      D6E3C5F377C05990FE0EB1D0E8754D5E7CE88EB7B61567BFB055EB3089F0EC26
      7EFB3768AD9E5AA3B57C7CB5D6FCD1DFB4A60FFFA2357AE8672DEBFE1FB4CC7B
      97681D1E5E582C74C2C0D87748DF595E7EC1FA643FF1DE30F85D2930CF22F6DB
      BA8E93B6B8BF3F86DEC8737CFF7EE42E1CA633DA7868F6DA576EBA111A379CD8
      01BB94DFC8B3B395436A9D8862E3F09F9F4A1E602DB357365665DE4D62D6D88C
      C905A156947376AF496A18C32D8A8E3543C858290C3A18F84E0C340C7CCF4636
      2E9E0603BBBD9EF0F432C0D3D7C07B393C11E865FF265A2B7B287A331B0C6165
      A0C116957D021DAF07605F98DF2E1D03EDF73619E16BE445A8FC6C7BFA3090B8
      3C9F9D2613D62AFB479C3C5301126D607B69A044BC2D0FEC32A84EB592CA5307
      1FA32A7B6C17CD0A5FCFCBBE95430C59A4ADCA48CF2F2E1F4A0578326BC24870
      65482CB6DE54512E362B11075C4C593C5519E945174603778548D60483330332
      2141A75EE31798B6AA55D4A1DAB8A06380B80D6CE71D209279909191618CB68F
      A7E83084351A92F3F0804C3A29044D219455FFAA60A47402BCB78F581CFEFC73
      3572FE913D597F60C7EE85A9777E89A421F3117FEB3C44F7FB0091BDDF4348D7
      5908EC341D7ED96FC1B7FD5478B79A028F96AFC0D8FC45B01E4843B1503819B5
      1D936EA74380D65F7F44E2BF4EE542F15F67C0FCFCFFDE1EE81DED41EAA776D5
      7EFDF5D758B4681164D97CC18205E0ED3F903D381F7CF081DA97237B7304D3C2
      2FB7D8868476F7E68C626FF491C6E205B8A103BC2E07BC3607BC3E4701AFD241
      B366CDD0B46953654B5D993A6F23C60FBF69B2B33D087FCFCE40529D376F1EDE
      7FFF7DBCF30E2F017DFB6DCC983143ED107A837B6EB9F14B213ADA03439D5623
      7346F748C2F8162A5CA5D8B871639512778AA1458B166A17509B366DD4CE20C7
      EEA0573F5E8FA747B699EC6C0FF4D359BCF98D973CBECD54B9DF44ED0A7AE595
      573079F2644C9A3409CF3EFB2CB8D0AF5272B40786B0264372C6F4AD8B49ADB9
      DF86BD0CC9ABA4DCAA552B9562870E1DC00D6F0A3A77EE8C2E5DBAB0853220E7
      9FAB30697487C9CEF640FF9AB402C0AC59B320F994945F78E105B5BDEAC9279F
      C4134F3C81C71E7B4C8188A0558E317419777FADEDFF64A084FD25D0357D11DA
      F649BAFFB407E035A5FF6FF40F7E9A98F197CA8020670CB7F70F74ED266ED07E
      9CC89FD54B2847C4F2F0F3849F972E5521D519BD7AF644DDE15FE1DCF7A3759C
      5562E7C16241C2F09D4EDC139F3556EEA143872ABBAAC13D6C9CCBB77F9D0D31
      6D46E40C6D1B8EC70644E1D18191789436571A71ECD831D5A85425167F717131
      662DDC838977B79CACBBE9B155DA92A732E4DBC911BC4413E4624A1BDFB19E0B
      19B41952F930803D6D31D3EFF81285AB1ED3E99A8D5B4106F554D6054BD549F6
      7AD6AD5F27DE6AA15DFBF6C8208392B54FEA8CD23F909D4E0DC61C7522EF7D27
      45B96BD2C1F1E3B9BCE0C43E42D53518B5445BF24C031248DA4C9A2E79366FDE
      8C9A181C397204F5867C0ECBD6E775AA3D58F24C43D2D8779C5D65E160489B3D
      7BF65FB87F8D7D08BAA1E950F7F62FAEB607BD72B6A2FB739BD065E206747C82
      C3FE4757A2D5834BD1E2FE1FD174F4F76872CF37C81AB6180D862D44E6D02F51
      77C8176C40F17F53FF803BA61E9D3973E63E7E60CC6FBEF9A6BD08526BF218C5
      A80DD84A3FCA3DCBAFDC7AEBADBE9C1EC0871F7EE886AE77F355E321F1FDBC6A
      D0971BBE209B5D1D1F1407EA7519B090A50BF1294ED0EFDDBB77EDD34F3FAD9B
      3C79B2F6C20B2F68CF3FFFBCDCD3E9E055BD4D0974E55C672AE1F22199693939
      396B535353215F6C5E3D885A25983A756A4F8AACE7E64EF5396BDEBC79477EFA
      DA474747E3C2850BAC7CB643D533F8F4F65925EF0FDE4EE2EFF935D6959595B1
      146A10250A502A70537029E3E75ECBE0E341B310103BD62F24BAC94351078CDC
      008AD3A74F839B1DB565CB9659685B56AC58B19FD97996FD8519EEAFF1431287
      C68D459D2C16550D4165AB91B4E6052CBED0A89CA9369C3265CA91AA9ABA2AC1
      FBFD6721A40E89D99C5D3E09E4E702892D11C6EBA772B405BBAA2306FF8C04E0
      FDBE244E1A8B1812E79FE022ED45C0C397D708B1D05594C1B3A2E0B8C2ABC6D0
      E3BD9EB3101C3F16B12496948BCEF2FA526F2020926BCE3F0047D62FC65B5786
      5443AB820C3937C7FE848CEE8010179E65CA3E40700C17AD7F22F1EF8B31B3F4
      3685598361C8E9149E833A9CE5E6BC1177B50241B1C0CE1F48BCE15BCC2E1F54
      039D33D890931DD80FE505751095C951955FA5D8BF7F8B77CC039D58B538F478
      EE400B1CD9B00F4B5F017E7C8129AFFB16EF5A6E8858F8DA5FE3D4F30D74D30B
      E275B34D2D74FFC46B1C80B6AC05921867A72307FB6BA4834F143735FFCA9A17
      E08AC070E7C3D2273DD85963C68C994E9C3CCEFED85C1990D610505151C1019B
      4E7DDA76ECD8C1A5E772242727ABCF5C585818788FE93812E3C1071F544C9428
      0CD04932B439C6E4F210A78977EEDC09E964F2971590DAC8384141505010468E
      1C398E7DE9C71890E02A01FDF23DD4ABAA2A88B2CD76C3860D888C8C54AD117F
      9E814E9D3A41FEB8CF7BDCE8D1A31754CB40526355E552FC15B5D93F2F2F4F75
      C265FBAD0C014417C25418E9C5A80A92F79898184E7F5BD4F841FAC89E9E9E9C
      4BF050C09F603849DC186C3C588C394B4EA0CC10AD1A8FB367CF42BE83B2F558
      5267E3C2D93CA362E2E0E0CCC2E36FFD3C6CCDAE2BC84808C0E6837550B8FD28
      A2BC0AD4E8457411CB593DD93D2D5973108BAD2498B2306F42584CFD871B2406
      C0DB538F8C787F6C3B170B5E3B8BACAC2C646464405A2621E0BB666744918917
      BA57BEC87BAACC82975BD60DF094F9D2D20A1B761C2D425A8C0F867709574862
      B0D088250DA9B2651B3295DD4A5F506E7BB1792A972458128ACBACD872A80875
      EBF86044D7088528868358DC32E01210B78021ABFBB827C3020CDE360D8A3823
      CE1B23BA454A1C9882D3167755E007E603DD9D530FDCC5BD5C6F979557780E6A
      1FE5730F89F59C025294B51B36326C635C30BEDE02E22DA0A7C5F716CB6A127B
      D37F554BF454F3D8F8364A196E75BE467ACE5131D9B4AF474C14F558699EFFEF
      596F2427E7B36CBF35F5A7BD96E77FD86D3EB464A7A9E8EBED65455F6D293DF4
      E5A6A2E7E76F284C7522563ADCC4FD6EB769505985796D4AB8EEC5F4702D2D2D
      CCE25F2F42F3CFAAA34FCB88F678B1B4AC62ED3BCBCFB935B44E1D2CDE563688
      EB8EF39A277AF95DBC5288CD870AF1E799426E33B4212ECC1BAD5343D1B69E5F
      CC8F5B2ECC7B858B77CF0E4A592C42280916FC5194525A5E31AB4982A7DFB173
      8598BB2A0F97B9F3E5A981F53061503D4E89FBE0C3B5B93870FC32BA370EF52B
      2CAD98F5C4C77B528481518CD2B2F261CD53FCEB5CB85C8ACFD6E4A1ACA402E3
      47F14B259184611D13F0FBFEB3F87A631E46744A457683B03ADFAC3F3E8C512F
      2A0645A5A6E19E060DBFECBD88122E8D5B6C569CBB5C8EB5FBCF239097A3F76C
      5207035AD5C19C1FF662E5DED3B8AD4D22AF662C1F2E0CF43450545A1EAB6337
      7EDF29DE12C8C1473967AE47BFBD0606AE7B77A81F894B45261C3C7945AD7CED
      CBE5A2BDC1C0EB3ACBF809AB5C5F28E2629ACC689B356E043297B1C671C86103
      FAB54AC4792ED88F99B50AA5E56635243093A946282C2E97B4D5241EE839556E
      B1A4A586FB22FF721167EACC9C70B4A2CFB3DF2B248B4C7F32054E1020393186
      8B77261495949D9248A5832B25659F1D3B5538B96383486E1F3C87F2CAB9C2AF
      27F5E27DE61AFA3EF3B5E0C28353B5DD9A2760FB81F36450F199042A1D5082F9
      EFFDB8EFB4CC9FDEDD350D5E6C95CCDCCCF5D6A22D98B978ABE0C160336158CF
      26F0E25CEBCB9FFD71BAA8B462BE4428063FBF7CF3513219F7F8BB6B4B02FC3C
      F0F08026C84A09C3FA3D7958BB3D170D9242F1C41DED5027DC1F77BEF8534971
      A9695CFEB7A38F0A03A318029BE60C589C366201EF3AFF75F6B8818D62EEEC5A
      9FDB051A4914F7B699B061D7294CFE74C3199B551B6B59316EB18AA0A124A0AD
      9EC39FDEB5B8A8A4BCC3E44F374EEA3BE1EBC3D90F7D59DCFEC1CF8BBB3DBAF0
      F0731FAE9D642E3777702516A2FFFEEA2C5CFF0AB8654108EBBDB03D35E9B94D
      CF274ED87028F2D1D54521E35616058F5B712878DC2FCFFB3FB83455705CC18D
      41EAF35B06159795AD4D0F30BF38A64D68DACB3DE2FCA7F64AF09FD0312EAD41
      90EEC5D2E2D2B5FA118B0655CB80A90E2A2D2E9F3738D3376654EB38EEFC01B6
      1E2BC0C62397719915ECAE9689B8BF437C0CCE16CED3F7F9C8C9444990387143
      4A4569F9ACDB1BF9FB354D08C14FBB2F60F7E94B6898148826C981387ABE042B
      0F5D442AB7EF8DBEB59E1F4ACA67E9B3E7A48824AA1C986CE66199A15A9D662C
      304B779CE55A822C116A18D9395170B07C278B3D47BA9B8E5C64AB14852659A1
      75B6FF7E5AB507EA35863CBEF2D0F8B675D20A4A4C3874961B97AC566E56B1A1
      63C348550397EFC8538C38684072543022C37CF0CA4B4B0FDBF63C93AE24A828
      298F8D0CF6C0AEDC8BDCDB684185C54406566E1968A0182CDB92CB2A6E25131D
      F2CE5D46E3E4505E675EA2DA0325817EC4B7A5738765F9FCBCF32C0A4B0A599D
      D91E68C0ABC36FE2A73E18B7BCF02319DAD8E480950918D8B93E1E7EF8E332ED
      F054B657E40B584E9D2D2C4D8B0EF44451B181A9D9DB03FBD228A748B8C18F5C
      298D86D0D0609CB87C991F5E1B1553D922A1DCFCD9779B8E4C1EDE2113874E70
      ACC05BE7EFE7CEE8E6E9911C6CE930F5FE76786CF60A26A5A17E4218167DBF83
      6EDB6734EC2D124A4BE66FD976F9818689E175BA3589C58F9B0EB3AFB41D3316
      6FE14E483665DC1EC18D86E8D8340D072EE663EFA65DA7D99D982F0CF462D87E
      B8EFA856661EF7F1DB6B4B769DBA841E3725ABBACFCB81D5A24D9DE860F4A674
      27CB4AB170CEE212128FB31D9EA3DA03C5409868EB1F59CC51E4DDF3DF5B7DE6
      F31F7720352512837B36C6D07E4DF843C9182CFC790716BDBBE40C749E7793D8
      D91EA8B7200C1CA0CF7C3E55D3AC77526923602D8DA6FAA930DD59C67FAA47C5
      E796C3EF1FA1DBF95CC3C019F3EF72501FC086259AD6A6BF4EB9AB4DB8BA4BAE
      2A2FC15244BF7C5ACA7207741FE1ABFCAE4C7C1EFE4CC595CD19EE8C730D330A
      7271419958F87AF625EDD6B1614EC4D009DF2AE2FCA9039C6182E8E317201684
      4A3128AA6420A1F35E3EA9DDFD5C9C2270204AB82BB8862BC4B79F3AA4527245
      7AE8F5741597F6E6261577F88996CA2F38AE612A70CAFDBB149244BAC2C4B98D
      54BC6B58D6BBFB15EEEE0733559C329E1B6A4FC515D1E17EF9CBAB29B7FCF4A4
      22DE34E27F3573C63A8DC44018F64A340889A748C91310215A249A3B0A5E800A
      8992EA68F200D79C74820A1E00E980E674BC0014D4B43CC445F4E6FF068FE35D
      9BE42290B8D5CEFA9FDFFF4CC68ED71B2294D721A2C94B19A7659E7CFBD7DFC8
      D8CB60F4D52442623FFE6C5B75606C756D9DA6324BE06FE3F9FD4E77B0796B65
      0E95B73BED8566AFB2BF71132F1F67EF353E094ACED7047CB92EAC825288C02B
      02BB8DF4DFB28E1F1CCC6BB7D62F22364F439F550018DAF3F4F553D890FF70FF
      DD1BCAC285B4A8644BA0BF97D8F7C253D7C56530C92D01E04E5F7E8D42B07551
      E2A0DD081E0E5D89F157B85C29789C823356207D66C2636D61F4ED498716ACBE
      2E5720A777C6F3C30E83F4163C344B40D6335541A7639F0B82C1F4D387A6C496
      00F250A54D529212130C0F17744CA4711C74E404C261A224211D937FC041472F
      81FCA5CF951CA199CE58336ED8B9D2776C82A0E77102D6D0897920E4D0872B6C
      5601A40712848FC1953E5C61FD39408811E4227CC78DB65F414350519E3C25FE
      4F6EE7AACC25883C89DDEE71C43CD6312D06CFB2A62D2D273052BF4AE562F3D3
      25FEFEDEB578BAFB09601A4630491A5D8395D8528823982482D5D9AF403F6D84
      B85225A2FC4A2C51B30A08C4F244693E10C1D1F2CBA6DEE72D7CBF029864A7DA
      38129CDBBC9960DA086B0DA1BA175C4482133D273CCF3701F9BA860016B04740
      95C0C77724C5CF625B936BA7BF8039BA2C3504E9ABB3AAC0150CE14B6322BFA6
      4F3AD731DA103EFF767E01C599CAD87A8F900E0000000049454E4400000000}
  end
  object TreeImageList: TImageList
    Left = 464
    Top = 256
    Bitmap = {
      494C010102000400040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000082D4700134F7B00367CB6005F9FC600E0EBF40000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000004E81AA00094F8600084D8400084C
      8300074B8100074B8000064A7D0006487C0005477B0005467A00034577000344
      7600034475000343750002437400417096000000000000000000000000000000
      00001656760087C0F80084C3F8002B77C3000D5AA400D4E3F100000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000185C91007BB1EB007EB3F0007CAF
      EE007BABEB0079A9EA0076A4E90075A2E80073A0E700729CE600719AE5006F99
      E5006F99E5006F99E5006F99E5000243740000000000848484007A7979007978
      78002D7BA000DCF0FF00408ED300006AB600338CBE002674B300697886007978
      77008B8B8B000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000185D92007DB7EF004794E7003889
      E2003683DF00347DDE003079DA002E73D8002B6ED600286BD5002667D2002463
      D1002260D000215ED0006F99E50003437500000000007A7A7A00BBBBBA00B4B4
      B4006F90A7006AADD00083AECC0041C3E10048DBF40068CAEB00378BD200A7B3
      BD007E7E7D000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000195E940081BCF1004C9FEA003F92
      E6003C8CE3003888E1003581DF00337CDD002F77D9002D72D700296DD6002769
      D3002565D2002462D1007199E50003447600000000007E7E7D0000000000E9E9
      E900E9E9E9009AC1D30066B1D100BBF5FD0051DBF6004ADFF70069CEEE00358D
      D80074808A000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000195F950083C3F20050A7EF00459C
      E9004196E7003E91E5003C8BE2003785E0003480DE00317ADA002F76D9002B6F
      D700296CD5002669D300729CE60003457700000000008584840000000000ABAB
      AB0087878700E4E4E4006F97AB0067C5E400C0F6FD004BD8F40046DDF6006BCF
      EF003088D300D1E5F60000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000001B60970086C8F50056B0F2004BA5
      EF0046A0ED00439AE9004094E7003D8EE5003889E2003683DF00347DDE003079
      DA002E73D8002B6ED60074A1E80005467900000000008888880000000000E5E5
      E500E4E4E400E2E2E200E0E0E000A1CEDC0069CEEC00C0F6FD004CD8F40048DF
      F6006AD1F0003C97DE00D8E7F400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000001B6198008ACEF7005BB8F6004FAD
      F2004CA9F00048A4EE00459DEB004399E8003F92E6003C8CE3003888E1003581
      DF00337CDD002F77D90077A5E90005477B00000000008E8E8D0000000000A8A8
      A80084848400DFDFDF00A3A3A300828282009ECDDA006CCFEB00BDF5FD005BD9
      F5005CC4EB005198D2005797D100E2EDF6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000001C629A008CD0FA005EBEF80053B7
      F60050B2F4004EACF1004BA8EF0047A2EE00459CE9004196E7003E91E5003C8B
      E2003785E0003480DE007BABEB0006487C00000000009391910000000000E0E0
      E000DDDDDD00D8D8D800D7D7D700D2D2D200CECECE008CC3D30071D0EB00A9E0
      F8007DB9E400A4CEF500BDDCFC005997D0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000001C649B008ED5FC008ED5FF0085CC
      FF0081CAFF007DC6FD007AC2FC0076BEF80071B9F7006CB4F50069AFF20063AA
      F1005FA5EF005BA0ED007DB1EF00064A7E00000000009595950000000000A3A3
      A30081818100D3D3D3009A9A9A007C7C7C00C8C8C8006264E5002B6ADA0067B6
      E400ABCDEE00E2F2FF00A2CDED00448AC6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000001C659C0073B5E3001969A700055A
      9C0005569A00055496000353920002508D00024D8A00014B8500014780000044
      7B00004176002C628B00608DB400074B80000000000098989800FCFCFC00D6D6
      D600D2D2D200CDCDCD00C8C8C800C3C3C300BEBEBE00BBBBBB00B7B7B700B4E2
      F300449AD30077A8D7003091CA00A8D3EC000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000003172A7003579AD005D96C4001C6A
      A9000F62A3000F5EA1000F5D9D000E5B9A000E5895000D5791000D558E000B50
      8900336B99005382A9002B6594005584A900000000009898980000000000A76B
      4200BC805500BE825600BF835700C1855900C4875B00C4885D00A76B42000000
      0000969594000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000EEF3F8001F669F003376AB005893
      C2005A94C2005A93C2005892C1005891BF005890BC00588EBA00578DB800578B
      B4005286AF002B67990080A4C00000000000000000009999990000000000A76B
      4200BA7D5200BC805400BE825500BF835700C1855900C4875B00A76B42000000
      0000959595000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000F4F7FA006596BD001B64
      9C0019629B0019629A0019609900185F9700185E9600165D9500165C9300165B
      91002163960087ABC60000000000000000000000000099999900000000009D61
      38009D6138009D6138009D6138009D6138009D6138009D6138009D6138000000
      0000939393000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A0A0A000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000989898000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A9A9A9009F9F9F009E9E
      9E00A1A1A100A2A2A200A3A3A300A2A2A200A1A1A1009E9E9E00999999009898
      9800ADADAD000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00FFFFF07F000000000000F03F00000000
      000080070000000000008007000000000000A007000000000000A00300000000
      0000A001000000000000A000000000000000A000000000000000A00000000000
      00008000000000000000A017000000000001A017000000008003A01700000000
      FFFFBFF700000000FFFF80070000000000000000000000000000000000000000
      000000000000}
  end
  object JvModernTabBarPainter: TJvModernTabBarPainter
    TabColor = clWhite
    Color = 14474460
    BorderColor = 14474460
    ControlDivideColor = 10526880
    CloseColorSelected = clWhite
    CloseCrossColorSelected = 6118749
    CloseRectColor = clWhite
    CloseRectColorDisabled = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    DisabledFont.Charset = DEFAULT_CHARSET
    DisabledFont.Color = clGrayText
    DisabledFont.Height = -11
    DisabledFont.Name = 'Tahoma'
    DisabledFont.Style = []
    SelectedFont.Charset = DEFAULT_CHARSET
    SelectedFont.Color = clWindowText
    SelectedFont.Height = -11
    SelectedFont.Name = 'Tahoma'
    SelectedFont.Style = []
    Left = 560
    Top = 256
  end
end
