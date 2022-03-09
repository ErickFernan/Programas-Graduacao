%% Erick Amorim Fernandes 86301
%  Fun��o matem�tica para representa��o de um neur�nio baseado no Modelo 
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

    
        
        
        



