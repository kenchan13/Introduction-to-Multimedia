clc;
clear all;
% Image Parameter and Read Image
reference_frame_addr = './data/frame437.jpg';
reference_frame = im2double(imread(reference_frame_addr));
target_frame_addr = './data/frame439.jpg';
target_frame = im2double(imread(target_frame_addr));

count = 1;
for i=8:8:16
    for j=8:8:16
        tic, [totalSAD_three(count), est_frame, motion_estimation] = threeStep(reference_frame, target_frame, i, j);
        time_full = toc
        % Save estimated image
        filename = strcat('threeStep_p',int2str(i),'_r',int2str(j),'.jpg');
        imwrite(est_frame, filename);
        % Plot Moving Vector
        subplot(2, 2, count);
        hold on, imshow(target_frame), hold off;
        hold on, quiver(motion_estimation(:, 1), motion_estimation(:, 2), motion_estimation(:, 3), motion_estimation(:, 4)), hold off;
        
        
        % Save residual image
        target_frame_t = im2uint8(target_frame);
        est_frame_t = im2uint8(est_frame);
        errorFrame = rgb2gray(imgDiff(target_frame_t,  est_frame_t));
        filename = strcat('residual_threeStep_p',int2str(i),'_r',int2str(j),'.jpg');
        imwrite(errorFrame, filename);
        % PSNR
        PSNR_Full_three(count) = 10*log10(255*255/mean(mean(mean(errorFrame.^2))));
        
        count = count + 1;
    end
end
pause(3);

% count = 1;
% for i=8:8:16
%     for j=8:8:16
%         tic, [totalSAD, est_frame, motion_estimation] = fullSearch(reference_frame, target_frame, i, j);
%         time_full = toc
%         filename = strcat('fullSearch_p',int2str(i),'_r',int2str(j),'.jpg');
%         imwrite(est_frame, filename);
%         subplot(2, 2, count);
%         hold on, imshow(target_frame), hold off;
%         hold on, quiver(motion_estimation(:, 1), motion_estimation(:, 2), motion_estimation(:, 3), motion_estimation(:, 4)), hold off;
%         count = count + 1;
%     end
% end


count = 1;
for i=8:8:16
    for j=8:8:16
        tic, [totalSAD_full(count), est_frame, motion_estimation] = fullSearch(reference_frame, target_frame, i, j);
        time_full = toc
        % Save estimated image
        filename = strcat('fullSearch_p',int2str(i),'_r',int2str(j),'.jpg');
        imwrite(est_frame, filename);
        % Plot Moving Vector
        subplot(2, 2, count);
        hold on, imshow(target_frame), hold off;
        hold on, quiver(motion_estimation(:, 1), motion_estimation(:, 2), motion_estimation(:, 3), motion_estimation(:, 4)), hold off;
                
        % Save residual image
        target_frame_t = im2uint8(target_frame);
        est_frame_t = im2uint8(est_frame);
        errorFrame = rgb2gray(imgDiff(target_frame_t,  est_frame_t));
        filename = strcat('residual_fullSearch_p',int2str(i),'_r',int2str(j),'.jpg');
        imwrite(errorFrame, filename);
        % PSNR
        PSNR_Full_full(count) = 10*log10(255*255/mean(mean(mean(errorFrame.^2))));
        
        count = count + 1;
    end
end

% Plot totalSAD_full
plot(totalSAD_three)
hold on
plot(totalSAD_full)
hold off
pause(3);

% Plot PSNR
plot(PSNR_Full_three)
hold on
plot(PSNR_Full_full)
hold off

% for frame432.jpg and frame439.jpg
count = 5;
reference_frame_addr = './data/frame432.jpg';
reference_frame = im2double(imread(reference_frame_addr));
target_frame_addr = './data/frame439.jpg';
target_frame = im2double(imread(target_frame_addr));

tic, [totalSAD_full(count), est_frame, motion_estimation] = fullSearch(reference_frame, target_frame, 8, 8);
target_frame_t = im2uint8(target_frame);
est_frame_t = im2uint8(est_frame);
errorFrame = rgb2gray(imgDiff(target_frame_t,  est_frame_t));
imshow(est_frame_t);
% PSNR
PSNR_Full_full(count) = 10*log10(255*255/mean(mean(mean(errorFrame.^2))))

fprintf("Finish\n");
