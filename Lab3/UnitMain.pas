unit UnitMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls;

type
  DDArray=Array of array of Double;
  TfrmMain = class(TForm)
    sgdArray: TStringGrid;   //таблица - элементы массива,
    btnRun: TButton; //кнопка запуска
    btnAddCol: TButton; //кнопка добавления столбца
    btnDelCol: TButton; //кнопка добавления столбца
    btnDelRow: TButton; //кнопка добавления столбца
    btnAddRow: TButton; //кнопка добавления столбца
    grpResult: TGroupBox;// группа вывода результата
    lblResult: TLabel;   // поле вывода результата
    lblInfo: TLabel;     // информация о программе
    procedure btnRunClick(Sender: TObject);
    procedure btnAddRowClick(Sender: TObject);
    procedure btnDelRowClick(Sender: TObject);
    procedure btnDelColClick(Sender: TObject);
    procedure btnAddColClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    function Input(var a:DDArray):boolean;
    procedure Output(const k:Integer);
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation
(*
Функция GetSpec для расчета количества ``особых чисел'' в массиве, т.е. таких,
которые больше суммы остальных элементов строки.
Возвращает количество ``особых'' чисел.
Параметры:
a - массив для поиска особых элементов
Локальные переменные:
i,j - переменные-счетчики для доступа к элементам массива,
n,m - кол-во строк и столбцов массива
k - кол-во особых чисел в массиве
s - сумма элементов текущей строки
*)
function GetSpec(const a:DDArray):Integer;
var n,m,k,i,j:Integer; s:Double;
begin
  k:=0;
  n:=length(a);m:=length(a[0]);
  for j:=0 to m-1 do begin
    s:=0;
    for i:=0 to n-1 do
       s:=s+a[i,j];
    for i:=0 to n-1 do  begin
    MessageDlg(floattostr(i),mtError,[mbOK],0)  ;
      if (a[i,j]>s-a[i,j]) then
        inc(k);
    end;
  end;
  GetSpec:=k;
end;

(*
Функция Input - вводит данные для поиска количества особых чисел матрицы.
Возвращает True, если операция прошла успешно, иначе возвращает False.
Параметры:
a - массив для поиска особых элементов
Локальные переменные:
i,j - переменные-счетчики для доступа к элементам массива,
n,m - кол-во строк и столбцов массива
errors - список информации о возникших ошибках I/O.
*)
function TfrmMain.Input(var a:DDArray):boolean;
var i,j,n,m:Integer;  errors:String;
begin
  n:=sgdArray.RowCount;m:=sgdArray.ColCount;
  SetLength(a,sgdArray.RowCount-1,sgdArray.ColCount-1);
  i:=0;
  if a<>NIL then
    while (i<n)and(a[i]<>NIL) do
        inc(i);
    if i<>n then
        errors:=errors+'Ошибка выделения памяти!'+#13#10;
  if errors='' then
      for i:= 1 to n-1 do
        for j:=1 to m-1 do
          try
            a[i-1][j-1]:=StrToFloat(sgdArray.Cells[j,i])
          except
            on EConvertError do
              errors:=errors+'Ошибка при чтении ячейки ['+
                          IntToStr(i)+','+IntToStr(j)+']!'+#13#10;
          end;
  if errors<>'' then begin
     Input:=False;
     MessageDlg('Ошибки:'+errors,mtError,[mbOK],0)
  end else Input:=True;
end;

(*
Процедура Output для вывода количества особых чисел на форму.
Параметры:
k - кол-во особых чисел
*)
procedure TfrmMain.Output(const k:Integer);
begin
  lblResult.Caption:= '"Особых" элементов:'+IntToStr(k);
end;
{$R *.dfm}
(*
Процедура btnRunClick - основная процедура программы расчета кол-ва особых значений.
Локальные переменные:
a - массив для поиска особых элементов
k - кол-во особых чисел
*)
procedure TfrmMain.btnRunClick(Sender: TObject);
var a:DDArray;k:Integer;
begin
  if Input(a) then begin
    k:=GetSpec(a);
    Output(k);
  end;
end;

procedure TfrmMain.btnAddRowClick(Sender: TObject);
begin
  with sgdArray do begin
    RowCount:=RowCount+1;
    Cells[0,RowCount-1]:=intToStr(RowCount-1);
  end;
end;

procedure TfrmMain.btnDelRowClick(Sender: TObject);
begin
  with sgdArray do begin
    RowCount:=RowCount-1;
  end;
end;

procedure TfrmMain.btnDelColClick(Sender: TObject);
begin
  with sgdArray do begin
    ColCount:=ColCount-1;
  end;
end;

procedure TfrmMain.btnAddColClick(Sender: TObject);
begin
  with sgdArray do begin
    ColCount:=ColCount+1;
    sgdArray.Cells[ColCount-1,0]:=intToStr(ColCount-1);
  end;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
var i:integer;
begin
 for i:=1 to 2 do begin
    sgdArray.Cells[0,i]:=intToStr(i);
    sgdArray.Cells[i,0]:=intToStr(i);
 end;
end;


end.
