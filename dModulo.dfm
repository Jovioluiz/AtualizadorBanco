object dm: Tdm
  OldCreateOrder = False
  Height = 150
  Width = 215
  object ds: TDataSource
    DataSet = cds
    Left = 32
    Top = 32
  end
  object cds: TClientDataSet
    PersistDataPacket.Data = {
      360000009619E0BD010000001800000001000000000003000000360007636F6D
      616E646F020049000000010005574944544802000200E8030000}
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'comando'
        DataType = ftString
        Size = 1000
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 80
    Top = 32
  end
  object dsExecutar: TDataSource
    DataSet = cdsExecutar
    Left = 40
    Top = 88
  end
  object cdsExecutar: TClientDataSet
    PersistDataPacket.Data = {
      4A0000009619E0BD0100000018000000020000000000030000004A000B73656C
      6563696F6E61646F040001000000000007636F6D616E646F0200490000000100
      05574944544802000200E8030000}
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'selecionado'
        DataType = ftInteger
      end
      item
        Name = 'comando'
        DataType = ftString
        Size = 1000
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 120
    Top = 88
    object cdsExecutarselecionado: TIntegerField
      DisplayLabel = '[X]'
      DisplayWidth = 2
      FieldName = 'selecionado'
    end
    object cdsExecutarcomando: TStringField
      FieldName = 'comando'
      Size = 1000
    end
  end
end
