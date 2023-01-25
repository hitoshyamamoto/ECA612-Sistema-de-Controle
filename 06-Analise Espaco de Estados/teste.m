clear all
close all
clc

pkg load control

Ngps = 1;
Dgps = [1 1 0];
Gps = tf(Ngps, Dgps);

Nhs = 1;
Dhs = 1;
Hs = tf(Nhs,Dhs);

GpHs = Gps*Hs

Mp = 0.2
ts = 5

zeta = sqrt((log(Mp))^2/((log(Mp)^2)+(pi^2)))
phim = atand((2*zeta)/(sqrt((sqrt((4*(zeta^4))+1))-2*(zeta^2))))
wu = 8/(tand(phim)*ts)

[mag_GpHjwu,phase_GpHjwu] = bode(GpHs,wu);

phase_Gcjwu = -180+phim-phase_GpHjwu

s0=1;
phi_C0 = angle(i*wu+s0)*(180/pi)
phi_Cp = phi_C0 - phase_Gcjwu

sp = wu/tand(phi_Cp)
mag_Gcjwu = 1/mag_GpHjwu

rC0 = abs(i*wu+s0)
rCp = abs(i*wu+sp)

K = mag_Gcjwu*(rCp/rC0)

Ngcs = K*[1 s0];
Dgcs = [1 sp];
Gcs = tf(Ngcs, Dgcs);

GcGpHs = Gcs*GpHs

figure
margin(GcGpHs)

GcGps = Gcs*Gps;
Ts = feedback(GcGps,Hs)

figure
step(Ts)
