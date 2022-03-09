% clear all
% clc

%%
y = dlmread ('saidamodelagemalunos.txt');
x = dlmread ('entradamodelagemalunos.txt');

saidaant = [129; y(1:559)];
x = [saidaant x];
dataEdu = [x y];


dataOutput = dlmread ('entradamodelagemteste.txt');
dados = zeros([241 1]);
vetordesaida = [87.6 dataOutput(1)];

for i = 2:241
    
agoravaiOutput = evalfis(vetordesaida,agoravai);
dados(i-1) = agoravaiOutput; 
vetordesaida = [agoravaiOutput dataOutput(i)];

end

agoravaiOutput = evalfis(vetordesaida,agoravai);
dados(241) = agoravaiOutput; 


% dlmwrite ('exemplosubmissaoanfis_erickfinal.txt', dados);
dlmwrite ('exemplosubmissaoanfis.txt', dados);
