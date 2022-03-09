%% Limpeza

% clear all 
% close all
% clc

%% Criar populações gaussianas

%% Entradas

m1x = 5 ; % média de x
m1y = 5 ; % média de y
v1x = 2; % variancia de x
v1y = 2; % variancia de y

m2x = 13 ; % média de x
m2y = 5 ; % média de y
v2x = 2; % variancia de x
v2y = 2; % variancia de y

%% População

% X1 = randn(200,1);
% Y1 = randn(200,1);
% 
% X2 = randn(200,1);
% Y2 = randn(200,1);

%% Tratamento para distribuição

x1g = (sqrt(v1x).*X1+m1x); % Aplicação da Gaussiana em x
y1g = (sqrt(v1y).*Y1+m1y); % Aplicação da Gaussiana em y

x2g = (sqrt(v2x).*X2+m2x); % Aplicação da Gaussiana em x
y2g = (sqrt(v2y).*Y2+m2y); % Aplicação da Gaussiana em y

%% Plotar populações 1 e 2

%% Plotagem

x = [x1g y1g; x2g y2g];

figure()
% title ('Distribuição Gaussiana');
hold on
plot(x1g, y1g, '*');
plot(x2g, y2g, '*');

%% Treinamento

saida_esperada = [ones(200,1);zeros(200,1)]; 
bias = -50*ones(400,1);
entrada = [x bias];
w = rand (1,3);
%  w = [-90 100 -350]
flag = 0;
alpha= .5;
count = 0;

while flag == 0 && count < 10^6
    
    count = count+1;
    output = hardlim(entrada*w');
    erro = saida_esperada-output;
    dw = alpha.*erro'*entrada;
    w = w + dw;
    flag = isequal(output,saida_esperada);
    
    
    
   %plotagem
    x = [0 20];
    y = -(w(1)/w(2))*x - bias*w(3)/w(2);
    
    
    h = plot(x,y,'k');
    axis([0 16 0 10])
    drawnow;

    try
       delete(h);
    end
end

x = [0 20];
y = -(w(1)/w(2))*x - bias*w(3)/w(2);
plot(x,y);
axis([0 16 0 10])


%% Funcionando com perceptron, tentar com adaline