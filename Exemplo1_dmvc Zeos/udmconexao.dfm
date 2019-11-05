object dmconexao: Tdmconexao
  OldCreateOrder = False
  Height = 224
  Width = 328
  object ZConnection1: TZConnection
    ControlsCodePage = cCP_UTF16
    AutoEncodeStrings = True
    Catalog = ''
    Connected = True
    HostName = 'localhost'
    Port = 3050
    Database = 
      'C:\Program Files\Firebird\Firebird_2_5\examples\empbuild\EMPLOYE' +
      'E.FDB'
    User = 'SYSDBA'
    Password = 'masterkey'
    Protocol = 'firebird'
    Left = 112
    Top = 104
  end
  object ZQuery1: TZQuery
    Connection = ZConnection1
    Params = <>
    Left = 192
    Top = 104
  end
end
