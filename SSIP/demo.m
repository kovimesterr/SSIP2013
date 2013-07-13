I=imread('./data2/mdb115.pgm');
se = strel('ball',12,50);
%%Performing the enhancing method.
H=hdTransform2(I,60,8);
O1=adapthisteq(I+H);
figure(1)
subplot(121)
imshow(I);
title('Original Image','FontSize',15)
subplot(122)
imshow(O1);
title('H-dome transformed image','FontSize',15)

J = imtophat(I,se);
O2=I+J;
figure(2)
subplot(121)
imshow(I);
title('Original Image','FontSize',15)
subplot(122)
imshow(O2);
title('Top-Hat transformed image','FontSize',15)
