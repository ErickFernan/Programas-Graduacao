%% IC - Prática 6
%  Aplicação da fç treinada

clear all;
close all;
clc;

%%
% nnstart

%%
U = dlmread ('entradaajustealunos.txt');
Y = dlmread ('saidaajustealunos.txt');
Z = dlmread ('entradaajusteteste.txt');


[out] = myNeuralNetworkFunction(Z);
[out2] = neuronio2(Z');
% dlmwrite ('exemplosubmissaomlp.txt',out);
figure
plot(out)
axis([0 1400 0 14])
figure
plot(out2)
axis([0 1400 0 14])