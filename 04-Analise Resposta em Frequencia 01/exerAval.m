# Exercicio Avaliativo
# Gp = 1/(s+1)
# H  = 1
# Mp = 0,25 (25%)
# ts = 2,5s
# Gc -> PI

clear all
close all
clc

#Carregar a Biblioteca
pkg load control

#Sistema da planta
Ngps  = 1;
Dgps  = [1 1];
Gps   = tf(Ngps,Dgps)

#Sistema do sensor
Nhs   = 1;
Dhs   = 1;
Hs    = tf(Nhs,Dhs)

#Sistema em Malha Aberta
GpHs  = series(Gps,Hs)

#Desempenho em Malha Fechada
Mp    = 0.25; #Overshoot
ts    = 2.5;    #Tempo de Acomodação
zeta  = sqrt((log(Mp))^2/((log(Mp))^2+pi^2))  #coeficiente de amortecimento
wn    = 4/(zeta*ts) #frequencia natural

#Localizar os pontos S1 e S2
s1    = -zeta*wn+i*wn*sqrt(1-zeta^2)
s2    = -zeta*wn-i*wn*sqrt(1-zeta^2)

#Plot para verificar
figure(1)
rlocus(GpHs)
hold on
plot(real(s1),imag(s1),'xr') # 'xr' eh 'x' marca o ponto com desenho 'x'
plot(real(s2),imag(s2),'xr') # e'r' anota o marcador com a cor vermelha
hold off

#Lugar das Raizes - C.A. e C.M.
#Como não se tem comando de calcular modulo e angulo diretamente do octave e matlab,
#então calcula-se manualmente utilizando as formulas abaixo.
GpHs1 = 1/(s1+1)  #Função do Gp com o valor do s1 no lugar do s
mag_GpHs1 = abs(GpHs1)
ang_GpHs1 = angle(GpHs1)*180/pi

#Se o angulo for positivo -> Avanço de Fase
#Se o angulo for negativo -> Atraso de Fase
ang_Gcs1  = -180-ang_GpHs1
sp = 0
theta_Cp  = angle(s1+sp)*180/pi
theta_C0  = ang_Gcs1+theta_Cp

#Valores do modulo
mag_Gcs1  = 1/mag_GpHs1
r_C0      = abs(s1+s0)
r_Cp      = abs(s1+sp)

#A partir dos modulos, calcula-se o ganho K
K = mag_Gcs1*(r_C0/r_Cp)

#Sistema do Controlador a partir dos resultados anteriores
Ngcs  = K*[1 s0]
Dgcs  = [1 sp]
Gcs   = tf(Ngcs,Dgcs)

#Sistema de Malha Fechado com o controlador
GcGpHs  = series(Gcs,GpHs)
GcGps   = series(Gcs,Gps)
Ts      = feedback(GcGps,Hs)

#Plot do sistema fechado
figure(2)
rlocus(GcGpHs)
hold on
plot(real(s1),imag(s1),'xr') # 'xr' eh 'x' marca o ponto com desenho 'x'
plot(real(s2),imag(s2),'xr') # e'r' anota o marcador com a cor vermelha
hold off

#Verificar os valores dos polos do sistema de malha fechada
[Nts, Dts]  = tfdata(Ts,'v')
zeros_mf    = roots(Nts)
polos_mf    = roots(Dts)

#Plotar o sistema de malha fechada no domínio do tempo
figure(3)
step(Ts)