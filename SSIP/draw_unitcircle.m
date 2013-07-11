function [x,y]=draw_unitcircle()
theta = linspace(0,2*pi,100);
x = cos(theta);                  
y = sin(theta);
plot(x,y,'k','LineWidth',3); 
hold on;
plot([-1,1],[0,0],'Color',[192 192 192]/256,'LineWidth',1);
plot([0,0],[-1,1],'Color',[192 192 192]/256,'LineWidth',1);
%title('Pólus diagram');
axis('equal'); 
axis([-1.02 1.02 -1.02 1.02]);
set(gca,'xTick',[-1 -0.5 0 0.5 1]);
set(gca,'yTick',[-1 -0.5 0 0.5 1]);
box on;