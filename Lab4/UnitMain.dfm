object frmMain: TfrmMain
  Left = 410
  Top = 171
  Width = 417
  Height = 359
  Caption = #1055#1088#1086#1075#1088#1072#1084#1084#1080#1088#1086#1074#1072#1085#1080#1077' '#1085#1072' '#1071#1042#1059' '#8470'4'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object lblInfo: TLabel
    Left = 0
    Top = 8
    Width = 409
    Height = 41
    AutoSize = False
    Caption = 
      #1055#1088#1086#1075#1088#1072#1084#1084#1072' '#1085#1072#1093#1086#1076#1080#1090' '#1074' '#1089#1090#1088#1086#1082#1077' '#1080#1079' '#1085#1091#1083#1077#1081' '#1080' '#1077#1076#1080#1085#1080#1094' '#1075#1088#1091#1087#1087#1099' '#1089' '#1095#1077#1090#1085#1099#1084' '#1082#1086#1083 +
      #1080#1095#1077#1089#1090#1074#1086#1084' '#1089#1080#1084#1074#1086#1083#1086#1074', '#1080' '#1074#1099#1074#1086#1076#1080#1090' '#1080#1093'.'
    WordWrap = True
  end
  object edtNewLine: TLabeledEdit
    Left = 0
    Top = 72
    Width = 193
    Height = 21
    EditLabel.Width = 90
    EditLabel.Height = 13
    EditLabel.Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1089#1090#1088#1086#1082#1091':'
    TabOrder = 0
    OnKeyPress = edtNewLineKeyPress
  end
  object lstStrings: TListBox
    Left = 0
    Top = 96
    Width = 193
    Height = 161
    ItemHeight = 13
    MultiSelect = True
    TabOrder = 1
    OnClick = lstStringsClick
  end
  object btnClose: TBitBtn
    Left = 160
    Top = 304
    Width = 73
    Height = 25
    Caption = '&'#1047#1072#1082#1088#1099#1090#1100
    TabOrder = 2
    Kind = bkClose
  end
  object grpResult: TGroupBox
    Left = 200
    Top = 56
    Width = 209
    Height = 233
    Caption = #1056#1077#1079#1091#1083#1100#1090#1072#1090
    TabOrder = 3
    object lblResult: TMemo
      Left = 16
      Top = 24
      Width = 185
      Height = 201
      TabOrder = 0
    end
  end
  object btnDelete: TButton
    Left = 0
    Top = 264
    Width = 193
    Height = 25
    Caption = #1059#1076#1072#1083#1080#1090#1100
    TabOrder = 4
    OnClick = btnDeleteClick
  end
end
