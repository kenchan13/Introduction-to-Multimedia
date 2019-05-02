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

count = 1;
for i=1 : block_height
    for j=1 : block_width % for every block in target frame
        y_start = (i-1)*block_size+1;
        y_end = i*block_size;
        x_start = (j-1)*block_size+1;
        x_end = j*block_size;
        
        % reference point of block_target
        block_target = target_frame(y_start : y_end, x_start : x_end);
        target_px = x_start; 
        target_py = y_start;
        
        center_px = target_px;
        center_py = target_py;
        
        for aa=log2(range):-1:1
            search_range=2^(aa-1);
            for ii=center_py-search_range : search_range : center_py+search_range
                for jj=center_px-search_range : search_range : center_px+search_range
                    if (ii>=1) && (ii<=(frame_height+1-block_size)) && (jj>=1) && (jj<=frame_width+1-block_size)
                        % search range in reference_frame
                        block_reference = reference_frame(ii:ii+block_size-1, jj:jj+block_size-1); 
                        temp = sum(sum(abs(block_reference-block_target)));
                        if min > temp
                            min = temp;
                            block_min = block_reference;
                            block_min_px = jj;
                            block_min_py = ii;
                        end
                    end
                end
            end
            
            center_px = block_min_px;
            center_py = block_min_py;
            min=10000000;
        end

        est_frame(y_start : y_end, x_start : x_end)=block_min;
        motion_estimation(count,:) = [block_min_px, block_min_py, target_px-block_min_px, target_py-block_min_py];
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