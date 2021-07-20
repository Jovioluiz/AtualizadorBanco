unit fPrincipal;

interface

uses
  Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Xml.xmldom, Xml.XMLIntf, Xml.XMLDoc,
  Vcl.StdCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids, uManipuladorScript, Vcl.ExtCtrls,
  Vcl.ComCtrls, Vcl.ExtDlgs, uManipuladorXML, dConexao, System.Types, Vcl.Menus;

type
  TfrmPrincipal = class(TForm)
    memoSql: TMemo;
    btnGravar: TButton;
    btnConfirma: TButton;
    dbGrid: TDBGrid;
    dialog: TOpenDialog;
    edtArquivo: TLabeledEdit;
    btnSelecionarArquivo: TButton;
    PageControl1: TPageControl;
    tsAdd: TTabSheet;
    tsRodar: TTabSheet;
    edtArquivoXml: TLabeledEdit;
    btnAdd: TButton;
    btnListar: TButton;
    dbGridExec: TDBGrid;
    btnExecutarSql: TButton;
    OpenTextFileDialog: TOpenTextFileDialog;
    edtVersao: TLabeledEdit;
    GroupBox1: TGroupBox;
    btnConectar: TButton;
    lblConexao: TLabel;
    lblBanco: TLabel;
    lblservidor: TLabel;
    lblPorta: TLabel;
    rbDDL: TRadioButton;
    rbDML: TRadioButton;
    popMenu: TPopupMenu;
    Excluir1: TMenuItem;
    Button1: TButton;
    procedure btnGravarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure dbGridDblClick(Sender: TObject);
    procedure btnSelecionarArquivoClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnListarClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure btnConectarClick(Sender: TObject);
    procedure btnExecutarSqlClick(Sender: TObject);
    procedure dbGridExecDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure dbGridExecCellClick(Column: TColumn);
    procedure Excluir1Click(Sender: TObject);
  private
    FManipulador: TManipuladorScript;
    FEdicao: Boolean;
    FManipuladorXML: TManipuladorXML;
    FConexao: TdmConexao;
    procedure SetManipulador(const Value: TManipuladorScript);
    procedure SetManipuladorXML(const Value: TManipuladorXML);
    procedure SetConexao(const Value: TdmConexao);
    { Private declarations }
  public
    { Public declarations }
    property Manipulador: TManipuladorScript read FManipulador write SetManipulador;
    property ManipuladorXML: TManipuladorXML read FManipuladorXML write SetManipuladorXML;
    property Conexao: TdmConexao read FConexao write SetConexao;
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

uses
  FileCtrl, System.StrUtils, System.Math, Winapi.Windows;

{$R *.dfm}

procedure TfrmPrincipal.btnAddClick(Sender: TObject);
begin
  if not Assigned(FConexao) then
    raise Exception.Create('Conecte em um banco primeiro');

  if OpenTextFileDialog.Execute then
    edtArquivoXml.Text := OpenTextFileDialog.FileName;
end;

procedure TfrmPrincipal.btnConectarClick(Sender: TObject);
begin
  FConexao := TdmConexao.Create(Self);
  lblBanco.Caption := FConexao.conexao.Params.Database;
  lblservidor.Caption := FConexao.conexao.Params.Values['Server'];
  lblPorta.Caption := FConexao.conexao.Params.Values['Port'];
  btnAdd.Enabled := True;
end;

procedure TfrmPrincipal.btnConfirmaClick(Sender: TObject);
begin
  if memoSql.Lines.Text <> '' then
  begin
    if FEdicao then
      ManipuladorXML.Dados.cds.Edit
    else
      ManipuladorXML.Dados.cds.Append;
    ManipuladorXML.Dados.cds.FieldByName('comando').AsString := memoSql.Text;
    ManipuladorXML.Dados.cds.Post;
    memoSql.Lines.Clear;
    FEdicao := False;
  end;
end;

procedure TfrmPrincipal.btnExecutarSqlClick(Sender: TObject);
begin
  if ManipuladorXML.Dados.cdsExecutar.IsEmpty then
    Exit;

  if Manipulador.GravarComandos(ManipuladorXML.Dados.cdsExecutar, FConexao.conexao) then
    ManipuladorXML.Dados.cdsExecutar.EmptyDataSet;
end;

procedure TfrmPrincipal.btnGravarClick(Sender: TObject);
begin
  if edtArquivo.Text = '' then
  begin
    edtArquivo.SetFocus;
    raise Exception.Create('Selecione um arquivo');
  end;
  ManipuladorXML.GravaXML(ManipuladorXML.Dados.cds, edtArquivo.Text, edtVersao.Text, IfThen(rbDDL.Checked, 'DDL', 'DML'));
  ManipuladorXML.Dados.cds.EmptyDataSet;
end;

procedure TfrmPrincipal.btnSelecionarArquivoClick(Sender: TObject);
begin
  if dialog.Execute then
    edtArquivo.Text := ExtractFilePath(dialog.FileName);
end;

procedure TfrmPrincipal.btnListarClick(Sender: TObject);
begin
  if edtArquivoXml.Text = '' then
    raise Exception.Create('Selecione um arquivo');

  FManipuladorXML.Dados.cdsExecutar.EmptyDataSet;
  FManipuladorXML.ListarComandosXML(edtArquivoXml.Text);
end;

procedure TfrmPrincipal.dbGridDblClick(Sender: TObject);
begin
  memoSql.Lines.Clear;

  if ManipuladorXML.Dados.cds.RecordCount > 0 then
  begin
    memoSql.Lines.Add(ManipuladorXML.Dados.cds.FieldByName('comando').AsString);
    FEdicao := True;
  end;
end;

procedure TfrmPrincipal.dbGridExecCellClick(Column: TColumn);
begin
  if not Assigned(ManipuladorXML.Dados.cdsExecutar.FindField('selecionado')) then
    ModalResult := mrOk
  else
  begin
    ManipuladorXML.Dados.cdsExecutar.Edit;
    ManipuladorXML.Dados.cdsExecutar.FieldByName('selecionado').AsInteger := IfThen(ManipuladorXML.Dados.cdsExecutar.FieldByName('selecionado').Asinteger = 1, 0, 1);
    ManipuladorXML.Dados.cdsExecutar.Post;
  end;
end;

procedure TfrmPrincipal.dbGridExecDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  lR: TRect;
  lCheck: integer;
begin
  if Assigned(ManipuladorXML.Dados.cdsExecutar.FindField('selecionado')) and (Column.Index = 0) then
  begin
    if (ManipuladorXML.Dados.cdsExecutar.FieldByName('selecionado').Value = 1) then
      lCheck := DFCS_BUTTONCHECK or DFCS_CHECKED
    else
      lCheck := DFCS_BUTTONCHECK;
    dbGridExec.Canvas.FillRect(Rect);
    lR := Rect;
    InflateRect(lR, -2, -2);
    DrawFrameControl(dbGridExec.Canvas.Handle, lR, DFC_BUTTON, lCheck);
  end
  else
    dbGridExec.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TfrmPrincipal.Excluir1Click(Sender: TObject);
begin
  FManipuladorXML.Dados.cds.Delete;
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  ManipuladorXML := TManipuladorXML.Create(Self);
  Manipulador := TManipuladorScript.Create;
  dbGrid.DataSource := ManipuladorXML.Dados.ds;
  dbGridExec.DataSource := ManipuladorXML.Dados.dsExecutar;
  FEdicao := False;
  PageControl1.ActivePageIndex := 0;
end;

procedure TfrmPrincipal.FormDestroy(Sender: TObject);
begin
  ManipuladorXML.Free;
  Manipulador.Free;
  FConexao.Free;
end;

procedure TfrmPrincipal.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL,0,0)
  end;
end;

procedure TfrmPrincipal.SetConexao(const Value: TdmConexao);
begin
  FConexao := Value;
end;

procedure TfrmPrincipal.SetManipulador(const Value: TManipuladorScript);
begin
  FManipulador := Value;
end;

procedure TfrmPrincipal.SetManipuladorXML(const Value: TManipuladorXML);
begin
  FManipuladorXML := Value;
end;

end.
