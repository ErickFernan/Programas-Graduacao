%% Erick Amorim Fernandes 86301
%  Este programa tem por objetivo aprender um padr�o de analise cr�dito
%  atr�ves de um banco de dados inicial e depois reproduzir sua tomada de
%  decis�o em 3 casos hipoteticos

%% Inicializa��o

clear all
close all
clc

%% Dados para treinamento
%  Masculino sera considerado como 1, Feminino como 0
%        Idade Sexo Casa Carro Casado Filhos  Renda  Resultado

Dados = [  18   1    0     1     0      0     1200       0;  %treinamento
           19   1    1     1     1      1      700       1;  %treinamento
           25   0    0     0     1      2      800       1;  %treinamento
           40   1    1     0     1      4      800       0;  %treinamento
           21   1    0     0     0      0     1100       1;  %treinamento
           22   0    1     1     1      2      500       0;  %treinamento
           18   0    1     0     0      0     1100       0;  %aplica��o
           30   1    1     1     1      3      500       0;  %aplica��o
           22   0    0     0     1      1     1200       0];  %aplica��o
%            25   0    0     0     1      2      800       1]; %aplica��o
       
       
%% Normalizando

dds_normalizado = [normalizar(Dados(:,1))   , Dados(:,2:5) , ...
                   normalizar(Dados(:,6:7)) , Dados(:,8)];
 
%% Treinamento               
%  Encontrar os pesos que satisfazem nossos dados de entrada tomando o bias = -1;

bias = -1; 
w = ones(1,7); % Cria��o do vetor de pesos
y = ones(6,1); % Vetor de resposta 
flag = 0; 
a=-2;
b=2;

while flag == 0
    
    w = a+(b-a)*rand(1,7); % Intervalo para busca de solu��es
    y = neuronio(dds_normalizado(1:6,1:7) ,w ,bias); 
    flag = isequal(y,dds_normalizado(1:6,8));
    
end

               
%% Aplicando ao neur�nio

[A,L] = size(Dados); % Respons�vel por pegar o ponto final dos dados de aplica��o

y2 = neuronio(dds_normalizado(7:A,1:7) ,w ,bias)

