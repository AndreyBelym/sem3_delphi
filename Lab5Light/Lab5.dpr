program Lab5;

uses
  Forms,
  UnitMain in 'UnitMain.pas' {frmMain},
  UnitDlg in 'UnitDlg.pas' {dlgChooseDT},
  UnitFolders in 'UnitFolders.pas' {dlgFolders};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TdlgChooseDT, dlgChooseDT);
  Application.CreateForm(TdlgFolders, dlgFolders);
  Application.Run;
end.
