object dmConexao: TdmConexao
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 197
  Width = 271
  object conexao: TFDConnection
    Params.Strings = (
      'DriverID=PG')
    Transaction = transacao
    Left = 48
    Top = 40
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 184
    Top = 40
  end
  object drive: TFDPhysPgDriverLink
    Left = 104
    Top = 40
  end
  object transacao: TFDTransaction
    Options.AutoStart = False
    Options.AutoStop = False
    Options.DisconnectAction = xdRollback
    Connection = conexao
    Left = 136
    Top = 128
  end
end
