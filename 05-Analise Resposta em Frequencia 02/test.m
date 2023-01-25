clear all
close all
clc

#Carregar a Biblioteca
pkg load control

Gs = control.tf([1 1],[1 2])

#Bode
bode(Gs)
[mag, phase, w] = bode(Gs, {min, max})
mag = 20*log10(mag)

#Nyquist
nyquist(Gs)
[Re, Im, w] = nyquist(Gs, {wmin, wmax})