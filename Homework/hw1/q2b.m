clear all;
img1 = './data/cat2_gray.png';
rgbImage = imread(img1);

[ImgHeight, ImgWidth] = size(rgbImage);

M = mean(rgbImage);

for h = 1 : ImgHeight
    for w = 1 : ImgWidth
        if (rgbImage(h, w) > M)
            rgbImage(h, w) = 255;
        else
            rgbImage(h, w) = 0;
        end
    end
end

imshow(rgbImage);