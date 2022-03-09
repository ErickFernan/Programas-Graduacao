clc
clear all

%%

arquivo=fopen('entradasclassalunos.txt');
x_t=fscanf(arquivo,'%f',[9,595]);
fclose(arquivo);
x_treinamento=x_t';
[linhas,colunas]=size(x_treinamento);
x_treinamento(isnan(x_treinamento))=0;  


arquivo2=fopen('saidaclassalunos.txt');
[y_treinamento,contador]=fscanf(arquivo2,'%f');
fclose(arquivo2);



arquivoteste=fopen('entradasclassteste.txt');
x_t2=fscanf(arquivoteste,'%f',[9,104]);
fclose(arquivoteste);
x_teste=x_t2';
[linhasteste,colunasteste]=size(x_teste);
x_teste(isnan(x_teste))=0; 
x_teste = [-1*ones(104,1) x_teste];
x_teste = x_teste';


%% Inicio

% x = [0 0 3 1;
%      0 3 0 1;
%      1 1 3 1];
 x = x_treinamento;
 bias = -1*ones(595,1);
 x =[bias x];
 x = x';
 
 
% correct_output = [0;1;1;1];
 correct_output = y_treinamento;
                 
% W = [0;0;0];
 W = zeros(10,1);
 
error = 1;
alpha = 0.01; % Tx de aprendizagem


%% Treinamento

for epoch = 1:400 % % Num de vezes do treinamento
    
    N = 595;
    
    for k = 1:N
        
        output(k) = hardlim (W'*x(:,k));
        error = correct_output(k) - output(k); 
        dW = alpha*error*x(:,k);
        
        
        if error ~= 0 % Correção dos pesos
            
            for i = 1:10
                
            W(i) = W(i) + dW(i);
            
            end
            
             
        end
        
    end
    
end

%% testar


    
output = hardlim(W'*x);
output2 = hardlim(W'*x_teste);
    



% [output' , correct_output]

%%

count = 0;
output = output';
output2 = output2';

dlmwrite ('submissaoperceptron.txt ', output2)

for i = 1:595
  
    teste = output(i)-correct_output(i);
    
    if teste ~= 0
        
        count = count + 1;
    
    end
    
    teste = 0;
    
end

%[output correct_output]
    
    
    
    
    
    