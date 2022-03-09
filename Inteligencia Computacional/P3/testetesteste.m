clc
clear all

%%

Dados = [  18   1    0     1     0      0     1200       0;  %treinamento
           19   1    1     1     1      1      700       1;  %treinamento
           25   0    0     0     1      2      800       1;  %treinamento
           40   1    1     0     1      4      800       0;  %treinamento
           21   1    0     0     0      0     1100       1;  %treinamento
           22   0    1     1     1      2      500       0];  %treinamento
         
%            25   0    0     0     1      2      800       1]; %aplicação
       
       
%% Normalizando

dds_normalizado = [normalizar(Dados(:,1))   , Dados(:,2:5) , ...
                   normalizar(Dados(:,6:7)) , Dados(:,8)];


%% Inicio

% x = [0 0 3 1;
%      0 3 0 1;
%      1 1 3 1];
 x = dds_normalizado(:,1:7);
 x = x';
 
 
% correct_output = [0;1;1;1];
 correct_output = dds_normalizado(:,8);
                 
% W = [0;0;0];
 W = zeros(7,1);
 

alpha = 0.95; % Tx de aprendizagem


%% Treinamento

for epoch = 1:50 % Num de vezes do treinamento
    
    N = 6;
    
    for k = 1:N
        
        output(k) = hardlim (W'*x(:,k));
        error = correct_output(k) - output(k);
        dW = alpha*error*x(:,k);
        
        if error ~= 0 % Correção dos pesos
            
            for i = 1:7
                
            W(i) = W(i) + dW(i);
            
            end
            
        end
        
    end
    
end

%% testar


    
output = hardlim(W'*x);
    


% [output' , correct_output]

%%

count = 0;
output = output';

for i = 1:6
  
    teste = output(i)-correct_output(i);
    
    if teste ~= 0
        
        count = count + 1;
    
    end
    
    teste = 0;
    
end

    
    
    
    
    
    