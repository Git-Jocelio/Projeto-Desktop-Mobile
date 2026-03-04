object DmServidor: TDmServidor
  Height = 358
  Width = 500
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
    Left = 112
    Top = 64
  end
  object FDPhysFBDriverLink1: TFDPhysFBDriverLink
    Left = 208
    Top = 64
  end
end
