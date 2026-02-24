object DM: TDM
  OnCreate = DataModuleCreate
  Height = 313
  Width = 514
  object Conn: TFDConnection
    Params.Strings = (
      
        'Database=C:\Users\jgsilva\Documents\Jocelio\desktop_mobile\Fonte' +
        'sServidor\DB\BANCO.FDB'
      'User_Name=SYSDBA'
      'Password=masterkey'
      'Port=3050'
      'Server=localhost'
      'CharacterSet=WIN1252'
      'DriverID=FB')
    ConnectedStoredUsage = [auRunTime]
    LoginPrompt = False
    BeforeConnect = ConnBeforeConnect
    Left = 152
    Top = 72
  end
  object FDPhysFBDriverLink1: TFDPhysFBDriverLink
    Left = 280
    Top = 72
  end
end
