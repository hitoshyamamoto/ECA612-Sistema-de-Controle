clear all
close all
clc

pkg load control

Ngps = [120];
Dgps = [1 11 14.25];
Gps = tf(Ngps, Dgps);

Gc1s = 8;

Ngc2s = [8 8];
Dgc2s = [1 0];
Gc2s = tf(Ngc2s, Dgc2s);

Hs = 0.8;

Gc1Gps = series(Gc1s, Gps);
T1s = feedback(Gc1Gps, Hs)
[Nt1s, Dt1s] = tfdata(T1s, 'v');
polos1_mf = roots(Dt1s)

Gc2Gps = series(Gc2s, Gps);
T2s = feedback(Gc2Gps, Hs)
[Nt2s, Dt2s] = tfdata(T2s, 'v');
polos2_mf = roots(Dt2s)

[y1,t] = step(T1s);
figure
plot(t,y1,'-b')
xlabel('t [s]')
ylabel('y')
hold
[y2,t] = step(T2s);
plot(t,y2,'-r')
r = ones(length(t),1);
Ru = (1/Hs)*r;
plot(t,Ru,'-g')
grid
legend('y1','y2','ru')

[y1,t] = ramp(T1s);
figure
plot(t,y1,'-b')
xlabel('t [s]')
ylabel('y')
hold
[y2,t] = ramp(T2s);
plot(t,y2,'-r')
r = t.*ones(length(t),1);
Hk = 1.5;
Ru = (1/Hk)*r;
plot(t,Ru,'-g')
grid
legend('y1','y2','ru')



