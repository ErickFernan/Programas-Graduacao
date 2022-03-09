close all
clear all
clc

%% cria��o de met�do por logica fuzzy para se assemlhar a fun��o 
%  y = sin(x)/x [0,2pi] passo 0.01

x = 0:0.01:2*pi;
y = sin(x)./x;

y(isnan(y))=1;

figure(1)
hold on
plot (x,y);

%% Parte para obten��o da figura

dados = zeros(1,629);
count = 1;
xpontos = 0:0.01:2*pi;

for A = 0:0.01:2*pi
    
    fis = readfis('SenXsobreXErick');
    options = evalfisOptions;
    options.NumSamplePoints = 629;
    [y2,irr,orr,arr,rfs] = evalfis(fis,[A],options);
    dados(count) = y2;
    count = count+1;
    
end    
 
plot(xpontos,dados);

%% Parte para calcular a correla��o

R = corrcoef(y,dados);
