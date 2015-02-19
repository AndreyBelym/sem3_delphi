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
    edtX: TLabeledEdit;
    edtY: TLabeledEdit;
    edtZ: TLabeledEdit;
    imgFormula: TImage;
    memResult: TMemo;
    procedure btnRunClick(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    
  private
    { Private declarations }
    function Input(var x,y,z:Double):boolean;
    procedure Output(w:Double);
  public
    { Public declarations }
    function CalcW(x,y,z:Double):Double;
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}
procedure TfrmMain.Output(w:Double);
begin
  memResult.Text:=memResult.Text+FloatToStr(w)+#13#10+'w=';
end;

function TfrmMain.Input(var x,y,z:Double):boolean;
var errors:string;
begin
  errors:='';
  if not TryStrToFloat(edtX.Text,x) then
    errors:=#10#13+'x - не вещественное число!';
  if not TryStrToFloat(edtY.Text,y) then
    errors:=errors+#10#13+'y - не вещественное число!';
  if not TryStrToFloat(edtZ.Text,z) then
    errors:=errors+#10#13+'z - не вещественное число!';
  if (errors<>'') then begin
	  Input:=False;MessageDlg('Ошибки: '+errors,mtError,[mbOK],0)
  end else Input:=True;
end;

function TfrmMain.CalcW(x,y,z:Double):Double;
begin
  CalcW:=Power(Abs(cos(x)-cos(y)),1+2*sqr(sin(y)))*
    (1+z+sqr(z)/2+z*sqr(z)/3+sqr(z)*sqr(z)/4);
end;

procedure TfrmMain.btnRunClick(Sender: TObject);
var x,y,z,w:Double;ok:boolean;
begin
  ok:=Input(x,y,z);
  if ok then begin
    w:=CalcW(x,y,z);
    Output(w);
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
