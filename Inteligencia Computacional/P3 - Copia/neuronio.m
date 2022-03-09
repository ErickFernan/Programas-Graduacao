%% Erick Amorim Fernandes 86301
%  Função matemática para representação de um neurônio baseado no Modelo 
%  de McCulloch-Pitts 

% x -> vetor de entrada
% w -> vetor de pesos

function y = neuronio(x,w,bias) 

soma = 0;
[A,B] = size(x);

for j = 1:A
    
    for i = 1:B;
        soma = soma + x(j,i)*w(i);
    end
    
    y(j) = hardlim(soma+bias);
    y = y';
    soma = 0;
end

    
        
        
        



