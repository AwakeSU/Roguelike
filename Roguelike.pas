uses crt, types, iostream, controller;
var
  map : field;
  control : char;
  posX, posY, i, j : integer;
  t : boolean;
  
begin
  posX := 5;
  posY := 5;
  for i := 1 to h do
    for j := 1 to w do
      map [i][j] := 0;
      
  for j := 1 to w do
  begin;
    map [1][j] := 1;
    map [j][1] := 1;
    map [h][j] := 1;
    map [j][w] := 1;
  end;
  
  background (map);
  
  while (control <> #27) do
  begin
    moveObject (control, @posX, @posY, map);
    control := readkey;
  end;

end.