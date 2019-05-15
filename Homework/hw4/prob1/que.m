clear all; close all; clc

img = im2double(imread('./bg.png'));
[h, w, ~] = size(img);
% imshow(img);

points = importdata('./points.txt');

%% Curve Computation
n = size(points, 1); % number of input points

%==============================================================%
% Code here. Store the results as `result1`, `result2`
M = [-1 3 -3 1; 3 -6 3 0; -3 3 0 0; 1 0 0 0];
count1 = 1;
for i = 1:3:n-1
    p0 = points(i,:); p1 = points(i+1,:);
    p2 = points(i+2,:); p3 = points(i+3,:);
    G = [p0; p1; p2; p3];
    for t = 0:0.2:1.0
        for j=1:2
            T = [t^3 t^2 t 1];
            result1(count1,j) = (T*M)*G(:,j);
        end
        count1 = count1 + 1;
    end
end

count1 = 1;
for i = 1:3:n-1
    p0 = points(i,:); p1 = points(i+1,:);
    p2 = points(i+2,:); p3 = points(i+3,:);
    G = [p0; p1; p2; p3];
    for t = 0:0.01:1.0
        for j=1:2
            T = [t^3 t^2 t 1];
            result2(count1,j) = (T*M)*G(:,j);
        end
        count1 = count1 + 1;
    end
end

%==============================================================%

% result1 = points; % shaped [?, 2]
% result2 = points; % shaped [?, 2]

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
% close all

%% Scaling
points = points .* 4;

%==============================================================%
% Code here.
imgResize = imresize(img, 4, 'nearest');

f = figure;
subplot(1, 1, 1);
imshow(img);
hold on
plot(points(:, 1), points(:, 2), 'r.');
plot(result1(:, 1), result1(:, 2), 'g-');
saveas(f, '1b.png');
%==============================================================%