clear all;
img1 = './data/cat1.png';
rgbImage = imread(img1);

[ImgHeight, ImgWidth, Layers] = size(rgbImage);
n = 2;

% Set YIQImage into zeros
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

% Figure out the hight of each block.
NumOfBlockRows = floor(ImgHeight / blockSizeHeight);
blockVectorR = [blockSizeHeight * ones(1, NumOfBlockRows), rem(ImgHeight, blockSizeHeight)];

% Figure out the width of each block.
NumOfBlockCols = floor(ImgWidth / blockSizeWidth);
blockVectorC = [blockSizeWidth * ones(1, NumOfBlockCols), rem(ImgWidth, blockSizeWidth)];

% Divide YIQImage into n*n pixel blocks
YIQBlocks = mat2cell(YIQImage, blockVectorR, blockVectorC, Layers);

% Size of rgbBlock
size = blockSizeHeight;

% Implement 1D DCT basis
U_temp = zeros(size);
for c = 0 : size-1
    for r = 0 : size-1
        if (c>0)
            a0 = sqrt(2/size);
        else
            a0 = 1/sqrt(size);
        end
        U_temp(r+1, c+1) = a0*cos((2*r+1)*c*pi/(2*size));
    end
end

% Calculate 2D DCT "U" by using 1D DCT basis
U = [];
for k = 1 : size
    for l = 1 : size
        % fprintf("k:%d, l:%d\n", k, l);
        U = [U {U_temp(:,k) * U_temp(:,l)'}];
    end
end
U = reshape(U, [size, size])';

% DCT process
% S is the YIQBlock source (1 block)
% TBlocks is sets of amplitudes of frequency components for Image
% NumOfBlockRows
TBlocks = mat2cell(zeros(ImgHeight, ImgWidth, Layers), blockVectorR, blockVectorC, Layers);

for x = 1: NumOfBlockRows
    for y = 1: NumOfBlockCols
        for z = 1: Layers
            S = YIQBlocks{x, y}(:,:,z); % For each color
            tempT = zeros(size);
            for k = 1 : size
                for l = 1 : size
                    tempT(k,l) = sum(U{k,l}.*S, 'all');
                end
            end
            % We only need top-left n*n data
            % Cut tempT and expand it with 0
            tempT = tempT(1:n, 1:n);
            tempT(blockSizeHeight, blockSizeHeight) = 0;
            TBlocks{x, y}(:,:,z) = tempT;
        end
    end
end


