f
[ImgHeight, ImgWidth, Layers] = size(rgbImage);
n = 2;

yiqImage = rgb2ntsc(rgbImage);
rgbImage2 = ntsc2rgb(yiqImage);


YIQImage = rgb2ntsc(rgbImage);

blockSizeHeight = 8;
blockSizeWidth = 8;

% Figure out the hight of each block.
NumOfBlockRows = floor(ImgHeight / blockSizeHeight);
blockVectorR = [blockSizeHeight * ones(1, NumOfBlockRows), rem(ImgHeight, blockSizeHeight)];

% Figure out the width of each block.
NumOfBlockCols = floor(ImgWidth / blockSizeWidth);
blockVectorC = [blockSizeWidth * ones(1, NumOfBlockCols), rem(ImgWidth, blockSizeWidth)];

% Divide YIQImage into n*n pixel blocks
YIQBlocks = mat2cell(YIQImage, blockVectorR, blockVectorC, Layers);


% DCT and get top-left data

for x = 1: NumOfBlockRows
    for y = 1: NumOfBlockCols
        for z = 1: Layers
            % DCT
            YIQtemp = dct2(YIQBlocks{x,y}(:,:,z));
            YIQtemp = YIQtemp(1:n, 1:n);
            
            
            
            if (n ~= blockSizeHeight)
                YIQtemp(blockSizeHeight, blockSizeHeight) = 0;
            end
            YIQBlocks{x,y}(:,:,z) = YIQtemp;
            fprintf("");
        end
    end
end

% Inverse DCT and change to RGB
RGBBlocks = YIQBlocks;
for x = 1: NumOfBlockRows
    for y = 1: NumOfBlockCols
        for z = 1: Layers
            YIQBlocks{x,y}(:,:,z) = idct2(YIQBlocks{x,y}(:,:,z));
            RGBBlocks{x,y} = ntsc2rgb(YIQBlocks{x,y});
        end
    end
end

% Convert YIQBlocks back to YIQImageFinal
RGBFinal = cell2mat(RGBBlocks);

imshow(RGBFinal);
% [peaksnr, snr] = psnr(RGBFinal, rgbImage);

% fprintf("PSNR: %d",snr);
fprintf("Finish\n");
