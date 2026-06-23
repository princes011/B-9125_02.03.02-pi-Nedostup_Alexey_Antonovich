unit checks1;

interface
uses types1;

procedure check_pasport_req(str : string; var pasport : string; var err : integer);
procedure check_date(str : string; var date : Data; var err : integer);
procedure check_price(str : string; var price : integer; var err : integer);
procedure check_category(str : string; var category : room_types; var err : integer);
procedure check_capacity(str : string; var capacity : integer; var err : integer);
procedure check_area(str : string; var area : real; var err : integer);


implementation

procedure check_pasport_req(str : string; var pasport : string; var err : integer);
var i : integer;
begin
  err := 0;
  if length(str) = 10 then
  begin
    for i := 1 to 10 do
      if not (str[i] in ['0'..'9']) then err := 1;
  end
  else err := 1;
  if err = 0 then pasport := str;
end;

procedure check_date(str : string; var date : Data; var err : integer);
const
  monthNames: array[1..12] of string = ('jan','feb','mar','apr','may','jun',
                                        'jul','aug','sep','oct','nov','dec');
var
  dayText, monthText, yearText: string;   // части даты как строки
  dayNum, monthNum, yearNum: integer;     // числовые значения дня, месяца, года
  errorCode: integer;                     // код ошибки для val
  i: integer;                             // счётчик цикла
  maxDays: integer;                       // максимальное количество дней в месяце
begin
  err := 0;
  if (length(str) = 11) and (str[3] = '.') and (str[7] = '.') then
  begin
    dayText := copy(str, 1, 2);
    monthText := copy(str, 4, 3);
    yearText := copy(str, 8, 4);
    val(dayText, dayNum, errorCode);
    if errorCode <> 0 then err := 1;
    val(yearText, yearNum, errorCode);
    if errorCode <> 0 then err := 1;
    if err = 0 then
    begin
      monthNum := 0;
      for i := 1 to 12 do
        if monthText = monthNames[i] then monthNum := i;
      if monthNum = 0 then err := 1;
    end;
    if err = 0 then
    begin
      if (yearNum < 2000) or (yearNum > 2025) then
        err := 2
      else
      begin 
        case monthNum of
          1,3,5,7,8,10,12: maxDays := 31;
          4,6,9,11: maxDays := 30;
          2: if ((yearNum mod 4 = 0) and (yearNum mod 100 <> 0)) or (yearNum mod 400 = 0)
             then maxDays := 29
             else maxDays := 28;
          else maxDays := 0;  
        end;
        if (dayNum < 1) or (dayNum > maxDays) then
          err := 2
        else
        begin
          date.Day := dayNum;
          date.Month := monthNum;
          date.Year := yearNum;
        end;
      end;
    end;
  end
  else
    err := 1;   
end;

procedure check_price(str : string; var price : integer; var err : integer);
var num, code: integer;
begin
  val(str, num, code);
  if code <> 0 then err := 1
  else if (num < 100) or (num > 1000) then err := 2
  else price := num;
end;

procedure check_category(str : string; var category : room_types; var err : integer);
begin
  if str = 'standart' then category := standart
  else if str = 'plus' then category := plus
  else if str = 'grand' then category := grand
  else err := 1;
end;

procedure check_capacity(str : string; var capacity : integer; var err : integer);
var num, code: integer;
begin
  val(str, num, code);
  if code <> 0 then err := 1
  else if (num < 1) or (num > 10) then err := 2
  else capacity := num;
end;

procedure check_area(str : string; var area : real; var err : integer);
var num, code: integer;
begin
  val(str, num, code);
  if code <> 0 then err := 1
  else if (num < 10) or (num > 100) then err := 2
  else area := num;
end;


begin
end.