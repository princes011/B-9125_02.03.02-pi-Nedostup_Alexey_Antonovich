unit types1;

interface
const N = 10000;

type room_types = (standart, plus, grand);

type Data = record
  Day : 1..31;
  Month : 1..12;
  Year : 2000..2025;
end;

type booking = record
  pasport : String;
  Date_in : Data;
  Date_out : Data;
  price : integer;
  category : room_types;
  capacity : integer;
  area : real;
end;

type correct_room_booking = array[1..N] of booking;
type all_room_booking = array[1..N] of booking;

const
  monthNames: array[1..12] of string = ('jan','feb','mar','apr','may','jun',
                                        'jul','aug','sep','oct','nov','dec');
  catNames: array[0..2] of string = ('standart', 'plus', 'grand');

implementation
begin
end.