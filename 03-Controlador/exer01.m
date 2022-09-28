clear all #fechar variaveis
close all #fechar figuras
clc #limpar comandos

pkg load control

Ngs = [1 4]; #numerador de Gs
Dgs = [1 5 6 0]; #denominador de Gs
Gs = tf(Ngs,Dgs)
figure(1)
rlocus(Gs)
#Estabilidade em malha fechada eh Kp>0