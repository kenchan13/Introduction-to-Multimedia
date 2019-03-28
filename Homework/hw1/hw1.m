clear all
img1 = './data/cat1.png';
n = 4; % Input n

% Read in a standard MATLAB color demo image.
%{
folder = fullfile(matlabroot, '\toolbox\images\imdemos');
baseFileName = 'peppers.png';
% Get the full filename, with path prepended.
img1 = fullfile(folder, baseFileName);
if ~exist(img1, 'file')
    % Didn't find it there.  Check the search path for it.
    img1 = baseFileName; % No path this time.
    if ~exist(img1, 'file')
        % Still didn't find it.  Alert user.
        errorMessage = sprintf('Error: %s does not exist.', img1);
        uiwait(warndlg(errorMessage));
        return;
    end
end
%}


% Read the image from disk.
rgbImage = imread(img1);


% Display image full screen.
% imshow(rgbImage);
% Enlarge figure to full screen.

% set(gcf, 'units','normalized','outerposition',[0 0 1 1]);
% drawnow;

[rows, columns, numberOfColorBands] = size(rgbImage);

blockSizeR = 8; % Rows in block.
blockSizeC = 8; % Columns in block.

wholeBlockRows = floor(rows / blockSizeR);
blockVectorR = [blockSizeR * ones(1, wholeBlockRows), rem(rows, blockSizeR)];

% Figure out the size of each block in columns.
wholeBlockCols = floor(columns / blockSizeC);
blockVectorC = [blockSizeC * ones(1, wholeBlockCols), rem(columns, blockSizeC)];

% Create the cell array, ca. 
% Each cell (except for the remainder cells at the end of the image)
% in the array contains a blockSizeR by blockSizeC by 3 color array.
% This line is where the image is actually divided up into blocks.
if numberOfColorBands > 1
    % It's a color image.
    ca = mat2cell(rgbImage, blockVectorR, blockVectorC, numberOfColorBands);
else
    ca = mat2cell(rgbImage, blockVectorR, blockVectorC);
end
% Save ca into ca_Origin
ca_Origin = ca;

% Size of rgbBlock
size = 8;
% Implement 1D DCT basis
U_temp = zeros(size);
for c = 0 : size-1
    for r = 0 : size-1
        if (c>0)
            a0 = sqrt(2/size);
        else
            a0 = 1/sqrt(size);
        end
        U_temp(r+1, c+1) = cos((2*r+1)*c*pi/(2*size))*a0;
    end
end

% Calculate 2D DCT "U" by using 1D DCT basis
U = [];
for k = 1 : size
    for l = 1 : size
        U = [U {U_temp(:,k) * U_temp(:,l)'}];
    end
end
U = reshape(U, [size, size])';

% Get 8*8 pixel regBlock from ca
% And apply 2D DCT for each regBlock for each color(regBlock_oneColor)
for r = 1 : 48
    for c = 1 : 56
        rgbBlock = ca{r, c};
        % Test r=1 c=1= rgb=3
        for rgb = 1 : 3
            % fprintf('r=%d, c=%d rgb=%d\n', r, c, rgb);
            rgbBlock_oneColor = rgbBlock(:,:,rgb);
            
            testcase = dct2(rgbBlock_oneColor);
            T = zeros(size);
            % Top-left n-by-n data are considered only
            for k = 1 : n
                for l = 1 : n
                    T(k,l) = sum(U{k,l} .* double(rgbBlock_oneColor), 'all');
                end
            end
            
            % Check the result
            % Round up all number to avoid tiny differences
            if round(T(1:n, 1:n), 3) ~= round(testcase(1:n, 1:n), 3)
                fprintf("block(%d,%d), color=%d: Error\n", r, c, rgb);
            else
                fprintf("block(%d,%d), color=%d: Great!\n", r, c, rgb);
            end
            
        end
        
    end
end




% Now display all the blocks!!!!!!!!!!!!!!!!!!!!!!
%{
plotIndex = 1;
numPlotsR = size(ca, 1);
numPlotsC = size(ca, 2);
for r = 1 : numPlotsR
    for c = 1 : numPlotsC
        fprintf('plotindex = %d,   c=%d, r=%d\n', plotIndex, c, r);
        % Specify the location for display of the image.
        subplot(numPlotsR, numPlotsC, plotIndex);
        % Extract the numerical array out of the cell
        % just for tutorial purposes.
        rgbBlock = ca{r,c};
        imshow(rgbBlock); % Could call imshow(ca{r,c}) if you wanted to.
        [rowsB columnsB numberOfColorBandsB] = size(rgbBlock);
        % Make the caption the block number.
        caption = sprintf('Block #%d of %d\n%d rows by %d columns', ...
            plotIndex, numPlotsR*numPlotsC, rowsB, columnsB);
        % title(caption);
        drawnow;
        % Increment the subplot to the next location.
        plotIndex = plotIndex + 1;
    end
end
%}

% Display the original image in the upper left.
%{
subplot(4, 6, 1);
imshow(rgbImage);
title('Original Image');
%}

%{
% Inform user of next stage where we process a gray scale image.
promptMessage = sprintf('Now I will do the same for a gray scale image.');
titleBarCaption = 'Continue?';
button = questdlg(promptMessage, titleBarCaption, 'OK', 'Cancel', 'OK');
if strcmpi(button, 'Cancel')
    return;
end
%}