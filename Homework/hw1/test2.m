clear all;
img1 = './data/cat1.png';
rgbImage = imread(img1);

[ImgHeight, ImgWidth, numberOfColorBands] = size(rgbImage);

% Set YIQ into zeros
YIQImage = zeros(ImgHeight, ImgWidth, 3);

YIQTable = [.299 .587 .114; .596 -.275 -.321; .212 -.523 .311];
% Convert RGBImage into YIQImage
for h = 1 : ImgHeight
    for w = 1 : ImgWidth
        RGBtemp = [rgbImage(h, w, 1); rgbImage(h, w, 2); rgbImage(h, w, 3)];
         YIQtemp = num2cell([YIQTable*double(RGBtemp)]);
         [YIQImage(h, w, 1) ,YIQImage(h, w, 2), YIQImage(h, w, 3)] = deal(YIQtemp{:});
    end
end

blockSizeHeight = 8; 
blockSizeWidth = 8;

wholeBlockRows = floor(ImgHeight / blockSizeHeight);
blockVectorR = [blockSizeHeight * ones(1, wholeBlockRows), rem(ImgHeight, blockSizeHeight)];

wholeBlockCols = floor(ImgWidth / blockSizeWidth);
blockVectorC = [blockSizeWidth * ones(1, wholeBlockCols), rem(ImgWidth, blockSizeWidth)];

% Divide YIQImage into n*n pixel blocks
YIQBlocks = mat2cell(YIQImage, blockVectorR, blockVectorC, numberOfColorBands);

