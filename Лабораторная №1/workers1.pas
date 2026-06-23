unit workers1;

interface
uses types1, checks1;

type TFieldArray = array[0..6] of string;

procedure read_file(var arb : all_room_booking; var c_r : integer; var ff, correct, uncorrect, anomaly : text);
procedure dublicated(var Correct_booking : all_room_booking; n: integer; doblicate : text);
procedure conflicted(var Correct_booking : all_room_booking; n: integer; conflict : text);
procedure sorted(var correct_booking : all_room_booking; n: integer);

implementation
//поменять процедуру в один проход по файлу
procedure read_file(var arb : all_room_booking; var c_r : integer; var ff, correct, uncorrect, anomaly : text);
var
  line: string;
  temp: array of string;
  fields: TFieldArray;
  i, err: integer;
  bk: booking;
  price, cap: integer;
  area: real;
  cat: room_types;
  din, dout: Data;
begin
  c_r := 0;
  while not eof(ff) do
  begin
    readln(ff, line);
    while (length(line) > 0) and (line[1] = ' ') do delete(line, 1, 1);
    while (length(line) > 0) and (line[length(line)] = ' ') do delete(line, length(line), 1);
    if line = '' then continue;
    temp := line.Split(' ');
    if temp.Length <> 7 then
      writeln(uncorrect, line)
    else
    begin
      for i := 0 to 6 do fields[i] := temp[i];
      err := 0;
      check_pasport_req(fields[0], bk.pasport, err);
      if err = 0 then check_date(fields[1], din, err);
      if err = 0 then check_date(fields[2], dout, err);
      if err = 0 then check_price(fields[3], price, err);
      if err = 0 then check_category(fields[4], cat, err);
      if err = 0 then check_capacity(fields[5], cap, err);
      if err = 0 then check_area(fields[6], area, err);
      if err = 1 then writeln(uncorrect, line)
      else if err = 2 then writeln(anomaly, line)
      else
      begin
        bk.Date_in := din; bk.Date_out := dout; bk.price := price;
        bk.category := cat; bk.capacity := cap; bk.area := area;
        c_r := c_r + 1;
        arb[c_r] := bk;
        writeln(correct, line);
      end;
    end;
  end;
end;

procedure dublicated(var Correct_booking : all_room_booking; n: integer; doblicate : text);
var i, j: integer;
begin
  for i := 1 to n-1 do
    for j := i+1 to n do
      if (Correct_booking[i].pasport = Correct_booking[j].pasport) and
         (Correct_booking[i].Date_in.Day = Correct_booking[j].Date_in.Day) and
         (Correct_booking[i].Date_in.Month = Correct_booking[j].Date_in.Month) and
         (Correct_booking[i].Date_in.Year = Correct_booking[j].Date_in.Year) and
         (Correct_booking[i].Date_out.Day = Correct_booking[j].Date_out.Day) and
         (Correct_booking[i].Date_out.Month = Correct_booking[j].Date_out.Month) and
         (Correct_booking[i].Date_out.Year = Correct_booking[j].Date_out.Year) and
         (Correct_booking[i].price = Correct_booking[j].price) and
         (Correct_booking[i].category = Correct_booking[j].category) and
         (Correct_booking[i].capacity = Correct_booking[j].capacity) and
         (Correct_booking[i].area = Correct_booking[j].area) then
        writeln(doblicate, Correct_booking[j].pasport);
end;

procedure conflicted(var Correct_booking : all_room_booking; n: integer; conflict : text);
var i: integer;
begin
  for i := 1 to n do
    with Correct_booking[i] do
      if (Date_out.Year < Date_in.Year) or
         ((Date_out.Year = Date_in.Year) and (Date_out.Month < Date_in.Month)) or
         ((Date_out.Year = Date_in.Year) and (Date_out.Month = Date_in.Month) and (Date_out.Day <= Date_in.Day)) then
        writeln(conflict, pasport, ' ',
                Date_in.Day, '.', monthNames[Date_in.Month], '.', Date_in.Year, ' ',
                Date_out.Day, '.', monthNames[Date_out.Month], '.', Date_out.Year, ' ',
                price, ' ', catNames[Ord(category)], ' ', capacity, ' ', area:0:2);
end;

procedure sorted(var correct_booking : all_room_booking; n: integer);
var i, j: integer; buffer: booking;
begin
  for i := 1 to n-1 do
    for j := i+1 to n do
      if (correct_booking[i].category > correct_booking[j].category) or
         ((correct_booking[i].category = correct_booking[j].category) and
          ((correct_booking[i].Date_in.Year > correct_booking[j].Date_in.Year) or
           ((correct_booking[i].Date_in.Year = correct_booking[j].Date_in.Year) and (correct_booking[i].Date_in.Month > correct_booking[j].Date_in.Month)) or
           ((correct_booking[i].Date_in.Year = correct_booking[j].Date_in.Year) and (correct_booking[i].Date_in.Month = correct_booking[j].Date_in.Month) and (correct_booking[i].Date_in.Day > correct_booking[j].Date_in.Day)))) then
      begin
        buffer := correct_booking[i];
        correct_booking[i] := correct_booking[j];
        correct_booking[j] := buffer;
      end;
end;

begin
end.