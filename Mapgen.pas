unit mapgen;

interface

const
    nhero = 1;
    nwall = 150;
    ntreasure = 20;
    nbeast = 30;

type
    maps = array[1..20, 1..30] of char;

procedure generate(i, j: byte; var map: maps; hero, wall, treasure, beast: byte; ht: boolean; var rand:integer);
implementation

procedure generate;
begin
    randomize;
    for i:=1 to 20 do
    for j:=1 to 30 do
    map[i,j]:='=';
    for i := 1 to 20 do 
    begin
        map[i, 1] := 'W'; map[i, 30] := 'W';
    end;
    for j := 1 to 30 do
    begin
        map[1, j] := 'W'; map[20, j] := 'W';
    end;
    for j := 2 to 29 do
        for i := 2 to 19 do 
        begin
            rand := random(551);
            case rand of
                0: 
                    if (hero < nhero) and (map[i, j] <> 'H') and (map[i, j] <> 'W') and (map[i, j] <> 'T') and (map[i, j] <> 'B') and (map[i, j] <> '.') then begin
                        map[i, j] := 'H'; hero := hero + 1;
                    end;
                1..15, 186..201: 
                    if (beast < nbeast) and (map[i, j] <> 'H') and (map[i, j] <> 'W') and (map[i, j] <> 'T') and (map[i, j] <> 'B') and (map[i, j] <> '.') then begin
                        map[i, j] := 'B'; beast := beast + 1;
                    end;
                31..40, 149..160:
                    if (treasure < ntreasure) and (map[i, j] <> 'H') and (map[i, j] <> 'W') and (map[i, j] <> 'T') and (map[i, j] <> 'B') and (map[i, j] <> '.') then begin
                        map[i, j] := 'T'; treasure := treasure + 1;
                    end;
                51..148, 161..185:
                    if (wall < nwall) and (map[i, j] <> 'H') and (map[i, j] <> 'W') and (map[i, j] <> 'T') and (map[i, j] <> 'B')  and (map[i, j] <> '.') then begin
                        map[i, j] := 'W'; wall := wall + 1;
                    end;
                202..550:
                    if (wall < nwall) and (map[i, j] <> 'H') and (map[i, j] <> 'W') and (map[i, j] <> 'T') and (map[i, j] <> 'B') and (map[i, j] <> '.') then begin
                        map[i, j] := '.';
                    end;
            end;
        end;
    for i := 1 to 20 do
        for j := 1 to 30 do 
        begin
            if (map[i, j] <> 'H') and (map[i, j] <> 'W') and (map[i, j] <> 'T') and (map[i, j] <> 'B') and (map[i, j] <> '.') then map[i, j] := '.';
            if map[i, j] = 'H' then ht := true;
        end;
    if ht = false then map[random(18) + 2, random(28) + 2] := 'H';
end;

begin
end. 