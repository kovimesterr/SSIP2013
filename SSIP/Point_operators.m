% Basic Image Processing Operations: 

disp ('Welcome to the Point Operators')
disp ('The worksheet follows the text directly and allows you to process basic images.')

%Let's initialise the display colour
colormap(gray);

%And let's start with empty memory
clear

disp (' ')
disp ('Let us use the image of a mammogram')
%read in the image
mammo=imread('Mammo5_contrast.pgm','pgm');
%images are stored as integers, so we need to double them for Matlab
%we also need to ensure we have a greyscale, not three colour planes 
mammo=double(mammo(:,:,1));
disp ('Let us see the top left hand corner')
%print out top left corner
mammo(1:10,1:10)
%and display it as an image
%we need to scale for the early section of this worksheet only, using a minimum
mini=min(min(mammo));
%and a maximum
maxi=max(max(mammo));
subplot (1,1,1), imagesc(mammo, [mini maxi])
plotedit on, title ('Original image of a mammo'), plotedit off
disp ('When you are ready to move on, press RETURN') 
pause;

%Let's show its dimensions
disp (' ')
disp ('The size of this image is')
size(mammo)

disp (' ')
disp ('Let us have a look at its histogram. This is a count of all pixels with a ')
disp ('specified brightness level, plotted against brightness level.') 
%We can calculate it by invoking the function histogram.m
hist_mammo=histogram(mammo);
%now we shall plot it
plot(hist_mammo);
plotedit on, title ('Histogram'), xlabel ('Brightness'),ylabel ('Number'),
plotedit off
 pause

disp (' ')
disp ('The most common point operator replaces each pixel by a scaled version of ')
disp ('the original value. We therefore multiply each pixel by a number (like a ')
disp ('gain), by specifying a function scale which is fed the picture and the ')
disp ('gain, or a level shift (upwards or downwards). The function scale takes ')
disp ('a picture pic and multiplies it by gain -here 1.1 - and adds a level -')
disp ('here 10. After viewing the image press RETURN')
 
%We'll call the function scale.m
brighter=scale(mammo,1.1,10);
disp ('Let us see the top left hand corner')
brighter(1:10,1:10)
subplot(2,2,1), imagesc(mammo, [mini maxi])
plotedit on, title ('Original image'), plotedit off
subplot(2,2,2), plot(histogram(mammo))
plotedit on, title ('Original histogram'), plotedit off
subplot(2,2,3), imagesc(brighter, [mini maxi])
plotedit on, title ('Brighter image'), plotedit off
subplot(2,2,4), plot(histogram(brighter))
plotedit on, title ('Brighter histogram'), plotedit off
pause

mult=input('Now choose a new value for the scale (e.g. 0.8) ');
add=input('And a new value for the offset (e.g. 5) ');
nbrighter=scale(mammo,mult,add);
disp ('Now see the result')
subplot(2,2,1), imagesc(mammo, [mini maxi])
plotedit on, title ('Original image'), plotedit off
subplot(2,2,2), imagesc(nbrighter, [mini maxi])
plotedit on, title ('New Image'), plotedit off
subplot(2,2,3), imagesc(brighter, [mini maxi])
plotedit on, title ('Brighter image'), plotedit off
subplot(2,2,4), plot(histogram(nbrighter))
plotedit on, title ('New histogram'), plotedit off
pause;

disp (' ')
disp ('For guaranteed viewing, we normalise images to stretch their histogram to ')
disp ('occupy all available grey levels. This is what appears to be done by ')
disp ('Matlabs imagesc function')
%We'll call the function normalise.m
norm_mammo=normalise(mammo);
disp ('Let us see the top left hand corner')
norm_mammo(1:10,1:10)
imagesc(norm_mammo);
plotedit on, title ('Normalised image'), plotedit off 
pause;
disp ('The histogram of the new image shows how all the grey levels have been used')
hist_norm=histogram(norm_mammo);
plot(hist_norm);
plotedit on, title ('Normalised Histogram'), plotedit off 
pause;

disp (' ')
disp ('The display process optimised for human viewing is called histogram equalisation ')
disp ('Here, unlike intensity normalisation, black and white are not given the same weight')
disp ('This stretches image intensity in a manner particularly suited to human viewing')
%We'll call the function equalise
equa_mammo=equalise(mammo);
equa_mammo(1:10,1:10)
imagesc(equa_mammo);
plotedit on, title ('Equalised image'), plotedit off 
pause;
disp ('The histogram of the new image shows how all the grey levels have been used')
equa_hist=histogram(equa_mammo);
plot(equa_hist);
plotedit on, title ('Equalised histogram'), plotedit off 
pause;

disp (' ')
disp ('We shall now consider the thresholding function that sets points above a ')
disp ('specified level to white and all others to black. Using a threshold of 161, we get')
%We'll call the function threshold
thre_mammo=threshold(mammo,160);
thre_mammo(1:10,1:10)
imagesc(thre_mammo)
plotedit on, title ('Image thresholded at 160'), plotedit off 
pause;
thresh=input('Now choose a threshold (e.g. 180) ');
nthre_mammo=threshold(mammo,thresh);
subplot(1,2,1), imagesc(thre_mammo)
plotedit on, title ('Mammo thresholded at '), plotedit off 
subplot(1,2,2), imagesc(nthre_mammo)
plotedit on, title ('Mammo thresholded at new value'), plotedit off 
disp ('If your threshold was bigger than 161, fewer points should be set')
disp ('to white')
pause;

