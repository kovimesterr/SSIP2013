for gs=3:2:31
    load(strcat('./anim9/deconv_blind_width',num2str(gs),'.mat'));
    I=imread((strcat('./anim9/deconv_blind_width0',num2str(gs),'.png')));
    figure(1);
    imshow(I);
    figure(2);
    subplot(121);
    surf(PSF)
    title('Original PSF')
    subplot(122);
    surf(P);    
    title('Reconstructed PSF')
    figure(3)
    surf(abs(PSF-P))
    title('Absolute difference')
    pause;
end
