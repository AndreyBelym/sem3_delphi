library energy;

uses
  SysUtils,
  Classes,
  Dialogs;

{$R *.res}
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

(*
Процедура CollectGarbage освобождает память из-под таблицы
единиц измерения units и таблицы конвертации convert.
*)
procedure CollectGarbage(var units:TUnitsTable;
                  var convert:TConvertTable); stdcall;
begin
   units:=NIL;
   convert:=NIL;
end;

(*
Функция ExportUnitsTable возвращает экспортируемую библиотекой
таблицу единиц измерения.
*)
function ExportUnitsTable:TUnitsTable; stdcall;
begin
  setlength(Result,1);
  Result[0].Category:='Энергия';
  setlength(Result[0].Units,4);
  Result[0].Units[0]:='Дж';
  Result[0].Units[1]:='кал.';
  Result[0].Units[2]:='эВ';
  Result[0].Units[3]:='Вт*ч';
end;

function JtoWh(value:extended):extended;  stdcall;
begin
  Result:=1/3600*value;
end;
function WhtoJ(value:extended):extended; stdcall;
begin
  Result:=3600*value;
end;

function eVtoJ(value:extended):extended; stdcall;
begin
  Result:=value/6.241e18;
end;
function JtoeV(value:extended):extended; stdcall;
begin
  Result:=6.241e18*value;
end;

function caltoJ(value:extended):extended; stdcall;
begin
  Result:=value/0.239;
end;
function Jtocal(value:extended):extended; stdcall;
begin
  Result:=0.239*value;
end;
////////////////////
function WhtoeV(value:extended):extended; stdcall;
begin
  Result:=2.247e22*value;
end;
function eVtoWh(value:extended):extended; stdcall;
begin
  Result:=value/2.247e22;
end;

function Whtocal(value:extended):extended; stdcall;
begin
  Result:=859.8*value;
end;
function caltoWh(value:extended):extended; stdcall;
begin
  Result:=value/859.8;
end;
/////////////////
function eVtocal(value:extended):extended; stdcall;
begin
  Result:=value/2.613e19;
end;
function caltoeV(value:extended):extended; stdcall;
begin
  Result:=2.613e19*value;
end;

(*
Функция ExportConvertTable возвращает экспортируемую библиотекой
таблицу единиц конвертации.
*)
function ExportConvertTable:TConvertTable; stdcall;
begin
  setlength(Result,12);
  Result[0].SrcUnit:='Дж';
  Result[0].DstUnit:='Вт*ч';
  Result[0].ConvertFunc:=JtoWh;

  Result[1].SrcUnit:='Дж';
  Result[1].DstUnit:='кал.';
  Result[1].ConvertFunc:=Jtocal;

  Result[2].SrcUnit:='Дж';
  Result[2].DstUnit:='эВ';
  Result[2].ConvertFunc:=JtoeV;

  Result[3].SrcUnit:='Вт*ч';
  Result[3].DstUnit:='Дж';
  Result[3].ConvertFunc:=WhtoJ;

  Result[4].SrcUnit:='кал.';
  Result[4].DstUnit:='Дж';
  Result[4].ConvertFunc:=caltoJ;

  Result[5].SrcUnit:='эВ';
  Result[5].DstUnit:='Дж';
  Result[5].ConvertFunc:=eVtoJ;
  ///////////////////////
  Result[6].SrcUnit:='Вт*ч';
  Result[6].DstUnit:='эВ';
  Result[6].ConvertFunc:=WhtoeV;

  Result[7].SrcUnit:='Вт*ч';
  Result[7].DstUnit:='кал.';
  Result[7].ConvertFunc:=Whtocal;

  Result[8].SrcUnit:='кал.';
  Result[8].DstUnit:='Вт*ч';
  Result[8].ConvertFunc:=caltoWh;

  Result[9].SrcUnit:='эВ';
  Result[9].DstUnit:='Вт*ч';
  Result[9].ConvertFunc:=eVtoWh;
  //////////////////////////
  Result[10].SrcUnit:='эВ';
  Result[10].DstUnit:='кал.';
  Result[10].ConvertFunc:=eVtocal;

  Result[11].SrcUnit:='кал.';
  Result[11].DstUnit:='эВ';
  Result[11].ConvertFunc:=caltoeV;
end;
exports CollectGarbage,ExportUnitsTable,ExportConvertTable;
begin
end.
