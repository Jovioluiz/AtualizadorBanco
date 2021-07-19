unit dConexao;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  FireDAC.Phys.PGDef, FireDAC.Phys.PG, FireDAC.Comp.UI, Data.DB,
  FireDAC.Comp.Client, IniFiles;

type
  TdmConexao = class(TDataModule)
    conexao: TFDConnection;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    drive: TFDPhysPgDriverLink;
    transacao: TFDTransaction;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmConexao: TdmConexao;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}


{ TdmConexao }

procedure TdmConexao.DataModuleCreate(Sender: TObject);
var
  conexaoIni: TIniFile;
  msg: string;
begin
  conexaoIni := TIniFile.Create(GetCurrentDir + '\conexao\conexao.ini');

  try
    try
      conexao.Params.Values['Server'] := conexaoIni.ReadString('configuracoes', 'servidor', conexao.Params.Values['Server']);
      conexao.Params.Database := conexaoIni.ReadString('configuracoes', 'banco', conexao.Params.Database);
      conexao.Params.UserName := conexaoIni.ReadString('configuracoes', 'usuario', conexao.Params.UserName);
      conexao.Params.Password := conexaoIni.ReadString('configuracoes', 'senha', conexao.Params.Password);
      conexao.Params.Values['Port'] := conexaoIni.ReadString('configuracoes', 'porta', conexao.Params.Values['Port']);
      drive.VendorLib := ExtractFilePath(GetCurrentDir) + 'lib\libpq.dll';
      conexao.Connected := True;

    except
      on e:Exception do
      begin
        msg := 'Erro ao conectar no banco de dados ' + conexao.Params.Database
               + #13 + ' Verifique o arquivo de conexao.' + #13;
        raise Exception.Create(msg + e.Message);
      end;
    end;
  finally
    conexaoIni.Free;
  end;
end;

end.
