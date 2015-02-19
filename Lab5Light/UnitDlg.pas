unit UnitDlg;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls, 
  Buttons, ExtCtrls, ComCtrls;

type
  TdlgChooseDT = class(TForm)
    OKBtn: TButton;
    CancelBtn: TButton;
    dtpTime: TDateTimePicker;
    calDate: TMonthCalendar;
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
  dtpTime.Date:=calDate.Date;
  Selected:=dtpTime.DateTime;
end;

end.
