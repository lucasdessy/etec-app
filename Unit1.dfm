object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 323
  ClientWidth = 527
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 24
    Top = 21
    Width = 27
    Height = 13
    Caption = 'Nome'
  end
  object Label2: TLabel
    Left = 24
    Top = 69
    Width = 28
    Height = 13
    Caption = 'Idade'
  end
  object Button1: TButton
    Left = 8
    Top = 193
    Width = 153
    Height = 32
    Caption = 'Gerar'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Memo1: TMemo
    Left = 184
    Top = 16
    Width = 335
    Height = 299
    TabOrder = 1
  end
  object Edit1: TEdit
    Left = 24
    Top = 40
    Width = 121
    Height = 21
    TabOrder = 2
  end
  object Edit2: TEdit
    Left = 24
    Top = 88
    Width = 121
    Height = 21
    TabOrder = 3
  end
  object RadioButton1: TRadioButton
    Left = 24
    Top = 136
    Width = 57
    Height = 17
    Caption = 'M'
    Checked = True
    TabOrder = 4
    TabStop = True
  end
  object RadioButton2: TRadioButton
    Left = 24
    Top = 159
    Width = 57
    Height = 17
    Caption = 'F'
    TabOrder = 5
  end
  object Button2: TButton
    Left = 8
    Top = 231
    Width = 153
    Height = 33
    Caption = 'Exportar'
    TabOrder = 6
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 8
    Top = 270
    Width = 153
    Height = 33
    Caption = 'Importar'
    TabOrder = 7
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 110
    Top = 115
    Width = 35
    Height = 25
    Caption = 'CL'
    TabOrder = 8
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 103
    Top = 162
    Width = 75
    Height = 25
    Caption = 'Button5'
    TabOrder = 9
    OnClick = Button5Click
  end
  object OpenDialog1: TOpenDialog
    Left = 168
    Top = 120
  end
end
