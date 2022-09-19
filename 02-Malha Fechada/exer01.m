clear all
close all
clc

pkg load control

%y..(t)+5y.(t)+6y(t) = u.(t)+u(t)
%pela Transformada de LaPlace
%2s^2.Y(s)+5s.Y(s)+6.Y(s) = sU(s)+U(s)
%(2s^2+5s+6)*Y(s) = (s+1)*U(s)
%y->saida // u->entrada
%G(s)=(s+1)/(2s^2+5s+6)
s = tf('s');
G = tf([1,1],[2,5,6])
