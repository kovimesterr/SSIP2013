titles{1}='Universal Image Quality Index (UIQUI)';
titles{2}='Absolute Mean Brightness Error (AMBE)';
titles{4}='Enchancement Measure (EME)';
titles{6}='Discrete Entropy (H)';


for i=[1,2,4,6]
    figure(i)
    hold on;

    load('./results/results_AMF');
    plot(1:39,sort(stat(:,i)),'r');

        load('./results/results_BDEC');
        plot(1:39,sort(stat(:,i)),'g'); %%It is much larger in magnitude than the others for AMBE.

    
    load('./results/results_CLAHE');
    plot(1:39,sort(stat(:,i)),'b');

    load('./results/results_decorrstretch');
    plot(1:39,sort(stat(:,i)),'m');

    load('./results/results_hdome');
    plot(1:39,sort(stat(:,i)),'k');

    load('./results/results_imadjust');
    plot(1:39,sort(stat(:,i)),'c');

    load('./results/results_imsharpen');
    plot(1:39,sort(stat(:,i)),'Color',rand(3,1));

    load('./results/results_tophat');
    plot(1:39,sort(stat(:,i)),'Color',rand(3,1));
    
%     if i>2
        plot(1:39,sort(stat(:,i-1)),'s-','Color',rand(3,1));   
        legend('AMF','BDEC','CLAHE','decorrstretch','h-dome','imadjust','imsharpen','top-hat','Original');
%     else
%         legend('AMF','BDEC','CLAHE','decorrstretch','h-dome','imadjust','imsharpen','top-hat');    
%     end
    title(titles{i},'FontSize',15);
    box on
end

%for i=2






