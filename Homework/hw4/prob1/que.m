clear all; close all; clc

img = im2double(imread('./bg.png'));
[h, w, ~] = size(img);
% imshow(img);

points = importdata('./points.txt');


%% Curve Computation
n = size(points, 1); % number of input points

%==============================================================%
% Code here. Store the results as `result1`, `result2`
%==============================================================%

result1 = points; % shaped [?, 2]
result2 = points; % shaped [?, 2]

% Draw the polygon of the curve
f = figure;
subplot(1, 2, 1);
imshow(img);
hold on
plot(points(:, 1), points(:, 2), 'r.');
plot(result1(:, 1), result1(:, 2), 'g-');

subplot(1, 2, 2);
imshow(img);
hold on
plot(points(:, 1), points(:, 2), 'r.');
plot(result2(:, 1), result2(:, 2), 'g-');
saveas(f, '1a.png');

%% Scaling
points = points .* 4;

%==============================================================%
% Code here.
%==============================================================%