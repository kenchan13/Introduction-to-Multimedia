clear all; close all; clc; 

%% Read OBJ file
obj = readObj('trump.obj');
tval = display_obj(obj,'tumpLPcolors.png');

%==============================================================%
% Code here. Move object center to (0, 0)
%==============================================================%

%% a.
f = figure; 
trisurf(obj.f.v, obj.v(:,1), obj.v(:,2), obj.v(:,3), ...
    'FaceVertexCData', tval, 'FaceColor', 'interp', 'EdgeAlpha', 0);
xlabel('X'); ylabel('Y'); zlabel('Z');
axis equal;
saveas(f, '2a.png');


%==============================================================%
% Code here. Other Problems
%==============================================================%