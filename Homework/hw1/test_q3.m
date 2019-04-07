% clc;
clear all;
img1 = './data/cat3_LR.png';
originImg = imread(img1);
[ImgHeight, ImgWidth, Layer] = size(originImg);

n = [3 5 7];
% rgbImage = zeros(ImgHeight, ImgWidth, Layer, length(n));

subplot(2,2,1);
imshow(originImg, 'InitialMagnification','fit');


K = fspecial('gaussian', [3 3], 5);
rgbImage3 = originImg;
for l = 1: Layer
    rgbImage3(:,:,l) = conv2(originImg(:,:,l), K, 'same');
end
subplot(2,2,2);
imshow(rgbImage3);



K = fspecial('gaussian', [5 5], 5);
rgbImage5 = originImg;
for l = 1: Layer
    rgbImage5(:,:,l) = conv2(originImg(:,:,l), K, 'same');
end
subplot(2,2,3);
imshow(rgbImage5);




K = fspecial('gaussian', [7 7], 5);
rgbImage7 = originImg;
for l = 1: Layer
    rgbImage7(:,:,l) = conv2(originImg(:,:,l), K, 'same');
end
subplot(2,2,4);
imshow(rgbImage7);