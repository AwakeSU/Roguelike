unit iostream;

interface
uses types, crt, controller;

procedure moveObject (control : char; posX, posY : ^integer; map : field);
procedure background  (map : field);

implementation

procedure background (map : field); //������� �������� ����� (map) � ������� ������ (posX, posY)

var
  x, y : integer; //���������� ��� ���������

begin
  for y := 1 to h do
    for x := 1 to w do
      begin
        if (map [y][x] = 1) then write ('#') //���� � ������� �����, �� ��������� "#"
        else write (' '); //���� � ������� ���, �� ��������� ������
        if (x = h) then writeln (); //���� ������ ���������,�� �������������� ������� �� ����� ������
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