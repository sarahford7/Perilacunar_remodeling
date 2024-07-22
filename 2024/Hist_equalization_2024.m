clc;
close all;
clear all;

% Load File
[baseFileName, folder] = uigetfile({'*.jpg';'*.png';'*.bmp';'*.jpeg';'*.tif'});  % Select file 
fullFileName = fullfile(folder, baseFileName); % Establish name of file
A = imread(fullFileName);

% Verify if the image is read correctly
if size(A, 3) == 1
    disp('Image is grayscale.');
else
    disp('Image is color.');
end

%% Uncomment when you want to choose a region of interest
BW = roipoly(A);

% 4a) (For color images only) Augment the mask to three channels:
if size(A, 3) == 3
    BW = cat(3, BW, BW, BW);
end

% 5) Use logical indexing to set area outside of ROI to zero:
A(~BW) = 0;
ROI = A;
% 6) Display extracted portion:
figure, imshow(A);
title('Extracted ROI');

% 7) Enhance brightness and contrast by applying histogram equalization
if size(A, 3) == 3
    % For color images, apply histogram equalization on each channel
    A(:,:,1) = histeq(A(:,:,1));
    A(:,:,2) = histeq(A(:,:,2));
    A(:,:,3) = histeq(A(:,:,3));
else
    % For grayscale images, apply histogram equalization directly
    A = histeq(A);
end

% 8) Display enhanced image:
figure, imshow(A);
title('Enhanced Image with Histogram Equalization');

% 9) Copy the ROI back to A to repeat with different parameters
A = ROI;

% 10) Enhance brightness and contrast by applying histogram equalization
if size(A, 3) == 3
    % For color images, apply histogram equalization on each channel
    A(:,:,1) = adapthisteq(A(:,:,1));
    A(:,:,2) = adapthisteq(A(:,:,2));
    A(:,:,3) = adapthisteq(A(:,:,3));
else
    % For grayscale images, apply histogram equalization directly
    A = adapthisteq(A);
end

% 11) Display enhanced image:
figure, imshow(A);
title('Enhanced Image with Adaptive Histogram Equalization');
