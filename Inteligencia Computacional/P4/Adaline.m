%%%% Aula Prática 5: Adaline %%%%
clc, clear all, close all  
Entrada = load ('entradamodelagemalunos.txt');
Saida = load ('saidamodelagemalunos.txt');

Tamanho_Amostra = round(0.7*length(Entrada)); % Amostra de teste -> 70% da matriz de dados original

s = randi([1 392],1,Tamanho_Amostra); % Vetor linha de valores aleatórios que tem o tamanho da amostra
 
Amostra_Treino = Entrada(s,1);
Saida_Associada = Saida(s,1);      
%% Início do treinamento
treinos = 3; % Número de treinamentos a serem feitos
% Obter o conjunto de amostras de treinamento {x(k)};
ent_minmax = minmax(Amostra_Treino');
MIN_Ent = ent_minmax(1); MAX_Ent = ent_minmax(2);
Amostra_Ent = (Amostra_Treino-MIN_Ent)/(MAX_Ent-MIN_Ent); % normalizar

Ent = [-1*ones(Tamanho_Amostra,1) Amostra_Ent]'; % Vetor de entrada com o bias
[m,n] = size(Ent); % Dimensões da matriz de entredas

% Associar a saída{d(k)}para cada amostra obtida;
sai_minmax = minmax(Saida_Associada');
MIN_Sai = sai_minmax(1); MAX_Sai = sai_minmax(2);
Saida_des =(Saida_Associada-MIN_Sai)/(MAX_Sai-MIN_Sai); 

% Iniciar o vetor w com valores aleatórios pequenos;
w = rand(1,m); 

% Especificar a taxa de aprendizagem {?} e a precisão de convergência {e};
eta = 0.01; % Taxa de aprendizado
epsilon = 1e-9; % Erro limitante

% Iniciar o contador de número de épocas {época?0};v
epoca = zeros(treinos,1);

% Inicialização do erro:
Eqm_anterior = 0;
Eqm_atual = zeros(treinos,1); %Erro quadrático médio

u = zeros(Tamanho_Amostra,1); 

for p = 1:treinos
    Eqm_anterior = 0;
    Eqm_atual = 0;
    epocas = 0;
    w = rand(2,1)';
    t = 0;
    Early_Stop = 10;
    while Early_Stop >= epsilon
        t = t + 1;
        Eqm_anterior = Eqm_atual;
        Eqm_atual = 0;
        for k = 1:length(Ent)
            u(k) = w*Ent(:,k);
            e = eta*(Saida_des(k) - u(k));
            w = w + e*Ent(:,k)';
            Eqm_atual = (Eqm_atual + ((e^2)/eta))/Tamanho_Amostra;
            epocas = epocas + 1;
        end
        epoca(p) = epoca(p) + 1;
        Eqm_atual_curva(k) = Eqm_atual;
        Early_Stop = abs(Eqm_atual - Eqm_anterior);
    end 
    w
end  

for i = 1:length(Ent)
    u(i) = w*Ent(:,i); 
    y_treinamento = purelin(u);%>>>>>>>>REVER<<<<<<<<<
    e(i) = (Saida_des(i)- y_treinamento(i));
    erro =(e(i))^2;
end 
erro_perc1 = (((erro)*ones(Tamanho_Amostra,1))*100)/length(Entrada); 
disp('Erro de teste (%): ');disp(erro_perc1);

%% Operação do Adaline

Ent_teste = [-1*ones(length(Entrada),1) (Entrada-MIN_Ent/MAX_Ent-MIN_Ent)]; 
e = 0;
for i = 1:length(Entrada)
    u(i)  = (Ent_teste(i,:))*w'; 
    y = purelin(u); 
    e(i) = (Saida(i) - y(i));
    erro =(e(i))^2;
end
 
erro_perc = (((erro)*ones(Tamanho_Amostra,1))*100)/length(Entrada); 
disp('Erro de teste (%): ');disp(erro_perc);
%%
figure()
t = 1:1:392; plot(t,Saida_des');  axis([0 30 0.4 1])
hold on 
plot(t,y_treinamento'); xlabel ('Amostras'), ylabel ('Valor normalizado');
