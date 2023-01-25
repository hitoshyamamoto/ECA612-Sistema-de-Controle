clear all
close all
clc

#Carregar a Biblioteca
pkg load control

#Planta
Ngps = 1;
Dgps = poly([-1;-1;-1]);
Gps = tf(Ngps, Dgps)

#Controlador
K = 2
Ngcs = K;
Dgcs = 1;
Gcs = tf(Ngcs,Dgcs)

#Sensor
Nhs = 1;
Dhs = 1;
Hs = tf(Nhs, Dhs)

#Plot
figure
GcGpHs = Gc*Gp*Hs
nyquist(GcGpHs)