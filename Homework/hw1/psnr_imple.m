clc;
clear all;
img1 = './data/cat3_LR.png';

A = imread(img1);
[ImgHeight, ImgWidth, Layers] = size(A);

B = imnoise(A, 'salt & pepper', 0.08);

A = double(A);
B = double(B);

[M N Layer] = size(A);
error = A - B;
MSE = sum(sum(error .* error)) / (M * N);

if(MSE > 0)
    PSNR = 10*log(255*255/MSE) / log(10);
else
    PSNR = 99;
end

PSNR = mean(PSNR);