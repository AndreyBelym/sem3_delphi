unit UnitMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ImgList, ComCtrls, ToolWin, StdCtrls, Grids,UnitDlg;

type
  TRoute=record
    Number:Word;
    BusType:String[25];
    Source:String[50];
    Destination:String[50];
    OutTime,InTime:TDateTime;
  end;
  TRouteTable=array of TRoute;
  TIndexArray=array of Integer;
  TRequest=record
      Mask:byte;
      Data:TRoute;
  end;
  TVisualFilter=record
    check:TCheckBox;
    case ControlType:(ComboBox,DateTimePicker) of
      DateTimePicker:(
        datetime:TDateTime;);
      Combobox:(
        combo:TListBox;);
  end;

  THackStringGrid = class(TStringGrid);
  TfrmMain = class(TForm)
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ImageList1: TImageList;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    GroupBox1: TGroupBox;
    DateTimePicker1: TDateTimePicker;
    DateTimePicker2: TDateTimePicker;
    GroupBox2: TGroupBox;
    StringGrid1: TStringGrid;
    ComboBox2: TComboBox;
    ComboBox1: TComboBox;
    ComboBox3: TComboBox;
    ComboBox4: TComboBox;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    CheckBox6: TCheckBox;
    Button1: TButton;
    Button2: TButton;
    DateTimePicker3: TDateTimePicker;
    DateTimePicker4: TDateTimePicker;
    Button3: TButton;
    procedure StringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure CheckBox1Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
    procedure CheckBox4Click(Sender: TObject);
    procedure CheckBox5Click(Sender: TObject);
    procedure CheckBox6Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button3Click(Sender: TObject);

  private
    { Private declarations }

  public
    { Public declarations }
  end;


var
  frmMain: TfrmMain;
  lastRow:Integer=1;
  lastCol:Integer=0;
  wasDeleted:Boolean=False;
  timetable:TRouteTable;
  index:TIndexArray;
implementation

{$R *.dfm}

procedure TfrmMain.StringGrid1SelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  if wasDeleted then wasDeleted:=False else begin
   MessageDlg('PrevCell:'+inttostr(lastRow)+','+inttostr(lastCol),mtInformation,[mbok],0);
   if (ACol=4) or (Acol=5) then
      if dlgChooseDT.ShowModal=mrOk then begin

        if ((Acol=5) and (StringGrid1.Cells[Acol-1,ARow]<>'') and
          (strtoDateTime(StringGrid1.Cells[Acol-1,ARow])>=dlgChooseDT.Selected))
          or
           ((Acol=4) and (StringGrid1.Cells[Acol+1,ARow]<>'') and
          (strtoDateTime(StringGrid1.Cells[Acol+1,ARow])<=dlgChooseDT.Selected))
          then
            MessageDlg('TIME PARADOX!',mtError,[mbok],0)
          else begin
            StringGrid1.Cells[Acol,ARow]:=
              copy(DateTimeToStr(dlgChooseDT.Selected),1,length(DateTimeToStr(dlgChooseDT.Selected))-3);
          end;
      end;
  end;
  lastCol:=ACol;lastRow:=ARow;
end;

procedure TfrmMain.CheckBox1Click(Sender: TObject);
begin
   ComboBox1.Enabled:=CheckBox1.Checked;
end;

procedure TfrmMain.CheckBox2Click(Sender: TObject);
begin
  ComboBox2.Enabled:=CheckBox2.Checked;
end;

procedure TfrmMain.CheckBox3Click(Sender: TObject);
begin
  ComboBox3.Enabled:=CheckBox3.Checked;
end;

procedure TfrmMain.CheckBox4Click(Sender: TObject);
begin
  ComboBox4.Enabled:=CheckBox4.Checked;
end;

procedure TfrmMain.CheckBox5Click(Sender: TObject);
begin
  DateTimePicker1.Enabled:=CheckBox5.Checked;
  DateTimePicker3.Enabled:=CheckBox5.Checked;
end;

procedure TfrmMain.CheckBox6Click(Sender: TObject);
begin
  DateTimePicker2.Enabled:=CheckBox6.Checked;
  DateTimePicker4.Enabled:=CheckBox6.Checked;
end;

procedure TfrmMain.Button2Click(Sender: TObject);
var i,j:Integer;
begin

  for i:=StringGrid1.Selection.Top to StringGrid1.Selection.Bottom do begin
    wasDeleted:=True;
   THackStringGrid(StringGrid1).DeleteRow(i);
  end;
end;

procedure TfrmMain.Button1Click(Sender: TObject);
 var sel:TGridRect; cansel:Boolean;
begin
  StringGrid1.RowCount:=StringGrid1.RowCount+1;
  cansel:=True;
  with  sel do begin
  Top:=StringGrid1.RowCount-1;
  Bottom:=Top;
  Left:=0;Right:=0;
  end;
  StringGrid1.Selection:=sel;
  StringGrid1SelectCell(Sender,0,StringGrid1.RowCount-1,cansel);
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  StringGrid1.Cells[0,0]:='№';StringGrid1.ColWidths[0]:=30;
  StringGrid1.Cells[1,0]:='Тип автобуса';StringGrid1.ColWidths[1]:=90;
  StringGrid1.Cells[2,0]:='Пункт отправления';StringGrid1.ColWidths[2]:=120;
  StringGrid1.Cells[3,0]:='Пункт назначения';StringGrid1.ColWidths[3]:=115;
  StringGrid1.Cells[4,0]:='Дата отправления';StringGrid1.ColWidths[4]:=120;
  StringGrid1.Cells[5,0]:='Дата прибытия';StringGrid1.ColWidths[5]:=120;
end;

function Filter(table:TRouteTable;request:TRequest):TindexArray;
var x:TIndexArray; i:Integer;
begin
for i:=0 to high(table) do begin
  
end;
end;
procedure TfrmMain.Button3Click(Sender: TObject);
var req:TRequest;
procedure GenRequest;
begin
  req.Mask:=0;
  if CheckBox1.Checked then begin
     req.Mask:=req.Mask+$1;
     req.data.number:=strtoint(Combobox1.Text);
  end;
  if CheckBox2.Checked then begin
     req.Mask:=req.Mask+$2;
     req.data.BusType:=Combobox2.Text;
  end;
  if CheckBox3.Checked then begin
     req.Mask:=req.Mask+$4;
     req.data.Source:=Combobox3.Text;
  end;
  if CheckBox4.Checked then begin
     req.Mask:=req.Mask+$8;
     req.data.Destination:=Combobox4.Text;
  end;
  if CheckBox5.Checked then begin
     req.Mask:=req.Mask+$16;
     DateTimePicker3.Date:=DateTimePicker1.Date;
     req.data.OutTime:=DateTimePicker3.DateTime;
  end;
  if CheckBox6.Checked then begin
     req.Mask:=req.Mask+$32;
     DateTimePicker4.Date:=DateTimePicker2.Date;
     req.data.OutTime:=DateTimePicker4.DateTime;
  end;
end;
begin
   GenRequest;
   index:=Filter(timetable,req);
   UpdateGrid;
end;

end.
