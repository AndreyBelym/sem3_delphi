unit UnitDlg;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls, 
  Buttons, ExtCtrls, ComCtrls;

type
  TdlgChooseDT = class(TForm)
    OKBtn: TButton;
    CancelBtn: TButton;
    MonthCalendar1: TMonthCalendar;
    DateTimePicker1: TDateTimePicker;
    procedure OKBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    Selected:TDateTime;
    { Public declarations }
  end;

var
  dlgChooseDT: TdlgChooseDT;

implementation

{$R *.dfm}

procedure TdlgChooseDT.OKBtnClick(Sender: TObject);
begin
  DateTimePicker1.Date:=MonthCalendar1.Date;
  Selected:=DateTimePicker1.DateTime;
end;

end.
