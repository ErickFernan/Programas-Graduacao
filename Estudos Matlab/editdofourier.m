clc
clear all

t = 0:0.01:2.3*pi;
T = 2*pi;

figure(1);
% for n=[5 20 100]
for n= 0:0.5:100
    try
       delete(h)
    end
    serie = 1/2;
    for k = 1:n
        
        serie = serie - ((1/(k*pi))*sin(k.*t));
        
    end
%     hold on
    plot (t, serie);
    drawnow

end  



         
        