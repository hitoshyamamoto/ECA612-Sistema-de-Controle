VS = input("Coloque o valor de VS:")
VL = 0;
if(VS<=0) VL=0;
else VL=VS;
endif

t = 0:0.01:10;
cont = size(t);

for i=1:cont
  VVS[i] = 3*exp(-t[i]/3)*sin(pi*t[i]);
end
subplot(1,2,1)
plot(t,VL),xlabel('tempo'),ylabel('VL')

subplot(1,2,2)
plot(t,VVS),xlabel('tempo'),ylabel('VS')
