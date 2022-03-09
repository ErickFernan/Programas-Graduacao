
clear all
close all
clc

%% Criação de duas séries temporais

% x1 = timeseries(rand(10,1));
% x2 = timeseries(rand(10,1));

t = [0:0.01:20];
x1 = sin(t);
x2 = 4*sin(t);

subplot(2,1,1)
plot(x1,'LineWidth',2)
axis([0,2000,-4,4])
title ('sin(t)');
subplot(2,1,2)
plot(x2,'LineWidth',2)
axis([0,2000,-4,4])
title ('4*sin(t)');

%% Adicionar dados da série e uma variável

% S1 = x1.data;
% S2 = x2.data;

S1 = x1;
S2 = x2;

%% Aplicando a fórmula para cálculo de distorção

soma_num = 0;
soma_den = 0;

for i = 1 : length (S1)
    
    num = (S1(i)-S2(i)).^2;
    soma_num = soma_num + num;
    
    den = (S1(i)).^2;
    soma_den = soma_den + den;
    
end

media_num = soma_num/ length(S1);
media_den = soma_den/ length(S1);

dxy = 10*log10(soma_num/soma_den)


