close all;
clear all;
clc;

%% Pré- Processamento de dados

inp1 = dlmread ('entradasclassalunos.txt');
out1 = dlmread ('saidaclassalunos.txt');

% Grupo 1 se a saida for 0 e grupo 2 se a saida for 1

G1 = []; % Grupo 1
G2 = []; % Grupo 2

a = 1; %V.auxiliar
b = 1; %V.auxiliar

% Separando o Grupo 1 em Grupo 2

for ii = 1: 595
    
    if( out1 (ii,1) == 0)     % Grupo 1
        G1(a) = inp1( ii, 6);
        a = a +1;
    else
        G2(b)  = inp1 (ii,6); % Grupo 2
        b = b +1;
    end
    
end

a = 1;
b = 1;

% Encontrando os pontos de NaN

G1real  = isnan(G1);
G2real  = isnan(G2);
G1semNaN = [];
G2senNaN = [];

% Retirando os NaN
for ii = 1: 220   % Rtirando NaN de G1
    if ( G1real(ii) == 0)
        G1semNaN(a) = G1(ii);
        a = a +1;
    end
end

for ii = 1: 375  % Rtirando NaN de G2
    if ( G2real(ii) == 0)
        G2semNaN(b) = G2(ii);
        b = b+1;
    end
end

% Encontrando  os Valores  medios para NaN1 e NaN2

NaN1 = mean (G1semNaN) ;
NaN2 = mean (G2semNaN) ;

inpo = inp1;
% Substituindo  os Valores nao dados no banco dados

for ii = 1: 595
    aux   = isnan (inp1(ii,6));
    if (aux == 1)
        if( out1 (ii,1) == 0)     % Grupo 1
            inp1(ii,6) = NaN1;
        else
            inp1(ii,6) = NaN2;        % Grupo 1
        end
    end
end
% Temo que inp1 é o vetor ja pronto para ser tratado


%% Tratamento

% Normalizaçao de dados

norm = minmax(inp1');
for ii = 1:size(inp1,2)
    inp1(:,ii) = (inp1(:,ii)-norm(ii,1))/(norm(ii,2)-norm(ii,1));
end
%Concatenando os dados
trnData = [inp1 out1];

fis = genfis2(inp1,out1,0.5);
epoch_n=20;
out_fismat = anfis(trnData,fis,epoch_n);
Zout1 = evalfis(inp1,out_fismat);
% plot(inp1,out1,inp1,out_fismat);

% %% Chamando a funçao de treinamento ]
% numMFs=1;
% mfType='gbellmf';
% epoch_n=20;
% in_fismat=genfis1(trnData,numMFs,mfType);
% out_fismat = anfis(trnData,in_fismat,epoch_n);
% Zout1 = evalfis(inp1,out_fismat);
% %plot(inp1,out1,inp1,out_fismat);

plot(Zout1)
hold on
plot(out1)
%% Validação
% Banco de dados para teste

inp2 = dlmread ('entradasclassteste.txt');

for ii = 1:size(inp2,2)
    inp2(:,ii) = (inp2(:,ii)-norm(ii,1))/(norm(ii,2)-norm(ii,1));
end

Zout2 = evalfis(inp2,out_fismat);

% Gerando o arquivo
dlmwrite ('submissaoanfis_renata.txt', Zout2)