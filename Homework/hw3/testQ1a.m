clc;
clear all;
% Image Parameter and Read Image
refImgAddr = './data/frame437.jpg';
refImg = imread(refImgAddr);
targetImgAddr = './data/frame439.jpg';
targetImg = imread(targetImgAddr);

% motionVector(refImg, targetImg, blockSize, searchRange);
[predicImg, mvx, mvy] = motionVector(refImg, targetImg, 8, 8);