%% Erick Amorim Fernandes 86301
%  Função para normalização de dados

function y = normalizar(dados)

y = (dados-min(dados))./(max(dados)-min(dados));

end