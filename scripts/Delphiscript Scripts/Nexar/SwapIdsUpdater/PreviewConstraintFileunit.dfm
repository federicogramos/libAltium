object fPreviewer: TfPreviewer
  Left = 16
  Top = 14
  BorderStyle = bsToolWindow
  Caption = 'Constraint File Previewer'
  ClientHeight = 539
  ClientWidth = 680
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object MemoConstraintFile: TMemo
    Left = 7
    Top = 8
    Width = 585
    Height = 519
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssBoth
    TabOrder = 0
    WordWrap = False
  end
  object bAccept: TButton
    Left = 600
    Top = 10
    Width = 75
    Height = 25
    Caption = 'Accept'
    ModalResult = 1
    TabOrder = 1
  end
  object bReject: TButton
    Left = 600
    Top = 39
    Width = 75
    Height = 25
    Caption = 'Reject'
    ModalResult = 2
    TabOrder = 2
  end
end
