clear all
close all
clc

pkg load control

%Funcoes de Transferencia
%Gp->planta // Gc->Controlador // H->Sensor
s = tf('s');
Gp = tf([1],[1,10]);
Gc = tf([100 200],[1 0]);
H = tf([0.1],[0.01 1]);

%Malha Fechada
T = feedback(Gc*Gp, H)

%Conjunto de Plots
figure(1)
step(T)
figure(2)
ramp(T)
figure(3)
bode(T)
