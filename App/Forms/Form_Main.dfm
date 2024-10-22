object FrMain: TFrMain
  Left = 0
  Top = 0
  Caption = 'Main'
  ClientHeight = 562
  ClientWidth = 1028
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object TreeView1: TTreeView
    Left = 0
    Top = 0
    Width = 305
    Height = 562
    Align = alLeft
    AutoExpand = True
    Indent = 19
    PopupMenu = PopupMenu1
    TabOrder = 0
    OnAdvancedCustomDrawItem = TreeView1AdvancedCustomDrawItem
    OnDblClick = TreeView1DblClick
    ExplicitHeight = 561
  end
  object Pages: TPageControl
    Left = 305
    Top = 0
    Width = 723
    Height = 562
    ActivePage = TabSheet3
    Align = alClient
    MultiLine = True
    TabOrder = 1
    OnChange = PagesChange
    ExplicitWidth = 719
    ExplicitHeight = 561
    object TabSheet1: TTabSheet
      Caption = 'Manager data'
      object BTNAddFolder: TSpeedButton
        Left = 80
        Top = 48
        Width = 150
        Height = 30
        Cursor = crHandPoint
        Caption = 'Add folder'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = BTNAddFolderClick
      end
      object BTNDeleteFolder: TSpeedButton
        Left = 80
        Top = 92
        Width = 150
        Height = 30
        Cursor = crHandPoint
        Caption = 'Delete folder'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = BTNDeleteFolderClick
      end
      object BTNAddDocument: TSpeedButton
        Left = 240
        Top = 48
        Width = 150
        Height = 30
        Cursor = crHandPoint
        Caption = 'Add document'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = BTNAddDocumentClick
      end
      object BTNDeleteDocument: TSpeedButton
        Left = 240
        Top = 92
        Width = 150
        Height = 30
        Cursor = crHandPoint
        Caption = 'Delete document'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = BTNDeleteDocumentClick
      end
      object Label3: TLabel
        Left = 40
        Top = 152
        Width = 208
        Height = 21
        Caption = 'The blue color is for folders'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label4: TLabel
        Left = 40
        Top = 200
        Width = 250
        Height = 21
        Caption = 'The green color is for documents'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGreen
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label5: TLabel
        Left = 40
        Top = 248
        Width = 360
        Height = 21
        Caption = 'The red color is for double clic in the grid seach'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label6: TLabel
        Left = 40
        Top = 296
        Width = 559
        Height = 21
        Caption = 
          'Double click on the node to generate the report of the related d' +
          'ocuments'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clTeal
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Search '
      ImageIndex = 1
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 715
        Height = 65
        Align = alTop
        TabOrder = 0
        object Label1: TLabel
          Left = 16
          Top = 13
          Width = 35
          Height = 15
          Caption = 'Search'
        end
        object Label2: TLabel
          Left = 1
          Top = 47
          Width = 549
          Height = 17
          Align = alBottom
          Alignment = taCenter
          Caption = 
            'You can search by (Name, Date, Description, Key Tags) Or (Author' +
            ' for reports or articles)'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
          WordWrap = True
        end
        object SEARCH_01: TEdit
          Left = 64
          Top = 10
          Width = 393
          Height = 23
          TabOrder = 0
          OnKeyUp = SEARCH_01KeyUp
        end
      end
      object DBGrid1: TDBGrid
        Left = 0
        Top = 65
        Width = 715
        Height = 467
        Align = alClient
        DataSource = DataSource1
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = 'Segoe UI'
        TitleFont.Style = []
        OnDblClick = DBGrid1DblClick
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Export'
      ImageIndex = 2
      object Memo1: TMemo
        Left = 0
        Top = 41
        Width = 715
        Height = 491
        Align = alClient
        Lines.Strings = (
          'Memo1')
        ReadOnly = True
        TabOrder = 0
        WordWrap = False
        ExplicitWidth = 711
        ExplicitHeight = 490
      end
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 715
        Height = 41
        Align = alTop
        TabOrder = 1
        ExplicitWidth = 711
        object Label7: TLabel
          Left = 16
          Top = 14
          Width = 48
          Height = 15
          Caption = 'Delimiter'
        end
        object BTNEXPORT: TSpeedButton
          Left = 136
          Top = 10
          Width = 81
          Height = 22
          Caption = 'EXPORT'
          OnClick = BTNEXPORTClick
        end
        object DELIMITER: TEdit
          Left = 80
          Top = 10
          Width = 33
          Height = 23
          MaxLength = 1
          TabOrder = 0
          Text = ';'
        end
      end
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 120
    Top = 40
    object Addfolder1: TMenuItem
      Caption = '&Add folder...'
      OnClick = BTNAddFolderClick
    end
    object Adddocument1: TMenuItem
      Caption = 'A&dd document...'
      OnClick = BTNAddDocumentClick
    end
    object Deletefolder1: TMenuItem
      Caption = 'D&elete folder...'
      OnClick = BTNDeleteFolderClick
    end
    object Deletedocument1: TMenuItem
      Caption = 'De&lete document...'
      OnClick = BTNDeleteDocumentClick
    end
  end
  object DataSource1: TDataSource
    AutoEdit = False
    Left = 109
    Top = 142
  end
end
