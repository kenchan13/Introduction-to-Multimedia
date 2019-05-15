%% This is convolution
function outputConv = conv_imple(input, filter)

[i_row, i_col] = size(input);
[f_row, f_col] = size(filter);

outputConv = zeros(i_row, 1);
midK = (f_row-1)/2;

for i = 1 : i_row
    sum = 0;
    for iK = -midK : midK
        if (1<=i+iK)&&(i+iK<=i_row)
            pos_f = iK+midK+1;
            pos_i = i+iK;
%             filter(iK+midK+1, 1)*input(i+iK, 1)
            sum = sum + filter(iK+midK+1, 1)*input(i+iK, 1);
        end
    end
    outputConv(i,1)=sum;
end