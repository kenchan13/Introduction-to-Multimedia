function [totalSAD, est_frame, motion_estimation] = fullSearch(reference_frame, target_frame, block_size, range)

% reference_frame = rgb2gray(reference_frame);
% target_frame = rgb2gray(target_frame);

est_frame = zeros(size(target_frame));

[frame_height, frame_width, frame_layer] = size(reference_frame);

block_width = frame_width/block_size;
block_height = frame_height/block_size;
block_layer = frame_layer;

block_target = zeros(block_size, block_size);
block_reference = zeros(block_size, block_size);

% record totalSAD
totalSAD = 0;

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
        block_target = target_frame(y_start : y_end, x_start : x_end, :);
        target_px = x_start; 
        target_py = y_start;
        
        for ii=y_start-range : y_start+range
            for jj=x_start-range : x_start+range
                if (ii>=1) && (ii<=(frame_height+1-block_size)) && (jj>=1) && (jj<=frame_width+1-block_size)
                    % search range in reference_frame
                    temp = 0;
                    for kk=1:block_layer
                        block_reference(:,:,kk) = reference_frame(ii:ii+block_size-1, jj:jj+block_size-1, kk); 
                        temp = sum(sum(abs(block_reference(:,:,kk)-block_target(:,:,kk)))) + temp;
                    end
                    if min > temp
                        min = temp;
                        block_min = block_reference;
                        reference_px = jj;
                        reference_py = ii;
                    end
                end
            end
        end
        
        totalSAD = totalSAD + temp;
        est_frame(y_start : y_end, x_start : x_end, :)=block_min;
        motion_estimation(count,:) = [reference_px, reference_py, target_px-reference_px, target_py-reference_py];
        count = count + 1;
        min=10000000;
    end
end