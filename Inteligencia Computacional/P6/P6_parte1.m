close all
clear all
clc

%% criação de metódo por logica fuzzy para se assemlhar a função 
%  y = x^2 [-4,4]

x = -4:0.01:4;
y = x.^2;

figure(1)
hold on
plot (x,y);

%% Parte para obtenção da figura

dados = zeros(1,801);
count = 1;
xpontos = -4:0.01:4;

for A = -4:0.01:4
    
    fis = readfis('Xquadradoerick');
    options = evalfisOptions;
    options.NumSamplePoints = 801;
    [y2,irr,orr,arr,rfs] = evalfis(fis,[A],options);
    dados(count) = y2;
    count = count+1;
    
end    
 
plot(xpontos,dados);

%% Parte para calcular a correlação

R = corrcoef(y,dados);
