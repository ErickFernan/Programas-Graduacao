clc;
clear;
% x = 0: 0.3: 8*pi;
% g = cos(x); 
% f = sin(x);
% z = 2*x;
% subplot(2,2,1);
% plot (x,g,'--r',x,f,'vb');
% title ('Cos e Sen de 0 a Pi');
% xlabel ('Eixo X');
% ylabel ('Eixo Y');
% 
% subplot(2,2,2);
% plot (g);
% title ('Cosseno de X');
% xlabel ('Eixo X');
% ylabel ('Eixo Y');
% 
% subplot(2,2,3);
% plot (f,'og');
% title ('Seno de X');
% xlabel ('Eixo X');
% ylabel ('Eixo Y');
% 
% subplot(2,2,4);
% plot (z,'r');
% title ('Z = 2*X');
% xlabel ('Eixo X');
% ylabel ('Eixo Y');


% t = 0:0.1:100;
% subplot(1,2,2)
% plot3(cos(t),sin(cos(t).^2),t);
% 
% ta = 1:0.1:100;
% subplot(1,2,1)
% comet3(ta,cos(ta)./ta,sin(ta)./ta);

% [x,y] = meshgrid(-3:0.1:3,-3:0.1:3);
% subplot(1,2,1);
% surf(x,y,x.*exp(-x.^2-y.^2));
% colorbar;
% subplot(1,2,2);
% mesh(x,y,x.*exp(-x.^2-y.^2));
% colorbar;

 [x,y] = meshgrid(-50:0.1:50,-50:0.1:50);
 surf(x,y,sin(sqrt(x.^2+y.^2)));
 colorbar;

% contour(x,y,sin(sqrt(x.^2+y.^2)),100);
% pcolor(x,y,sin(sqrt(x.^2+y.^2)))
 shading interp
