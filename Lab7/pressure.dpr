library pressure;

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
  Result[0].Category:='Давление';
  setlength(Result[0].Units,2);
  Result[0].Units[0]:='Па';
  Result[0].Units[1]:='мм.рт.ст';
end;

function PatommHg(value:extended):extended;  stdcall;
begin
  Result:=value/133.322;
end;
function mmHgtoPa(value:extended):extended; stdcall;
begin
  Result:=value*133.322;
end;

(*
Функция ExportConvertTable возвращает экспортируемую библиотекой
таблицу единиц конвертации.
*)
function ExportConvertTable:TConvertTable; stdcall;
begin
  setlength(Result,2);
  Result[0].SrcUnit:='Па';
  Result[0].DstUnit:='мм.рт.ст';
  Result[0].ConvertFunc:=PatommHg;

  Result[1].SrcUnit:='мм.рт.ст';
  Result[1].DstUnit:='Па';
  Result[1].ConvertFunc:=mmHgtoPa;
end;
exports CollectGarbage,ExportUnitsTable,ExportConvertTable;
begin
end.
