clear all;
img1 = './data/cat3_LR.png';
originImg = imread(img1);
[ImgHeight, ImgWidth, Layer] = size(originImg);

n = 3;
% K = fspecial('gaussian', [n n], 1);
K = [1 2 3; 4 5 6; 7 8 9];
midK = (n-1)/2;
rgbImage = double(originImg);


I = reshape((1:16), [4 4])';
B = reshape((1:16), [4 4])';
for h = 1: 4
    for w = 1:4
        sum = 0;
        for hK = -midK:midK
            for wK = -midK:midK
                if (1<=h+hK)&&(h+hK<=4) && (1<=w+wK)&&(w+wK<=4)
                    sum = sum + K(hK+midK+1, wK+midK+1)*I(h+hK, w+wK);
                end
            end
        end
        B(h, w) = sum;
    end
end

A = conv2(I, K, 'same');
        
%{
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
%}
