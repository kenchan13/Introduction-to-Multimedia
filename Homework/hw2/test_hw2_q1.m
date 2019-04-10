close all;
clear;
clc;

Start = 54;
Num = 60;
fsample = 44100;
fcutoff = 310;
fcutoff = fcutoff/fsample;


for N =Start:2:Num
    middle = fix(N/2)+1;
    fltr = double(zeros(1, N));
    
    for n = -fix(N/2): fix(N/2)
        if (n==0) fltr(middle) = 2*fcutoff;
        else fltr(n+middle) = sin(2*pi*fcutoff*n)/(pi*n);
        end
    end
    
    
    for n = 1: N
        fltr(n)=fltr(n)*( (0.42)+0.5*cos((2*pi*n)/(N-1))+0.08*cos((4*pi*n)/(N-1)));
    end
    
    
    subplot(Num-Start+1,1,N-Start+1);
    plot(fltr, 'LineWidth', .5); 
    
    
end

