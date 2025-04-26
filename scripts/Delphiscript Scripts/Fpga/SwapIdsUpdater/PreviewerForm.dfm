object fPreviewer: TfPreviewer
  Left = 81
  Top = 173
  Width = 502
  Height = 314
  Caption = 'Previewer'
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
    Left = 13
    Top = 10
    Width = 389
    Height = 258
    Lines.Strings = (
      '')
    TabOrder = 0
  end
  object bOK: TButton
    Left = 413
    Top = 10
    Width = 75
    Height = 25
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 1
  end
  object bCancel: TButton
    Left = 414
    Top = 36
    Width = 75
    Height = 25
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
end
