x = dlmread ('entradamodelagemalunos.txt');
y = dlmread ('saidamodelagemalunos.txt');

data = [rand(10,1) 10*rand(10,1)-5 rand(10,1)];
fis = genfis1(data,[3 7],char('pimf','trimf'));
[x,mf] = plotmf(fis,'input',1);
subplot(2,1,1), plot(x,mf);
xlabel('input 1 (pimf)');
[x,mf] = plotmf(fis,'input',2);
subplot(2,1,2), plot(x,mf);
xlabel('input 2 (trimf)');

data = [x y];
fis = genfis1(data,[3],char('trimf'));
options.NumMembershipFunctions = 20;
in_fis  = genfis(x,y,options);

options = anfisOptions;
options.InitialFIS = in_fis;
options.EpochNumber = 20;
out_fis = anfis([x y],options);
plot(x,y,x,evalfis(out_fis,x));
legend('Training Data','anfis Output');