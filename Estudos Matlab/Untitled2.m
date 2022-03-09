clc
clear
% operacoes(1,2)
% [soma, subt] = operacoes(1,2)

load dados;

s = struct('Matricula',[],'Nome',[],'Idade',[],'Curso',[],'Turma',[],'Turno',[],'Situacao',[]);

for i = 1:size(dados,1)
    
    s(i).Matricula = dados(i,1);
    s(i).Nome      = dados(i,2);
    s(i).Idade     = dados(i,3);
    s(i).Curso     = dados(i,4);
    s(i).Turma     = dados(i,5);
    s(i).Turno     = dados(i,6);
    s(i).Situacao  = dados(i,7);
    
end

for i = 1:1:size(dados,1)
    
display(['---------------Aluno ' num2str(i)])
display(s(i))

end

