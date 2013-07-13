titles{1}='Universal Image Quality Index (UIQ)';
titles{2}='Absolute Mean Brightness Error (AMBE)';
titles{4}='Enchancement Measure (EME)';
titles{6}='Discrete Entropy (H)';

ic1=rand(3,1);
ic2=rand(3,1);
ic3=rand(3,1);

%for i=[1,2,4,6]
i=2
    figure(i)
    hold on;

    load('./results/results_AMF');
    plot(1:39,sort(stat(:,i)),'r','LineWidth',2);
    
    load('./results/results_CLAHE');
    plot(1:39,sort(stat(:,i)),'b','LineWidth',2);

    load('./results/results_decorrstretch');
    plot(1:39,sort(stat(:,i)),'m','LineWidth',2);

    load('./results/results_hdome');
    plot(1:39,sort(stat(:,i)),'k','LineWidth',2);

    load('./results/results_imadjust');
    plot(1:39,sort(stat(:,i)),'c','LineWidth',2);

    load('./results/results_imsharpen');
    plot(1:39,sort(stat(:,i)),'Color',ic1,'LineWidth',2);

    load('./results/results_tophat');
    plot(1:39,sort(stat(:,i)),'Color',ic2,'LineWidth',2);
    
     if i>1
        plot(1:39,sort(stat(:,i-1)),'.-','Color',ic3,'LineWidth',2);     
     end
     
    %load('./results/results_BDEC');
    %plot(1:39,sort(stat(:,i)),'g','LineWidth',2); %%It is much larger in magnitude than the others for AMBE.

    if i>1  
        legend('AMF','CLAHE','decorrstretch','h-dome','imadjust','imsharpen','top-hat','Original','BDEC');
    else
        legend('AMF','CLAHE','decorrstretch','h-dome','imadjust','imsharpen','top-hat','BDEC');    
    end
    
    
    title(titles{i},'FontSize',15);
    box on
%end

%for i=2






