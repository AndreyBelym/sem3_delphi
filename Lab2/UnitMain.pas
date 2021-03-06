unit UnitMain;
interface

uses
  Windows, SysUtils,
  Forms, Dialogs,
  Math,  Controls, StdCtrls, ExtCtrls, jpeg, Classes;

type
  TFunc = function(x:Double):Double;
  TFuncRec = record
      func:TFunc;
      descr:string;
  end;
  TfrmMain = class(TForm)
    lblInfo: TLabel;  //���������� � ���������
    grpParams: TGroupBox;  //������ ���������� �����
    btnRun: TButton;  //������ �������
    btnExit: TButton;  //������ ������
    txtX: TLabeledEdit;  //���� ����� �
    txtY: TLabeledEdit;  //���� ����� �
    imgFormula: TImage;  //������� �������
    memResult: TMemo;  //���� ������ �����������
    rgrFunctions: TRadioGroup; //������������� �������
    procedure btnRunClick(Sender: TObject);
    procedure btnExitClick(Sender: TObject);

  private
    { Private declarations }
    function Input(var x,y:Double;var f:TFuncRec):boolean;
    procedure Output(x,y:Double;f:String;d:Double);
  public
    { Public declarations }

  end;
  function CalcD(x,y:Double;f:TFunc):Double;
var
  frmMain: TfrmMain;

implementation

{$R *.dfm}
(*
��������� Output ������� ������������ �������� ������� ������� �� �����.
���������:
d - �������� ������� �������
*)
procedure TfrmMain.Output(x,y:Double;f:String;d:Double);
begin
  memResult.Text:=memResult.Text+
                  'x='+floattostr(x)+#13#10+
                  'y='+floattostr(y)+#13#10+
                  'f(x)='+f+#13#10+
                  'd='+FloatToStr(d)+#13#10;
  memResult.SelLength:=length(memResult.Text);
end;

function f1(x:Double):Double;
begin
  f1:=sinh(x);
end;
function f2(x:Double):Double;
begin
  f2:=sqr(x);
end;
function f3(x:Double):Double;
begin
  f3:=exp(x);
end;
(*
������� Input ������ ������ ��� ������� �������� ������� �������.
���������� True, ���� �������� ������ �������, ����� ���������� False.
���������:
x,y - ����� ��� ������� �������� ������� �������
f - �������, � ������� ������� �������������� �������� ������� �������
��������� ����������:
errors - ������ ���������� � ��������� ������� I/O.
*)
function TfrmMain.Input(var x,y:Double;var f:TFuncRec):boolean;
var errors:string;
const n=3;
const TestFuncs:array [0..n-1] of TFuncRec = ((func:f1;descr:'sh(x)'),
                                            (func:f2;descr:'x^2'),
                                            (func:f3;descr:'exp(x)'));
begin
  errors:='';
  f:=TestFuncs[rgrFunctions.ItemIndex];
  if not TryStrToFloat(txtX.Text,x) then
    errors:=#10#13+'x - �� ������������ �����!'
  else if abs(x)>100 then
    errors:= #10#13+'x ������� �������!';
  if not TryStrToFloat(txtY.Text,y) then
    errors:=errors+#10#13+'y - �� ������������ �����!';
  if (errors<>'') then begin
    MessageDlg('������: '+errors,mtError,[mbOK],0);
    Input:=False;
  end else Input:=True;
end;

(*
������� CalcD ������������ �������� ������� �������.
���������� ������������ ��������.
���������:
x,y - ����� ��� ������� �������� ������� �������
f - �������, � ������� ������� �������������� �������� ������� �������
*)
function CalcD(x,y:Double;f:TFunc):Double;
begin
  if x>y then
    CalcD:=sqr(f(x)-y)*(f(x)-y)+arctan(f(x))
  else if x<y then
    CalcD:=sqr(y-f(x))*(y-f(x))+arctan(f(x))
  else
    CalcD:=sqr(y+f(x))*(y+f(x))+0.5;
end;

(*
��������� btnRunClick - �������� ��������� ��������� ������� ������� �������.
��������� ����������:
x,y - ����� ��� ������� �������� ������� �������
f - �������, � ������� ������� �������������� �������� ������� �������
d - �������� �������.
*)
procedure TfrmMain.btnRunClick(Sender: TObject);
var x,y,d:Double;f:TFuncRec;
begin
  if Input(x,y,f) then begin
    d:=CalcD(x,y,f.func);
    Output(x,y,f.descr,d);
  end;
end;

procedure TfrmMain.btnExitClick(Sender: TObject);
begin
Application.Terminate;
end;

end.
