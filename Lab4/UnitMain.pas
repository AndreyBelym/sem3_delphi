unit UnitMain;

interface

uses
  Windows, Messages, SysUtils,  Classes, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TStrArray=array of string; //������������ ������ �����
  TStrRec=record
    groups:TStrArray;
    lineNum:Integer;
  end;
  type TSrcRec=record
    str:String;
    num:Integer;
  end;
  TSrcRecArray=array of  TSrcRec;
  TStrRecArray=array of TStrRec;
  TfrmMain = class(TForm) //�������� �����
    edtNewLine: TLabeledEdit; //���� ����� ����� ������ 
    lstStrings: TListBox; //������ ��������� �����
    btnClose: TBitBtn; //������ �������� �����
    grpResult: TGroupBox; //���� ��� ������ �����������
    btnDelete: TButton; //������ �������� ������
    lblInfo: TLabel;
    lblResult: TMemo; //������� � ����������� � ���������
    //���������� ������� ������� ������� � ���� ����� ����� ������
    procedure edtNewLineKeyPress(Sender: TObject; var Key: Char);
    //���������� ������� ������� ������ �������� ������ btnDeleteClick
    procedure btnDeleteClick(Sender: TObject);
    //���������� ������� ������ ������ �� ������ lstStringsClick
    procedure lstStringsClick(Sender: TObject);
    //���� ������
    function InputString:TSrcRecArray;
    //����� �����������
    procedure Output(x:TStrRecArray);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

{
��������� addGroup - ���������� ��������� ������ �� ����� � ������ � ������ ����������� �������� � ������������ ������.
���������:
const str:String - ������ � ������� ��������
const beg,end_:integer - ��������� � �������� ������� ������
x:TStrArray - ������������ ������ �����
��������� ����������:
k:integer - ������ ������� �����
}
  procedure addGroup(const str:string;const beg,end_:integer;var x:TStrArray);
  var k:integer;
  begin
    k:=length(x);
    if ((end_-beg) mod 2 = 0) then begin
        inc(k);
        setlength(x,k);
        if (length(x)=k)and(x<>NIL) then
          x[k-1]:=copy(str,beg,end_-beg)
        else begin
          setlength(x,0) ;
          x:=NIL;
          OutOfMemoryError;
        end;
      end;
  end;
  
{
������� getGroups - ��������� �� ������ ����� �� ����� � ������ 
� ������ ����������� ��������.
���������� ������������ ������ �����.
���������:
str:string - ������ ��� ������ �����
��������� ����������:
x:TStrArray -������������ ������ �����
beg:integer - ������ ������ ��������
i:integer - ������ �������� �������� ������
}  
function getGroups(const str:String):TStrArray;
var x:TStrArray;
  beg,i:integer;
begin
  beg:=1;
  if length(str)<>1 then begin
  for i:=2 to length(str) do begin
    if str[i]<>str[i-1] then begin
      addGroup(str,beg,i,x);
      beg:=i;
    end;

  end;
  addGroup(str,beg,length(str)+1,x);
  end else x:=NIL;
  Result:=x;
end;

{
���������� ������� ������� ������� � ���� ����� ����� ������ edtNewLineKeyPress.
���������:
Sender:TObject - ������-����������� �������
Key: Char - ������ ������� �������
}
procedure TfrmMain.edtNewLineKeyPress(Sender: TObject; var Key: Char);
begin
  if Key=#13 then begin
      Key:=#0;
      lstStrings.Items.Add(edtNewLine.Text);
      lstStrings.Selected[lstStrings.Items.Count-1]:=True;
      lstStringsClick(Sender);
      edtNewLine.Text:='';
  end
  else if (Key<>'0') and (Key<>'1') then
      Key:=#0;   
end;


{
���������� ������� ������� ������ �������� ������ btnDeleteClick.
���������:
Sender:TObject - ������-����������� �������
}
procedure TfrmMain.btnDeleteClick(Sender: TObject);
var i:Integer;
begin
  i:=0;
  while i<=lstStrings.Items.Count-1 do begin
    if lstStrings.Selected[i] then lstStrings.Items.Delete(i);
    inc(i);
  end;
end;

{
���������� ������� ������ ������ �� ������ lstStringsClick - �������� ��������� ���������.
���������:
Sender:TObject - ������-����������� �������
��������� ����������:
x:TStrArray - ������������ ������ �����
str:string - ������ ��� ������ �����
}
procedure TfrmMain.lstStringsClick(Sender: TObject);

var x:TStrRecArray; str:TSrcRecArray;  i:Integer;
begin
  str:=InputString;
  setlength(x,length(str));
  try
    for i:=0 to length(str)-1 do begin
      x[i].groups:=getGroups(str[i].str);
      x[i].lineNum:=str[i].num;
    end;
    Output(x);
    setlength(x,0);x:=NIL;
  except
    on EOutOfMemory do
      MessageDlg('������ ��������� ������!',mtError,[mbOK],0);
  end;

end;
{
������� InputString - ��������� ������ ��� ������ � ��� ����� �� ����� � ������ 
� ������ ����������� ��������.
���������� ��������� ������.
}
function TfrmMain.InputString:TSrcRecArray;
var x:TSrcRecArray; k,i:Integer;
begin
  setlength(x,lstStrings.SelCount);
  k:=0;
  for i:=0 to lstStrings.Items.Count-1 do
    if lstStrings.Selected[i] then begin
      x[k].num:=i;
      x[k].str:=lstStrings.Items[i];
      inc(k);
    end;
  result:=x;

end;

{
��������� Output - ����� ����� �� ����� � ������
� ������ ����������� �������� �� �����.
���������:
x:TStrArray - ������������ ������ �����
��������� ����������:
i:integer - ����������-�������
}
procedure TfrmMain.Output(x:TStrRecArray);
var i,j:integer;
begin
  lblResult.Text:= '';
  for j:=0 to length(x)-1 do begin
    lblResult.Text:=lblResult.Text+'������ �'+inttostr(x[j].linenum+1) +#13#10;
    if x[j].groups<>NIL then
    for i:=0 to (length(x[j].groups)-1) do
      lblResult.Text:= lblResult.Text+x[j].groups[i]+#13#10
    else  lblResult.Text:=lblResult.Text+'��� ������ �����!'+#13#10;
    lblResult.Text:=lblResult.Text+'-----------------'+#13#10;
  end;
end;
end.

