function [ G, F] = HMLCE( file )

psi=0.8;
c1=1/(1+psi);
c2=psi/(1+psi);
    
I=imread(file);
F=uint8(zeros(size(I)));
G=uint8(zeros(size(I)));

meanI=mean2(I);
stdI=std2(I).^2;

n=size(I,1)*size(I,2);
gi=imhist(I)/n;
u=ones(256,1)/256;

g=c1.*gi+c2.*u;
f=cumsum(g);
f=uint8((f-min(f))./(1-min(f)).*255+0.5);
for i=1:1:size(I,1)
    for j=1:1:size(I,2)        
        F(i,j)=f(I(i,j)+1);
    end
end
subplot(1,3,1);
imshow(I);
title('Original image');

subplot(1,3,2);
imshow(F);
title('Histogram modified image');


%% Local contrast enhancement.
%Defining constants.
E=3.0;
K0=0.5;
K1=0.03;
K2=0.5;
kernel=3;

%Processing image 'F'.
w=floor(kernel/2);
for i=2:1:size(I,1)-1
    for j=2:1:size(I,2)-1       
        Sxy=F(i-w:i+w , j-w:j+w);
        meanSxy=mean2(Sxy);
        stdSxy=std2(Sxy).^2;
        if meanSxy<=K0*meanI && K1*stdI<=stdSxy && stdSxy<=K2*stdI
            E*F(i,j);
            G(i,j)=E*F(i,j);
        else
            G(i,j)=F(i,j);
        end
    end
end
G=uint8((G-min(min(G))./(max(max(G))-min(min(G))).*255+0.5));

subplot(1,3,3);
imshow(G);
title('HMLCE image');