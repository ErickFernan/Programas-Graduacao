% Prática 4 - IC
% Este programa tem por função usar o aprendizado por ADALINE prevendo 1
% ponto no futuro de um caso real de aquecimento

clear all;
close all;
clc;

%%
U = dlmread ('entradamodelagemalunos.txt');
Y = dlmread ('saidamodelagemalunos.txt');

%Modelo y(k) = a*(y(k-1))+ b*(u(k)), k=2(primeiro valor)

%montando a matriz de entrada
entradas = zeros(559,2);
for k = 2:1:size(Y) % Pego um a frente, pois irei "prever" esse ponto
      entradas(k,:) = [Y(k-1), (U(k))];
end
entradas(1,:) = [];
saidas = Y(2:end);

%jogando na adelaine
in = entradas;
out= saidas;
n = 0.00000015;
[w b erms epoc] = adalaine1(in,out,n);


Ynovo = entradas*w';
figure(1)
plot ( Ynovo,'g') 
hold on 
plot (Y,'r') 
hold off

yp(1) = Y(1); % Defino o primeiro e faço a predição livre 
for c=1:size(Y)-1
    
 yp(c+1) = w(1)*(yp(c))+ w(2)*(U(c+1));
 
end 

% Parte para a entrega 

Uentrega  = dlmread ('entradamodelagemteste.txt');

yentrega = Y(560);
% yentrega(1,1) = 0; 
for c=2 :size(Uentrega )-1
    
 yentrega(c) = w(1)*(yentrega (c -1))+ w(2)*(Uentrega (c));
 
end 
yentrega = yentrega'; 

figure (3) 
plot ( Y,'g') 
hold on 
plot (yp,'r')

figure (4) 
plot (yentrega) 
hold on 
plot (Uentrega) 

dlmwrite ('exemplosubmissaoadaline.txt ', yentrega) 
 
figure(5)
plot (yentrega) 