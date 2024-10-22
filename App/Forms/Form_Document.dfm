object FrDocument: TFrDocument
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Document'
  ClientHeight = 273
  ClientWidth = 685
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poMainFormCenter
  TextHeight = 15
  object Label1: TLabel
    Left = 16
    Top = 16
    Width = 10
    Height = 15
    Caption = 'Id'
  end
  object Label2: TLabel
    Left = 16
    Top = 45
    Width = 32
    Height = 15
    Caption = 'Name'
  end
  object Label3: TLabel
    Left = 16
    Top = 74
    Width = 60
    Height = 15
    Caption = 'Date added'
  end
  object Label4: TLabel
    Left = 16
    Top = 103
    Width = 75
    Height = 15
    Caption = 'Date modified'
  end
  object Label5: TLabel
    Left = 16
    Top = 129
    Width = 20
    Height = 15
    Caption = 'Size'
  end
  object Label6: TLabel
    Left = 16
    Top = 158
    Width = 60
    Height = 15
    Caption = 'Description'
  end
  object Label13: TLabel
    Left = 360
    Top = 14
    Width = 23
    Height = 15
    Caption = 'Tags'
  end
  object Label14: TLabel
    Left = 360
    Top = 42
    Width = 24
    Height = 15
    Caption = 'Type'
  end
  object lbAuthor: TLabel
    Left = 360
    Top = 68
    Width = 37
    Height = 15
    Caption = 'Author'
  end
  object lbPublication: TLabel
    Left = 360
    Top = 96
    Width = 60
    Height = 15
    Caption = 'Publication'
  end
  object lbVersion: TLabel
    Left = 360
    Top = 125
    Width = 38
    Height = 15
    Caption = 'Version'
  end
  object lbEncryption: TLabel
    Left = 360
    Top = 153
    Width = 91
    Height = 15
    Caption = 'Encryption status'
  end
  object lbSummary: TLabel
    Left = 360
    Top = 183
    Width = 51
    Height = 15
    Caption = 'Summary'
  end
  object DOCUMENT_ID: TDBEdit
    Left = 128
    Top = 15
    Width = 200
    Height = 23
    DataField = 'DOCUMENT_ID'
    DataSource = DataSource1
    Enabled = False
    TabOrder = 0
  end
  object DOCUMENT_NAME: TDBEdit
    Left = 128
    Top = 42
    Width = 200
    Height = 23
    DataField = 'DOCUMENT_NAME'
    DataSource = DataSource1
    TabOrder = 1
  end
  object DOCUMENT_ADDED: TDBEdit
    Left = 128
    Top = 71
    Width = 200
    Height = 23
    DataField = 'DOCUMENT_ADDED'
    DataSource = DataSource1
    Enabled = False
    TabOrder = 2
  end
  object DOCUMENT_MODIFIED: TDBEdit
    Left = 128
    Top = 99
    Width = 200
    Height = 23
    DataField = 'DOCUMENT_MODIFIED'
    DataSource = DataSource1
    Enabled = False
    TabOrder = 3
  end
  object DOCUMENT_SIZE: TDBEdit
    Left = 128
    Top = 128
    Width = 200
    Height = 23
    DataField = 'DOCUMENT_SIZE'
    DataSource = DataSource1
    TabOrder = 4
  end
  object DOCUMENT_DESCRIPTION: TDBMemo
    Left = 128
    Top = 157
    Width = 200
    Height = 48
    DataField = 'DOCUMENT_DESCRIPTION'
    DataSource = DataSource1
    TabOrder = 5
  end
  object DOCUMENT_TAGS: TDBEdit
    Left = 472
    Top = 13
    Width = 200
    Height = 23
    DataField = 'DOCUMENT_TAGS'
    DataSource = DataSource1
    TabOrder = 6
  end
  object DOCUMENT_TYPE: TDBEdit
    Left = 472
    Top = 41
    Width = 200
    Height = 23
    DataField = 'DOCUMENT_TYPE'
    DataSource = DataSource1
    Enabled = False
    TabOrder = 7
  end
  object DOCUMENT_AUTHOR: TDBEdit
    Left = 472
    Top = 67
    Width = 200
    Height = 23
    DataField = 'DOCUMENT_AUTHOR'
    DataSource = DataSource1
    TabOrder = 8
  end
  object DOCUMENT_PUBLICATION: TDBEdit
    Left = 472
    Top = 95
    Width = 200
    Height = 23
    DataField = 'DOCUMENT_PUBLICATION'
    DataSource = DataSource1
    TabOrder = 9
  end
  object DOCUMENT_VERSION: TDBEdit
    Left = 472
    Top = 124
    Width = 200
    Height = 23
    DataField = 'DOCUMENT_VERSION'
    DataSource = DataSource1
    TabOrder = 10
  end
  object DOCUMENT_ENCRYPTION: TDBEdit
    Left = 472
    Top = 152
    Width = 200
    Height = 23
    DataField = 'DOCUMENT_ENCRYPTION'
    DataSource = DataSource1
    TabOrder = 11
  end
  object DOCUMENT_SUMMARY: TDBEdit
    Left = 472
    Top = 182
    Width = 200
    Height = 23
    DataField = 'DOCUMENT_SUMMARY'
    DataSource = DataSource1
    TabOrder = 12
  end
  object BTNOK: TBitBtn
    Left = 18
    Top = 225
    Width = 84
    Height = 34
    Caption = 'ACCEPT'
    Kind = bkOK
    NumGlyphs = 2
    TabOrder = 13
  end
  object BTNCANCEL: TBitBtn
    Left = 128
    Top = 225
    Width = 84
    Height = 34
    Caption = 'CANCEL'
    Kind = bkCancel
    NumGlyphs = 2
    TabOrder = 14
  end
  object DataSource1: TDataSource
    Left = 256
    Top = 224
  end
end
