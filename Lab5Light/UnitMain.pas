unit UnitMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ImgList, ComCtrls, ToolWin, StdCtrls, Grids,UnitDlg,UnitFolders;

type
  TRoute=record  //�������
    Number:Word;  //����� ��������
    BusType:String[25]; //��� ��������
    Destination:String[50]; //����� ����������
    OutTime,InTime:TDateTime; //����� ������ � ��������
  end;
  TRouteTable=array of TRoute; //���������� ���������
  TIndexArray=array of Integer; //��������� ������ ����������

  THackStringGrid = class(TStringGrid); //������� � ���������� ��������� ��������
  TfrmMain = class(TForm) //�������� �����
    tlbFileOps: TToolBar; //������ ������������
    tbtNew: TToolButton;  //������ ������ "������� ����������"
    imlToolbar: TImageList;  //������ ����������� ��� ������
    tbtOpen: TToolButton; //������ ������ "������� ����������"
    tbtSave: TToolButton; //������ ������ "��������� ����������"
    grpFilter: TGroupBox;  //������ �������� ����������
    dtpDate: TDateTimePicker;  //����� ����
    grpTimeTable: TGroupBox;  //������ ��������, ������������ ����������
    sgdTimetable: TStringGrid; //������� ����������
    btnAddLine: TButton; //������ "�������� ������"
    btnDelLine: TButton; //������ "������� ������"
    dtpTime: TDateTimePicker; //����� �������
    btnFilter: TButton;  //������ "�������������"
    btnNoFilter: TButton;  //������ "�������� ������"
    sdgSaveFile: TSaveDialog; //������ ���������� �����
    odgOpenFile: TOpenDialog; //������ �������� �����
    lblInfoDate: TLabel; //�������-�������� � ������ ����
    lblInfoDest: TLabel;  //�������-�������� � ������ ������ ����������
    edtDestination: TEdit; //���� ������ ����������
    lblProgInfo: TLabel; //���������� � ���������
    btnSaveFiltered: TButton;
    ToolButton1: TToolButton;  //������ ���������� ����������� ����������

    //���������� ������� ������ �������� ������
    procedure btnDelLineClick(Sender: TObject);
    //���������� ������� ������ ���������� ������
    procedure btnAddLineClick(Sender: TObject);
    //���������� ������� �������� �����
    procedure FormCreate(Sender: TObject);
    //���������� ������� ������ ����������
    procedure btnFilterClick(Sender: TObject);
    //����� ���������� ������� �� ����������
    procedure UpdateGrid;
    //����� ���������� ���������� �� �������
    procedure updatetable;
    //���������� ������� ������ ������ ����������
    procedure btnNoFilterClick(Sender: TObject);
    //���������� ������� ������ �������� ����������
    procedure tbtNewClick(Sender: TObject);
    //���������� ������� ������ ���������� ����������
    procedure tbtSaveClick(Sender: TObject);
    //���������� ������� ������ �������� ����������
    procedure tbtOpenClick(Sender: TObject);
    //���������� ���������� ������� ���� �� �������
    procedure sgdTimetableMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    //���������� ������� ������ ���������� ��������������� ���������
    procedure btnSaveFilteredClick(Sender: TObject);
    //���������� ������� ����������� �����
    procedure FormDestroy(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);

  private
    { Private declarations }

  public
    { Public declarations }
  end;

//��������� ������ ���������� �� �����
procedure ReadFromFile(filename:string;var timetable:TRouteTable;
                          var index:TIndexArray);

//��������� ���������� ���������
function Filter(table:TRouteTable;date:TDateTime;dest:String):TindexArray;

//��������� ���������� ���������� � ����
procedure SaveToFile(filename:string; timetable:tRouteTable; index:TIndexArray);

var
  frmMain: TfrmMain;   //�������� �����
  timetable:TRouteTable;  //���������� ���������
  index:TIndexArray;  //��������� ������ ����������
implementation
(*
��������� ReadFromFile ��������� �� ����� � ������ filename ���������� timetable
� ������� ��������� ������ index.
����� ���������� ���������� � ������ ������������� ������.
���������:
filename:string - ��� ����� ��� ������;
var timetable:TRouteTable - ���������� ���������
var index:TIndexArray - ��������� ������ ����������
��������� ����������:
f:file of TRoute - ���� ��� ������
i:Integer - ������� ��� ��������� ��������
*)
procedure ReadFromFile(filename:string;var timetable:TRouteTable;
                        var index:TIndexArray);
var f:file of TRoute; i:Integer;
begin
  AssignFile(f,filename);
    Reset(f);
  try
    setlength(timetable,filesize(f));
    For i:=0 to high(timetable) do
      Read(f,timetable[i]);

  setlength(index,length(timetable));
  for i:=0 to high(timetable) do
    index[i]:=i;
  finally CloseFile(f);
  end;
end;
(*
������� Filter ��������������� � ���������� table ��������, ����������
� ����� dest ������ ���� date. ���������� ������� ����� ���������.
����� ���������� ���������� � ������ ������������� ������.
���������:
table:TRouteTable - ���������� ���������
date:TDateTime  - ������������ ���� ��������
dest:String - ��� ������ ����������
��������� ����������:
x:TIndexArray - ��������� ��������
i,k:Integer - �������� ��� ��������� ��������
*)
function Filter(table:TRouteTable;date:TDateTime;dest:String):TindexArray;
var x:TIndexArray; i,k:Integer;
begin
x:=nil;
k:=0;
for i:=0 to high(table) do begin
   if (table[i].Intime<=date) and ((dest='') or (dest=table[i].Destination))
   then begin
      setlength(x,k+1);
      x[k]:=i;
      inc(k);
   end;
end;
result:=x;
end;
(*
��������� SaveToFile ��������� � ���� � ������ filename ������ �� ����������
timetable � �������� �� ������� index.
����� ���������� ���������� � ������ ������������� ������.
���������:
filename:string - ��� ����� ��� ������
timetable:tRouteTable - ���������� ���������
index:TIndexArray - ������ ����� ���������� ��� ������
��������� ����������:
f:file of TRoute  - ���� ��� ������
i:Integer - ������� ��� ��������� ��������
*)
procedure SaveToFile(filename:string; timetable:tRouteTable; index:TIndexArray);
var f:file of TRoute; i:Integer;
begin
  Assign(f,filename);
  Rewrite(f);
  try
    for i:=0 to length(index)-1 do
      Write(f,timetable[index[i]]);
  finally CloseFile(f);
  end;
end;
{$R *.dfm}
(*
*)
procedure DeleteIndex(var anArray:TIndexArray; const aPosition:integer);
var
   lg, j : integer;
begin
   lg := length(anArray);
   if aPosition > lg-1 then
     exit
   else if aPosition = lg-1 then begin
           Setlength(anArray, lg -1);
           exit;
        end;
   for j := aPosition to lg-2 do
     anArray[j] := anArray[j+1]-1;
   SetLength(anArray, lg-1);

end;
(*
*)
procedure DeleteRoute(var anArray:TRouteTable; const aPosition:integer);
var
   lg, j : integer;
begin   
   lg := length(anArray);
   if aPosition > lg-1 then 
     exit
   else if aPosition = lg-1 then begin
           Setlength(anArray, lg -1);
           exit;
        end; 
   for j := aPosition to lg-2 do
     anArray[j] := anArray[j+1];
   SetLength(anArray, lg-1);

end;
procedure TfrmMain.updatetable;
var i,j,k:integer; errors:string; next:Boolean;
begin
  errors:='';
  for i:=1 to sgdTimetable.RowCount-1 do
    for j:=0 to sgdTimetable.ColCount-1 do
  try
   case j of
    0: begin
      for k:=1 to  sgdTimetable.RowCount-1 do
        if (strtoint(sgdTimetable.Cells[j,i])=strtoint(sgdTimetable.Cells[j,k]))
         and (i<>k)
           then raise EConvertError.Create('�������� ��������!');
         timetable[index[i-1]].Number:=strtoint(sgdTimetable.Cells[j,i]);
    end;
    1:if sgdTimetable.Cells[j,i]<> '' then
      timetable[index[i-1]].BusType:=sgdTimetable.Cells[j,i]
    else raise EConvertError.Create('������ ������!');
    2:if sgdTimetable.Cells[j,i]<> '' then
        timetable[index[i-1]].destination:=sgdTimetable.Cells[j,i]
      else raise EConvertError.Create('������ ������!');
    3:begin
      try
        strtoDateTime(sgdTimetable.Cells[j+1,i]);
        next:=False
      except else
        next:=True;
      end;
      if not next and
          (strtoDateTime(sgdTimetable.Cells[j+1,i])<=
              strtoDateTime(sgdTimetable.Cells[j,i])) then
      raise EConvertError.Create('TIME PARADOX!') else

      timetable[index[i-1]].outtime:=strtodatetime(sgdTimetable.Cells[j,i])
    end;
    4:begin
      try
        strtoDateTime(sgdTimetable.Cells[j-1,i]);
        next:=False;
      except else
        next:=True;
      end;
      if not next and
          (strtoDateTime(sgdTimetable.Cells[j-1,i])>=
              strtoDateTime(sgdTimetable.Cells[j,i])) then
        raise EConvertError.Create('TIME PARADOX!') else
    timetable[index[i-1]].intime:=strtodatetime(sgdTimetable.Cells[j,i])
     end;
   end;
  except on E:EConvertError do
      errors:=errors+Format('������������ �������� � ������ [%d,%d]! '+e.
                                Message +#10#13,[i,j+1]);
  end;
  if errors<>'' then
    raise EConvertError.Create('������ ��� ���������� ����������:'+#10#13+errors);
end;

procedure TfrmMain.btnDelLineClick(Sender: TObject);
var i:Integer; x:boolean;
begin
 try
  x:=false;
  try
    if (sgdTimetable.Selection.Top=1) and
      (sgdTimetable.Selection.Bottom=sgdTimetable.RowCount-1) then x:=true;
    for i:=sgdTimetable.Selection.Top to sgdTimetable.Selection.Bottom do begin

      sgdTimetable.Rows[i].Clear;
      THackStringGrid(sgdTimetable).DeleteRow(i);
      DeleteRoute(timetable,index[i-1]);
      DeleteIndex(index,i-1);
    end;
  except else
    if (sgdTimetable.Selection.Top=1) and
      (sgdTimetable.Selection.Bottom=sgdTimetable.RowCount-1) then x:=true
    else begin
    setlength(timetable,
              sgdTimetable.RowCount+
              sgdTimetable.Selection.Top-
              sgdTimetable.Selection.Bottom-1);
    setlength(index,
              sgdTimetable.RowCount+
              sgdTimetable.Selection.Top-
              sgdTimetable.Selection.Bottom-1);
    end;
    for i:=sgdTimetable.Selection.Top to sgdTimetable.Selection.Bottom do
      THackStringGrid(sgdTimetable).DeleteRow(i);
  end;
  if x then
  begin

    sgdTimetable.RowCount:=sgdTimetable.RowCount+1;
    sgdTimetable.FixedRows:=1;
    setlength(timetable,length(timetable)+1);setlength(index,length(index)+1);
    index[high(index)]:=high(timetable);
  end;
 except else
  MessageDlg('������ �������� ������!',mtError,[mbOk],0);
  grpFilter.Enabled:=false;
    grpTimetable.Enabled:=false;
    tbtSave.Enabled:=False;
 end;
end;

procedure TfrmMain.btnAddLineClick(Sender: TObject);
 var sel:TGridRect;
begin
 try
  sgdTimetable.RowCount:=sgdTimetable.RowCount+1;
  sgdTimetable.Rows[sgdTimetable.RowCount-1].Clear;
  with  sel do begin
  Top:=sgdTimetable.RowCount-1;
  Bottom:=Top;
  Left:=0;Right:=0;
  end;
  setlength(timetable,length(timetable)+1);setlength(index,length(index)+1);
  index[high(index)]:=high(timetable);
  sgdTimetable.Selection:=sel;
 except else  MessageDlg('������ ���������� ������!',mtError,[mbOk],0);
 grpFilter.Enabled:=false;
    grpTimetable.Enabled:=false;
    tbtSave.Enabled:=False;
 end;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
 try
  sgdTimetable.Cells[0,0]:='�';sgdTimetable.ColWidths[0]:=30;
  sgdTimetable.Cells[1,0]:='��� ��������';sgdTimetable.ColWidths[1]:=90;
  sgdTimetable.Cells[2,0]:='����� ����������';sgdTimetable.ColWidths[2]:=115;
  sgdTimetable.Cells[3,0]:='���� �����������';sgdTimetable.ColWidths[3]:=120;
  sgdTimetable.Cells[4,0]:='���� ��������';sgdTimetable.ColWidths[4]:=120;
  setlength(timetable,1);setlength(index,1);
  index[0]:=0;
 except else MessageDlg('������ �������������!',mtError,[mbOk],0);
 grpFilter.Enabled:=false;
    grpTimetable.Enabled:=false;
    tbtSave.Enabled:=False;
 end;
end;



procedure  TfrmMain.UpdateGrid;
var i:integer;
begin
  if length(index)<>0 then begin
  sgdTimetable.RowCount:=length(index)+1;
  for i:=1 to length(index) do begin
     sgdTimetable.Cells[0,i]:= inttostr(timetable[index[i-1]].number);
     sgdTimetable.Cells[1,i]:= timetable[index[i-1]].BusType;
     sgdTimetable.Cells[2,i]:= timetable[index[i-1]].Destination;
     sgdTimetable.Cells[3,i]:=
            copy(datetimetostr(timetable[index[i-1]].OutTime),
              1,length(datetimetostr(timetable[index[i-1]].OutTime))-3);
     sgdTimetable.Cells[4,i]:=
            copy(datetimetostr(timetable[index[i-1]].inTime),1,
                 length(datetimetostr(timetable[index[i-1]].inTime))-3);
  end;
  end;
end;
procedure TfrmMain.btnFilterClick(Sender: TObject);
var deadline:TDateTime; dest:string;newindex:TIndexArray;
begin
  newindex:=nil;
  try
   dtpTime.Date:=dtpDate.Date;
   deadline:=dtpTime.DateTime;dest:=edtDestination.Text;
   updatetable;
   newindex:=Filter(timetable,deadline,dest);

   if length(newindex)=0 then
    MessageDlg('������ ���!',mtInformation,[mbok],0)
   else begin
    index:=nil;
    index:=newindex;
    newindex:=nil;
    UpdateGrid;
    btnNoFilter.Enabled:=True;
    btnSaveFiltered.Enabled:=True;
    btnAddLine.Enabled:=False;
   end;
  except on e:EConvertError do
      MessageDlg(e.Message,mtError,[mbok],0);
  else MessageDlg('������ ����������!',mtError,[mbOk],0);
  grpFilter.Enabled:=false;
    grpTimetable.Enabled:=false;
    tbtSave.Enabled:=False;
  end;
end;

procedure TfrmMain.btnNoFilterClick(Sender: TObject);
var i:integer;
begin
  try
  updatetable;
  setlength(index,length(timetable));
  for i:=0 to high(timetable) do
    index[i]:=i;

  UpdateGrid;
  try
    updatetable;
  except on e:EConvertError do
      MessageDlg(e.Message,mtWarning,[mbok],0);
  end;
  btnNoFilter.Enabled:=False;
  btnSaveFiltered.Enabled:=False;
  btnAddLine.Enabled:=True;
  except on e:EConvertError do
      MessageDlg(e.Message,mtError,[mbok],0);
  else MessageDlg('������ ����������!',mtError,[mbOk],0);
  grpFilter.Enabled:=false;
    grpTimetable.Enabled:=false;
    tbtSave.Enabled:=False;
  end;
end;

procedure TfrmMain.tbtNewClick(Sender: TObject);
var sel:TGridRect;
begin
 try
  with  sel do begin
  Top:=1;
  Bottom:=sgdTimetable.RowCount-1;
  Left:=0;Right:=0;
  end;
  sgdTimetable.Selection:=sel;
  btnDelLineClick(Sender);
  grpFilter.Enabled:=true;
    grpTimetable.Enabled:=true;
    tbtSave.Enabled:=true;
  btnNoFilter.Enabled:=False;
    btnSaveFiltered.Enabled:=False;
  except else MessageDlg('������ �������� ����������!',mtError,[mbOk],0);
  grpFilter.Enabled:=false;
    grpTimetable.Enabled:=false;
    tbtSave.Enabled:=False;
  end;
end;

procedure TfrmMain.tbtSaveClick(Sender: TObject);
var  i:Integer;  save:Boolean; allindex:TIndexArray;
begin
  try
  try
    updatetable;
    save:=true
  except on e:EConvertError do
      save:=MessageDlg(e.Message+
                        '���������� ����������?'+#10#13,
                          mtWarning,[mbok,mbcancel],0)=1;
  end;
  if save then
    if btnNoFilter.Enabled then
      save:=MessageDlg(
      '�� ������ �������� ���� ����� ����������!'+#10#13#10#13+
      '����� ���������� ���������� �� ������ ������������ ���� ����� ����������,'+
      #10#13+
      '������ � ���� ���������� ����� ���������� ���������.'+#10#13+
      '���������� ����������?'+#10#13,
      mtWarning,[mbok,mbcancel],0)=1;
  if save and sdgSaveFile.Execute then begin
      setlength(allindex,length(timetable));
      for i:=0 to length(timetable)-1 do
        allindex[i]:=i;
      SaveToFile(sdgSaveFile.FileName,timetable,allindex);
      allindex:=nil;
  end;
  except else
    MessageDlg('������ ������ � ����!',mtError,[mbOk],0);
  end;
end;

procedure TfrmMain.tbtOpenClick(Sender: TObject);
begin
  try
  if odgOpenFile.Execute then begin
    ReadFromFile(odgOpenFile.FileName,timetable,index);
    UpdateGrid;
    btnNoFilter.Enabled:=False;
    btnSaveFiltered.Enabled:=False;
    grpFilter.Enabled:=true;
    grpTimetable.Enabled:=true;
    tbtSave.Enabled:=true;
  end;
  except else
    MessageDlg('������ ������ �����!',mtError,[mbOk],0);
    grpFilter.Enabled:=false;
    grpTimetable.Enabled:=false;
    tbtSave.Enabled:=False;
  end;
end;

procedure TfrmMain.sgdTimetableMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  var acol,arow:integer;
begin
   sgdTimetable.MouseToCell(X,Y,acol,arow);
  if (ACol=3) or (Acol=4) then
      if dlgChooseDT.ShowModal=mrOk then begin
            sgdTimetable.Cells[Acol,ARow]:=
              copy(DateTimeToStr(dlgChooseDT.Selected),1,
                length(DateTimeToStr(dlgChooseDT.Selected))-3);
          end
      else THackStringGrid(sgdTimetable).EditorMode:=true;

end;

procedure TfrmMain.btnSaveFilteredClick(Sender: TObject);
var save:Boolean;
begin
  try
  try
    updatetable;
    save:=true
  except on e:EConvertError do
      save:=MessageDlg(e.Message+
                        '���������� ����������?'+#10#13,
                          mtWarning,[mbok,mbcancel],0)=1;
  end;
  if save and sdgSaveFile.Execute then begin
      SaveToFile(sdgSaveFile.FileName,timetable,index);
  end;
  except else
    MessageDlg('������ ������ � ����!',mtError,[mbOk],0);
  end;
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  TimeTable:=nil;
  Index:=Nil;
end;

procedure TfrmMain.ToolButton1Click(Sender: TObject);
begin
  dlgFolders.ShowModal;
end;

end.
