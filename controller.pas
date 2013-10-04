unit controller;

interface
uses types, crt;

procedure movement ( input : char; x:^integer; y:^integer; map : field);

implementation

procedure movement ( input : char; x:^integer; y:^integer; map : field);
  begin
    case input of
      #37 : if (map [y^][x^ - 1] = 0 ) then x^ -= 1;
      #38 : if (map [y^ - 1][x^] = 0 ) then y^ -= 1;
      #39 : if (map [y^][x^ + 1] = 0 ) then x^ += 1;
      #40 : if (map [y^ + 1][x^] = 0 ) then y^ += 1;
    end;
    
    
  end;
  
end.
