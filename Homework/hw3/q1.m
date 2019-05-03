clc;
clear all;
% Image Parameter and Read Image
reference_frame_addr = './data/frame438.jpg';
reference_frame = im2double(imread(reference_frame_addr));
target_frame_addr = './data/frame439.jpg';
target_frame = im2double(imread(target_frame_addr));

tic;
[totalSAD, est_frame, motion_estimation] = threeStep(reference_frame, target_frame, 8, 8);
time_full = toc

% tic;
% [totalSAD, est_frame, motion_estimation] = fullSearch(reference_frame, target_frame, 8, 8);
% time_full = toc

% errorFrame = imabsdiff(reference_frame,  est_frame);
errorFrame = imgDiff(reference_frame,  est_frame);
PSNR_Full = 10*log10(255*255/mean(mean(mean(errorFrame.^2))));

% subplot(2, 2, 1), imshow(reference_frame), title('Anchor Frame');
% subplot(2, 2, 2), imshow(target_frame), title('Target Frame');
% subplot(2, 2, 3), imshow(est_frame), title('Estimation Frame');
% subplot(2, 2, 4);
% hold on, imshow(target_frame), hold off;
% hold on, quiver(motion_estimation(:, 1), motion_estimation(:, 2), motion_estimation(:, 3), motion_estimation(:, 4)), hold off;
% title('Motion Estimation');

fprintf("Finish\n");
