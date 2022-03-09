clear all
clc


%%

 x = (0:1:559)';
% y = sin(2*x)./exp(x/5);

% x = dlmread ('entradamodelagemalunos.txt');
% y = dlmread ('saidamodelagemalunos.txt');

options = genfisOptions('GridPartition');
options.NumMembershipFunctions = 20;
in_fis  = genfis(x,y,options);

options = anfisOptions;
options.InitialFIS = in_fis;
options.EpochNumber = 20;
out_fis = anfis([x y],options);
figure
plot(x,y,'*',x,evalfis(out_fis,x),'.');
legend('Training Data','anfis Output');


inp2 = dlmread ('entradamodelagemteste.txt');

x2 = (0:1:240)';
Zout2 = evalfis(x2,out_fis);
figure
plot(x2,Zout2);

%%

% data = [rand(10,1) 10*rand(10,1)-5 rand(10,1)];
% fis = genfis1(data,[3 7],char('pimf','trimf'));
% [x,mf] = plotmf(fis,'input',1);
% subplot(2,1,1), plot(x,mf);
% xlabel('input 1 (pimf)');
% [x,mf] = plotmf(fis,'input',2);
% subplot(2,1,2), plot(x,mf);
% xlabel('input 2 (trimf)');
