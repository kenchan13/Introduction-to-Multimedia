clc;
clear all;
% Image Parameter and Read Image
refImgAddr = './data/frame437.jpg';
refImg = imread(refImgAddr);
targetImgAddr = './data/frame439.jpg';
targetImg = imread(targetImgAddr);

% Process Parameter
p = 8;
method = 'full'; % full & 3-step

refBlock = blockDivider(refImg, p);
targetBlock = blockDivider(targetImg, p);

[blockHeight, blockWidth] = size(refBlock);
% for each targetBlock
for i = 1: blockHeight-1
    for j = 1 : blockWidth-1
        
        % Determine search range in regImg
        h1=i-1; h2=i+1; w1=j-1; w2=j+1;
        if i==1
            h1=1;
        end
        if i==blockHeight
            h2=blockHeight;
        end
        if j==1
            w1=1;
        end
        if j==blockWidth
            w1=blockWidth-1;
            w2=blockWidth;
        end
            
        % Combine selected regImg blocks into image
        refImgPart = cell2mat(refBlock(h1:h2,w1:w2));
        targetImgPart = targetBlock{i,j};
        
        [h w l] = size(refImgPart);
        % fprintf("h=%d w=%d\n", h, w);
        
%         refImgLabel = insertShape(refImg, 'Rectangle', [(w1-1)*p (h1-1)*p (w2-w1+1)*p+2 (h2-h1+1)*p+2], 'LineWidth',1);
%         refImgLabel2 = insertShape(refImgLabel, 'Rectangle', [(j-1)*p (i-1)*p p+2 p+2], 'LineWidth',1, 'Color','blue');
%         subplot(2,2,1), imshow(refImgLabel2);
%         subplot(2,2,2), imshow(refImgPart);
%            
%         targetImgLabel = insertShape(targetImg, 'Rectangle', [(j-1)*p (i-1)*p p+2 p+2], 'LineWidth',1);
%         subplot(2,2,3), imshow(targetImgLabel);
%         subplot(2,2,4), imshow(targetImgPart);
        
        % w = waitforbuttonpress;
%         pause(.0001);
        
        % Comparing targetImg and refImg within search range(refImgPart)
        for x = 1: h-p+1
%             pause(.1);
            for y = 1: w-p+1
                if matrixSame(refImgPart(x:x+p-1, y:y+p-1, :), targetImgPart) == 1, fprintf("haha"), end
%                 subplot(1,2,1), imshow(refImgPart(x:x+p-1, y:y+p-1, :));
%                 subplot(1,2,2), imshow(targetImgPart);
%                 pause(.0001);
            end
        end


    end
end

fprintf("Finish\n");
