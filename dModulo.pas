unit dModulo;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Datasnap.DBClient;

type
  Tdm = class(TDataModule)
    ds: TDataSource;
    cds: TClientDataSet;
    dsExecutar: TDataSource;
    cdsExecutar: TClientDataSet;
    cdsExecutarcomando: TStringField;
    cdsExecutarselecionado: TIntegerField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dm: Tdm;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
