figure(1)
hold on;

load('./results/results_AMF');
plot(1:39,sort(stat(:,1)),'r');

load('./results/results_BDEC');
plot(1:39,sort(stat(:,1)),'g');

load('./results/results_CLAHE');
plot(1:39,sort(stat(:,1)),'b');

load('./results/results_decorrstretch');
plot(1:39,sort(stat(:,1)),'m');

load('./results/results_hdome');
plot(1:39,sort(stat(:,1)),'k');

load('./results/results_imadjust');
plot(1:39,sort(stat(:,1)),'c');

load('./results/results_imsharpen');
plot(1:39,sort(stat(:,1)),'Color',rand(3,1));

load('./results/results_tophat');
plot(1:39,sort(stat(:,1)),'Color',rand(3,1));








% %Show Absolute Mean Brightness Error
% plot(sort(stat(:,2)),'g');
% hold off;