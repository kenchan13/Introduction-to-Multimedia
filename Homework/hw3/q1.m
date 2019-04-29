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
        fprintf("h=%d w=%d\n", h, w);
        
        
        subplot(2,1,1), imshow(refImgPart);
        refImgLabel = insertShape(refImg, 'Rectangle', [(w1-1)*p (h1-1)*p (w2-w1+1)*p+2 (h2-h1+1)*p+2], 'LineWidth',1);
        refImgLabel2 = insertShape(refImgLabel, 'Rectangle', [(j-1)*p (i-1)*p p+2 p+2], 'LineWidth',1, 'Color','blue');
        subplot(2,1,2), imshow(refImgLabel2);
        pause(.0001);
%         w = waitforbuttonpress;
        
        %{
        flag = 0;
        [refImgPart_H, regImgPart_W, layer] = size(refImgPart);
        for x = 1: refImgPart_H-p
            for y = 1: regImgPart_W-p
                temp = refImgPart(x:x+p-1, y:y+p-1, 1:3) - targetImgPart;
                
                imshow(targetImgPart);
                pause(5);
                if temp == zeros(8,8,3)
                    fprintf("target: (%d,%d)  refPos: (%d,%d) Great!\n", i,j,x,y);
                    flag = 1;
                    % [x y width height]
%                     refImgLabel = insertShape(refImgPart, 'Rectangle', [x-1 y-1 p+1 p+1], 'LineWidth',1);
%                     subplot(1,2,1), imshow(refImgLabel);
%                     subplot(1,2,2), imshow(targetImgPart)
                    
                    pause(5);
                    break;
                end
            end
            
            if flag == 1
                break
            end
        end
        %}
        
    end
end

fprintf("Finish\n");
