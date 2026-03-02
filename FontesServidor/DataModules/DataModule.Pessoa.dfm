object DmPessoa: TDmPessoa
  Height = 480
  Width = 640
  object Conn: TFDConnection
    Params.Strings = (
      
        'Database=C:\Users\jgsilva\Documents\Jocelio\desktop_mobile\Fonte' +
        'sServidor\DB\BANCO.FDB'
      'User_Name=SYSDBA'
      'Password=masterkey'
      'Protocol=TCPIP'
      'Server=localhost'
      'Port=3050'
      'CharacterSet=WIN1252'
      'DriverID=FB')
    ConnectedStoredUsage = []
    LoginPrompt = False
    Left = 192
    Top = 216
  end
  object FDPhysFBDriverLink1: TFDPhysFBDriverLink
    Left = 312
    Top = 216
  end
end
