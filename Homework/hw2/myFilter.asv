function [outputSignal, outputFilter] = myFilter(inputSignal, fsample, N, windowName, filterName, fcutoff1, fcutoff2)
%%% Input 
% inputSignal: input signal
% fsample: sampling frequency
% N : size of FIR filter(odd)
% windowName: 'Blackmann'
% filterName: 'low-pass', 'high-pass', 'bandpass', 'bandstop' 
% fcutoff1: cut-off frequency or band frequencies
%       if type is 'low-pass' or 'high-pass', para has only one element         
%       if type is 'bandpass' or 'bandstop', para is a vector of 2 elements

%%% Ouput
% outputSignal: output (filtered) signal
% outputFilter: output filter 

%% 1. Normalization
fcutoff1 = fcutoff1/fsample;
fcutoff2 = fcutoff2/fsample;
middle = floor(N/2)+1;

%% 2. Create the filter according the ideal equations (slide #76)
% (Hint) Do the initialization for the outputFilter here
% fltr = double(zeros(1, N));
fltr = double(zeros(N, 1));
if strcmp(filterName, 'low-pass') == 1
    for n = -floor(N/2)+1: floor(N/2)
    %for n = -fix(N/2): fix(N/2)
        if (n==0) fltr(middle) = 2*fcutoff1;
        else fltr(n+middle) = sin(2*pi*fcutoff1*n)/(pi*n);
        end
    end
elseif strcmp(filterName, 'high-pass') == 1
    for n = -floor(N/2): floor(N/2)
        if (n==0) fltr(middle) = 1-2*fcutoff1;
        else fltr(n+middle) = -sin(2*pi*fcutoff1*n)/(pi*n);
        end
    end
elseif strcmp(filterName, 'bandpass') == 1
    for n = -floor(N/2): floor(N/2)
        if (n==0) fltr(middle) = 2*(fcutoff2-fcutoff1);
        else fltr(n+middle) =  sin(2*pi*fcutoff2*n)/(pi*n) - sin(2*pi*fcutoff1*n)/(pi*n);
        end
    end
end

%% 3. Create the windowing function (slide #79) and Get the realistic filter

if strcmp(windowName,'Blackman') == 1 
    for n = 1: N
        fltr(n)=fltr(n)*( (0.42)-0.5*cos((2*pi*n)/(N-1))+0.08*cos((4*pi*n)/(N-1)));
    end
end


%% 4. Filter the input signal in time domain. Do not use matlab function 'conv'

[row col] = size(inputSignal);
for C = 1 : col
    outputSignal(:,C) = conv_imple(inputSignal(:,C), fltr);
%     outputSignal(:,C) = conv(inputSignal(:,C), fltr, 'same');
end
% if (test == outputSignal) fprintf("true\n"), end
outputFilter = fltr;


