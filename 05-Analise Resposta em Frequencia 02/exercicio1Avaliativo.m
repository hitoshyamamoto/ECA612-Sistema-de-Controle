clear all
close all
clc

#Carregar a Biblioteca
pkg load control

# --- Exercício 1 ---
#Planta
Ngps = 10;
Dgps = poly([-1;-1]);
Gps = tf(Ngps, Dgps)

#Controlador
K = 0.5;
Ngcs = K*poly([-100]);
Dgcs = [1 0];
Gcs = tf(Ngcs,Dgcs)

#Sensor
Nhs = 0.1;
Dhs = 1;
Hs = tf(Nhs, Dhs);

#Series
GcGps = series(Gcs, Gps);
GcGpHs = series(GcGps,Hs)

#Plot
figure(1)
bode(GcGpHs)

#--- Reavalização ---
Adb = 27.9
Av = 10^(Adb/20)
K = 0.5/Av

#Planta
Ngps = 10;
Dgps = poly([-1;-1]);
Gps = tf(Ngps, Dgps)

#Controlador
Ngcs = K*poly([-100]);
Dgcs = [1 0];
Gcs = tf(Ngcs,Dgcs)

#Sensor
Nhs = 0.1;
Dhs = 1;
Hs = tf(Nhs, Dhs);

#Series
GcGps = series(Gcs, Gps);
GcGpHs = series(GcGps,Hs)

#Plot
figure(2)
margin(GcGpHs)