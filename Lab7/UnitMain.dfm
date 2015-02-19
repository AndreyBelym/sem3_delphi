object frmMain: TfrmMain
  Left = 254
  Top = 137
  Width = 418
  Height = 380
  Caption = #1051#1072#1073#1086#1088#1072#1090#1086#1088#1085#1072#1103' '#1088#1072#1073#1086#1090#1072' '#8470'7'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object bvlSndBevel: TBevel
    Left = 312
    Top = 191
    Width = 89
    Height = 35
    Style = bsRaised
  end
  object bvlFstBevel: TBevel
    Left = 88
    Top = 191
    Width = 89
    Height = 35
    Style = bsRaised
  end
  object lblFstUnit: TLabel
    Left = 96
    Top = 192
    Width = 73
    Height = 33
    AutoSize = False
    DragMode = dmAutomatic
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    OnDragDrop = lblFstUnitDragDrop
    OnDragOver = lblFstUnitDragOver
  end
  object lblSndUnit: TLabel
    Left = 320
    Top = 192
    Width = 73
    Height = 33
    AutoSize = False
    DragMode = dmAutomatic
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    OnDragDrop = lblFstUnitDragDrop
    OnDragOver = lblFstUnitDragOver
  end
  object imgFstTrash: TImage
    Left = 152
    Top = 168
    Width = 24
    Height = 22
    AutoSize = True
    Picture.Data = {
      07544269746D61707E010000424D7E0100000000000076000000280000001800
      0000160000000100040000000000080100000000000000000000100000000000
      0000000000000000800000800000008080008000000080008000808000008080
      8000C0C0C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFF
      FF008000000000000000000000080777777777777777777777700F7777777777
      7777777777700F88888888888888888887700F88888888888888888887700F88
      888700000007888887700F888880FFFFFFF0888887700F888880F0F0F0F08888
      87700F888880F0F0F0F0888887700F888880F0F0F0F0888887700F888880F0F0
      F0F0888887700F888880F0F0F0F0888887700F888880F0F0F0F0888887700F88
      8880F0F0F0F0888887700F888880FFFFFFF0888887700F888870000000007888
      87700F88880FFFFFFFFF088887700F88887000000000788887700F8888888700
      0788888887700F88888888888888888887700FFFFFFFFFFFFFFFFFFFFF708000
      00000000000000000008}
    OnDragDrop = imgFstTrashDragDrop
    OnDragOver = imgFstTrashDragOver
  end
  object imgSndTrash: TImage
    Left = 376
    Top = 168
    Width = 24
    Height = 22
    AutoSize = True
    Picture.Data = {
      07544269746D61707E010000424D7E0100000000000076000000280000001800
      0000160000000100040000000000080100000000000000000000100000000000
      0000000000000000800000800000008080008000000080008000808000008080
      8000C0C0C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFF
      FF008000000000000000000000080777777777777777777777700F7777777777
      7777777777700F88888888888888888887700F88888888888888888887700F88
      888700000007888887700F888880FFFFFFF0888887700F888880F0F0F0F08888
      87700F888880F0F0F0F0888887700F888880F0F0F0F0888887700F888880F0F0
      F0F0888887700F888880F0F0F0F0888887700F888880F0F0F0F0888887700F88
      8880F0F0F0F0888887700F888880FFFFFFF0888887700F888870000000007888
      87700F88880FFFFFFFFF088887700F88887000000000788887700F8888888700
      0788888887700F88888888888888888887700FFFFFFFFFFFFFFFFFFFFF708000
      00000000000000000008}
    OnDragDrop = imgFstTrashDragDrop
    OnDragOver = imgFstTrashDragOver
  end
  object lblInfo: TLabel
    Left = 0
    Top = 8
    Width = 401
    Height = 73
    AutoSize = False
    Caption = 
      ' '#1055#1088#1086#1075#1088#1072#1084#1084#1072' '#1087#1086#1079#1074#1086#1083#1103#1077#1090' '#1082#1086#1085#1074#1077#1088#1090#1080#1088#1086#1074#1072#1090#1100' '#1074#1077#1083#1080#1095#1080#1085#1099' '#1088#1072#1079#1083#1080#1095#1085#1099#1093' '#1077#1076#1080#1085#1080#1094' '#1080#1079 +
      #1084#1077#1088#1077#1085#1080#1103' '#1084#1077#1078#1076#1091' '#1089#1086#1073#1086#1081'. '#1042#1099#1073#1077#1088#1080#1090#1077' '#1082#1083#1072#1089#1089'  '#1077#1076#1080#1085#1080#1094' '#1080#1079#1084#1077#1088#1077#1085#1080#1103', '#1087#1086#1089#1083#1077' '#1095#1077#1075 +
      #1086' '#1087#1077#1088#1077#1090#1072#1097#1080#1090#1077' '#1085#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1103' '#1077#1076#1080#1085#1080#1094' '#1080#1079#1084#1077#1088#1077#1085#1080#1103' '#1074' '#1086#1073#1083#1072#1089#1090#1080', '#1086#1075#1088#1072#1085#1080#1095#1077#1085#1085 +
      #1099#1077' '#1088#1072#1084#1082#1086#1081'. '#1042#1074#1077#1076#1080#1090#1077' '#1079#1085#1072#1095#1077#1085#1080#1077' '#1074' '#1083#1102#1073#1086#1077' '#1087#1086#1083#1077' '#1074#1074#1086#1076#1072' '#1080' '#1085#1072#1078#1084#1080#1090#1077' '#1082#1083#1072#1074#1080#1096#1091 +
      ' <Enter> '#1085#1072' '#1082#1083#1072#1074#1080#1072#1090#1091#1088#1077' '#1080#1083#1080' '#1082#1085#1086#1087#1082#1091' "=" '#1074' '#1086#1082#1085#1077' '#1087#1088#1086#1075#1088#1072#1084#1084#1099'.'
    WordWrap = True
  end
  object edtFstVal: TEdit
    Left = 8
    Top = 192
    Width = 81
    Height = 33
    AutoSize = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    Text = '0'
    OnKeyPress = edtFstValKeyPress
  end
  object edtSndVal: TEdit
    Left = 232
    Top = 192
    Width = 81
    Height = 33
    AutoSize = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    Text = '0'
    OnKeyPress = edtFstValKeyPress
  end
  object memLog: TMemo
    Left = 0
    Top = 232
    Width = 409
    Height = 121
    Alignment = taCenter
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Lines.Strings = (
      '0 = 0')
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 2
  end
  object cbxCategory: TComboBox
    Left = 0
    Top = 88
    Width = 121
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 3
    OnSelect = cbxCategorySelect
  end
  object sbxUnits: TScrollBox
    Left = 0
    Top = 112
    Width = 401
    Height = 49
    TabOrder = 4
  end
  object btnEqu: TButton
    Left = 184
    Top = 192
    Width = 41
    Height = 33
    Caption = '='
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
    OnClick = btnEquClick
  end
end
