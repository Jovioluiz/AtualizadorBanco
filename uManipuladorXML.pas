unit uManipuladorXML;

interface

uses
  dModulo, Datasnap.DBClient, Xml.XMLDoc, System.Classes;

type TManipuladorXML = class
  private
    FDados: Tdm;
    FDocumentoXML: TXMLDocument;
    FComponente: TComponent;
    procedure SetDados(const Value: Tdm);

  public

  procedure GravaXML(dataSet: TClientDataset; Caminho, Versao, TipoVersao: string);
  procedure ListarComandosXML(Xml: string);
  constructor Create(componente: TComponent);
  destructor Destroy; override;

  property Dados: Tdm read FDados write SetDados;
end;

implementation

uses
  Xml.XMLIntf, System.SysUtils;

{ TManipuladorXML }

constructor TManipuladorXML.Create(componente: TComponent);
begin
  FDados := Tdm.Create(nil);
  FComponente := componente;
end;

destructor TManipuladorXML.Destroy;
begin
//  FDocumentoXML.Free;
  FDados.Free;
  inherited;
end;

procedure TManipuladorXML.GravaXML(dataSet: TClientDataset; Caminho, Versao, TipoVersao: string);
var
  nodeAtualizador,
  nodeAtualizacao,
  nodeComando: IXMLNode;
begin

  FDocumentoXML := TXMLDocument.Create(FComponente);
  FDocumentoXML.Active := True;
  FDocumentoXML.Options := [doNodeAutoIndent];//identa o xml

  try
    FDocumentoXML.Version := '1.0';
    FDocumentoXML.Encoding := 'ISO-8859-1';

    nodeAtualizador := FDocumentoXML.AddChild('atualizador');

    nodeAtualizacao := nodeAtualizador.AddChild('atualizacao');
    nodeAtualizacao.Attributes['versao_ddl'] := Versao;

    dataSet.First;
    while not dataSet.Eof do
    begin
      nodeComando := nodeAtualizacao.AddChild('comando');
      nodeComando.Attributes['comando_sql'] := dataSet.FieldByName('comando').AsString;
      dataSet.Next;
    end;

    FDocumentoXML.SaveToFile(Caminho + TipoVersao + 'v_' + Versao + '.xml');
  finally
    FDocumentoXML.Free;
  end;
end;

procedure TManipuladorXML.ListarComandosXML(Xml: string);
var
  i: Integer;
  xmlNodeAtualizacao,
  xmlNodeComando: IXMLNode;
begin
  FDocumentoXML := TXMLDocument.Create(FComponente);

  try
    FDocumentoXML.Active := True;
    FDocumentoXML.LoadFromFile(Xml);

    xmlNodeAtualizacao := FDocumentoXML.DocumentElement.ChildNodes.FindNode('atualizacao');
    xmlNodeComando := xmlNodeAtualizacao.ChildNodes.FindNode('comando');

    xmlNodeComando.ChildNodes.First;
    for i := 0 to Pred(xmlNodeAtualizacao.ChildNodes.Count) do
    begin
      Dados.cdsExecutar.Append;
      Dados.cdsExecutar.FieldByName('comando').AsString := StringReplace(xmlNodeAtualizacao.ChildNodes[i].Attributes['comando_sql'], ' ', ' ', [rfReplaceAll]);
      Dados.cdsExecutar.Post;
    end;
  finally
    FDocumentoXML.Free;
  end;
end;

procedure TManipuladorXML.SetDados(const Value: Tdm);
begin
  FDados := Value;
end;

end.
