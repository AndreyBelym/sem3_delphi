library thermal;

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
  Result[0].Category:='�����������';
  setlength(Result[0].Units,3);
  Result[0].Units[0]:='C';
  Result[0].Units[1]:='F';
  Result[0].Units[2]:='K';
end;

function CtoK(value:extended):extended;  stdcall;
begin
  Result:=value+273;
end;
function KtoC(value:extended):extended; stdcall;
begin
  Result:=value-273;
end;

function CtoF(value:extended):extended; stdcall;
begin
  Result:=value*9/5+32;
end;
function FtoC(value:extended):extended; stdcall;
begin
  Result:=(value-32)*5/9;
end;

function FtoK(value:extended):extended; stdcall;
begin
  Result:=CtoK(FToC(Value));
end;
function KtoF(value:extended):extended; stdcall;
begin
  Result:=CtoF(KtoC(value));
end;

(*
������� ExportConvertTable ���������� �������������� �����������
������� ������ �����������.
*)
function ExportConvertTable:TConvertTable; stdcall;
begin
  setlength(Result,6);
  Result[0].SrcUnit:='C';
  Result[0].DstUnit:='K';
  Result[0].ConvertFunc:=CtoK;

  Result[1].SrcUnit:='K';
  Result[1].DstUnit:='C';
  Result[1].ConvertFunc:=KtoC;

  Result[2].SrcUnit:='K';
  Result[2].DstUnit:='F';
  Result[2].ConvertFunc:=KtoF;

  Result[3].SrcUnit:='F';
  Result[3].DstUnit:='C';
  Result[3].ConvertFunc:=FtoC;

  Result[4].SrcUnit:='C';
  Result[4].DstUnit:='F';
  Result[4].ConvertFunc:=CtoF;

  Result[5].SrcUnit:='F';
  Result[5].DstUnit:='K';
  Result[5].ConvertFunc:=FtoK;
end;
exports CollectGarbage,ExportUnitsTable,ExportConvertTable;
begin
end.
