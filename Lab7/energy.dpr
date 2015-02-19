library energy;

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
  Result[0].Category:='�������';
  setlength(Result[0].Units,4);
  Result[0].Units[0]:='��';
  Result[0].Units[1]:='���.';
  Result[0].Units[2]:='��';
  Result[0].Units[3]:='��*�';
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
������� ExportConvertTable ���������� �������������� �����������
������� ������ �����������.
*)
function ExportConvertTable:TConvertTable; stdcall;
begin
  setlength(Result,12);
  Result[0].SrcUnit:='��';
  Result[0].DstUnit:='��*�';
  Result[0].ConvertFunc:=JtoWh;

  Result[1].SrcUnit:='��';
  Result[1].DstUnit:='���.';
  Result[1].ConvertFunc:=Jtocal;

  Result[2].SrcUnit:='��';
  Result[2].DstUnit:='��';
  Result[2].ConvertFunc:=JtoeV;

  Result[3].SrcUnit:='��*�';
  Result[3].DstUnit:='��';
  Result[3].ConvertFunc:=WhtoJ;

  Result[4].SrcUnit:='���.';
  Result[4].DstUnit:='��';
  Result[4].ConvertFunc:=caltoJ;

  Result[5].SrcUnit:='��';
  Result[5].DstUnit:='��';
  Result[5].ConvertFunc:=eVtoJ;
  ///////////////////////
  Result[6].SrcUnit:='��*�';
  Result[6].DstUnit:='��';
  Result[6].ConvertFunc:=WhtoeV;

  Result[7].SrcUnit:='��*�';
  Result[7].DstUnit:='���.';
  Result[7].ConvertFunc:=Whtocal;

  Result[8].SrcUnit:='���.';
  Result[8].DstUnit:='��*�';
  Result[8].ConvertFunc:=caltoWh;

  Result[9].SrcUnit:='��';
  Result[9].DstUnit:='��*�';
  Result[9].ConvertFunc:=eVtoWh;
  //////////////////////////
  Result[10].SrcUnit:='��';
  Result[10].DstUnit:='���.';
  Result[10].ConvertFunc:=eVtocal;

  Result[11].SrcUnit:='���.';
  Result[11].DstUnit:='��';
  Result[11].ConvertFunc:=caltoeV;
end;
exports CollectGarbage,ExportUnitsTable,ExportConvertTable;
begin
end.
