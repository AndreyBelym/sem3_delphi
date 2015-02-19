unit UnitMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ComCtrls;

type
  TConvertUnits=record //список типов величин
    Category:ShortString; //категория
    Units:array of ShortString; //наименования
  end;
  TUnitsTable=array of TConvertUnits;//таблица типов величин
  //тип функции перевода величин
  TConvertFunction=function (value:extended):extended; stdcall;
  //строка таблицы конвертации
  TConvertLine=record
    SrcUnit,DstUnit:ShortString;//исходный и требуемый типы
    ConvertFunc:TConvertFunction; //функция конвертации
  end;
  TConvertTable=array of TConvertLine; //таблица конвертации

  //тип функции экспорта таблицы типов из DLL
  UnitsTableExportFunc=function:TUnitsTable; stdcall;
  //тип функции экспорта таблицы конвертации из DLL
  ConvertTableExportFunc=function:TConvertTable;  stdcall;
  //тип функции сборки мусора из DLL
  GarbageCollectorFunc=procedure (var units:TUnitsTable;
              var convert:TConvertTable); stdcall;

  TfrmMain = class(TForm) //основная форма
    edtFstVal: TEdit;//первая величина
    edtSndVal: TEdit;//вторая величина
    memLog: TMemo;   //вывод результатов
    lblFstUnit: TLabel;//тип первой величины
    lblSndUnit: TLabel;//тип второй величины
    imgFstTrash: TImage;//мусорная корзина 1
    imgSndTrash: TImage;//мусорная корзина 2
    cbxCategory: TComboBox;//выбор категории типов
    sbxUnits: TScrollBox;//единицы измерения
    lblInfo: TLabel;     //информация о программе
    bvlFstBevel: TBevel; //рамка вокруг единицы измерения
    bvlSndBevel: TBevel; //рамка вокруг единицы измерения
    btnEqu: TButton;     //кнопка "равно"

    //обработчик "сбрасывания" в поле единиц измерения
    procedure lblFstUnitDragDrop(Sender, Source: TObject; X, Y: Integer);
    //обработчик "попадания" в поле единиц измерения
    procedure lblFstUnitDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    //обработчик "сбрасывания" в мусорную корзину
    procedure imgFstTrashDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    ////обработчик "попадания" в мусорную корзину
    procedure imgFstTrashDragDrop(Sender, Source: TObject; X, Y: Integer);
    //обработчик нажатий клавиатуры в поле ввода величин
    procedure edtFstValKeyPress(Sender: TObject; var Key: Char);
    //обработчик выбора категорий типов
    procedure cbxCategorySelect(Sender: TObject);
    //обработчик создания формы
    procedure FormCreate(Sender: TObject);
    //обработчик разрушения формы
    procedure FormDestroy(Sender: TObject);
    //обработчик нажатия кнопки "равно"
    procedure btnEquClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
var
  frmMain: TfrmMain; //основная форма
  ConvertTable:tconverttable; //таблица конвертации
  UnitsTable:TUnitsTable; //таблица единиц измерения
  LoadedLibraries:array of Cardinal; //список подключенных DLL
implementation

(*
Функция GetConvFunction получает из таблицы ConvTable для единиц измерения
SrcUnit(исходный тип) и DstUnit(целевой тип) функцию конвертации ConvFunc.
Если функция найдена, возвращает True, в противном случае возвращает False.
Параметры
ConvTable:array of TConvertLine - таблица конвертации
SrcUnit,DstUnit:ShortString - исходный тип и целевой тип конвертации
var ConvFunc:TConvertFunction - функция конвертации
Локальные переменные
i:LongInt - счетчик для обработки массива
*)
function GetConvFunction(ConvTable:array of TConvertLine;
          SrcUnit,DstUnit:ShortString;
            var ConvFunc:TConvertFunction):Boolean;
var i:LongInt;
begin
   Result:=False;
   for i:=low(ConvTable) to HIGH(ConvTable) do
    if (SrcUnit=ConvTable[i].SrcUnit) and (DstUnit=ConvTable[i].DstUnit) then
    begin
      ConvFunc:=ConvTable[i].ConvertFunc;
      Result:=True;
    end;
end;
{$R *.dfm}

procedure TfrmMain.lblFstUnitDragDrop(Sender, Source: TObject; X, Y: Integer);
var DragLabel:TLabel;temp:string;
begin
  try
    if (TLabel(Sender).Name='lblFstUnit') and (TLabel(Source).Name='lblSndUnit')
          or
       (TLabel(Sender).Name='lblSndUnit') and (TLabel(Source).Name='lblFstUnit')
    then begin
      temp:=TLabel(Sender).Caption;
      TLabel(Sender).Caption:=TLabel(Source).Caption;
      TLabel(Source).Caption:=temp;
    end
    else begin
      DragLabel:=TLabel(Source);
      TLabel(Sender).Caption:=DragLabel.Caption;
    end;
  except;
  end;
end;

procedure TfrmMain.lblFstUnitDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
begin
  Accept:=Source is TLabel;
end;
procedure TfrmMain.imgFstTrashDragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
  try
    if (TLabel(Source).Name='lblFstUnit') or (TLabel(Source).Name='lblSndUnit') then
      Accept:=True
    else Accept:=False;
  except else Accept:=False;
  end;
end;

procedure TfrmMain.imgFstTrashDragDrop(Sender, Source: TObject; X, Y: Integer);
begin
  TLabel(Source).Caption:='';
end;

procedure TfrmMain.edtFstValKeyPress(Sender: TObject; var Key: Char);
var Master,Slave:TEdit; MUnit,SUnit:String; ConvFunc:TConvertFunction;
begin
  If Key=#13 then begin
    Master:=TEdit(Sender);
    if Master.Name='edtFstVal' then begin
       Slave:=edtSndVal; MUnit:=lblFstUnit.Caption; SUnit:=lblSndUnit.Caption;
    end else if  Master.Name='edtSndVal' then begin
       Slave:=edtFstVal; MUnit:=lblSndUnit.Caption; SUnit:=lblFstUnit.Caption;
    end else raise EComponentError.Create('Unkown component!');
    try
      strtofloat(Master.Text);
      if (MUnit<>'') and (SUnit<>'') then begin
        if MUnit=SUnit then begin
          slave.Text:=Master.Text;
          memLog.Lines.Add(edtFstVal.Text+lblFstUnit.Caption+' = '+
                                  edtSndVal.Text+lblSndUnit.Caption);
        end else
        if GetConvFunction(ConvertTable,MUnit,SUnit,ConvFunc) then begin
          Slave.Text:=floattostr(ConvFunc(strtofloat(Master.Text)));
          memLog.Lines.Add(edtFstVal.Text+lblFstUnit.Caption+' = '+
                          edtSndVal.Text+lblSndUnit.Caption);
        end else MessageDlg('Неизвестно, как перевести '+MUnit+' в '+SUnit+'.',
                                            mtInformation,[mbok],0);
      end;
    except on EConvertError do
        MessageDlg('Неправильное значение!', mtInformation,[mbok],0);
  end;
end;end;

procedure TfrmMain.cbxCategorySelect(Sender: TObject);
var i,j:Cardinal; newlabel:TLabel;
begin
   for i:=0 to length(UnitsTable)-1 do
    if UnitsTable[i].Category=cbxCategory.Text then begin
      while sbxUnits.ControlCount<>0 do
        sbxUnits.Controls[0].Destroy;
      for j:= low(UnitsTable[i].Units) to high(UnitsTable[i].Units) do
  begin
     newlabel:=TLabel.Create(sbxUnits);
     newlabel.AutoSize:=true;
     Newlabel.Align:=alLeft;
     NewLabel.DragMode:=dmAutomatic;
     newlabel.Font.Size:=14;
     newlabel.Alignment:=taCenter;
     newlabel.Layout:=tlCenter;
     newlabel.Caption:=UnitsTable[i].Units[j];
     newlabel.Parent:=sbxUnits;

     newlabel:=TLabel.Create(sbxUnits);
     newlabel.AutoSize:=true;
     Newlabel.Align:=alLeft;
     newlabel.Font.Size:=14;
     newlabel.Alignment:=taCenter;
     newlabel.Layout:=tlCenter;
     newlabel.Caption:='  ';
     newlabel.Parent:=sbxUnits;
  end;
  end;
end;

(*
Процедура ConnectDLL подключает библиотеку DllName и
импортирует таблицы единиц измерений и конвертации.
Параметры
DllName:PChar - путь к библиотеке
Локальные переменные
Handle:Cardinal - дескриптор библиотеки
NewUnits:TUnitsTable - импортированная таблица типов
NewConvert:TConvertTable - импортированная таблица конвертации
UExport:UnitsTableExportFunc - функция импорта таблицы типов
CExport:ConvertTableExportFunc - функция импорта таблицы конвертации
GCollect:GarbageCollectorFunc - функция сборки мусора
i,j,k,m:LongInt - счетчики для обработки массивов;
l1,l2:LongInt - размеры существующей и импортированной таблиц конвертации;
l1u,l2u:LongInt - размер существующего списка типов и импортированного;
appended,exist:boolean - флаги наличия импортируемых данных в таблицах;
*)
procedure ConnectDLL(DllName:PChar);
var Handle:Cardinal;
var NewUnits:TUnitsTable; NewConvert:TConvertTable;
var UExport:UnitsTableExportFunc;
  CExport:ConvertTableExportFunc;
  GCollect:GarbageCollectorFunc;
var i,j,k,m,l1,l2,l1u,l2u:LongInt;
    appended,exist:boolean;
begin
newUnits:=nil;newConvert:=nil;
Handle:=LoadLibrary(DllName);
if Handle = 0 then
  begin
    raise EAccessViolation.Create('Ошибка подключения библиотеки '+DllName) ;
  end;
@UExport:=GetProcAddress(Handle,'ExportUnitsTable');
if @UExport=nil then
     raise EAccessViolation.Create('Ошибка подключения библиотеки '+DllName) ;
NewUnits:=UExport;

l2:=length(NewUnits);
for i:= 0 to l2-1 do begin
  l1:=length(UnitsTable); appended:=false;
  for j:=0 to l1-1 do
    if UnitsTable[j].Category=NewUnits[i].Category then begin


      l2u:=length(NewUnits[i].Units);
      for k:= 0 to l2u-1 do begin
          l1u:=length(UnitsTable[j].Units);  exist:=false;
          for m:=0 to l1u-1 do
            if UnitsTable[j].Units[M]=NewUnits[i].Units[k] then
               exist:=true;
          if not exist then begin
            inc(l1u);setlength(UnitsTable[j].Units,l1u);
            UnitsTable[j].Units[l1u-1]:=NewUnits[i].Units[k];
          end;
      end;
      appended:=true;
    end;
  if not appended then begin
    inc(l1);setlength(UnitsTable,l1);
    UnitsTable[l1-1].Category:=NewUnits[i].Category;
    setlength(UnitsTable[l1-1].Units,length(NewUnits[i].Units));
    For j:=0 to length(NewUnits[i].Units)-1 do
    UnitsTable[l1-1].Units[j]:=NewUnits[i].Units[j];
  end;
end;

@CExport:=GetProcAddress(Handle,'ExportConvertTable');
if @CExport=nil  then
     raise EAccessViolation.Create('Ошибка подключения библиотеки '+DllName) ;
NewConvert:=CExport;


l2:=length(NewConvert);
for i:=0 to l2-1 do begin
  l1:=length(ConvertTable); exist:=false;
  for j:=0 to l1-1 do
    if (ConvertTable[j].DstUnit=NewConvert[i].DstUnit)
       and (ConvertTable[j].SrcUnit=NewConvert[i].SrcUnit) then
        exist:=true;
  if not exist then begin
    inc(l1);setlength(ConvertTable,l1);
    ConvertTable[l1-1].SrcUnit:=NewConvert[i].SrcUnit;
    ConvertTable[l1-1].DstUnit:=NewConvert[i].DstUnit;
    ConvertTable[l1-1].ConvertFunc:=NewConvert[i].ConvertFunc;
  end;
end;
@GCollect:=GetProcAddress(Handle,'CollectGarbage');
if @GCollect=nil then
     raise EAccessViolation.Create('Ошибка подключения библиотеки '+DllName) ;
for i:= 0 to length(newunits)-1 do
      newunits[i].Units:=NIL;
GCollect(NewUnits,NewConvert);
SetLength(LoadedLibraries,length(LoadedLibraries)+1);
LoadedLibraries[0]:=Handle;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
var i:Longint;
  search:TSearchRec;
begin
if FindFirst('*.dll',0,search)=0 then begin
  try
    ConnectDLL(PChar(search.name));
  except else MessageDlg('Попытка подключения библиотеки '+
                      search.name+' неудачна!',mtWarning,[mbok],0);
  end;
  While FindNext(search)=0 do begin
    try
      ConnectDLL(PChar(search.name));
    except  else MessageDlg('Попытка подключения библиотеки '+
                            search.name+' неудачна!',mtWarning,[mbok],0);
    end;
  end;
  FindClose(search);
end;
if length(UnitsTable)<>0 then begin
for i:=0 to length(UnitsTable)-1 do
  cbxCategory.Items.Add(UnitsTable[i].Category);
cbxCategory.ItemIndex:=0;
cbxCategorySelect(cbxCategory);
end;
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
var i:longint;
begin
  for i:=0 to length(UnitsTable)-1 do
    UnitsTable[i].Units:=nil;

  UnitsTable:=nil;
  while sbxUnits.ControlCount<>0 do
        sbxUnits.Controls[0].Destroy;
  SetLength(ConvertTable,0);
  for i:= 0 to length(LoadedLibraries)-1 do
    FreeLibrary(LoadedLibraries[i]);
  LoadedLibraries:=NIL;
end;

procedure TfrmMain.btnEquClick(Sender: TObject);
var PseudoKey:Char;
begin
  PseudoKey:=#13;
  edtFstValKeyPress(edtFstVal,PseudoKey);
end;

end.
