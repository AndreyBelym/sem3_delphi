object frmMain: TfrmMain
  Left = 298
  Top = 119
  Width = 551
  Height = 313
  Caption = #1051#1072#1073#1086#1088#1072#1090#1086#1088#1085#1072#1103' '#1088#1072#1073#1086#1090#1072' '#8470'3'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lblInfo: TLabel
    Left = 408
    Top = 64
    Width = 129
    Height = 89
    AutoSize = False
    Caption = 
      #1055#1088#1086#1075#1088#1072#1084#1072' '#1085#1072#1093#1086#1076#1080#1090' '#1086#1089#1086#1073#1099#1077' '#1095#1080#1089#1083#1072' '#1074' '#1084#1072#1089#1089#1080#1074#1077', '#1090'. '#1077'. '#1090#1072#1082#1080#1077', '#1082#1086#1090#1086#1088#1099#1077' '#1073#1086 +
      #1083#1100#1096#1077' '#1089#1091#1084#1084#1099' '#1086#1089#1090#1072#1083#1100#1085#1099#1093' '#1101#1083#1077#1084#1077#1085#1090#1086#1074' '#1089#1074#1086#1077#1081' '#1089#1090#1088#1086#1082#1080'.'
    WordWrap = True
  end
  object sgdArray: TStringGrid
    Left = 8
    Top = 8
    Width = 393
    Height = 241
    ColCount = 3
    RowCount = 3
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRowMoving, goColMoving, goEditing]
    TabOrder = 0
    ColWidths = (
      64
      64
      64)
  end
  object btnRun: TButton
    Left = 408
    Top = 160
    Width = 129
    Height = 33
    Caption = #1055#1086#1089#1095#1080#1090#1072#1090#1100'!'
    TabOrder = 1
    OnClick = btnRunClick
  end
  object btnAddCol: TButton
    Left = 408
    Top = 8
    Width = 113
    Height = 25
    Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1089#1090#1086#1083#1073#1077#1094
    TabOrder = 2
    OnClick = btnAddColClick
  end
  object btnDelCol: TButton
    Left = 408
    Top = 32
    Width = 113
    Height = 25
    Caption = #1059#1076#1072#1083#1080#1090#1100' '#1089#1090#1086#1083#1073#1077#1094
    TabOrder = 3
    OnClick = btnDelColClick
  end
  object btnDelRow: TButton
    Left = 120
    Top = 256
    Width = 113
    Height = 25
    Caption = #1059#1076#1072#1083#1080#1090#1100' '#1089#1090#1088#1086#1082#1091
    TabOrder = 4
    OnClick = btnDelRowClick
  end
  object btnAddRow: TButton
    Left = 8
    Top = 256
    Width = 113
    Height = 25
    Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1089#1090#1088#1086#1082#1091
    TabOrder = 5
    OnClick = btnAddRowClick
  end
  object grpResult: TGroupBox
    Left = 408
    Top = 192
    Width = 129
    Height = 57
    TabOrder = 6
    object lblResult: TLabel
      Left = 8
      Top = 8
      Width = 113
      Height = 41
      Alignment = taCenter
      AutoSize = False
      Caption = '"'#1054#1089#1086#1073#1099#1093'" '#1101#1083#1077#1084#1077#1085#1090#1086#1074':'
      Layout = tlCenter
    end
  end
end
