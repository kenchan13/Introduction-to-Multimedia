clear all;
clc;
n = 2; % Input n

% Size of rgbBlock
size = 4;

% Implement 1D DCT basis
U_temp = zeros(size);
for c = 0 : size-1
    for r = 0 : size-1
        if (c>0)
            a0 = sqrt(2/size);
        else
            a0 = 1/sqrt(size);
        end
        U_temp(r+1, c+1) = cos((2*r+1)*c*pi/(2*size))*a0;
    end
end

% Calculate 2D DCT "U" by using 1D DCT basis
U = [];
for k = 1 : size
    for l = 1 : size
        % fprintf("k:%d, l:%d\n", k, l);
        U = [U {U_temp(:,k) * U_temp(:,l)'}];
    end
end
U = reshape(U, [size, size])';

% S is the rbgBlock source (1 block)
% T is the result of the 2D DCT for "one block"
S = [1 2 2 0; 0 1 3 1; 0 1 2 1; 1 2 2 -1];

T = zeros(size);
for k = 1 : size
    for l = 1 : size
        T(k,l) = sum(U{k,l}.*S, 'all');
    end
end

% We conly need top-left n*n data
% Cut T and expand T with 0
T = T(1:n, 1:n);
T(size, size) = 0;

% DCT inverse
for k = 1: size
    for l = 1: size
        S(k,l) = sum(U{k,l}.*T, 'all');
    end
end