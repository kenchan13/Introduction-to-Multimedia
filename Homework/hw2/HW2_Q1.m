%%% HW2_Q1.m - Complete the procedure of separating HW2_mix.wav into 3 songs

%% Clean variables and screen
close all;
clear;
clc;

%% Visualization parameters (Change it if you want)
% Some Tips:
% (Tip 1) You can change the axis range to make the plotted result more clearly 
% (Tip 2) You can use subplot function to show multiple spectrums / shapes in one figure
titlefont = 15;
fontsize = 13;
LineWidth = .5;

%% 1. Read in input audio file ( audioread )
% y_input: input signal, fs: sampling rate
[y_input, fs] = audioread('HW2_Mix.wav');

%%% Plot example : plot the input audio
% The provided function "make_spectrum" generates frequency
% and magnitude. Use the following example to plot the spectrum.
subplot(4,2,1:2);
[frequency, magnitude] = makeSpectrum(y_input, fs);
plot(frequency, magnitude, 'LineWidth', LineWidth); 
title('Input', 'fontsize', titlefont);
set(gca, 'fontsize', fontsize)
xlim([0 1600]);


%% 2. Filtering 
% (Hint) Implement my_filter here
% [...] = myFilter(...);
% N: Window size, assume N is odd
% fcutoff: Cutoff frequency

N = 1999;
fcutoff1 = 800;
fcutoff2 = 0;
filterName = 'high-pass';
[outputSignal, outputFilter] = myFilter(y_input, fs, N, 'Blackman', filterName, fcutoff1, fcutoff2);

% gong = audioplayer(outputSignal, fs);
% play(gong);

%%% Plot the shape of filters in Time domain
subplot(4,2,3);
plot(outputFilter, 'LineWidth', LineWidth); 
title('Shape of Filters', 'fontsize', titlefont);
set(gca, 'fontsize', fontsize)
xlim([0 2000]);

%%% Plot the spectrum of filters (Frequency Analysis)
subplot(4,2,4);
[outFilterFrequency, outFiltermagnitude] = makeSpectrum(outputFilter, fs);
plot(outFilterFrequency,outFiltermagnitude, 'LineWidth', LineWidth); 
title('Spectrum of Filters', 'fontsize', titlefont);
set(gca, 'fontsize', fontsize)
xlim([0 2000]);

%% 3. Save the filtered audio (audiowrite)
% Name the file 'FilterName_para1_para2.wav'
% para means the cutoff frequency that you set for the filter

para1 = int2str(fcutoff1);
para2 = int2str(fcutoff2);
audiowrite( strcat(filterName,'_',para1,'_',para2,'.wav'), outputSignal, fs);

%%% Plot the spectrum of filtered signals
subplot(4,2,5:6);
[outFrequency, outmagnitude] = makeSpectrum(outputSignal, fs);
plot(outFrequency, outmagnitude, 'LineWidth', LineWidth); 
title('Spectrum of Filtered Signals', 'fontsize', titlefont);
set(gca, 'fontsize', fontsize)
xlim([0 1600]);

%% 4, Reduce the sample rate of the three separated songs to 2kHz.
[P, Q] = rat(2000/fs);
outputSignal2000 = resample(outputSignal, P, Q);

% gong = audioplayer(outputSignal2000, 2000);
% play(gong);

subplot(4,2,7:8);
[outFrequency, outmagnitude] = makeSpectrum(outputSignal2000, 2000);
plot(outFrequency, outmagnitude, 'LineWidth', LineWidth); 
title('Output with 2kHz', 'fontsize', titlefont);
set(gca, 'fontsize', fontsize)
xlim([0 1600]);

%% 4. Save the files after changing the sampling rate
audiowrite( strcat(filterName,'_',para1,'_',para2,'_2kHz.wav'), outputSignal2000, double(2000));

%% 5. one-fold echo and multiple-fold echo (slide #69
% Use the files before reducing sampling rates

% one-fold echo
[row, col] = size(outputSignal);
oneEcho = zeros(row, 1);
for n = 1: row
    if (n-3200 > 1)
        oneEcho(n, 1) = outputSignal(n, 1) + 0.8*outputSignal(n-3200, 1);
    end
end

% gong = audioplayer(oneEcho, fs);
% play(gong);

% multiple-fold echo
multiEcho = zeros(row, 1);
for n = 1: row
    if (n-3200 > 1)
        multiEcho(n, 1) = outputSignal(n, 1) + 0.8*multiEcho(n-3200, 1);
    end
end

% gong = audioplayer(multiEcho, fs);
% play(gong);

%% 5. Save the echo audios  'Echo_one.wav' and 'Echo_multiple.wav'

if strcmp(filterName, 'low-pass') == 1
    audiowrite('Echo_one.wav', oneEcho, fs);
    audiowrite('Echo_multiple.wav', multiEcho, fs);
end

