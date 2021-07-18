object dmConexao: TdmConexao
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 197
  Width = 271
  object conexao: TFDConnection
    Params.Strings = (
      'DriverID=PG')
    Left = 48
    Top = 40
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 184
    Top = 32
  end
  object drive: TFDPhysPgDriverLink
    Left = 104
    Top = 40
  end
end
