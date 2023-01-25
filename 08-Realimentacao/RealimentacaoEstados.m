#PROJETO: Sistema PI

#As repostas estao nas ultimas linhas do codigo

# 0 - Alocar polos nao-dominantes (5 vezes mais afastados que os dominantes)
# 1 - Valor de KI
# 2 - O que ocorre com o desempenho do sistema e com sinal de controle se
#     os polos não-dominantes forem alocados 10 vezes mais distantes dos dominantes?
# 3 - Por que há necessidade de se fazer a expansão com integrador?


#Requisitos
#Mp = 0,18 (18%)
#ts = 1,5s

%limpar imagens, variaveis e janela de comando
clear all
close all
clc

%carregar as bibliotecas
pkg load control
pkg load signal

### Caracteristicas do Sistema ###
# Overshoot
Mp = 0.18
# Tempo de Acomodacao
Ta = 1.5
# Coeficiente de Amortecimento
Zeta = sqrt((log(Mp))^2/((log(Mp)^2)+(pi^2)))
# Frequencia natural
Wn = 4/(Zeta*Ta)

#Espaco de Estados
A = [0 1; -5 -6]
B = [0; 1]
C = [1; 0]
D = [0]

#############################
##### Alocacao de Polos #####
#############################

### Polos Dominantes ###
sp_12_real = -Zeta*Wn
sp_12_imag = Wn*sqrt(1-Zeta^2)
sp_1_phase = rad2deg(atan(sp_12_imag/(sp_12_real*(-1))))
sp_2_phase = sp_1_phase*(-1)

s1s2_soma     =  (-1)*2*sp_12_real
s1s2_quadrado =  sp_12_real^2 + sp_12_imag^2

N_dominante = [1 s1s2_soma s1s2_quadrado]
func_dominante = tf(N_dominante,1)

### 2 Estados -> 2 ganhos K de realimentacao de estados ###
aloc_K1 = s1s2_quadrado
aloc_K2 = s1s2_soma
aloc_K = [aloc_K1 aloc_K2]

################################
##### Fórmula de Ackermann #####
################################

### Matrizes expendidas ###
Acker_Ai = [0 1 0; -5 -6 0; -1 0 0]
Acker_Bi = [0; 1; 0]
Acker_AB = [1; -6; 0]
Acker_A2B = [-6;31;-1]
Acker_Mci = [Acker_Bi Acker_AB Acker_A2B]
#Acker_Mci =
#    0    1   -6
#    1   -6   31
#    0    0   -1
Acker_det_Mci = det(Acker_Mci) #det(Mci)=1
Acker_inv_Mci = inv(Acker_Mci)
#Acker_Ki = [K -Ki] # [K -Acker_Ki] = [K1 K2 -Kf]

#Polod dominantes da planta
#Real       -> -2,6667
#Imaginaria ->  4,8855
#polo dominante = 5*(-2,6667)
a0 = s1s2_quadrado*(-1)*5*sp_12_real
a1 = (s1s2_soma*5*(-1)*sp_12_real)+(s1s2_quadrado)
a2 = (5*(-1)*sp_12_real)+(s1s2_soma)
N_dominante_2 = [1 a2 a1 a0]
func_dominante_2 = tf(N_dominante_2,1)

### Polinomio Matricial [psi(Ai,alpha_i)]###
Ai2 = Acker_Ai.*Acker_Ai
Ai3 = Ai2.*(Acker_Ai)
Poli_matricial_psi = Ai3 + (Ai2*a2) + Acker_Ai*a1 + a0.*[1 0 0; 0 1 0; 0 0 1]

Ki = [0 0 1]*(Acker_inv_Mci.*Poli_matricial_psi)
#Ki =
#    0          0  -413.0512
#Ganho Integrativo = Ki = 413.0512

###################
##### GRAFICO #####
###################

#Planta
Gp = tf(1,N_dominante)

#Controlador PI (Ki/s)
#s0 = (-1)*sp_12_real*5;
#NGc = (-413.0512).*[1 s0];
#DGc = [1 0];
#Gc_PI = tf(NGc,DGc)
Gc_PI = (tf((-1)*Ki,1))

#Sensor
H = tf(1,1)

#Malha Fechada
GcGp = Gc_PI*Gp
Ts = feedback(GcGp,H)
figure
step(Ts)

#####################
##### RESPOSTAS #####
#####################

# KI = 413,0512

# Se o polo nao-dominante for alocado a 10 vezes distante em relacao aos polos dominantes,
# o desempenho sera inferior comparado ao 5 vezes distante em relacao aos polos dominantes,
# pois, quanto mais distante o polo nao-dominante estivcer em relacao ao polo-dominante, ele
# influenciara no sistema cada vez menos. Assim, caso contrario, ou seja, quanto mais perto dos
# polos-dominantes, maior sera sua influencia em relacao aos polos dominantes.
