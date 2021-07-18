unit uManipuladorScript;

interface

uses
  dModulo, Datasnap.DBClient, FireDAC.Comp.Client, FireDAC.DApt;

type
  TManipuladorScript = class
  private
    FDados: Tdm;
    FArquivo: TextFile;
    procedure SetDados(const Value: Tdm);
    procedure SetArquivo(const Value: TextFile);

  public
    procedure GravaArquivo(Comandos: TClientDataset; Caminho: string);
    procedure ListarComandos(Arquivo: String);
    function GravarComandos(Scripts: TClientDataset; Conexao: TFDConnection): Boolean;
    constructor Create;
    destructor Destroy; override;
    property Dados: Tdm read FDados write SetDados;
    property Arquivo: TextFile read FArquivo write SetArquivo;

  end;

implementation

uses
  System.Classes, System.Types, System.SysUtils, dConexao, Vcl.Dialogs;

{ TManipun

uses
  System.Classes;adorScript }

constructor TManipuladorScript.Create;
begin
  FDados := Tdm.Create(nil);
end;

destructor TManipuladorScript.Destroy;
begin
  FDados.Free;
  inherited;
end;

procedure TManipuladorScript.GravaArquivo(Comandos: TClientDataset; Caminho: string);
begin
  AssignFile(FArquivo, Caminho);
  {$I-}
  Reset(FArquivo);
  {$I+}

  try

    if (IOResult <> 0) then
      Rewrite(FArquivo) { arquivo não existe e será criado }
    else
    begin
      CloseFile(FArquivo);
      Append(FArquivo); { o arquivo existe e será aberto para saídas adicionais }
    end;

    Comandos.First;
    while not Comandos.Eof do
    begin
      Writeln(FArquivo, Comandos.FieldByName('comando').AsString.Replace(sLineBreak, ' '));
      Comandos.Next;
    end;
  finally
    CloseFile(FArquivo);
  end;
end;

function TManipuladorScript.GravarComandos(Scripts: TClientDataset; Conexao: TFDConnection): Boolean;
var
  i: integer;
  query: TFDQuery;
  msg: string;
begin

  query := TFDQuery.Create(nil);
  query.Connection := Conexao;

  try
    try
      Scripts.First;
      for i := 0 to Pred(Scripts.RecordCount) do
      begin
        if Scripts.FieldByName('selecionado').AsInteger = 1 then
        begin
          query.SQL.Add(Scripts.FieldByName('comando').AsString);
          query.ExecSQL;
        end;
        Scripts.Next;
      end;

      query.Connection.Commit;
      Result := True;
    except on E: Exception do
      begin
        query.Connection.Rollback;
        msg := 'Ocorreu o seguinte erro ' + E.Message;
        ShowMessage(msg);
        Exit(False); 
      end;
    end;
    
  finally
    query.Free;
  end;
end;

procedure TManipuladorScript.ListarComandos(Arquivo: String);
var
  linhas: TStringList;
  i: integer;
  delimiter: TArray<string>;
begin
  linhas := TStringList.Create;
  linhas.LoadFromFile(Arquivo);

  try

    for i := 1 to Pred(linhas.Count) do
    begin
      delimiter := linhas.Strings[i].Split([';']);
      Dados.cdsExecutar.Append;
      Dados.cdsExecutar.FieldByName('selecionado').AsBoolean := True;
      Dados.cdsExecutar.FieldByName('comando').AsString := delimiter[i-1];
      Dados.cdsExecutar.Post;
    end;

  finally
    linhas.Free;
  end;
end;

procedure TManipuladorScript.SetArquivo(const Value: TextFile);
begin
//  FArquivo := Value;
end;

procedure TManipuladorScript.SetDados(const Value: Tdm);
begin
  FDados := Value;
end;

end.
