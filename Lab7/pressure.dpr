library pressure;

uses
  SysUtils,
  Classes,
  Dialogs;

{$R *.res}
type
  TConvertUnits=record //������ ����� �������
    Category:ShortString; //���������
    Units:array of ShortString; //������������
  end;
  TUnitsTable=array of TConvertUnits;//������� ����� �������
  //��� ������� �������� �������
  TConvertFunction=function (value:extended):extended; stdcall;
  //������ ������� �����������
  TConvertLine=record
    SrcUnit,DstUnit:ShortString;//�������� � ��������� ����
    ConvertFunc:TConvertFunction; //������� �����������
  end;
  TConvertTable=array of TConvertLine; //������� �����������

  //��� ������� �������� ������� ����� �� DLL
  UnitsTableExportFunc=function:TUnitsTable; stdcall;
  //��� ������� �������� ������� ����������� �� DLL
  ConvertTableExportFunc=function:TConvertTable;  stdcall;
  //��� ������� ������ ������ �� DLL
  GarbageCollectorFunc=procedure (var units:TUnitsTable;
                        var convert:TConvertTable); stdcall;

(*
��������� CollectGarbage ����������� ������ ��-��� �������
������ ��������� units � ������� ����������� convert.
*)
procedure CollectGarbage(var units:TUnitsTable;
                      var convert:TConvertTable); stdcall;
begin
   units:=NIL;
   convert:=NIL;
end;

(*
������� ExportUnitsTable ���������� �������������� �����������
������� ������ ���������.
*)
function ExportUnitsTable:TUnitsTable; stdcall;
begin
  setlength(Result,1);
  Result[0].Category:='��������';
  setlength(Result[0].Units,2);
  Result[0].Units[0]:='��';
  Result[0].Units[1]:='��.��.��';
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
������� ExportConvertTable ���������� �������������� �����������
������� ������ �����������.
*)
function ExportConvertTable:TConvertTable; stdcall;
begin
  setlength(Result,2);
  Result[0].SrcUnit:='��';
  Result[0].DstUnit:='��.��.��';
  Result[0].ConvertFunc:=PatommHg;

  Result[1].SrcUnit:='��.��.��';
  Result[1].DstUnit:='��';
  Result[1].ConvertFunc:=mmHgtoPa;
end;
exports CollectGarbage,ExportUnitsTable,ExportConvertTable;
begin
end.
