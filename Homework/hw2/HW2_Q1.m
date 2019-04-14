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
xlim([100 1600]);


%% 2. Filtering 
% (Hint) Implement my_filter here
% [...] = myFilter(...);
% N: Window size, assume N is odd
% fcutoff: Cutoff frequency

N = 1999;
fcutoff1 = 350;
fcutoff2 = 0;
filterName = 'low-pass';
[outputSignal, outputFilter] = myFilter(y_input, fs, N, 'Blackman', filterName, fcutoff1, fcutoff2);

% gong = audioplayer(outputSignal, fs);
% play(gong);

%%% Plot the shape of filters in Time domain
subplot(4,2,3);
plot(outputFilter, 'LineWidth', LineWidth); 
title('Shape of Filters', 'fontsize', titlefont);
set(gca, 'fontsize', fontsize)
xlim([0 1200]);

%%% Plot the spectrum of filters (Frequency Analysis)
subplot(4,2,4);
[outFilterFrequency, outFiltermagnitude] = makeSpectrum(outputFilter, fs);
plot(outFilterFrequency,outFiltermagnitude, 'LineWidth', LineWidth); 
title('Spectrum of Filters', 'fontsize', titlefont);
set(gca, 'fontsize', fontsize)
xlim([0 1200]);

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
title('Output', 'fontsize', titlefont);
set(gca, 'fontsize', fontsize)
xlim([100 1600]);

%% 4, Reduce the sample rate of the three separated songs to 2kHz.
[P, Q] = rat(2000/fs);
outputSignal2 = resample(outputSignal, P, Q);

% gong = audioplayer(outputSignal2, 2000);
% play(gong);

subplot(4,2,7:8);
[outFrequency, outmagnitude] = makeSpectrum(outputSignal2, fs);
plot(outFrequency, outmagnitude, 'LineWidth', LineWidth); 
title('Output', 'fontsize', titlefont);
set(gca, 'fontsize', fontsize)
xlim([0 25000]);

%% 4. Save the files after changing the sampling rate



%% 5. one-fold echo and multiple-fold echo (slide #69

% one-fold echo
ak = [1,zeros(1,3199),0.8];
bk = [1];
oneEcho = conv(outputSignal2, ak, 'same') - conv(outputSignal2, bk, 'same');

% multiple-fold echo
ak = [1];
bk = [1, zeros(1,3199), -0.8];
multiEcho = conv(outputSignal2, ak, 'same') - conv(outputSignal2, bk, 'same');

gong = audioplayer(multiEcho, 2000);
play(gong);

%% 5. Save the echo audios  'Echo_one.wav' and 'Echo_multiple.wav'



