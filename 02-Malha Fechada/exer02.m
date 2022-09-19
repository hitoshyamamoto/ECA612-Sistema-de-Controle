clear all
close all
clc

pkg load control

s = tf('s');
Gp = tf([1],[1,10])
Gc = tf([100 200],[1 0])
H = tf([0.1],[0.01 1])

T = feedback(Gc*Gp, H)

