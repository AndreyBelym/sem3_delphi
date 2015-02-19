library length;

{ Important note about DLL memory management: ShareMem must be the
  first unit in your library's USES clause AND your project's (select
  Project-View Source) USES clause if your DLL exports any procedures or
  functions that pass strings as parameters or function results. This
  applies to all strings passed to and from your DLL--even those that
  are nested in records and classes. ShareMem is the interface unit to
  the BORLNDMM.DLL shared memory manager, which must be deployed along
  with your DLL. To avoid using BORLNDMM.DLL, pass string information
  using PChar or ShortString parameters. }

uses
  SysUtils,
  Classes;

{$R *.res}
type
  TConvertUnits=record
    Category:PChar;
    Units:array of PChar;
  end;
  TUnitsTable=array of TConvertUnits;
  TConvertFunction=function (value:extended):extended; stdcall;
  TConvertLine=record
    SrcUnit,DstUnit:PChar;
    ConvertFunc:TConvertFunction;
  end;
  TConvertTable=array of TConvertLine;
  UnitsTableExportFunc=function:TUnitsTable; stdcall;
  ConvertTableExportFunc=function:TConvertTable; stdcall;

function ExportUnitsTable:TUnitsTable; stdcall;
begin
  setlength(Result,1);
  Result[0].Category:='Длина';
  setlength(Result[0].Units,3);
  Result[0].Units[0]:='см';
  Result[0].Units[1]:='дм';
  Result[0].Units[2]:='м';
end;

function CtoK(value:extended):extended;  stdcall;
begin
  Result:=value+273;
end;
function KtoC(value:extended):extended; stdcall;
begin
  Result:=value-273;
end;

{function CtoF(value:extended):extended;
begin
end;
function FtoC(value:extended):extended;
begin
end;

function FtoK(value:extended):extended;
begin
end;
function KtoF(value:extended):extended;
begin
end;
}
function ExportConvertTable:TConvertTable; stdcall;
begin
  setlength(Result,2);
  Result[0].SrcUnit:='C';
  Result[0].DstUnit:='K';
  Result[0].ConvertFunc:=CtoK;

  Result[1].SrcUnit:='K';
  Result[1].DstUnit:='C';
  Result[1].ConvertFunc:=KtoC;
end;
exports KtoC,CtoK,ExportUnitsTable,ExportConvertTable;
begin
end.
