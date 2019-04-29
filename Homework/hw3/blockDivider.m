function rgbBlocks = blockDivider(rgbImage, blockSizeHeight)

[ImgHeight, ImgWidth, Layers] = size(rgbImage);

blockSizeWidth = blockSizeHeight;

% Figure out the hight of each block.
NumOfBlockRows = floor(ImgHeight / blockSizeHeight);
blockVectorR = [blockSizeHeight * ones(1, NumOfBlockRows), rem(ImgHeight, blockSizeHeight)];

% Figure out the width of each block.
NumOfBlockCols = floor(ImgWidth / blockSizeWidth);
blockVectorC = [blockSizeWidth * ones(1, NumOfBlockCols), rem(ImgWidth, blockSizeWidth)];

% Divide YIQImage into n*n pixel blocks
rgbBlocks = mat2cell(rgbImage, blockVectorR, blockVectorC, Layers);