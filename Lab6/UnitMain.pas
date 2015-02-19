unit UnitMain;
interface

uses
  
  Classes, Controls, Forms,
  StdCtrls, jpeg, ExtCtrls;

type
  TfrmMain = class(TForm)
    lblInfo: TLabel;//���������� � ���������
    grpParams: TGroupBox;//������ ����������
    btnRun: TButton;//������ �������
    btnExit: TButton;//������ ������
    edtX: TLabeledEdit;//���� ��������� X
    edtY: TLabeledEdit;//���� ��������� Y
    edtZ: TLabeledEdit;//���� ��������� Z
    imgFormula: TImage;//�������
    memResult: TMemo;//��������� �������
    //���������� ������� ������ �������
    procedure btnRunClick(Sender: TObject); 
    //���������� ������� ������ ������ 
    procedure btnExitClick(Sender: TObject);
    //���������� ������� �������� �����
    procedure FormCreate(Sender: TObject);

  private
    { Private declarations }

  public
    { Public declarations }


  end;
    //���� ������
    function Input(var x,y,z:Double):boolean;  external 'LabDLL';
    //����� ������
    procedure Output(w:Double);   external 'LabDLL';
    //������ �������
    function CalcW(x,y,z:Double):Double; external 'LabDLL';
var
  frmMain: TfrmMain;

implementation

{$R *.dfm}
(*
��������� btnRunClick - ���������� ������� ������ ����� �� ������ 
btnRun - �������� ��������� ���������.
���������:
Sender:TObject - ������-����������� �������
��������� ����������:
x,y,z:Double-��������� ������� �������� �������
w   : Double -�������� �������
*)
procedure TfrmMain.btnRunClick(Sender: TObject);
var x,y,z,w:Double;ok:boolean;
begin
  ok:=Input(x,y,z);
  if ok then begin
    w:=CalcW(x,y,z);
    Output(w);
  end;
end;
(*
���������-���������� ������� btnExitClick ��� ������ ����� �� ������ 
btnExit ��������� ����������.
���������:
Sender:TObject - ������-����������� �������
*)
procedure TfrmMain.btnExitClick(Sender: TObject);
begin
Application.Terminate;
end;
(*
��������� FormCreate ��������� � ��������������� ���� memResult 
������ "w=". 
���������:
Sender:TObject-������-����������� �������
*)
procedure TfrmMain.FormCreate(Sender: TObject);
begin
  memResult.Text:=memResult.Text+'w=';
end;
end.
