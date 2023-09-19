close all
clc
clear all


[baseFileName, folder] = uigetfile({'*.jpg';'*.png';'*.bmp';'*.jpeg';'*.tif'});  %select file 
fullFileName = fullfile(folder, baseFileName); %establish name of file
A = imread(fullFileName);

GA=rgb2gray(A); %turning 3 dim into one dimension 

% figure()
% imshow(A)
% figure()
% imshow(GA,[])
% 
% HGA=histeq(GA); %Normalizes the pixel intensity 
% figure()
% imshow(HGA,[])
% 
% H2GA=adapthisteq(GA);
% figure()
% imshow(H2GA,[])
% 
% imaGA = imadjust(GA);
% figure()
% imshow(imaGA,[])

%THE FOLLOWING CODE IS NOT WORKING, DONT RUN IT
%IMADJUST with colour:
% A1=A(:,:,1);
% A2=A(:,:,2);
% A3=A(:,:,3);
% maxcanal1=max(max(A1));
% maxcanal2=max(max(A2));
% maxcanal3=max(max(A1));

% shadow_lab = rgb2lab(A);
% 
% max_luminosity = 100;
% L = shadow_lab(:,:,1)/max_luminosity;
% 
% shadow_imadjust = shadow_lab;
% shadow_imadjust(:,:,1) = imadjust(L)*max_luminosity;
% shadow_imadjust = lab2rgb(shadow_imadjust);
% % imaGA = imadjust(GA);
% figure()
% imshow(shadow_imadjust)

%THIS CODE SHOULD WORK BUT NOT FOR IMAGES THAT ARE TOO BIG
%New method for augmenting contrast:
AInv = imcomplement(A);
%BInv = imreducehaze(AInv);
%B = imcomplement(BInv);
% figure()
% imshow(B)
BInv = imreducehaze(AInv, 'Method','approx','ContrastEnhancement','boost');
BImp = imcomplement(BInv);
figure()
imshow(BImp)
