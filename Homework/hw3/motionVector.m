clear all;
clc;

reference_frame_Addr = './data/frame437.jpg';
reference_frame = imread(reference_frame_Addr);
target_frame_Addr = './data/frame439.jpg';
target_frame = imread(target_frame_Addr);
reference_frame = im2double(rgb2gray(reference_frame));
target_frame = im2double(rgb2gray(target_frame));

est_frame = zeros(size(target_frame));

[frame_height, frame_width, frame_layer] = size(reference_frame);

block_size = 8;
range = 8;

block_width = frame_width/block_size;
block_height = frame_height/block_size;

block_target = zeros(block_size, block_size);
block_reference = zeros(block_size, block_size);

% record the motions 
motion_estimation = zeros(block_height*block_width, 4);
min = 10000000;

% start
count = 1;
for i=1 : block_height
    for j=1 : block_width % for every block in target frame
        y_start = (i-1)*block_size+1;
        y_end = i*block_size;
        x_start = (j-1)*block_size+1;
        x_end = j*block_size;

        block_target = target_frame(y_start : y_end, x_start : x_end);
        % middle point of block_target
        target_px = (j-0.5)*block_size+1; 
        target_py = (i-0.5)*block_size+1;
        
        for ii=y_start-range : y_start+range
            for jj=x_start-range : x_start+range
                if (ii>=1) && (ii<=(frame_height+1-block_size)) && (jj>=1) && (jj<=frame_width+1-block_size)
                    % search range in reference_frame
                    block_reference = reference_frame(ii:ii+block_size-1, jj:jj+block_size-1); 
                    temp = sum(sum(abs(block_reference-block_target)));
                    if min > temp
                        min = temp;
                        block_min = block_reference;
                        reference_px = jj + block_size*0.5;
                        reference_py = ii + block_size*0.5;
                    end
                end
            end
        end
        est_frame(y_start : y_end, x_start : x_end)=block_min;
        motion_estimation(count,:) = [target_px, target_py, reference_px-target_px, reference_py-target_py];
        count = count + 1;
        min=10000000;
    end
end

subplot(2, 2, 1);
imshow(reference_frame);
title('Anchor Frame');
subplot(2, 2, 2);
imshow(target_frame);
title('Target Frame');
subplot(2, 2, 3);
imshow(est_frame);
title('Estimation Frame');
subplot(2, 2, 4);
hold on;
imshow(target_frame);
hold off;
hold on;
quiver(motion_estimation(:, 1), motion_estimation(:, 2), motion_estimation(:, 3), motion_estimation(:, 4));
hold off;
title('Motion Estimation');