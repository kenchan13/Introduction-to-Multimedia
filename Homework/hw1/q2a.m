clear all;
img1 = './data/cat3_LR.png';
rgbImage = imread(img1);

[ImgHeight, ImgWidth] = size(rgbImage);

for h = 1 : ImgHeight
    for w = 1 : ImgWidth
        if (rgbImage(h, w) > randi(255))
            rgbImage(h, w) = 255;
        else
            rgbImage(h, w) = 0;
        end
    end
end

% imshow(rgbImage);

% fprintf("PSNR:%d\n", psnr(rgbImage, rgbImageInt), psnr_imple(rgbImage, rgbImageInt))
filename = strsplit(img1, {'.','/'});
filename = strcat(filename{1,3}, '_', 'q2a', '.jpg');
imwrite(rgbImage, filename);