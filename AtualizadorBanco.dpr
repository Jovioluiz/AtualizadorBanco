program AtualizadorBanco;

uses
  Vcl.Forms,
  fPrincipal in 'fPrincipal.pas' {frmPrincipal},
  dModulo in 'dModulo.pas' {dm: TDataModule},
  uManipuladorScript in 'uManipuladorScript.pas',
  uManipuladorXML in 'uManipuladorXML.pas',
  dConexao in 'Conexao\dConexao.pas' {dmConexao: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(Tdm, dm);
  ReportMemoryLeaksOnShutdown := True;
  Application.Run;
end.
