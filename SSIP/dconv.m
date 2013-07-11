%%Loading the test image.
I=imread('testimg.png');
gs=21; %Size of the gaussion window.
delta2=10;

%for delta2=linspace(1,10,25)    
for gs=3:2:31    
    PSF = fspecial('gaussian',gs,delta2);
    V = [0.0001];
    BlurredNoisy = imnoise(imfilter(I,PSF),'gaussian',0,V);
    WT = zeros(size(I));
    WT(5:end-4,5:end-4) = 1;
    INITPSF = ones(size(PSF));
    [J P] = deconvblind(double(BlurredNoisy)/255,PSF,20,10*sqrt(V),WT);
%    [J P] = deconvblind(double(BlurredNoisy)/255,PSF,20,V,WT);

    subplot(221);imshow(BlurredNoisy);
%    title(strcat('A = Blurred and Noisy with the PSF of std= ', num2str(delta2)));
    title(strcat('A = Blurred and Noisy with the PSF of width= ', num2str(gs)));
    subplot(222);imshow(PSF,[]);
    title('True PSF');
    subplot(223);imshow(J);
    title('Deblurred Image');
    subplot(224);imshow(P,[]);
    title('Recovered PSF');
    %saveas(gca,strcat('./anim9/deconv_blind_width',num2str(gs),'.png'));
    save(strcat('./anim8/deconv_blind_width',num2str(gs),'.mat'),'PSF','P');
end