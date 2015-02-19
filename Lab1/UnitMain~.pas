unit UnitMain;
interface

uses
  Windows, Messages, SysUtils, Variants, 
  Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Math, ExtCtrls, jpeg;

type
  TfrmMain = class(TForm)
    lblInfo: TLabel;
    grpParams: TGroupBox;
    btnRun: TButton;
    btnExit: TButton;
    txtX: TLabeledEdit;
    txtY: TLabeledEdit;
    txtZ: TLabeledEdit;
    imgFormula: TImage;
    memResult: TMemo;
    procedure btnRunClick(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

procedure TfrmMain.btnRunClick(Sender: TObject);
var x,y,z,w:Double; ok:Boolean; errors:string;
begin
  errors:='';
  if not TryStrToFloat(txtX.Text,x) then
    errors:=#10#13+'x - не вещественное число!';
  if not TryStrToFloat(txtY.Text,y) then
    errors:=errors+#10#13+'y - не вещественное число!';
  if not TryStrToFloat(txtZ.Text,z) then
    errors:=errors+#10#13+'z - не вещественное число!';
  if (errors<>'') then
	MessageDlg('Ошибки: '+errors,mtError,[mbOK],0)
  else begin
    w:=Power(Abs(cos(x)-cos(y)),1+2*sqr(sin(y)))*
        (1+z+sqr(z)/2+z*sqr(z)/3+sqr(z)*sqr(z)/4);
        memResult.Text:=memResult.Text+FloatToStr(w}+#13#10+'w=';
  end;
end;

procedure TfrmMain.btnExitClick(Sender: TObject);
begin
Application.Terminate;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  memResult.Text:=memResult.Text+'w=';
end;

end.
