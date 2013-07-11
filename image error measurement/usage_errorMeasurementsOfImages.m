%%
clear all; clc;

%% report format characters
newlineInAscii1 = [13 10];
spaceInInAscii = 32;
% for printing, newline causes much confusion in matlab and is provided here as an alternative
newline = char(newlineInAscii1); 
spaceChar = char(spaceInInAscii);

%% plot parameters
plotIndex = 1;
plotRowSize = 1;
plotColSize = 2;

%% read the image
targetFolder = 'images';

IMG = 'lena.jpg';   % IMG : originalImage
IMG = strcat(targetFolder, '\', IMG);
IMG = imread(IMG);
IMG = rgb2gray(IMG);
IMG = double(IMG);

%% noise parameters
sigma = 0.05;
offset = 0.01;

erosionFilterSize = 2;
dilationFilterSize = 2;
mean = 0;

noiseTypeModes = {
    'gaussian',         % [1]
    'salt & pepper',    % [2]    
    'localvar',         % [3]
    'speckle',          % [4] (multiplicative noise)
    'poisson',          % [5]
    'motion blur',      % [6]
    'erosion',          % [7]
    'dilation',         % [8]
    % 'jpg compression blocking effect'   % [9]
    % [10] Interpolation/ resizing noise <to do>
    };

noiseChosen = 2;
noiseTypeChosen = char(noiseTypeModes(noiseChosen));

originalImage = uint8(IMG);

%% plot original
titleStr = 'Original';

imagePlot( originalImage, plotRowSize, plotColSize, ...
                    plotIndex, titleStr );
plotIndex = plotIndex + 1;

%%
for i = 1:(plotRowSize*plotColSize)-1

IMG_aforeUpdated = double(IMG);    % backup the previous state just in case it gets updated.

% returns the noise param updates for further corruption    
% IMG may be updated as the noisy image for the next round
[IMG, noisyImage, titleStr, sigma, dilationFilterSize, erosionFilterSize] = ...
    noisyImageGeneration(IMG, mean, sigma, offset, dilationFilterSize, erosionFilterSize, noiseTypeChosen);

imageQualityIndex_Value = imageQualityIndex(double(originalImage), double(noisyImage));

titleStr = [titleStr ',' newline 'IQI: ' num2str(imageQualityIndex_Value)];

imagePlot( noisyImage, plotRowSize, plotColSize, ...
                    plotIndex, titleStr );
plotIndex = plotIndex + 1;

end

if (~strcmp(char(class(noisyImage)), 'uint8'))
    disp('noisyImage is NOT type: uint8');
end

%% PSNR
psnr_Value = PSNR(originalImage, noisyImage);
    fprintf('PSNR = +%5.5f dB \n', psnr_Value);
%% RMSE
[mse, rmse] = RMSE2(double(originalImage), double(noisyImage));
    fprintf('MSE = %5.5f \n', mse);
    fprintf('RMSE = %5.5f \n', rmse);
%% Universal Quality Index
imageQualityIndex_Value = imageQualityIndex(double(originalImage), double(noisyImage));
    fprintf('Universal Image Quality Index = %5.5f \n', imageQualityIndex_Value);
%% Enhancement : measure of enhance- ment, or measure of improvement
[M M] = size(originalImage);
L = 8;
EME_original = eme(double(originalImage),M,L);
EME_noisyImage = eme(double(noisyImage),M,L);
    fprintf('EME (original image) = %5.5f \n', EME_original);
    fprintf('EME (noisy image) = %5.5f \n', EME_noisyImage);
%% PearsonCorrelationCoefficient
pcc = compute_PearsonCorrelationCoefficient (double(originalImage), double(noisyImage));
    fprintf('PearsonCorrelationCoefficient (originalImage vs noisyImage) = %5.5f \n', pcc);
pcc = compute_PearsonCorrelationCoefficient (double(originalImage), double(originalImage));
    fprintf('PearsonCorrelationCoefficient (originalImage vs originalImage) = %5.5f \n', pcc);

%% Signal to signal noise ratio, SNR
noise = double(noisyImage) - double(originalImage); % assume additive noise

% check noise
noisyImageReconstructed = double(originalImage) + noise;
residue = noisyImageReconstructed - double(noisyImage);

if (sum(residue(:) ~= 0))
    disp('The noise is NOT relevant.');
end

snr_power = SNR(originalImage, noise);
    fprintf('SNR = %5.5f dB \n', snr_power);
    
%% Mean absolute error, MAE
mae = meanAbsoluteError(double(originalImage), double(noisyImage));
    fprintf('MAE = %5.5f \n', mae);