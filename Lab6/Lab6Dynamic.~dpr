program Lab6Dynamic;

uses
  Windows,Forms,Dialogs;

{$R *.res}
var Handle:LongWord;
    ShowForm:function:Integer;
begin
  Application.Initialize;
  Handle := LoadLibrary('LabDLL.dll');
  if Handle = 0 then
  begin
    MessageDlg('He найдена библиотека LabDLL.DLL',mtError,[mbOk],0) ;
    Halt
  end;
  @ShowForm:=GetProcAddress(Handle,'ShowForm');
  if @ShowForm=NIL then
    MessageDlg('He найдена библиотека LabDLL.DLL',mtError,[mbOk],0)
  else ShowForm;
  FreeLibrary(Handle);
end.
