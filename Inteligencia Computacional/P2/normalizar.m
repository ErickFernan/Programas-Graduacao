%% Erick Amorim Fernandes 86301
%  Fun��o para normaliza��o de dados

function y = normalizar(dados)

y = (dados-min(dados))./(max(dados)-min(dados));

end