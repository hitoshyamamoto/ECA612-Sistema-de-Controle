M=zeros(4,2)
M=[5,8;-5,8;5,-8;-5,-8]

for i=1:4
  angulo_ref = ((atan(M(i,1)/M(i,2)))*180)/pi;
  
  %1ºQ
  if M(i,1)>=0 && M(i,2)>=0
    angulo_res = angulo_ref
  endif
  
  %2ºQ
  if M(i,1)>=0 && M(i,2)<0
    angulo_res = angulo_ref + 180
  endif
  
  %3ºQ
  if M(i,1)<0 && M(i,2)<0
    angulo_res = angulo_ref + 180
  endif
  
  %4ºQ
  if M(i,1)<0 && M(i,2)>=0
    angulo_res = angulo_ref + 360
  endif
  
end