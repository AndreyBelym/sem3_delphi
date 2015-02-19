unit UnitFolders;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls,FileCtrl,Dialogs;

type
  TdlgFolders = class(TForm)
    OKBtn: TButton;
    CancelBtn: TButton;
    Bevel1: TBevel;
    Button1: TButton;
    StaticText1: TStaticText;
    ListBox1: TListBox;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dlgFolders: TdlgFolders;

implementation
type TFilesList=array of string;
{$R *.dfm}
procedure FindFiles(const dir:string;var fnames:TFilesList);
var attrs:Integer;res:TSearchRec;
begin
 try
  attrs:=faDirectory;
  if findfirst(dir+'\*.*',attrs,res)=0 then begin
    if (res.Name<>'.') and (res.Name<>'..') and((res.Attr and faDirectory)<>0)
        then FindFiles(dir+'\'+res.Name,fnames);
    while FindNext(res)=0 do
      if (res.Name<>'.') and (res.Name<>'..') and ((res.Attr and faDirectory)<>0) then
        FindFiles(dir+'\'+res.Name,fnames);
    FindClose(res);
  end;
  attrs:=faAnyFile;
  if findfirst(dir+'\*.dat',attrs,res)=0 then begin
    setlength(fnames,length(fnames)+1);fnames[high(fnames)]:=dir+'\'+res.Name;
    while FindNext(res)=0 do
      setlength(fnames,length(fnames)+1);fnames[high(fnames)]:=dir+'\'+res.Name;
    FindClose(res);
  end;
 except else
  MessageDlg('Ошибка!',mtInformation,[mbok],0);
 end;
end;

procedure TdlgFolders.Button1Click(Sender: TObject);
var Root:string; i:integer; files:TFilesList;
begin
  if SelectDirectory('Выберите корневую папку','',Root) then begin
    ListBox1.Clear;
    StaticText1.Caption:=Root;
    FindFiles(Root,Files);
    for i:=0 to high(files) do
      ListBox1.Items.Add(Files[i]);
  end;
end;

end.
