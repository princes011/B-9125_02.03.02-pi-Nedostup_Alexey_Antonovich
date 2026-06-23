program Main;
uses types1, checks1, workers1;
var
  arb: all_room_booking;
  c_r: integer;
  f_in, f_correct, f_incorrect, f_anomaly, f_duplicate, f_conflict: text;
  fout: text;
  idx: integer;
begin
  assign(f_in, 'input.txt');
  reset(f_in);
  assign(f_correct, 'correct.txt');
  rewrite(f_correct);
  assign(f_incorrect, 'incorrect.txt');
  rewrite(f_incorrect);
  assign(f_anomaly, 'anomaly.txt');
  rewrite(f_anomaly);
  assign(f_duplicate, 'duplicate.txt');
  rewrite(f_duplicate);
  assign(f_conflict, 'conflict.txt');
  rewrite(f_conflict);

  read_file(arb, c_r, f_in, f_correct, f_incorrect, f_anomaly);

  close(f_in);
  close(f_correct);
  close(f_incorrect);
  close(f_anomaly);

  dublicated(arb, c_r, f_duplicate);
  close(f_duplicate);

  conflicted(arb, c_r, f_conflict);
  close(f_conflict);
//сортировка

   
  if c_r > 0 then
  begin
     sorted(arb, c_r);
    assign(fout, 'output.txt');
    rewrite(fout);
    for idx := 1 to c_r do
      with arb[idx] do
        writeln(fout, pasport, ' ',
                Date_in.Day, '.', monthNames[Date_in.Month], '.', Date_in.Year, ' ',
                Date_out.Day, '.', monthNames[Date_out.Month], '.', Date_out.Year, ' ',
                price, ' ', catNames[Ord(category)], ' ', capacity, ' ', area:0:2);
    close(fout);
  end;

  writeln('Обработано записей. Правильных: ', c_r);
end.