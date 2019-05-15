clear all; close all; clc; 

%% Read OBJ file
obj = readObj('trump.obj');
tval = display_obj(obj,'tumpLPcolors.png');

%==============================================================%
% Code here. Move object center to (0, 0)
x = obj.v(:,1); y = obj.v(:,2); z = obj.v(:,3);
center = [(max(x)+min(x))/2, (max(y)+min(y))/2, (max(z)+min(z))/2];
%==============================================================%

%% a.
f = figure;
obj.v = obj.v - center;
hold on
trisurf(obj.f.v, obj.v(:,1), obj.v(:,2), obj.v(:,3), ...
    'FaceVertexCData', tval, 'FaceColor', 'interp', 'EdgeAlpha', 0);
xlabel('X'); ylabel('Y'); zlabel('Z');
axis equal;

saveas(f, '2a.png');
close all
%==============================================================%
% Code here. Other Problems
%% b.
% First, create a 100-by-100 image to texture the cone with:

H = repmat(linspace(0, 1, 100), 100, 1);     % 100-by-100 hues
S = repmat([linspace(0, 1, 50) ...           % 100-by-100 saturations
            linspace(1, 0, 50)].', 1, 100);  %'
V = repmat([ones(1, 50) ...                  % 100-by-100 values
            linspace(1, 0, 50)].', 1, 100);  %'
hsvImage = cat(3, H, S, V);                  % Create an HSV image
C = hsv2rgb(hsvImage);                       % Convert it to an RGB image

% Next, create the conical surface coordinates:
theta = linspace(0, 2*pi, 100);  % Angular points
X = [zeros(1, 100); ...          % X coordinates
     cos(theta); ...
     zeros(1, 100)];
Y = [zeros(1, 100); ...          % Y coordinates
     sin(theta); ...
     zeros(1, 100)]; 
Z = [1.*ones(2, 100); ...        % Z coordinates
     zeros(1, 100)] - 1.4;

% Finally, plot the texture-mapped surface:
f = figure;
% show trump
trisurf(obj.f.v, obj.v(:,1), obj.v(:,2), obj.v(:,3), ...
    'FaceVertexCData', tval, 'FaceColor', 'interp', 'EdgeAlpha', 0);
hold on
surf(X, Y, Z, C, 'FaceColor', 'texturemap', 'EdgeColor', 'none');
axis equal

saveas(f, '2b.png');
%==============================================================%