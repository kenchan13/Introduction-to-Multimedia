clear all;
img1 = './data/cat3_LR.png';
rgbImage = imread(img1);

[ImgHeight, ImgWidth] = size(rgbImage);

% imshow(rgbImage);

for y = 1 : ImgHeight
    for x = 1 : ImgWidth
        % Get value "e"
        if (rgbImage(y,x) < 128)
            e = rgbImage(y,x);
        else
            e = rgbImage(y,x)-255;
        end
        
        if (x+1 <= ImgWidth)
            if (rgbImage(y,x+1) +(7/16)*e < 128)
                rgbImage(y,x+1) = 0;
            else 
                rgbImage(y,x+1) = 255;
            end
        end
        
        if (y+1 <= ImgHeight && x-1 >= 1)
            % rgbImage(y+1,x-1) = rgbImage(y+1,x-1) +(3/16)*e;
            if (rgbImage(y+1,x-1) +(3/16)*e < 128)
                rgbImage(y+1,x-1) = 0;
            else 
                rgbImage(y+1,x-1) = 255;
            end
        end
        
        if (y+1 <= ImgHeight)
            % rgbImage(y+1,x) = rgbImage(y+1,x) +(5/16)*e;
            if (rgbImage(y+1,x) +(5/16)*e < 128)
                rgbImage(y+1,x) = 0;
            else 
                rgbImage(y+1,x) = 255;
            end
        end
        
        if (x+1 <= ImgWidth && y+1 <= ImgHeight)
            % rgbImage(y+1,x+1) = rgbImage(y+1,x+1) +(1/16)*e;
            if (rgbImage(y+1,x+1) +(1/16)*e < 128)
                rgbImage(y+1,x+1) = 0;
            else 
                rgbImage(y+1,x+1) = 255;
            end
        end
    end
end

% imshow(rgbImage);
% fprintf("PSNR:%d\n", psnr(rgbImage, rgbImageInt), psnr_imple(rgbImage, rgbImageInt))
filename = strsplit(img1, {'.','/'});
filename = strcat(filename{1,3}, '_', 'q2c', '.jpg');
imwrite(rgbImage, filename);
