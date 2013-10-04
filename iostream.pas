unit iostream;

interface
uses types, crt, controller;

procedure moveObject (control : char; posX, posY : ^integer; map : field);
procedure background  (map : field);

implementation

procedure background (map : field); //функция получает карту (map) и позицию игрока (posX, posY)

var
  x, y : integer; //переменные для счетчиков

begin
  for y := 1 to h do
    for x := 1 to w do
      begin
        if (map [y][x] = 1) then write ('#') //если в массиве стена, то выводится "#"
        else write (' '); //если в массиве пол, то выводится пробел
        if (x = h) then writeln (); //если строка кончается,то осуществляется переход на новую строку
      end;
end;

procedure moveObject (control : char; posX, posY : ^integer; map : field);
var
  bX, bY : integer;
begin
  bX := posX^;
  bY := posY^;
  movement (control, posX, posY, map);
  gotoxy (posX^, posY^);
  write ('*');
  gotoxy (bX, bY);
  write (' ');
end;

end.