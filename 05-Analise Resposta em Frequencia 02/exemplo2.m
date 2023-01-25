clear all
close all
clc

#Carregar a Biblioteca
pkg load control

#Planta
Ngps = 100;
Dgps = [1 8 100];
Gps = tf(Ngps, Dgps)

#Controlador
K = 10
Ngcs = K*[1 4];
Dgcs = [1 0];
Gcs = tf(Ngcs,Dgcs)

#Sensor
Nhs = 1;
Dhs = 1;
Hs = tf(Nhs, Dhs);

#Series
GcGps = series(Gcs, Gps);
GcGpHs = series(GcGps,Hs)

#Plot
figure(1)
bode(GcGpHs)

figure(2)
margin(GcGpHs)

#Margem de Fase (MF)
#MF = 180-165 = 8,11º (estável em malha fechada)

#MArgem de Ganho (MG)
#MG é infinito, então MG>0.