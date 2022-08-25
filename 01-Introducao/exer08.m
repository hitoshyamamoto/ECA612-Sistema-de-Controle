5x = input("Coloque um valor: ")

function M = aula2(x)
  M = ones(x)
  for lin = 2:x
    for col = 2:x
      if M(lin-1,col)+M(lin,col-1)<20
        M(lin,col) = M(lin-1,col) + M(lin,col-1);
      else
        if M(lin-1,col)>M(lin,col-1)
          M(lin,col) = M(lin-1,col);
        else
          M(lin,col) = M(lin,col-1);
        endif
      endif
    endfor
  endfor
endfunction