clear all #fechar variaveis
close all #fechar figuras
clc #limpar comandos

pkg load control

#FT do Gp
NGp = [100];
DGp = [1 10 100];
Gp = tf(NGp,DGp)

#FT do H
H=1;

#Pela definicao:
# 1+K.G = 0
# Gc = Kp + Ki/s
# Temos:
# 1 + Gc*Gp*H = 0
# 1 + [ (Kp*s+Ki)/s ]*[ 100/(s^2+10s+100) ]*1 = 0
# [ s^3+10s^2+100s+2000s+100*Ki ] / [ s^3+10s^2+100s ] = 0

# Pelo numerador:
# s^3+10s^2+100s+2000s+100*Ki = 0
# Se A(s) = s^3+10s^2+2100s
# Divide o numerado pelo A(s):
# 1 + (Ki*100)/(s^3+10s^2+2100s) = 0
# 1 + Ki * [100/(s^3+10s^2+2100s)] = 0
# Assimilando com " 1 + K*G(s)=0 ", temos:
# K = Ki
# G(s) = 100/(s^3+10s^2+2100s)

#Lugar das Raizes da FT
NGs = [100];
DGs = [1 10 2100 0];
Gs = tf(NGs,DGs)
figure(1)
rlocus(Gs)

#Pelo comando rlocfind()
#utlize o comando a seguir na "Janela de Comando": [K, polos] = rlocfind(Gs)