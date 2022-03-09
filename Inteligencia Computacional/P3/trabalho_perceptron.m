clc
clear all

%% Inicio

x = [5 0 3 1;
     0 3 45 1;
     1 1 3 1];

 
correct_output = [0;
                  1;
                  0;
                  1];
                
W = [0;
     0;
     0];
 

alpha = 0.95; % Tx de aprendizagem


%% Treinamento

for epoch = 1:100 % Num de vezes do treinamento
    
    N = 4;
    
    for k = 1:N
        
        output(k) = hardlim (W'*x(:,k));
        error = correct_output(k) - output(k);
        dW = alpha*error*x(:,k);
        
        if error ~= 0 % Correção dos pesos
            
            W(1) = W(1) + dW(1);
            W(2) = W(2) + dW(2);
            W(3) = W(3) + dW(3);
            
        end
        
    end
    
end

%% testar


    
    output(k) = hardlim(W'*x(:,k))
    



       
    