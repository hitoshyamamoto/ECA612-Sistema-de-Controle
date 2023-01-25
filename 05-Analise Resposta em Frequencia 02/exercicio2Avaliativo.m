clear all
close all
clc

#Carregar a Biblioteca
pkg load control

#Como h� p�los no semi plano direito (SPD), n�o � recomendado utilizar
#o diagrama de bode, pois o sistema estar� inst�vel tamb�m.
#Assim, � recomendado utilizar o diagrama de nyquist somente neste exerc�cio.

# --- Exerc�cio 2 ---
#Planta
Ngps = 1;
Dgps = [1 -4 5];
Gps = tf(Ngps, Dgps)
#s1,2=2+-j -> 2 polos no SPD (semi plano direito)

#Controlador
K = 50;
Ngcs = K*[1 -1];
Dgcs = [1 20];
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
nyquist(GcGpHs)

# --- Reavalia��o ---

#Nyquist intersect = -0,6538
Av=0.6538;
Av2=0.5;

Kmin = 50/Av
Kmax = 50/Av2

#Controlador
K = 50/Av;
Ngcs = K*[1 -1];
Dgcs = [1 20];
Gcs = tf(Ngcs,Dgcs)

#Series
GcGps = series(Gcs, Gps);
GcGpHs = series(GcGps,Hs)

#Plot
figure(2)
nyquist(GcGpHs)