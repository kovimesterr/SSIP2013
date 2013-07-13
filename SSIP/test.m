%%Setting the path of the database.
database='./data2/';
files=dir(database);

%%Initializing parameters.
n=length(files);
stat=zeros(n-2,6);
block_size=3;

se = strel('ball',12,50);

for i=3:n
    file=strcat(database,files(i).name);
    I=imread(file);

    %%Performing the enhancing method.
%     H=hdTransform2(M,60,8);
%     O=adapthisteq(I+H);
    J = imtophat(I,se);
    O=I+J;
    %%Computing the quantitative error measures.
    [stat(i-2,1), quality_map] = imageQualityIndex (I, O, block_size);
    %Absolute Mean Brightness Error
    stat(i-2,2)=abs(mean2(I)-mean2(O));
    %Enhancement Measure
    stat(i-2,3)=EME(I,size(O,1),block_size);
    stat(i-2,4)=EME(O,size(O,1),block_size);
    %Discrete Entropy
    stat(i-2,5)=entropy(I);
    stat(i-2,6)=entropy(O);
    
    %%Saving the data.
    save('results_tophat.mat','stat');
end