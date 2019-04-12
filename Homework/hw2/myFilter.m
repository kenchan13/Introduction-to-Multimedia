function [outputSignal, outputFilter] = myFilter(inputSignal, fsample, N, windowName, filterName, fcutoff)
%%% Input 
% inputSignal: input signal
% fsample: sampling frequency
% N : size of FIR filter(odd)
% windowName: 'Blackmann'
% filterName: 'low-pass', 'high-pass', 'bandpass', 'bandstop' 
% fcutoff: cut-off frequency or band frequencies
%       if type is 'low-pass' or 'high-pass', para has only one element         
%       if type is 'bandpass' or 'bandstop', para is a vector of 2 elements

%%% Ouput
% outputSignal: output (filtered) signal
% outputFilter: output filter 

%% 1. Normalization
fcutoff = fcutoff/fsample;
middle = floor(N/2)+1;
% middle = fix(N/2)+1;

%% 2. Create the filter according the ideal equations (slide #76)
% (Hint) Do the initialization for the outputFilter here
% if strcmp(filterName,'?') == 1
% ...
% end
fltr = double(zeros(1, N+1));
if strcmp(filterName, 'low-pass') == 1
    for n = -floor(N/2)+1: floor(N/2)
    %for n = -fix(N/2): fix(N/2)
        if (n==0) fltr(middle) = 2*fcutoff;
        else fltr(n+middle) = sin(2*pi*fcutoff*n)/(pi*n);
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
%{
m=length(inputSignal);
n=length(fltr);
X=[inputSignal,zeros(1,n)];
H=[fltr,zeros(1,m)];

for i=1:n+m-1
    Y(i)=0;
    for j=1:m
        if(i-j+1>0)
            Y(i)=Y(i)+X(j)*H(i-j+1);
        else
        end
    end
end
outputSignal = Y;
outputFilter = fltr;

%}

outputSignal = conv(inputSignal, fltr, 'same');
outputFilter = fltr;


