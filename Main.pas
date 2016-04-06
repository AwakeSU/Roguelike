program main;

uses
    crt, mapgen;


label 1, 2, 3, 4, 5, 6;

type
    treasures = array[1..50] of string;

var
    part1, part2: string;
    treasurefirst, treasurelast, enemyfirst, enemylast, save, sav: text;
    startgame, goldrandom, kill, savefile: byte;
    i, j, day, win, dead, randomizer: integer;
    gold, moveto, buy: longint;
    map: maps;
    treasureff1, treasureff2, enemyff1, enemyff2: treasures;
    attack, defence, hitpoints, movement, herox, heroy, food, mp, hp, fd: shortint;
    close: boolean;

procedure treasurecheck(x: integer; y, z: treasures; var a, b: string);
begin
    x := random(50) + 1;
    a := y[x];
    x := random(50) + 1;
    b := z[x];
    gotoxy(6, 24);
    write('You found ', a, ' ', b);
    readln;
    readln;
end;

procedure enemycheck(x: integer; y, z: treasures; var a, b: string);
begin
    x := random(50) + 1;
    a := y[x];
    x := random(50) + 1;
    b := z[x];
    gotoxy(6, 24);
    write('You attacked ', a, ' ', b);
    readln;
    readln;
end;

begin
    hidecursor;
    2: textcolor(2);
    gold := 0;
    kill := 0;
    clrscr;
    randomize;
    gotoxy(30, 2);
    write('Roguelike symbols');
    gotoxy(29, 4);
    write('0 - start  new game');
    gotoxy(30, 5);
    write('1 - continue game');
    gotoxy(30, 6);
    write('2 - how to play?');
    gotoxy(34, 7);
    write('3 - exit');
    gotoxy(38, 9);
    read(startgame);
    1: case startgame of
        0: 
            begin
                attack := 3;
                defence := 2;
                hp := 5;
                movement := 2;
                fd := 10;
            end;
        2: 
            begin
                clrscr;
                gotoxy(32, 2);
                write('How to play?');
                gotoxy(1, 4);
                writeln('In this game your main target is to survive as long as you can. You is a H(Hero). Use 4/8/6/2 buttons to move left/up/right/down, then press enter to finish the turn. If you touch T(treasure) you will collect it, B(beast) you will fight it. Battles in this game are fully automatizated, but Attack and Defence will help you to survive. If you lost the battle, you will lose 1 hitpoint. If your hitpoints=0 you will die.');
                readln; readln;
                goto 2;
            end;
        1:
            begin
                clrscr;
                gotoxy(32, 2);
                write('Choose save (1-5);');
                gotoxy(38, 4);
                read(savefile);
                case savefile of
                    1: assign(save, 'save/1.save');
                    2: assign(save, 'save/2.save');
                    3: assign(save, 'save/3.save');
                    4: assign(save, 'save/4.save');
                    5: assign(save, 'save/5.save');
                end;
                reset(save);
                read(save, attack);
                read(save, defence);
                read(save, hp);
                read(save, movement);
                read(save, fd);
                read(save, gold);
                read(save, kill);
            end;
        3: exit;
    else 
        begin
            gotoxy(32, 9);
            write('Wrong option');
            delay(1000);
            goto 2;
        end;
    end;
    clrscr;
    day := 1;
    assign(treasurefirst, 'treasure/treasurefirst.txt');
    assign(treasurelast, 'treasure/treasurelast.txt');
    assign(enemyfirst, 'enemy/enemyfirst.txt');
    assign(enemylast, 'enemy/enemylast.txt');
    reset(treasurefirst);
    reset(treasurelast);
    reset(enemyfirst);
    reset(enemylast);
    for i := 1 to 50 do 
    begin
        read(treasurefirst, treasureff1[i]);
        read(treasurelast, treasureff2[i]);
        readln(treasurefirst);
        readln(treasurelast);
        read(enemyfirst, enemyff1[i]);
        read(enemylast, enemyff2[i]);
        readln(enemyfirst);
        readln(enemylast);
    end;
    while close = false do 
    begin
        4: clrscr;
        gotoxy(25, 2);
        write('Welcome to the shop, stranger!');
        gotoxy(2, 4);
        write('1) Buy a horse (+1 mpd) - 1000 gold');
        gotoxy(2, 6);
        write('2) Buy a sword (+1 atk) - 500 gold');
        gotoxy(2, 8);
        write('3) Buy a shield (+1 dfc) - 500 gold');
        gotoxy(2, 10);
        write('4) Buy an apple (+1 food) - 750 gold');
        gotoxy(2, 12);
        write('5) Buy a potion (+1 hp) - 750 gold');
        gotoxy(2, 14);
        write('6) Buy an axe (+1 dfc, +1 atk) - 900 gold');
        gotoxy(2, 16);
        write('7) Hire a guard (+1 dfc, +1 hp) - 1100 gold');
        gotoxy(2, 18);
        write('8) Hire a cook (+1 food, +1 hp) - 1400 gold');
        gotoxy(2, 20);
        write('9) Buy a One Ring  (+1 all) - 3300 gold');
        gotoxy(2, 22);
        write('You have ', gold, ' gold');
        gotoxy(2, 24);
        write('Press 1-9 to buy, 0 to continue, 10 to end: ');
        read(buy);
        case buy of
            0: goto 5;;
            1:
                if gold >= 1000 then begin
                    gold := gold - 1000;
                    movement := movement + 1;
                end
                else begin gotoxy(46, 24); write('not enough money'); readln; readln; goto 4; end;
            2:
                if gold >= 500 then begin
                    gold := gold - 500;
                    attack := attack + 1;
                end
                else begin gotoxy(46, 24); write('not enough money'); readln; readln; goto 4; end;
            3:
                if gold >= 500 then begin
                    gold := gold - 500;
                    defence := defence + 1;
                end
                else begin gotoxy(46, 24); write('not enough money'); readln; readln; goto 4; end;
            4:
                if gold >= 750 then begin
                    gold := gold - 750;
                    fd := fd + 1;
                end
                else begin gotoxy(46, 24); write('not enough money'); readln; readln; goto 4; end;
            5:
                if gold >= 750 then begin
                    gold := gold - 750;
                    hp := hp + 1;
                end
                else begin gotoxy(46, 24); write('not enough money'); readln; readln; goto 4; end;
            6:
                if gold >= 900 then begin
                    gold := gold - 900;
                    attack := attack + 1;
                    defence := defence + 1;
                end
                else begin gotoxy(46, 24); write('not enough money'); readln; readln; goto 4; end;
            7:
                if gold >= 1100 then begin
                    gold := gold - 1100;
                    hp := hp + 1;
                    defence := defence + 1;
                end
                else begin gotoxy(46, 24); write('not enough money'); readln; readln; goto 4; end;
            8:
                if gold >= 1400 then begin
                    gold := gold - 1400;
                    hp := hp + 1;
                    fd := fd + 1;
                end
                else begin gotoxy(46, 24); write('not enough money'); readln; readln; goto 4; end;
            9:
                if gold >= 3300 then begin
                    gold := gold - 3300;
                    hp := hp + 1;
                    fd := fd + 1;
                    attack := attack + 1;
                    defence := defence + 1;
                    movement := movement + 1;
                end
                else begin gotoxy(46, 24); write('not enough money'); readln; readln; goto 4; end;
            10: goto 6;
        else
            begin
                gotoxy(46, 24); write('wrong symbol'); readln; readln; goto 4; end;
        end;
        5: generate(1, 1, map, 0, 0, 0, 0, false, randomizer);
        hitpoints := hp;
        food := fd;
        while hitpoints > 0 do 
        begin
            mp := movement;
            while (mp > 0) and (hitpoints > 0) do 
            begin
                if food <= 0 then hitpoints := hitpoints - 1;
                3: clrscr;
                gotoxy(16, 1);
                writeln('Day ', day);
                writeln;
                for i := 1 to 20 do 
                begin
                    write('  ');
                    for j := 1 to 30 do 
                    begin
                        if map[i, j] <> 'H' then
                            write(map[i, j])
                        else begin
                            textcolor(10);
                            write(map[i, j]);
                            heroy := i;
                            herox := j;
                            textcolor(2);
                        end;
                    end;
                    
                    writeln;
                end;
                gotoxy(37, 3);
                write('Attack: ', attack);
                gotoxy(37, 4);
                write('Defence: ', defence);
                gotoxy(37, 5);
                write('Hitpoints: ', hitpoints, '/', hp);
                gotoxy(37, 6);
                write('Moves per day: ', mp, '/', movement);
                gotoxy(37, 7);
                write('Gold: ', gold);
                gotoxy(37, 8);
                write('Food: ', food, '/', fd);
                gotoxy(37, 9);
                write('Kills: ', kill);
                gotoxy(37, 12);
                write('Move to: ');
                read(moveto);
                case moveto of 
                    4:   
                        case map[heroy, herox - 1] of
                            '.':
                                begin
                                    map[heroy, herox - 1] := 'H';
                                    map[heroy, herox] := '.';
                                end;
                            'T':
                                begin
                                    map[heroy, herox - 1] := 'H';
                                    map[heroy, herox] := '.';
                                    treasurecheck(randomizer, treasureff1, treasureff2, part1, part2);
                                    goldrandom := random(50, 150);
                                    inc(gold, goldrandom);
                                end;
                            'B':
                                begin
                                    map[heroy, herox - 1] := 'H';
                                    map[heroy, herox] := '.';
                                    enemycheck(randomizer, enemyff1, enemyff2, part1, part2);
                                    win := random(2 * attack + 2 * defence);
                                    dead := random(5) + kill;
                                    if win > dead then begin
                                        kill := kill + 1;
                                        goldrandom := random(30, 100);
                                        inc(gold, goldrandom);
                                    end
                                    else hitpoints := hitpoints - 1;
                                end;
                        end;
                    8:    
                        case map[heroy - 1, herox] of
                            '.':
                                begin
                                    map[heroy - 1, herox] := 'H';
                                    map[heroy, herox] := '.';
                                end;
                            'T':
                                begin
                                    map[heroy - 1, herox] := 'H';
                                    map[heroy, herox] := '.';
                                    treasurecheck(randomizer, treasureff1, treasureff2, part1, part2);
                                    goldrandom := random(50, 150);
                                    inc(gold, goldrandom);
                                end;
                            'B':
                                begin
                                    map[heroy - 1, herox] := 'H';
                                    map[heroy, herox] := '.';
                                    enemycheck(randomizer, enemyff1, enemyff2, part1, part2);
                                    win := random(2 * attack + 2 * defence);
                                    dead := random(5) + kill;
                                    if win > dead then begin
                                        kill := kill + 1;
                                        goldrandom := random(30, 100);
                                        inc(gold, goldrandom);
                                    end
                                    else hitpoints := hitpoints - 1;
                                end;
                        end;
                    6:  
                        case map[heroy, herox + 1] of
                            '.':
                                begin
                                    map[heroy, herox + 1] := 'H';
                                    map[heroy, herox] := '.';
                                end;
                            'T':
                                begin
                                    map[heroy, herox + 1] := 'H';
                                    map[heroy, herox] := '.';
                                    treasurecheck(randomizer, treasureff1, treasureff2, part1, part2);
                                    goldrandom := random(50, 150);
                                    inc(gold, goldrandom);
                                end;
                            'B':
                                begin
                                    map[heroy, herox + 1] := 'H';
                                    map[heroy, herox] := '.';
                                    enemycheck(randomizer, enemyff1, enemyff2, part1, part2);
                                    win := random(2 * attack + 2 * defence);
                                    dead := random(5) + kill;
                                    if win > dead then begin
                                        kill := kill + 1;
                                        goldrandom := random(30, 100);
                                        inc(gold, goldrandom);
                                    end
                                    else hitpoints := hitpoints - 1;
                                end;
                        end;
                    2: 
                        case map[heroy + 1, herox] of
                            '.':
                                begin
                                    map[heroy + 1, herox] := 'H';
                                    map[heroy, herox] := '.';
                                end;
                            'T':
                                begin
                                    map[heroy + 1, herox] := 'H';
                                    map[heroy, herox] := '.';
                                    treasurecheck(randomizer, treasureff1, treasureff2, part1, part2);
                                    goldrandom := random(50, 150);
                                    inc(gold, goldrandom);
                                end;
                            'B':
                                begin
                                    map[heroy + 1, herox] := 'H';
                                    map[heroy, herox] := '.';
                                    enemycheck(randomizer, enemyff1, enemyff2, part1, part2);
                                    win := random(2 * attack + 2 * defence);
                                    dead := random(5) + kill;
                                    if win > dead then begin
                                        kill := kill + 1;
                                        goldrandom := random(30, 100);
                                        inc(gold, goldrandom);
                                    end
                                    else hitpoints := hitpoints - 1;
                                end;
                        end;
                else 
                    begin
                        gotoxy(46, 12);
                        write('wrong move');
                        delay(500);
                        goto 3;
                    end;
                end;
                mp := mp - 1;
            end;
            day := day + 1;
            if food <> 0 then food := food - 1;
        end;
        readln;
        readln;
    end;
    6: clrscr;
    gotoxy(25, 2);
    write('Choose save (1-5, 0 - exit)');
    gotoxy(38, 4);
    read(savefile);
    case savefile of
        1: assign(sav, 'save/1.save');
        2: assign(sav, 'save/2.save');
        3: assign(sav, 'save/3.save');
        4: assign(sav, 'save/4.save');
        5: assign(sav, 'save/5.save');
        0: exit;
    else goto 6;
    end;
    rewrite(sav);
    write(sav, attack, ' ', defence, ' ', hp, ' ', movement, ' ', fd, ' ', gold, ' ', kill);
    closefile(sav);
end.