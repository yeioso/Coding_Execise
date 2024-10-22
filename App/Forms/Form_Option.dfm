object FrOption: TFrOption
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Option'
  ClientHeight = 350
  ClientWidth = 205
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poMainFormCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  TextHeight = 15
  object Label1: TLabel
    Left = 11
    Top = 269
    Width = 32
    Height = 15
    Caption = 'Name'
  end
  object RadioGroup1: TRadioGroup
    Left = 11
    Top = 8
    Width = 194
    Height = 241
    Caption = 'RadioGroup1'
    ItemIndex = 0
    Items.Strings = (
      'Text Document'
      'Report Document'
      'Article Document'
      'PDF Document')
    TabOrder = 0
  end
  object BTNOK: TBitBtn
    Left = 8
    Top = 304
    Width = 84
    Height = 34
    Caption = 'ACCEPT'
    Kind = bkOK
    NumGlyphs = 2
    TabOrder = 1
  end
  object BTNCANCEL: TBitBtn
    Left = 118
    Top = 304
    Width = 84
    Height = 34
    Caption = 'CANCEL'
    Kind = bkCancel
    NumGlyphs = 2
    TabOrder = 2
  end
  object DOCUMENT_NAME: TEdit
    Left = 56
    Top = 265
    Width = 147
    Height = 23
    TabOrder = 3
    Text = 'DOCUMENT_NAME'
  end
end
