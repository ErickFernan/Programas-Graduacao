%% Erick Amorim Fernandes 86301
%  Programa para utiliza��o da fun��o "neuronio" criada para pr�tica 2 de
%  disciplina de IC, assim como sua representa��o em plano cartesiano.

%% Inicializa��o
close all
clear all
clc

%% NAND

%% Utiliza��o do neur�nio

Ent = [[0 0];   % Entrada de dados
       [0 1];
       [1 0];
       [1 1]]; 
   
w = [-0.9 -0.9]; % Pesos

bias = 1;

y = neuronio(Ent,w,bias); 

%% Parte respons�vel pela plotagem

Xr = Ent(:,1);
Yr = Ent(:,2);
r = -((w(1)/w(2)).*Xr) - (bias/w(2));

figure()
plot(Xr(1:3),Yr(1:3),'*','linewidth',2,'MarkerSize',12)
hold on
plot(Xr(4),Yr(4),'rX','linewidth',2,'MarkerSize',12)
plot(Xr,r,'k','linewidth',2)
title('Fun��o L�gica NAND')
legend('y = 1','y = 0','Location','North')

%% OR

%% Utiliza��o do neur�nio

Ent = [[0 0];   % Entrada de dados
       [0 1];
       [1 0];
       [1 1]]; 
   
w = [.9 .9]; % Pesos

bias = -.8;

y = neuronio(Ent,w,bias);

%% Parte respons�vel pela plotagem

Xr = Ent(:,1);
Yr = Ent(:,2);
r = -((w(1)/w(2)).*Xr) - (bias/w(2));

figure()
plot(Xr(2:4),Yr(2:4),'*','linewidth',2,'MarkerSize',12)
hold on
plot(Xr(1),Yr(1),'rX','linewidth',2,'MarkerSize',12)
plot(Xr,r,'k','linewidth',2)
title('Fun��o L�gica OR')
legend('y = 1','y = 0','Location','North')

%% XOR 

%% Representa��o gr�fica

Ent = [[0 0];   % Entrada de dados
       [0 1];
       [1 0];
       [1 1]]; 

Xr = Ent(:,1);
Yr = Ent(:,2);   
       

figure()
plot(Xr(2:3),Yr(2:3),'*','linewidth',2,'MarkerSize',12)
hold on
plot(Xr(1),Yr(1),'rX','linewidth',2,'MarkerSize',12)
plot(Xr(4),Yr(4),'rX','linewidth',2,'MarkerSize',12)
plot([0,1],[0.5,1.5],'k','linewidth',2)
plot([0,1],[-0.5,0.5],'k','linewidth',2)
title('Fun��o L�gica XOR')
legend('y = 1','y = 0','Location','North')