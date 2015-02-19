unit UnitMain;
interface

uses
  
  Classes, Controls, Forms,
  StdCtrls, jpeg, ExtCtrls;

type
  TfrmMain = class(TForm)
    lblInfo: TLabel;//Информация о программе
    grpParams: TGroupBox;//Группа параметров
    btnRun: TButton;//Кнопка запуска
    btnExit: TButton;//Кнопка выхода
    edtX: TLabeledEdit;//Ввод параметра X
    edtY: TLabeledEdit;//Ввод параметра Y
    edtZ: TLabeledEdit;//Ввод параметра Z
    imgFormula: TImage;//Формула
    memResult: TMemo;//Результат расчета
    //Обработчик нажатия кнопки запуска
    procedure btnRunClick(Sender: TObject); 
    //Обработчик нажатия кнопки выхода 
    procedure btnExitClick(Sender: TObject);
    //Обработчик события создания формы
    procedure FormCreate(Sender: TObject);

  private
    { Private declarations }

  public
    { Public declarations }


  end;
    //Ввод данных
    function Input(var x,y,z:Double):boolean;  external 'LabDLL';
    //Вывод данных
    procedure Output(w:Double);   external 'LabDLL';
    //Расчет функции
    function CalcW(x,y,z:Double):Double; external 'LabDLL';
var
  frmMain: TfrmMain;

implementation

{$R *.dfm}
(*
Процедура btnRunClick - обработчик события шелчка мышки на кнопке 
btnRun - основная процедура программы.
Параметры:
Sender:TObject - объект-возбудитель события
Локальные переменные:
x,y,z:Double-параметры расчёта значения функции
w   : Double -значение функции
*)
procedure TfrmMain.btnRunClick(Sender: TObject);
var x,y,z,w:Double;ok:boolean;
begin
  ok:=Input(x,y,z);
  if ok then begin
    w:=CalcW(x,y,z);
    Output(w);
  end;
end;
(*
Процедура-обработчик события btnExitClick при шелчке мышке по кнопке 
btnExit завершает приложение.
Параметры:
Sender:TObject - объект-возбудитель события
*)
procedure TfrmMain.btnExitClick(Sender: TObject);
begin
Application.Terminate;
end;
(*
Процедура FormCreate добавляет к информационному полю memResult 
строку "w=". 
Параметры:
Sender:TObject-объект-возбудитель события
*)
procedure TfrmMain.FormCreate(Sender: TObject);
begin
  memResult.Text:=memResult.Text+'w=';
end;
end.
