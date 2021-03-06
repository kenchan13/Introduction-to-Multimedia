clc;
clear all;
img1 = './data/cat3_LR.png';
originImg = imread(img1);
originImg2 = im2double(originImg);
[ImgHeight, ImgWidth, Layer] = size(originImg);

n = 5;
sigma = 10;
K = fspecial('gaussian', [n n], sigma);
midK = (n-1)/2;
rgbImage = im2double(originImg);

for h = 1: ImgHeight
   for w = 1: ImgWidth
       for l = 1: Layer

           sum = 0;
           for hK = -midK:midK
               for wK = -midK:midK
                   if (1<=h+hK)&&(h+hK<=ImgHeight) && (1<=w+wK)&&(w+wK<=ImgWidth)
                       sum = sum + K(hK+midK+1, wK+midK+1)*rgbImage(h+hK, w+wK, l);
                   end
               end
           end
           rgbImage(h, w, l) = sum;
       end
   end
end

fprintf("PSNR:%d\n", psnr(rgbImage, originImg2), psnr_imple(rgbImage, originImg2))
filename = strsplit(img1, {'.','/'});
filename = strcat(filename{1,3}, '_', int2str(n),'_','s',int2str(sigma), '.jpg');
imwrite(rgbImage, filename);
% imshow(rgbImage);

