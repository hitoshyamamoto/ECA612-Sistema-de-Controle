clear all
close all
clc

pkg load control

NGs1 = [1];
DGs1 = [1 1 5 0];
Gs1 = tf(NGs1,DGs1)

figure(1)
rlocus(Gs1)

NGs2 = [1 0];
DGs2 = [1 1 0 20];
Gs2 = tf(NGs2,DGs2)

figure(2)
rlocus(Gs2)

NGs3 = [1];
DGs3 = [1 1 0 0];
Gs3 = tf(NGs3,DGs3)

figure(3)
rlocus(Gs3)