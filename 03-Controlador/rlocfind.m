function [K,polo] = rlocfind(G)
  [zeros,poles,T] = tfdata(G);
  zeros = cell2mat(zeros);
  poles = cell2mat(poles);
  dim_z = length(zeros);
  dim_p = length(poles);
  pol_zeros = 0;
  pol_polos = 0;
  [x,y] = ginput(1);
  z = x+i*y;
  for n = 1:dim_z
    pol_zeros = pol_zeros + zeros(1,n)*z^(dim_z-n);
  endfor
  for n = 1:dim_p
    pol_polos = pol_polos + poles(1,n)*z^(dim_p-n);
  endfor
   K = abs(pol_polos)/abs(pol_zeros);
   polo = z;
 end