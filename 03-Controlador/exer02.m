clear all #fechar variaveis
close all #fechar figuras
clc #limpar comandos

pkg load control

#Funcao de Transferencia da Planta
#utilizando o comando poly()
Ngp = 2;
Dgp = poly([2;-3]);
Gp = tf(Ngp,Dgp)

#Funcao de Transferencia do Sensor
#utilizando o formato de vetor
Nh = [0.1];
Dh = [0.1 1];
H = tf(Nh,Dh)

#Pela definicao: 1 + K.G = 0
#No sistema, temos: 1 + Gc.Gp.H = 0

#Gc = Kp    ...(Ganho no sistema)
#Gs = Gp.H  ...(Funcao de TRansferencia Resultante do Sistema)                   

#Definindo a Funcao de Transferencia do sistema
Gs = series(Gp,H)

#Plotando o Lugar das Raizes
figure(1)
rlocus(Gs)

#Pelo comando rlocfind()
#utlize o comando a seguir na "Janela de Comando": [K, polos] = rlocfind(Gs)