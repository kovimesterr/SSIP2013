addpath('C:\MATLAB7\work\rait');
% for pole=0:0.05:0.99
%     figure(1)
%     draw_unitcircle;
%     hold on;    
%     plot(pole,0,'r.','MarkerSize',25);
%     drawnow;
%     hold off;
%     title('Pole(s) of the system','Interpreter','Latex','FontSize',17);
% end

figure(2);
num=0;
for pole=0:0.05:0.99
    figure(1)
    subplot(2,2,[1]);
    draw_unitcircle;
    hold on;    
    plot(pole,0,'r.','MarkerSize',25);
    drawnow;
    hold off;
    title('Pole(s) of the system','Interpreter','Latex','FontSize',17);
    
    n=1000;
    t=linspace(-pi,pi,n);
    mpoles=multiply_poles(pole,2);
    mts=mt_system(n,mpoles);
    subplot(2,2,2);
    plot(t,real(mts(2,:)),'b','LineWidth',2);
    axis([-pi,pi,-7,7]);
    title('Real part of the system','Interpreter','Latex','FontSize',17);
    subplot(2,2,4);
    plot(t,imag(mts(2,:)),'r','LineWidth',2);
    axis([-pi,pi,-2*pi,2*pi]);
    title('Imaginary part of the system','Interpreter','Latex','FontSize',17);

    subplot(2,2,[3]);
    mts=mt_system(2000,mpoles);
    plot(mts(2,:),'k','LineWidth',2);   
    axis square;
    axis([-5,6.5,-6,6]);
    title('Complex curve of the system','Interpreter','Latex','FontSize',17);  
    
    drawnow;
    num=num+1;
    saveas(gca,strcat('./anim1/pole_rad_',num2str(num),'.pdf'));
end
