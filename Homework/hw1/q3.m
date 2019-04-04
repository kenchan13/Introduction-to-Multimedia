clear all;
img1 = './data/cat3_LR.png';
rgbImage = imread(img1);
[ImgHeight, ImgWidth, Layer] = size(rgbImage);

n = 3;
K = fspecial('gaussian', [n n], 1);
midK = (n-1)/2;
originImg = rgbImage;

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

imshow([originImg, rgbImage]);